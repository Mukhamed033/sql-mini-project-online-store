-- 📁 Создание таблицы клиентов
CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,       -- Уникальный ID клиента
  customer_name TEXT                     -- Имя клиента
);

-- 📁 Создание таблицы заказов
CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,          -- Уникальный номер заказа
  customer_id INTEGER,                   -- Внешний ключ: ID клиента, который сделал заказ
  order_date DATE,                       -- Дата оформления заказа
  total_amount DECIMAL,                  -- Общая сумма заказа
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)  -- Связь с таблицей клиентов
);

-- 📁 Создание таблицы товаров в заказах
CREATE TABLE order_items (
  item_id INTEGER PRIMARY KEY,           -- Уникальный ID строки с товаром в заказе
  order_id INTEGER,                      -- Внешний ключ: ID заказа
  product_name TEXT,                     -- Название товара
  category TEXT,                         -- Категория товара
  quantity INTEGER,                      -- Количество единиц товара
  price DECIMAL,                         -- Цена за одну единицу товара
  FOREIGN KEY (order_id) REFERENCES orders(order_id)  -- Связь с таблицей заказов
);

-- 📦 Добавление клиентов
INSERT INTO customers VALUES 
(1, 'Ivan Petrov'),                      -- Клиент с ID 1
(2, 'Anna Ivanova'),                     -- Клиент с ID 2
(3, 'Oleg Sidorov');                     -- Клиент с ID 3

-- 🛒 Добавление заказов
INSERT INTO orders VALUES 
(101, 1, '2024-10-01', 300),             -- Заказ №101 от клиента 1
(102, 2, '2024-10-01', 450),             -- Заказ №102 от клиента 2
(103, 1, '2024-10-02', 150),             -- Заказ №103 от клиента 1
(104, 3, '2024-10-03', 500);             -- Заказ №104 от клиента 3

-- 🧾 Добавление товаров в заказы
INSERT INTO order_items VALUES
(1, 101, 'Keyboard', 'Electronics', 1, 100),    -- В заказе 101: 1 клавиатура по 100
(2, 101, 'Mouse', 'Electronics', 2, 100),       -- В заказе 101: 2 мышки по 100
(3, 102, 'Headphones', 'Electronics', 3, 150),  -- В заказе 102: 3 наушника по 150
(4, 103, 'Mouse', 'Electronics', 1, 150),       -- В заказе 103: 1 мышь по 150
(5, 104, 'Monitor', 'Electronics', 2, 250);     -- В заказе 104: 2 монитора по 250


























-- 📌 1. Количество заказов по каждому клиенту
-- Объединяем таблицы клиентов и заказов, затем считаем количество заказов по каждому клиенту

SELECT 
  c.customer_name,                 -- Имя клиента
  COUNT(o.order_id) AS count_order -- Количество заказов
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id -- Связь заказов с клиентами
GROUP BY c.customer_name;                       -- Группировка по имени клиента

-- 📌 Пояснение: JOIN объединяет таблицы, а COUNT подсчитывает количество заказов каждого клиента.


-- 📌 2. Выручка по каждому продукту
-- Считаем общую выручку по каждому товару = количество × цена

SELECT 
  product_name, 
  SUM(quantity * price) AS revenue  -- Общая выручка по продукту
FROM order_items
GROUP BY product_name               -- Группировка по названию товара
ORDER BY revenue DESC;              -- Сортировка по выручке (по убыванию)

-- 📌 Пояснение: Используем SUM() для расчета выручки по каждому товару.


-- 📌 3. Средний чек по каждому клиенту
-- Вычисляем среднюю сумму заказов (чек) для каждого клиента

SELECT 
  c.customer_name, 
  AVG(o.total_amount) AS avg_check  -- Средняя сумма заказов
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id -- Связываем клиентов с их заказами
GROUP BY c.customer_name;                       -- Группировка по клиенту

-- 📌 Пояснение: AVG() вычисляет среднее значение total_amount для каждого клиента.


-- 📌 4. Количество заказов по датам
-- Считаем, сколько заказов сделано в каждый день

SELECT 
  order_date, 
  COUNT(*) AS total_orders         -- Количество заказов на дату
FROM orders 
GROUP BY order_date               -- Группировка по дате
ORDER BY total_orders DESC;       -- Сортировка по убыванию заказов

-- 📌 Пояснение: COUNT(*) подсчитывает все заказы по каждой дате.


