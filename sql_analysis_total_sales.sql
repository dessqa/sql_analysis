use classicmodels;

select * from customers;

select *
from orders;

select *
from customers;

select *
from orderdetails;

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
select 
		sum(orderdetails.quantityOrdered * orderdetails.priceEach) AS totalPrice,
        orders.status
from orderdetails
left join orders
on orderdetails.orderNumber = orders.orderNumber
group by orders.status

