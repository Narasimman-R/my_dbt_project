-- models/sample_table.sql

-- {{ config(
--     materialized='table',
--     post_hook=[
--         "INSERT INTO {{ this }} (id, name) VALUES (1, 'Alice'), (2, 'Bob')"
--     ]
-- ) }}

-- SELECT
--     0 AS id,
--     'init' AS name
-- WHERE 1 = 0  -- Create empty table structure

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
