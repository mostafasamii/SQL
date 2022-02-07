# Case Study #1 - Danny's

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%231%20-%20Danny's%20Diner/images/1.png )

#Introduction

Danny seriously loves Japanese food so in the beginning of 2021, he decides to embark upon a risky venture and opens up a cute little restaurant that sells his 3 favorite foods: sushi, curry and ramen.

Danny’s Diner is in need of your assistance to help the restaurant stay afloat - the restaurant has captured some very basic data from their few months of operation but have no idea how to use their data to help them run the business.


#Probelm Statement

Danny wants to use the data to answer a few simple questions about his customers, especially about their visiting patterns, how much money they’ve spent and also which menu items are their favourite. Having this deeper connection with his customers will help him deliver a better and more personalised experience for his loyal customers.

He plans on using these insights to help him decide whether he should expand the existing customer loyalty program - additionally he needs help to generate some basic datasets so his team can easily inspect the data without needing to use SQL.

Danny has provided you with a sample of his overall customer data due to privacy issues - but he hopes that these examples are enough for you to write fully functioning SQL queries to help him answer his questions!

Danny has shared with you 3 key datasets for this case study:
* Sales
* Menu
* Members

You can inspect the Entity Relationship Diagram (ERD) and example data below
## Entity Relationship Diagram

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%231%20-%20Danny's%20Diner/images/ERD.PNG)

## Example Datasets
All datasets exist within the **dannys_diner** database schema - be sure to include this reference within your SQL scripts as you start exploring the data and answering the case study questions.


### Table 1: Sales
The sales table captures all customer_id level purchases with an corresponding order_date and product_id information for when and what menu items were ordered.

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%231%20-%20Danny's%20Diner/images/SalesTable.PNG)

### Table 2: Menu

The menu table maps the product_id to the actual product_name and price of each menu item.

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%231%20-%20Danny's%20Diner/images/MenuTable.PNG)

### Table 3: Members
The final members table captures the join_date when a customer_id joined the beta version of the Danny's Diner loyalty program

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%231%20-%20Danny's%20Diner/images/MembersTable.PNG)

# Case Study Questions

1- What is the total amount each customer spent at the restaurant?

2- How many days has each customer visited the restaurant?

3- What was the first item from the menu purchased for each customer?

4- What is the most purchased item on the menu and how many times was it purchased by all customers?

5- Which item was the most popular for each customer?

6- Which item was purchased first by the customer after they became member?

7- Which item was purchased just before the customer became a member?

8- What is the total items and amount spent for each member before they became a member?

9- If each 1$ spent equates to 10 points and such has a 2x points multiplier - How many points would each customer have?

10- In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?


# Bonus questions

* Creating basic data tables that Danny and his team can use to quickly derive insights without needing to join the underlying tables using SQL.

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%231%20-%20Danny's%20Diner/images/bonusquestion_1.PNG)

* Danny also requires further information about the ranking if customers products, but he purposely does not need the ranking for non-member
purchases so he expect null ranking values for the records when customers are not yet part of the loyalty program.

![Image of Interface](https://github.com/mostafasamii/SQL/blob/main/8-weeks-SQL-challenge/Case%20Study%20%231%20-%20Danny's%20Diner/images/bonusquestion_2.PNG)
