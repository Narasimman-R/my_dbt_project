SELECT 
    id AS host_id,
    name,
    CASE 
        WHEN is_superhost = 'yes' THEN 'true' 
        ELSE 'false' 
    END AS is_superhost,
    created_at,
    updated_at 
FROM Sample_DB.dbo.raw_hosts;
