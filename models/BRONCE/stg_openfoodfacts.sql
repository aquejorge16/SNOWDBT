{{ config(materialized='view') }}

SELECT
    raw:"_id"::STRING                AS id,
    raw:"product_name"::STRING       AS product_name,
    raw:"brands"::STRING             AS brands,
    raw:"categories"::STRING         AS categories,
    raw:"countries"::STRING          AS countries,
    raw:"nutriments"                 AS nutriments,
    raw:"labels"::STRING             AS labels,
    raw:"ingredients_text"::STRING   AS ingredients_text,
    raw:"expiration_date"::STRING    AS expiration_date,
    raw:"created_t"::TIMESTAMP       AS created_time,
    raw:"last_modified_t"::TIMESTAMP AS last_modified_time
FROM {{ source('openfoodfacts_raw', 'raw_openfoodfacts') }}
