{% snapshot product_snapshots %}
{{
    config(
        target_schema='snapshots',
        unique_key='id',
        strategy='check',
        check_cols=['brands', 'nutriscore_grade', 'fat_100g', 'sugars_100g']
    )
}}

SELECT *
FROM {{ ref('silver_openfoodfacts') }}

{% endsnapshot %}
