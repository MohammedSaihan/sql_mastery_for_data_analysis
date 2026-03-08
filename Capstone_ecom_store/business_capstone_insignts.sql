select * from orders;

-- total revenue of business
select sum(amount) as total_revenue
from payments;

-- revenue of product

select
    p.product_name , sum(p.price * oi.quantity) as revenue_of_product
from orders_items oi
join products p on oi.product_id = p.product_id
join orders o on oi.order_id = o.order_id
where o.order_status = 'Delivered'
group by p.product_name
order by revenue_of_product desc;

-- top revenue by customer

select
    c.name , sum(p.amount) as total_spend
from customers c
join orders o on o.customer_id = c.customer_id
join payments p on o.order_id = p.order_id
group by c.name
order by total_spend desc

-- Best Selling Products

select
    p.product_name,
    sum(oi.quantity) as total_selling
from orders_items oi
join products p on oi.product_id = p.product_id
group by p.product_name
order by total_selling desc


-- Cancelled Orders Count
select count(*) as Cancelled_Items
from orders
where order_status = 'Cancelled'