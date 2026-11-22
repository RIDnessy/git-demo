--1. все пользователи с ролью админ
select email, full_name
from users 
where role = 'admin';

--2. все товары категории электроники чья цена ниже 50 долларов
select name, price 
from products 
where price < '50' 
AND category = 'Electronics'
order by price asc;

--3. данные 10 самых новых недавно созданных аккаунтов
select email, created_at
from users 
order by created_at asc 
limit 10;

--4. данные товаров, чье name содержит слово keyboard
select name, category, price 
from products 
where name ilike '%keyboard%'
order by name asc;

--5. данные пользователей чье полное имя начинается с буквы А
select full_name, email 
from users 
where full_name ilike 'A%';

--6. 5 самых дешевых из категории 'Furniture' 
select name, price 
from products 
where category = 'Furniture'
order by price asc
limit 5;

--7. данные товаров ценой от 100 до 200 тысяч включительно 
select name, category, price
FROM products
where price between 100 and 200
order by price desc
limit 10;

--8. товары с 6 по 10 место по убыванию
select name, price 
from products 
order by price desc 
limit 5 offset 5;

--9. внешний ключ в таблице orders вероятнее всего будет ссылаться на столбец id в таблице users, который является ее первичным ключом primary key

