use classicmodels;

select *
from orders;

select *
from customers;

select *
from orderdetails;

select *
from productlines;

select *
from products;

# Посчитаем общее число заказов
select count(orders.orderNumber)
from orders;

# Для ABC-анализа необходимо выявить долю того или иного продукта в общем объеме продаж.
# Для начала запросим все категории и товары, посчитаем кол-во покупок данного товара,
# средний объем покупок, цену покупки и цену продажи, затраты, грязную и чистую прибыль

select 
		productlines.productLine,
		products.productName,
        products.productCode,
        count(orderdetails.productCode) as counts,
        avg(orderdetails.quantityOrdered) as avg_count_in_order,
        products.buyPrice as buy_price,
        orderdetails.priceEach,
		orderdetails.quantityOrdered * products.buyPrice as costs,
        orderdetails.quantityOrdered * orderdetails.priceEach as profit,
        orderdetails.quantityOrdered * orderdetails.priceEach - orderdetails.quantityOrdered * products.buyPrice as net_profit
from 
productlines
left join 
products
on
productlines.productLine = products.productLine
left join 
orderdetails
on 
products.productCode = orderdetails.productCode
group by 
orderdetails.productCode
order by 
net_profit
desc,
counts
desc;

# Далее добавим кол-во товаров в заказах.
# Сначала общее, потом посчитаем среднее.

select productCode,
priceEach,
quantityOrdered * priceEach as total_value
from orderdetails
group by productCode