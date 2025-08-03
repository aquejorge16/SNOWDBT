{{ config(
    materialized='view',
    tags=['bronce']
) }}

SELECT
    PARSE_JSON(raw):_id::STRING              AS id,
    PARSE_JSON(raw):product_name::STRING     AS product_name,
    PARSE_JSON(raw):brands::STRING           AS brands,
    PARSE_JSON(raw):categories::STRING       AS categories,
    PARSE_JSON(raw):nutriscore_grade::STRING AS nutriscore_grade,
    PARSE_JSON(raw):countries_tags::ARRAY    AS countries_tags,
    PARSE_JSON(raw):ingredients_text::STRING AS ingredients,
    PARSE_JSON(raw):code::STRING             AS code,
    PARSE_JSON(raw):quantity::STRING         AS quantity,
    PARSE_JSON(raw):nutriments::VARIANT      AS nutriments
FROM {{ source('openfoodfacts_raw', 'raw_openfoodfacts') }}
