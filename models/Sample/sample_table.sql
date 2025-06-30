{{ config(
    materialized='incremental',
    unique_key='id'
) }}

SELECT
  5 AS id,
  'testuser' AS name
