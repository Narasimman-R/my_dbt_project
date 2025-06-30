{{ config(
    materialized='incremental',
    unique_key='id',
    schema='default'
) }}

SELECT
  3 AS id,
  'Charlie' AS name
