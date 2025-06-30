
{{ config(
    materialized='incremental',
    unique_key='id'
) }}

-- Base select statement to append new rows
SELECT
    {{ current_timestamp() | string }} AS id,  -- Use timestamp or sequence to generate new ID
    'new_user' AS name

{% if is_incremental() %}
-- Only run if it's incremental
WHERE 1 = 1
{% endif %}
