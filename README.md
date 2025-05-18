**Assessment_Q1**: I used relational filtering and intersection strategy. This is used when you want to combine data accross different entities.
It ensures accuracy and avoids duplicates. 
So, i just needed to find customers who have a savings plan that is funded and an investment plan that is funded. 
I encountered some technical and data related challenges.
Customers may have multiple savings or investment accounts.

**Assessment_Q2**: I used a CTE(Custom Table Expression) aggregation approach combined with conditional logic to segment users by transaction behavior.

**Assessment_Q3**: Here's the approach i used for the Inactivity alert query: First, i identified active accounts for both savings and investments. After that, i determined the last inflow transaction date. Next, i combined both savings and investment data, calculated the number of inactivity days, filtered for inactive accounts and ordered by inactivity days. 
It wasn't easy dealing with the status column but the main problem was lack of straightforward inflow transaction table/column and ambiguous join keys.

**Assessment_Q4**: For the Customer Lifetime Value (CLU), the approach used is a data-driven modelling approach based on aggregated historical behaviour
