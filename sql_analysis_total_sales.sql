use classicmodels;

select * from customers;

select *
from orders;

select *
from customers;

select *
from orderdetails;products

# Посчитаем общее число заказов
select count(orders.orderNumber)
from orders;

# Посчитаем общую прибыль с каждого заказа.
# Потом объединим с таблицей Orders, чтобы вывести статус заказа.
select orderdetails.orderNumber,
	orderdetails.quantityOrdered,
	orderdetails.priceEach,
	(orderdetails.quantityOrdered * orderdetails.priceEach) AS totalPrice,
	orders.status
from orderdetails
left join orders
on orderdetails.orderNumber = orders.orderNumber;

# Далее посчитаем прибыль/потери по всем статусам
select orders.status as "Статус",
	sum(orderdetails.quantityOrdered * orderdetails.priceEach) AS "Денежный оборот"
from orderdetails
left join orders
on orderdetails.orderNumber = orders.orderNumber
group by orders.status
order by sum(orderdetails.quantityOrdered * orderdetails.priceEach) desc;

# Если учесть, что полученные цифры по данному запросу это потенциальная прибыль магизина,
# можно посчитать процент потерь по каждому статусу
select sum(orderdetails.quantityOrdered * orderdetails.priceEach) AS "Потенциальная прибыль компании"
from orderdetails
left join orders
on orderdetails.orderNumber = orders.orderNumber;

# Теперь можем посчитать процент прибыли/потерь
select orders.status as "Статус",
	sum(orderdetails.quantityOrdered * orderdetails.priceEach) AS "Денежный оборот", #Считаем сумму заказов по статусам
	((sum(orderdetails.quantityOrdered * orderdetails.priceEach) / (
    	select sum(quantityOrdered * priceEach) #Считаем всю прибыль (с отказами, холдами и  прочим)
		from orderdetails)) * 100) as "Процентное соотношение прибыли/затрат на общую потенциальную прибыль"
from orderdetails
left join orders
on orderdetails.orderNumber = orders.orderNumber
group by orders.status
order by sum(orderdetails.quantityOrdered * orderdetails.priceEach) desc;

# Теперь считаем объем продаж по кол-ву купленных товаров
select 
	orderdetails.productCode as "Код товара",
	orders.status,
	sum(orderdetails.quantityOrdered) as "Сумма товаров"
from orderdetails
left join orders
on orderdetails.orderNumber = orders.orderNumber
group by orderdetails.productCode, orders.status
order by orderdetails.productCode, orders.status desc