{{ config(
    materialized='table',
    tags=["gold"]
) }}

SELECT
    country.value::STRING AS country,
    COALESCE(sf.categories, 'not defined') AS category,
    COALESCE(sf.brands, 'not defined') AS brand,
    sf.nutriscore_grade,
    COUNT(*) AS total_products,
    COUNT(DISTINCT sf.code) AS unique_products,
    AVG(sf.fat_100g) AS avg_fat_100g,
    AVG(sf.sugars_100g) AS avg_sugars_100g
FROM {{ ref('silver_openfoodfacts') }} sf,
     LATERAL FLATTEN(input => sf.countries_tags) AS country
WHERE sf.nutriscore_grade IN ('a', 'b', 'c', 'd', 'e')
GROUP BY
    country.value,
    COALESCE(sf.categories, 'not defined'),
    COALESCE(sf.brands, 'not defined'),
    sf.nutriscore_grade
