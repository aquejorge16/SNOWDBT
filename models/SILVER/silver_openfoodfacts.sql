{{ config(materialized='incremental', unique_key='id') }}

SELECT
  id,
  product_name,
  brands,
  categories,
  countries,
  nutriments:"fat"::FLOAT       AS fat,
  nutriments:"sugars"::FLOAT    AS sugars,
  nutriments:"proteins"::FLOAT  AS proteins,
  nutriments:"salt"::FLOAT      AS salt,
  last_modified_time
FROM {{ ref('stg_openfoodfacts') }}

{% if is_incremental() %}
  WHERE last_modified_time > (SELECT max(last_modified_time) FROM {{ this }})
{% endif %}
