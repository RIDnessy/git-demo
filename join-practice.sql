INSERT INTO users (email, hashed_password, full_name, role)
VALUES ('never_ordered@example.com', 'not-a-real-hash', 'No Orders Yet', 'member')
ON CONFLICT (email) DO NOTHING;

INSERT INTO products (name, category, price, stock)
SELECT 'Unreleased Prototype', 'Electronics', 999.99, 0
WHERE NOT EXISTS (SELECT 1 FROM products WHERE name = 'Unreleased Prototype');

--1. кто что сказал
select 
    orders.id as order_id, 
    users.email, 
    products.name as product_name, 
    orders.quantity
from orders
join users on orders.user_id = users.id
join products on orders.product_id = products.id;

--2. отсорировано по дню заказа
select 
    orders.id as order_id, 
    users.email, 
    products.name as product_name, 
    orders.quantity,
    orders.created_at::date as order_date
from orders
join users on orders.user_id = users.id
join products on orders.product_id = products.id
order by orders.created_at desc;

--3. пользователи, которые никогда не заказывали
select users.email
from users
left join orders on users.id = orders.user_id
where orders.id is null;

--4 заказы по статусам 
select 
    status, 
    count(*) as orders_count
from orders
group by status
order by orders_count desc;

--5. выручка по категориям 
select 
    products.category,
    sum(products.price * orders.quantity) as total_revenue
from orders
join products on orders.product_id = products.id
group by products.category
order by total_revenue desc;

--6. топ 5 покупателей 
select 
    users.email,
    sum(orders.quantity) as total_items_bought
from orders
join users on orders.user_id = users.id
group by users.email
order by total_items_bought desc
limit 5;

--7. категории выше среднего 
select 
    category,
    avg(price) as avg_price
from products
group by category
having avg(price) > (select avg(price) from products);

--8. частые покупатели 
select 
    users.email,
    count(orders.id) as orders_count
from orders
join users on orders.user_id = users.id
group by users.email
having count(orders.id) > 40
order by orders_count desc;

--9. никогда не заказанные товары
select products.name
from products
left join orders on products.id = orders.product_id
where orders.id is null;