/*
 Завдання на SQL до лекції 03.
 */


/*
1.
Вивести кількість фільмів в кожній категорії.
Результат відсортувати за спаданням.
*/
SELECT
    count(film_id) AS film_count,
    c.name
FROM
    film_category
LEFT JOIN category c
    ON film_category.category_id = c.category_id
GROUP BY
    c.name
ORDER BY
    film_count DESC;

/*
2.
Вивести 10 акторів, чиї фільми брали на прокат найбільше.
Результат відсортувати за спаданням.
*/
SELECT
    count(inv.film_id) AS rentals_count,
    fa.actor_id AS actor
FROM
    rental
LEFT JOIN inventory inv
    ON rental.inventory_id = inv.inventory_id
LEFT JOIN film_actor fa
    ON inv.film_id = fa.film_id
GROUP BY
    actor
ORDER BY
    rentals_count DESC
LIMIT 10


/*
3.
Вивести категорія фільмів, на яку було витрачено найбільше грошей
в прокаті
*/
SELECT
    c.name AS category_name,
    SUM(amount) AS payments
FROM payment
LEFT JOIN rental r
    ON payment.rental_id = r.rental_id
LEFT JOIN inventory i
    ON i.inventory_id = r.inventory_id
LEFT JOIN film_category fc
    ON i.film_id = fc.film_id
LEFT JOIN category c
    ON c.category_id = fc.category_id
GROUP BY
    category_name
ORDER BY
    payments DESC
LIMIT 1


/*
4.
Вивести назви фільмів, яких не має в inventory.
Запит має бути без оператора IN
*/
SELECT
    f.title
FROM film f
LEFT OUTER JOIN inventory i
    ON f.film_id = i.film_id
WHERE i.inventory_id IS NULL


/*
5.
Вивести топ 3 актори, які найбільше зʼявлялись в категорії фільмів “Children”.
*/
SELECT
     first_name || ' ' || last_name AS actor,
     count(fa.film_id) AS qty
FROM category ca
LEFT JOIN film_category fc
    ON ca.category_id = fc.category_id
LEFT JOIN film_actor fa
    ON fc.film_id = fa.film_id
LEFT JOIN actor
    ON actor.actor_id = fa.actor_id
WHERE name = 'Children'
GROUP BY
    actor
ORDER BY
    qty DESC
LIMIT 3