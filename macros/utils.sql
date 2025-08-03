{% macro clean_brand(brand) %}
    CASE 
        WHEN {{ brand }} IS NULL THEN 'not defined'
        ELSE LOWER(TRIM({{ brand }}))
    END
{% endmacro %}