WITH savings_last_txn AS (
    SELECT
        s.id AS plan_id,
        s.owner_id,
        'Savings' AS type,
        s.verification_transaction_date AS last_transaction_date
    FROM savings_savingsaccount s
    WHERE s.verification_status_id = 1  -- confirmed/active
),
plans_last_txn AS (
    SELECT
        p.id AS plan_id,
        p.owner_id,
        'Investment' AS type,
        MAX(w.transaction_date) AS last_transaction_date
    FROM plans_plan p
    LEFT JOIN withdrawals_withdrawal w ON p.id = w.plan_id
    WHERE p.status_id = 1
    GROUP BY p.id, p.owner_id
),
combined AS (
    SELECT * 
    FROM savings_last_txn
    UNION ALL
    SELECT *
    FROM plans_last_txn
)
SELECT
    plan_id,
    owner_id,
    type,
    last_transaction_date,
    DATEDIFF(CURDATE(), last_transaction_date) AS inactivity_days
FROM combined
WHERE last_transaction_date IS NOT NULL
   OR last_transaction_date < CURDATE() - INTERVAL 365 DAY
ORDER BY inactivity_days DESC;
