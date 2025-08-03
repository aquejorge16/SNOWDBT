{{ config(
    materialized='table',
    unique_key='id',
    tags=["silver"]
) }}

WITH base AS (
    SELECT
        *,
        ROW_NUMBER() OVER (PARTITION BY id ORDER BY id) AS rn
    FROM (
        SELECT
            id,
            product_name,
            {{ normalize_text("brands") }} AS brands,
            categories,
            nutriscore_grade,
            countries_tags,
            ingredients,
            code,
            quantity,
            nutriments:fat_100g::FLOAT AS fat_100g,
            nutriments:sugars_100g::FLOAT AS sugars_100g
        FROM {{ ref('stg_openfoodfacts') }}
        WHERE id IS NOT NULL
          AND brands IS NOT NULL
          AND nutriments:fat_100g IS NOT NULL
          AND nutriments:sugars_100g IS NOT NULL
          AND nutriments:fat_100g::FLOAT BETWEEN 0 AND 100
          AND nutriments:sugars_100g::FLOAT BETWEEN 0 AND 100
    )
)

SELECT
    id,
    product_name,
    brands,
    categories,
    nutriscore_grade,
    countries_tags,
    ingredients,
    code,
    quantity,
    fat_100g,
    sugars_100g
FROM base
WHERE rn = 1
