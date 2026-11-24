--1. новая таблица reviews
create table reviews (
    user_id integer references users(id),
    product_id integer references products(id),
    rating integer check (rating between 1 and 5),
    comment text,
    created_at timestamp default now(),
    primary key (user_id, product_id)
);

--2. добавление столбца
alter table users add column phone_number text;

--3. добавление ограничения постфактум
alter table orders add constraint check_quantity_max check (quantity <= 10);

--4. товар
insert into products (name, category, price, stock) 
values ('Studio Desk Lamp', 'Office', 45.50, 25)
returning id;

--5. повышение цен по всему каталогу
update products 
set price = price * 1.10 
where category = 'Furniture';

--6. автоотмена утсраевших заказов
update orders 
set status = 'cancelled' 
where status = 'pending' and created_at < now() - interval '30 days';

--7. удаление и обьяснение ошибки
-- для начала находим товар 
select product_id from orders limit 1;
-- пытаемся его удалить
delete from products where id = 58;
-- ошибка возникает из за того что в таблице orders есть записи, которые ссылаются на этот товар. База данных защищает свою ссылочную целостность и не дает удалить товар, на который уже есть заказы.

--8. индекс под новый шаблон запроса 
create index idx_orders_status_created_at on orders(status, created_at);

--9. безопасная транзакция пополнения запаса и заказа
begin;

insert into orders (user_id, product_id, quantity, status) 
values (1, 1, 2, 'pending');

update products 
set stock = stock - 2 
where id = 1;

commit;

