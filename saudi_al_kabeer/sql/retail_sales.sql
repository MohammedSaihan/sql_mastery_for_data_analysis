# Which product category generates the highest revenue?
select
    p.category,
    sum(s.total_amount) as revenue,
    sum(total_amount) * 100 / sum(sum(total_amount)) over()  as pct_revenue
from sales_transactions s
join products p on s.product_id = p.product_id
group by category
order by revenue desc ;

# Monthly Revenue Trend

select
    date_format(order_date,'%y-%m') as month,
    sum(total_amount) as monthly_revenue,
    LAG(sum(total_amount)) over (order by date_format(order_date,'%y-%m')) as prv_month,
    round(
        (sum(total_amount) - lag(sum(total_amount)) over (order by date_format(order_date,'%y-%m')))
        / lag(sum(total_amount)) over (order by date_format(order_date,'%y-%m'))*100,2
    )  as pct_growth
from sales_transactions
group by month
order by month;

with monthlySales as (
    select
        date_format(order_date,'%y-%m-01') as month_start,
        sum(total_amount) as montly_revenue
    from sales_transactions
    group by month_start
)

select
    DATE_FORMAT(month_start, '%Y-%m') AS month,
    montly_revenue,
    lag(montly_revenue) over (order by month_start)  as previous_monthly_revenue,
    round(
        (montly_revenue - lag(montly_revenue) over (order by month_start))
        / lag(montly_revenue) over (order by month_start)*100,2
    ) as mom_growth_pct
from monthlySales
order by month_start;

# Top 10 Products by Revenue
select
    p.product_name,
    sum(s.total_amount) as product_revenue,
    sum(s.total_amount) * 100 / sum(sum(total_amount)) over()  as pct_revenue
from sales_transactions s
join products p on s.product_id = p.product_id
group by product_name
order by product_revenue desc
limit 10;

#total_orders

select
    count(distinct transaction_id) as total_orders
from sales_transactions;

# Which age group spends the most?
select
    case
        when c.age between 18 and 25 then '18-25'
        when c.age between 26 and 35 then '26-35'
        when c.age between 36 and 45 then '36-45'
        when c.age between 45 and 60 then '46-60'
        else '60+'
    end as age_seg,
    sum(s.total_amount) as revenu_generated
from sales_transactions s
join customers c on s.customer_id = c.customer_id
group by age_seg
order by revenu_generated desc;

# City-wise Sales Performance
SELECT
    c.city_name,
    sum(s.total_amount) as city_revunue,
    sum(s.total_amount) * 100 / sum(sum(s.total_amount)) over()  as pct_revenue
from sales_transactions s
join cities c on s.city_id = c.city_id
group by city_name
order by city_revunue DESC;

# Average Order Value (AOV)
SELECT
    total_revenue,
    total_orders,
    ROUND((total_revenue/total_orders),2) AS AOV
FROM(
    SELECT
        SUM(sales_transactions.total_amount) AS total_revenue,
        COUNT(sales_transactions.quantity) AS total_orders
    FROM sales_transactions

) AS ORDER_DETAILS;

# Revenue Contribution by Category %
select
    p.category,
    sum(s.total_amount) as category_revenue,
    SUM(SUM(s.total_amount)) OVER() AS total_revenue,
    ROUND(SUM(s.total_amount) / SUM(SUM(s.total_amount)) OVER() * 100, 2) AS contribution_pct
from products p
join sales_transactions s on p.product_id = s.product_id
group by p.category
order by  category_revenue desc;

# Top Customers by Spending
SELECT
    c.customer_name,
    sum(s.total_amount) AS total_revenue,
    ROUND(SUM(s.total_amount) / SUM(SUM(s.total_amount)) OVER() * 100, 2) AS contribution_pct
FROM customers c
JOIN sales_transactions S ON c.customer_id = S.customer_id
GROUP BY customer_name
ORDER BY total_revenue DESC
LIMIT 10;

-- Sales by Day of Week

SELECT
    DAYOFWEEK(order_date) AS day_of_week,
    SUM(total_amount) AS weekly_revenue

FROM sales_transactions
GROUP BY day_of_week
order by day_of_week;

# Product Demand Analysis Which products sell the most units?

SELECT
    p.product_name AS catergory_name,
    s.unit_price AS unit_sold
FROM sales_transactions s
JOIN products p ON s.product_id = p.product_id
ORDER BY unit_sold DESC;

# Month over ;Month Growth

WITH monthlySales AS (
    SELECT
        DATE_FORMAT(sales_transactions.order_date,'%y-%m-01') AS monthstart,
        SUM(sales_transactions.total_amount) AS monthlyrev
    FROM sales_transactions
    GROUP BY monthstart
)

SELECT
    DATE_FORMAT(monthstart,'%y-%m') AS month,
    monthlyrev,
    LAG(monthlyrev) over (ORDER BY monthstart) AS prev_month,
    ROUND(
        (monthlyrev - LAG(monthlyrev) over (ORDER BY monthstart)) / LAG(monthlyrev) over (ORDER BY monthstart)*100,2
    ) AS pct_rev
FROM monthlySales;


# Customer Repeat Purchase Rate

WITH CustomerStat AS (
    SELECT
        customer_id,
        COUNT(DISTINCT transaction_id) as order_count
    FROM sales_transactions
    GROUP BY customer_id
)

SELECT
    SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) AS 'REPEATED CUSTOMER',
    SUM(CASE WHEN order_count = 1 THEN 1 ELSE 0 END) AS 'NEW CUSTOMER',
    100* SUM(CASE WHEN order_count > 1 THEN 1 ELSE 0 END) / COUNT(*) AS 'REPEATED CUSTOMER PCT',
    100* SUM(CASE WHEN order_count = 1 THEN 1 ELSE 0 END) / COUNT(*) AS 'NEW CUSTOMER PCT'
FROM CustomerStat;

WITH CustomerStats AS (
		SELECT
			customer_id,
            count(distinct transaction_id) as total_orders
		from sales_transactions
        group by customer_id
)

select
	customer_id,
    total_orders,
    case
		when total_orders = 1 then 'new customer'
        when total_orders > 1 then 'repeated customer'
        else 'no orders'
	end as customer_status
from CustomerStats;

# Customer Lifetime Value (Simple Version)

SELECT
    customer_id,
    AVG(total_amount) * COUNT(invoice_id) AS CLV
FROM sales_transactions
GROUP BY customer_id;

WITH CUSTOMER_STAT AS
    (
    SELECT customer_id,
        AVG(total_amount) AS avg_order_value,
        COUNT(invoice_id) AS number_of_orders
    FROM sales_transactions
    group by customer_id
)

SELECT
    customer_id,
    avg_order_value * number_of_orders AS individual_clv
FROM CUSTOMER_STAT;


WITH CLV_SUMMARY AS (
    SELECT
        sales_transactions.customer_id,
        AVG(sales_transactions.total_amount) * COUNT(sales_transactions.invoice_id) AS CLV
    FROM sales_transactions
    GROUP BY sales_transactions.customer_id
)

SELECT ROUND(AVG(CLV),2) AS Average_customer_lifetime_value
FROM CLV_SUMMARY;

SELECT
    p.category,
    SUM(s.total_amount) AS total_revenue,
    SUM(s.total_amount - s.unit_price) AS total_profit,
    ROUND((SUM(s.total_amount - s.unit_price) / SUM(s.total_amount)) * 100, 2) AS profit_margin_pct
FROM products p
JOIN sales_transactions s ON p.product_id = s.product_id
GROUP BY category
ORDER BY total_profit DESC
LIMIT 10;

# Sales Distribution by Age Group

SELECT
    CASE
        WHEN c.age BETWEEN 18 AND 25 THEN '18-25'
        WHEN c.age BETWEEN 26 AND 35 THEN '26-35'
        WHEN c.age BETWEEN 36 AND 45 THEN '36-45'
        WHEN c.age BETWEEN 46 AND 55 THEN '46-55'
        ELSE '60+'
    END AS age_group_seg,
    SUM(s.total_amount) as segment_contribution
from customers c
JOIN sales_transactions s ON c.customer_id = s.customer_id
GROUP BY age_group_seg
ORDER BY  segment_contribution DESC

# High Revenue Cities vs Low Revenue Cities

SELECT
    c.city_name,
    SUM(s.total_amount) AS city_revenue
FROM sales_transactions s
JOIN cities c ON s.city_id = c.city_id
GROUP BY city_name
ORDER BY city_revenue DESC
LIMIT 10;

WITH cityRevenue AS (
    SELECT
        c.city_name,
        SUM(s.total_amount) AS city_revenue
FROM sales_transactions s
JOIN cities c ON s.city_id = c.city_id
GROUP BY city_name
),

TotalStat AS (
    SELECT SUM(city_revenue) AS grand_total FROM cityRevenue
)

SELECT
    city_name,
    city_revenue,
    (city_revenue / (SELECT grand_total FROM TotalStat)) * 100 AS revnue_percentage
FROM cityRevenue
ORDER BY city_revenue DESC
LIMIT 3;

# Seasonal Sales Pattern

SELECT
    DATE_FORMAT(sales_transactions.order_date,'%y-%m') AS monthly_season,
    SUM(sales_transactions.total_amount) AS sales_monthly,
    sum(total_amount) * 100 / sum(sum(total_amount)) over()  as pct_revenue
FROM sales_transactions
GROUP BY monthly_season
ORDER BY monthly_season;

