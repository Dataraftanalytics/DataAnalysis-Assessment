WITH user_transactions AS (
    SELECT 
        uc.id AS customer_id,
        CONCAT(uc.first_name, ' ', uc.last_name) AS name,
        TIMESTAMPDIFF(MONTH, uc.date_joined, CURDATE()) AS tenure_months,
        COUNT(w.id) AS total_transactions,
        SUM(w.amount) AS total_transaction_value
    FROM users_customuser uc
    JOIN savings_savingsaccount s ON uc.id = s.owner_id
    JOIN withdrawals_withdrawal w ON s.id = w.id  
    GROUP BY uc.id, uc.first_name, uc.last_name, uc.date_joined
),
clv_calc AS (
    SELECT 
        customer_id,
        name,
        tenure_months,
        total_transactions,
        ROUND(((total_transaction_value * 0.001) / NULLIF(tenure_months, 0)) * 12, 2) AS estimated_clv
    FROM user_transactions
)
SELECT * 
FROM clv_calc
ORDER BY estimated_clv DESC;


