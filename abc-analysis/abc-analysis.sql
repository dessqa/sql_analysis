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

# Поскольку товаров много, посчитаем сначала по линейкам продукта
# их вклад в общую прибыль.
drop temporary table  temp_table_name;
drop temporary table  temp_table_name_1;

drop temporary table  temp_table_name_2;


CREATE TEMPORARY TABLE temp_table_name_2
select
products.productLine,
sum(orderdetails.quantityOrdered * orderdetails.priceEach) as sum_profit,
sum(orderdetails.quantityOrdered * orderdetails.priceEach) / (

select sum(orderdetails.quantityOrdered * orderdetails.priceEach)
from orderdetails

) * 100 as percent
from
products
left join 
orderdetails
on 
products.productCode = orderdetails.productCode
group by products.productLine
order by sum_profit desc;

select *
from temp_table_name_2;

select s.*,
       round(coalesce(sum(s.percent) over (order by s.percent desc
       rows between unbounded preceding and current row), 
       0)) as total,
		(case
		when round(coalesce(sum(s.percent) over (order by s.percent desc
		rows between unbounded preceding and current row), 
		0)) <= 80 then "A"
		when round(coalesce(sum(s.percent) over (order by s.percent desc
		rows between unbounded preceding and current row), 
		0)) > 80 and round(coalesce(sum(s.percent) over (order by s.percent desc
		rows between unbounded preceding and current row), 
		0)) <= 95 then "B"
		else
		"C"
		end) as cat_ABC
from temp_table_name_2 s