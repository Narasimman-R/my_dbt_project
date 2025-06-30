-- models/sample_table.sql

{{ config(
    materialized='table',
    post_hook=[
        "INSERT INTO {{ this }} (id, name) VALUES (1, 'Alice'), (2, 'Bob')"
    ]
) }}

SELECT
    0 AS id,
    'init' AS name
WHERE 1 = 0  -- Create empty table structure
