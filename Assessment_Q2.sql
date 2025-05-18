WITH monthly_txn_counts AS (
    SELECT
        uc.id AS user_id,
        DATE_FORMAT(s.transaction_date, '%Y-%m') AS txn_month,
        COUNT(*) AS txn_count
    FROM 
        users_customuser uc
    JOIN 
        savings_savingsaccount s ON uc.id = s.id
    GROUP BY 
        uc.id, DATE_FORMAT(s.transaction_date, '%Y-%m')
),
average_txn_per_month AS (
    SELECT
        user_id,
        AVG(txn_count) AS avg_txn_per_month
    FROM 
        monthly_txn_counts
    GROUP BY 
        user_id
),
categorized_customers AS (
    SELECT
        user_id,
        avg_txn_per_month,
        CASE
            WHEN avg_txn_per_month >= 10 THEN 'High Frequency'
            WHEN avg_txn_per_month BETWEEN 3 AND 9 THEN 'Medium Frequency'
            ELSE 'Low Frequency'
        END AS frequency_category
    FROM average_txn_per_month
)
SELECT
    frequency_category,
    COUNT(*) AS customer_count,
    ROUND(AVG(avg_txn_per_month), 2) AS avg_transactions_per_month
FROM
    categorized_customers
GROUP BY
    frequency_category
ORDER BY
    FIELD(frequency_category, 'High Frequency', 'Medium Frequency', 'Low Frequency');
