-- Цель – определить, на какие товары спрос будет стабильным.

-- С помощью анализа продаж этим методом можно сэкономить бюджет и время, отказавшись от продажи товаров, на которые не будет спроса.

-- Этапы анализа следующие: 
-- 1. составляется список товаров и выручки, которую приносит товар. 
-- 2. С помощью формулы определяется коэффициент вариации. 
-- 3. Затем товарам присваивается категория X, Y или Z.

-- Группа X. Товары с коэффициентом от 0% до 10%;
-- Группа Y. Товары с коэффициентом от 10% до 25%;
-- Группа Z. Товары с коэффициентов вариации больше 25%.
-- Простыми словами, коэффициент вариации – это возможное отклонение величин. Так вот, отклонение спроса сказывается на продажах, что создает сложности при достижении плановых показателей.

-- 1. Список товаров и выручки, которую приносит товар каждый месяц всего периода
use classicmodels;

select *
from orders;

select *
from orderdetails;

-- Длительность наблюдений
select min(orders.orderDate),
max(orders.orderDate),
timestampdiff(month, min(orders.orderDate), max(orders.orderDate))
from orders;
-- В рассматриваемом периоде будет 28 месяцев.

-- Решение костыльное, ничего лучше не придумал, к сожалению.
-- Добавлю столбик с вычислением вариации спроса на товар: стандартное отклонение / среднее * 100%
select orderdetails.productCode,
        sum(case when month(orders.orderDate) = '1' and year(orders.orderDate) = '2003' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as jan_3,
		sum(case when month(orders.orderDate) = '2' and year(orders.orderDate) = '2003' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as feb_3,
		sum(case when month(orders.orderDate) = '3' and year(orders.orderDate) = '2003' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as mar_3,
		sum(case when month(orders.orderDate) = '4' and year(orders.orderDate) = '2003' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as apr_3,
		sum(case when month(orders.orderDate) = '5' and year(orders.orderDate) = '2003' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as may_3,
		sum(case when month(orders.orderDate) = '6' and year(orders.orderDate) = '2003' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as jun_3,
		sum(case when month(orders.orderDate) = '7' and year(orders.orderDate) = '2003' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as jul_3,
		sum(case when month(orders.orderDate) = '8' and year(orders.orderDate) = '2003' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as aug_3,
		sum(case when month(orders.orderDate) = '9' and year(orders.orderDate) = '2003' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as sep_3,
		sum(case when month(orders.orderDate) = '10' and year(orders.orderDate) = '2003' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as oct_3,
		sum(case when month(orders.orderDate) = '11' and year(orders.orderDate) = '2003' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as nov_3,
		sum(case when month(orders.orderDate) = '12' and year(orders.orderDate) = '2003' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end ) as decemb_3,
		sum(case when month(orders.orderDate) = '1' and year(orders.orderDate) = '2004' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as jan_4,
		sum(case when month(orders.orderDate) = '2' and year(orders.orderDate) = '2004' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as feb_4,
		sum(case when month(orders.orderDate) = '3' and year(orders.orderDate) = '2004' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as mar_4,
		sum(case when month(orders.orderDate) = '4' and year(orders.orderDate) = '2004' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as apr_4,
		sum(case when month(orders.orderDate) = '5' and year(orders.orderDate) = '2004' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as may_4,
		sum(case when month(orders.orderDate) = '6' and year(orders.orderDate) = '2004' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as jun_4,
		sum(case when month(orders.orderDate) = '7' and year(orders.orderDate) = '2004' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as jul_4,
		sum(case when month(orders.orderDate) = '8' and year(orders.orderDate) = '2004' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as aug_4,
		sum(case when month(orders.orderDate) = '9' and year(orders.orderDate) = '2004' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as sep_4,
		sum(case when month(orders.orderDate) = '10' and year(orders.orderDate) = '2004' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as oct_4,
		sum(case when month(orders.orderDate) = '11' and year(orders.orderDate) = '2004' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as nov_4,
		sum(case when month(orders.orderDate) = '12' and year(orders.orderDate) = '2004' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end ) as decemb_4,
		sum(case when month(orders.orderDate) = '1' and year(orders.orderDate) = '2005' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as jan_5,
		sum(case when month(orders.orderDate) = '2' and year(orders.orderDate) = '2005' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as feb_5,
		sum(case when month(orders.orderDate) = '3' and year(orders.orderDate) = '2005' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as mar_5,
		sum(case when month(orders.orderDate) = '4' and year(orders.orderDate) = '2005' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as apr_5,
		sum(case when month(orders.orderDate) = '5' and year(orders.orderDate) = '2005' then orderdetails.quantityOrdered * orderdetails.priceEach else 0 end) as may_5,
        (STDDEV(orderdetails.quantityOrdered * orderdetails.priceEach))/AVG(orderdetails.quantityOrdered * orderdetails.priceEach) * 100 as std_value
from orderdetails
left join
orders
on
orderdetails.orderNumber = orders.orderNumber
group by orderdetails.productCode;
-- Из таблицы видно, что у всех товаров нестабильный спрос, т.е. коэф. вариации > 20.
-- Посмотрим на эту информацию в разрезе годов, м.б. что-то было по другому.
-- Используем Python.