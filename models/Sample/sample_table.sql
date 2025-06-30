{{ config(
    materialized='incremental',
    unique_key='id'
) }}

SELECT
  4 AS id,
  'auston' AS name
