{% macro extract_nutrient(column_alias) %}
  nutriments:"{{ column_alias }}"::FLOAT AS {{ column_alias }}
{% endmacro %}
