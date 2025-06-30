{{ config(
    materialized='incremental',
    unique_key='id'
) }}

SELECT
  3 AS id,
  'Charlie' AS name
