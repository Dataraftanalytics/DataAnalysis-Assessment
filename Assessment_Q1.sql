SELECT 
    uc.id AS user_id,
    uc.first_name,
    uc.last_name,
    COALESCE(SUM(ss.amount), 0) + COALESCE(SUM(pp.amount), 0) AS total_deposits
FROM 
    users_customuser uc
JOIN 
    savings_savingsaccount ss
    ON uc.id = ss.savings_id AND ss.confirmed_amount = TRUE
JOIN 
    plans_plan pp 
    ON uc.id = pp.id AND pp.amount = TRUE AND pp.description = 'investment'
GROUP BY 
    uc.id, uc.first_name, uc.last_name
ORDER BY 
    total_deposits DESC;
