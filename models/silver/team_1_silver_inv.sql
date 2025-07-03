WITH ranked_inventory AS (
  SELECT *,
         ROW_NUMBER() OVER (
           PARTITION BY product_id
           ORDER BY _fivetran_synced DESC
         ) AS row_num
  FROM {{ source('bronze', 'team_1_bronze_inventory_movements') }}
  WHERE _fivetran_deleted = FALSE
    AND stock_level IS NOT NULL  
)
SELECT
  product_id,
  stock_level,
  movement_date,
  _fivetran_deleted
  _fivetran_synced
FROM ranked_inventory