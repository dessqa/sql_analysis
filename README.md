# Первый проект по анализу БД SQL.
Данный проект направлен на развитие способностей и знаний в SQL.

## Схема БД 

![Image alt](https://github.com/dessqa/sql_analysis/raw/main/illustration.png)

### 1. Общий объем выручки по имеющимся заказам
Сюда входят все заказы с разными статусами (Shipped, Hold on, etc.)
Построим график распределения денежных потоков. [SQL запрос](https://github.com/dessqa/sql_analysis/blob/main/volume_of_sales/sql_analysis_total_sales.sql)


![Image alt](https://github.com/dessqa/sql_analysis/blob/volume-of-sales/volume_of_sales/volume_of_sales.png)

### 2. ABC-анализ
Цель – выявить долю того или иного продукта в общем объеме продаж.
<details><summary>Теория</summary>
<p>

Этот инструмент широко используется в розничной торговле и позволяет увидеть, какое торговое направление генерирует выручку, а какие группы товаров совсем плохо продаются и не приносят выгоды бизнесу.

Основой для расчета является прибыль или выручка на конкретную группу товаров или определенный продукт. Результаты анализа продаж товаров помогают принимать решения в области ассортиментной политики.

В основе метода АВС лежит известный принцип Парето: 80% всей выручки приносят 20% проданных товаров. По результату все анализируемые товары разделятся на три группы:

Группа А. Двигатели торговли, занимают долю от 0 до 80% выручки нарастающим итогом;
Группа В. Товары, спрос на которые хорош, но выручки на них приходится от 81% до 95% нарастающим итогом;
Группа С. Товары этой группы имеют долю свыше 96% выручки нарастающим итогом, приносят мало прибыли, являются нерентабельными.

</p>
</details>


![Image alt](https://github.com/dessqa/sql_analysis/blob/main/abc-analysis/abc-analysis.png)

#### Результат

|productLine|sum_profit|percent|total|cat_ABC
|---|---|---|---|---|
|`Classic Cars`|3853922.49|40.127509|40|`A`|
|`Vintage Cars`|1797559.63|18.716409|59|`A`|
|`Motorcycles`|1121426.12|11.676425|71|`A`|
|`Trucks and Buses`|1024113.57|10.663195|81|`B`|
|`Planes`|954637.54|9.939802|91|`B`|
|`Ships`|663998.34|6.913631|98|`C`|
|`Trains`|188532.92|1.963028|100|`C`|

#### Вывод
1. Категории `Classic Cars`, `Vintage Cars`, `Motorcycles` продаются лучше и больше приносят прибыли в соответствии с принципом Парето.
2. На категории `Trucks and Buses`, `Planes` стоит обратить внимание, поскольку спрос на них меньше, однако, прибыль всё таки есть.
3. От категорий `Ships`, `Trains` следует отказаться, т.к. прибыль минимальна.