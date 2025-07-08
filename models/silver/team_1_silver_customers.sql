{{ config(materialized='incremental') }}

WITH ranked_customers AS (
  SELECT *,
         ROW_NUMBER() OVER (
           PARTITION BY customer_id
           ORDER BY _fivetran_synced DESC
         ) AS row_num
  FROM {{ source('bronze', 'team_1_bronze_customer') }}
  WHERE _fivetran_deleted = FALSE
    AND name IS NOT NULL  
    AND email IS NOT NULL
    AND created_at IS NOT NULL
)

SELECT
  customer_id,
  name,
  email,
  CAST(created_at AS TIMESTAMP) AS created_at,
  CAST(updated_at AS TIMESTAMP) AS updated_at,
  _fivetran_synced
FROM ranked_customers
WHERE row_num = 1;

-- ========= Logging block =========
{% if execute %}
  {# Row count from target table #}
  {% set result = run_query("SELECT COUNT(*) AS cnt FROM {{ this }}") %}
  {% if result %}
    {% set row_count = result.columns[0].values()[0] %}
    {{ log("Row count in model: " ~ row_count, info=True) }}
  {% endif %}

  {# SQL code logging #}
  {% set compiled_sql = to_sql() %}
  {{ log("Compiled SQL: " ~ compiled_sql, info=True) }}
{% endif %}
