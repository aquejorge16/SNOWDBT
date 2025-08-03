{% macro normalize_text(col) %}
    LOWER(TRIM({{ col }}))
{% endmacro %}