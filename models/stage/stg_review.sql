SELECT 
    listing_id,
    CAST(date AS DATE) AS date,
    reviewer_name,
    comments,
    UPPER(sentiment) AS sentiment
FROM Sample_DB.dbo.raw_reviews;
