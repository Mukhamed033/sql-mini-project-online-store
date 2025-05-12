 Количество заказов по каждому клиенту

SELECT c.customer_name, COUNT(o.order_id) AS count_order
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
 Пояснение: Запрос считает, сколько заказов сделал каждый клиент. Мы используем JOIN, чтобы объединить таблицы клиентов и заказов, и затем группируем по имени клиента (customer_name).

2. Выручка по каждому продукту

SELECT product_name, SUM(quantity * price) AS revenue
FROM order_items
GROUP BY product_name
ORDER BY revenue DESC;
 Пояснение: Этот запрос подсчитывает общую выручку по каждому продукту, умножая количество товаров на их цену и суммируя результат. Результаты сортируются по убыванию выручки.

3. Средний чек по каждому клиенту

SELECT c.customer_name, AVG(o.total_amount) AS chek
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_name;
 Пояснение: Запрос вычисляет среднюю сумму заказа (средний чек) для каждого клиента. Это делается с помощью агрегатной функции AVG().

4. Количество заказов по датам

SELECT order_date, COUNT(*) AS total_orders
FROM orders 
GROUP BY order_date
ORDER BY total_orders DESC;
 Пояснение: Запрос считает количество заказов по дням и сортирует их по убыванию. Таким образом, ты узнаешь, в какие дни было больше всего заказов.

