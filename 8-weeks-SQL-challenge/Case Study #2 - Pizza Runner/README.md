# Case Study #1 - Danny's

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%232%20-%20Pizza%20Runner/images/2.png)

# Introduction

Did you know that over 115 million kilograms of pizza is consumed daily worldwide??? (Well according to Wikipedia anyway…)

Danny was scrolling through his Instagram feed when something really caught his eye - “80s Retro Styling and Pizza Is The Future!”

Danny was sold on the idea, but he knew that pizza alone was not going to help him get seed funding to expand his new Pizza Empire - so he had one more genius idea to combine with it - he was going to Uberize it - and so Pizza Runner was launched!

Danny started by recruiting “runners” to deliver fresh pizza from Pizza Runner Headquarters (otherwise known as Danny’s house) and also maxed out his credit card to pay freelance developers to build a mobile app to accept orders from customers.


# Available Data

Because Danny had a few years of experience as a data scientist - he was very aware that data collection was going to be critical for his business’ growth.

He has prepared for us an entity relationship diagram of his database design but requires further assistance to clean his data and apply some basic calculations so he can better direct his runners and optimise Pizza Runner’s operations.

All datasets exist within the pizza_runner database schema - be sure to include this reference within your SQL scripts as you start exploring the data and answering the case study questions.

You can inspect the Entity Relationship Diagram (ERD) and example data below

## Entity Relationship Diagram

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%232%20-%20Pizza%20Runner/images/ERD.PNG)

### Table 1: runners

The runners table shows the registeration_date for each new runner

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%232%20-%20Pizza%20Runner/images/runners.PNG)

### Table 2: customer_orders

Customer pizza orders are captured in the customer_orders table with 1 row for each individual pizza that is part of the order

The pizza_id realtes to the type of pizza which was ordered whilst the exclusions are the ingredient_id values which should be removed from the pizza and the extras are the ingredient_id values which should be added to the pizza.

Note that customers can order multiple pizzas in a single order with varying exclusions and extras values even if the pizza is the same type !

The exclusions and extras columns will need to be cleaned up before using them in your queries.

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%232%20-%20Pizza%20Runner/images/customers_orders.PNG)

### Table 3: runners_orders

After each orders are received through the system - they are assigned to a runner - however not all orders are fully completed and can be cancelled by the restaurant or the customer.

The pickup_time is the timestamp at which the runner arrives at the Pizza Runner Headquarters to pick up the freshly cooked pizzas. The distance and duration fields are related to how far and long the runner had to travel to deliver the order to the respective customer.

There are some known date issues with this table so be careful when using this in your queries - make sure to check the data types for each column in the schema SQL !

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%232%20-%20Pizza%20Runner/images/runnners_orders.PNG)

### Table 4: pizza_names

At the moment - Pizza Runner only has 2 pizzas available the meat lovers or vegetarians

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%232%20-%20Pizza%20Runner/images/pizza_names.PNG)

### Table 5: pizza_recipes

Each pizza_id has a standard set of toppings which are used as part of the pizza recipe.

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%232%20-%20Pizza%20Runner/images/pizza_recipes.PNG)

### Table 6: pizza_toppings

This table contains all of the topping_names values with their corresponding topping_id value

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%232%20-%20Pizza%20Runner/images/pizza_toppings.PNG)

# Case Study Questions

This case study has a LOT of questions - they are broken up by area of focus including:

* Pizza Metrics
* Runner and Customer experience
* Ingredients Optimization
* Pricing and Rating
* Bonus DML challenges (Data Manipulation Language)

Each of the following case study questions can be answered using a single SQL statement.

Again, there are many questions in this case study - please feel free to pick and choose which ones you would like to try !

Before you start writing your SQL queries however - you might want to investigate the data, you may want to do something with some of those null values and data types in the customer_orders and runners_orders tables!

### A. Pizza Metrics

1. How many pizzas were ordered?

2. How many unique customer orders were made?

3. How many successful orders were delivered by each runner?

4. How many of each type of pizza was delivered?

5. How many vegetarian and meatlovers were ordered by each customer?

6. What was the maximum number of pizzas delivered in a single order?

7. For each customer, how many delivered pizzas had at least 1 change and how many has no changes?

8. How many pizzas was delivered that had both exclusions and extras?

9. What was the total volume of orders for each day of the week?

10. What was the volume of orders for each day of the week?

### B. Runner and Customer Expeience

1. How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

2. What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

3. Is there a relationship between the number of pizzas and how long the order takes to prepare?

4. What was the average distance travelled for each customer?

5. What was the difference between the longest and shortest delivery times for all orders?

6. What was the average speed for each runner for each delivery and do you notice any trend for these values?

7. What is the successful delivery percentage for each runner?

### C. Ingredients Optimization

1. What was the standard ingredients for each pizza?

2. What was the most commonly added extra?

3. What was the most common exclusions?

4. Generate an order item for each record in the customer_orders table in the format of one of the following:
  * Meat Lovers
  * Meat Lovers - Exclude Beef
  * Meat Lovers - Extra Bacon
  * Meat Lovers - Exclude Cheese, Bacon - Extra Mushroom, Peppers

5. Generate an alphabetically ordered comma separated ingredient list for each pizza order from the customer_orders table and add a 2x in front of any relevant ingredients. For example: "Meat Lovers: 2xBacon, Beef, ... , Salami"

6. What is the total quantity of each ingredient used in all delivered pizzas sorted by most frequent first?

### D. Pricing and Ratings

1. If a Meat Lovers Pizza costs $12 and Vegetarian costs $10 there were no charges for changes - how much money has Pizza runner made so far if there are no delivery fees?

2. What if there was an additional $1 charge for any pizza extras?
  * add chees is $1 extra

3. The pizza runner tram now wants to add an additional rating system that allows customers to rate their runner, how would you design and additional table for this new dataset - generate a schema for this new table and insert your own data for ratings for each successful customer order between 1 to 5.

4. Using your newly generated table - can you join all of the information together to form a table which has the following information for successful deliveries?
  * customer_id
  * order_id
  * runner_id
  * rating
  * order_time
  * pickup_time
  * time between order and pickup
  * delivery duration
  * average speed
  * total number of pizzas

5. If a Meat Lovers pizza was $12 and Vegetarian $10 fixed prices with no cost for extras and each runner is paid $0.3 per kilometer traveled - how much money does Pizza Runner have left over after these deliveries?

### E. Bonus questions

If Danny wants to expand his range of pizzas - How would this impact the existing data design? Write and INSERT statement to demonstrates what would happen if a new Superme pizza with all the toppings was added to the Pizza Runner menu?
