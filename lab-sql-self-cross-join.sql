# Lab | SQL Self and cross join

#In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals.
USE sakila;

### Instructions

#1. Get all pairs of actors that worked together.
SELECT * FROM sakila.actor a
JOIN sakila.film_actor b ON a.actor_id = b.actor_id;

SELECT a1.actor_id, a2.actor_id, a1.film_id FROM sakila.film_actor a1
JOIN sakila.film_actor a2 
ON a1.actor_id<a2.actor_id AND a1.film_id = a2.film_id;

SELECT b1.first_name, b1.last_name, b2.first_name, b2.last_name, c.title 
FROM sakila.film_actor a1
JOIN sakila.film_actor a2 
ON a1.actor_id<a2.actor_id AND a1.film_id = a2.film_id
JOIN sakila.actor b1 ON a1.actor_id=b1.actor_id
JOIN sakila.actor b2 ON a2.actor_id = b2.actor_id
JOIN sakila.film c ON a1.film_id=c.film_id;

#2. Get all pairs of customers that have rented the same film more than 3 times.
SELECT a1.first_name, a1.last_name, a2.first_name, a2.last_name, a1.title FROM (
SELECT a.customer_id, a.first_name, a.last_name, b.rental_id, c.inventory_id, d.film_id, d.title
FROM sakila.customer a JOIN sakila.rental b ON a.customer_id=b.customer_id
JOIN sakila.inventory c ON b.inventory_id = c.inventory_id
JOIN sakila.film d ON c.film_id=d.film_id) AS a1
JOIN (SELECT a.customer_id, a.first_name, a.last_name, b.rental_id, c.inventory_id, d.film_id, d.title
FROM sakila.customer a JOIN sakila.rental b ON a.customer_id=b.customer_id
JOIN sakila.inventory c ON b.inventory_id = c.inventory_id
JOIN sakila.film d ON c.film_id=d.film_id
) AS a2 
ON a1.customer_id<a2.customer_id AND a1.film_id = a2.film_id;

/*CREATE TEMPORARY TABLE IF NOT EXISTS sakila.customer_rental_film
SELECT a.customer_id, a.first_name, a.last_name, b.rental_id, c.inventory_id, d.film_id, d.title
FROM sakila.customer a JOIN sakila.rental b ON a.customer_id=b.customer_id
JOIN sakila.inventory c ON b.inventory_id = c.inventory_id
JOIN sakila.film d ON c.film_id=d.film_id;

NOT THE CODE I USED IN THE END
*/

#3. Get all possible pairs of actors and films.
-- Cross join to get all the possible combinations of actors and films
-- It means the pairs actor + film
SELECT * FROM (
  SELECT DISTINCT first_name, last_name FROM sakila.actor
) sub1
CROSS JOIN (
  SELECT DISTINCT title FROM sakila.film
) sub2;