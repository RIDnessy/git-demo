
-- Проектирование схемы (создание таблиц)

-- Таблица студентов

create table students (
    id serial primary key,
    full_name text not null,
    email text unique not null,
    birth_date date,
    enrolled_at date default current_date
);

-- Таблица курсов

create table courses (
    id serial primary key,
    course_name text not null,
    teacher_name text not null,
    credits integer not null check (credits > 0)
);

-- Таблица оценок

create table grades (
    id serial primary key,
    student_id integer not null references students(id),
    course_id integer not null references courses(id),
    grade integer not null check (grade between 0 and 100),
    unique (student_id, course_id) -- Один студент - одна оценка за курс
);

-- Заполнение таблицы данными

-- Вставляем 3 курса
insert into courses (course_name, teacher_name, credits) values
('Databases', 'Ivanov', 4),
('Statistics', 'Petrova', 3),
('Algorithms', 'Sidorov', 5);

-- 3 студента
insert into students (full_name, email, birth_date) values
('Alex Johnson', 'alex@example.com', '2000-01-15'),
('Maria Smith', 'maria@example.com', null),
('John Doe', 'john@example.com', '1999-05-20');

-- 4 оценки

insert into grades (student_id, course_id, grade) values
(1, 1, 95),
(1, 2, 88),
(2, 1, 75),
(3, 3, 90);

-- Обновление информации по двум студентам

-- Обновление 1: Заполнение даты рождения Марии

update students
set birth_date = '2001-08-10'
where email = 'maria@example.com';

-- Обновление 2: Исправление email Джона

update students
set email = 'john.new@example.com'
where id = 3;

-- Удаление одного студента

delete from grades where student_id = 3;
delete from students where id = 3;

-- Проверка

select * from students;
select s.full_name, c.course_name, g.grade
from grades g
join students s on s.id = g.student_id
join courses c on c.id = g.course_id;