use sakila;

# 1- Afficher les 10 locations les plus longues (nom/prenom client, film, video club, durée)
select customer.last_name,customer.last_name,film.title,store.store_id,datediff(return_date,rental_date) as df
from customer
join rental
on customer.customer_id = rental.customer_id
join inventory
on inventory.inventory_id = rental.inventory_id
join film
on film.film_id = inventory.film_id
join store
on store.store_id = customer.store_id
order by df desc
limit 10;

#2- Afficher les 10 meilleurs clients actifs par montant dépensé (nom/prénom client, montant dépensé)
select customer.first_name,customer.last_name,sum(amount) as montant
from payment
join customer
on payment.customer_id = customer.customer_id
group by payment.customer_id
order by montant desc
limit 10

#3- Afficher la durée moyenne de location par film triée de manière descendante
select  AVG(datediff(return_date,rental_date)) as moy ,film.title
from rental
join inventory
on rental.inventory_id = inventory.inventory_id
join film
on film.film_id = inventory.film_id
group by film.film_id
order by moy desc 
limit 10;

#4- Afficher tous les films n'ayant jamais été empruntés
select film.title ,rental.rental_date
from film
join inventory
on film.film_id = inventory.film_id
join rental
on rental.inventory_id = inventory.inventory_id
where rental.rental_id is null ;

#5- Afficher le nombre d'employés (staff) par video club
select count(staff_id),store.store_id
from staff
join store
on store.store_id = staff.store_id
group by store_id;

#6- Afficher les 10 villes avec le plus de video clubs
select count(store_id) as c,city.city
from store
join address
on store.address_id = address.address_id
join city
on address.city_id = city.city_id
group by city.city_id
order by c desc
limit 10;

#7- Afficher le film le plus long dans lequel joue Johnny Lollobrigida
select film.title,actor.first_name,actor.last_name,film.length
from film
join film_actor
on film.film_id = film_actor.film_id
join actor
on film_actor.actor_id = actor.actor_id
where first_name='Johnny' and last_name='Lollobrigida'
order by length desc
limit 10;
 
#8- Afficher le temps moyen de location du film 'Academy dinosaur'
select film.title, avg(datediff(rental.return_date,rental.rental_date)) as moy
from film
join inventory
on film.film_id=inventory.film_id
join rental
on rental.inventory_id=inventory.inventory_id
where film.title="Academy dinosaur"
group by film.title
limit 10;

#9- Afficher les films avec plus de deux exemplaires en invenatire (store id, titre du film, nombre d'exemplaires)
select count(inventory.inventory_id) as nbre_exmp, film.title, inventory.store_id 
from inventory
join film
on film.film_id=inventory.film_id
group by inventory.store_id, film.title
having nbre_exmp >=2
limit 10;

#10- Lister les films contenant 'din' dans le titre: 
select film.title
from film
where film.title like "%din%";

#11- Lister les 5 films les plus empruntés
select film.title, count(rental.rental_id) as cr
from film
join inventory
on film.film_id=inventory.film_id
join rental
on rental.inventory_id=inventory.inventory_id
group by rental.inventory_id
order by cr desc
limit 5;

#12- Lister les films sortis en 2003, 2005 et 2006
select film.title, release_year
from film
where film.release_year in (2003, 2005, 2006);

#13- Afficher les films ayant été empruntés mais n'ayant pas encore été restitués,
#triés par date d'emprunt. Afficher seulement les 10 premiers.
select film.title, rental.rental_date, rental.return_date
from film
join inventory
on film.film_id=inventory.film_id
join rental
on rental.inventory_id=inventory.inventory_id
where rental.return_date is null
order by rental.rental_date desc
limit 10;

#14- Afficher les films d'action durant plus de 2h
select film.title, film.length, category.name
from film
join film_category
on film_category.film_id=film.film_id
join category
on category.category_id=film_category.category_id
where category.name='action'
and   film.length >=120;

#15- Afficher tous les utilisateurs ayant emprunté des films avec la mention NC-17
select customer.first_name, customer.last_name, film.rating, customer.customer_id
from film
join inventory
on film.film_id=inventory.film_id
join rental
on rental.inventory_id=inventory.inventory_id
join customer
on customer.customer_id=rental.customer_id
where film.rating ='NC-17';

#16- Afficher les films d'animation dont la langue originale est l'anglais
select film.title, category.name
from film
join language
on film.original_language_id=language.language_id
join film_category
on film_category.film_id=film.film_id
join category
on category.category_id=film_category.category_id
where language.name='english' and category.name='animation'  ;

#17- Afficher les films dans lesquels une actrice nommée Jennifer a joué (bonus: en même temps qu'un acteur nommé Johnny)
select film.title, actor.first_name
from film
join film_actor on film.film_id = film_actor.film_id
join actor on actor.actor_id=film_actor.actor_id 
where actor.first_name='Jennifer' and first_name='Johnny';

#18- Quelles sont les 3 catégories les plus empruntées?
SELECT c.name, COUNT(rental_date) FROM category AS c
JOIN film_category AS fa ON c.category_id = fa.category_id
JOIN film AS f ON fa.film_id = f.film_id
JOIN inventory AS i ON f.film_id = i.film_id
JOIN rental AS r ON i.inventory_id = r.inventory_id
GROUP BY c.name
ORDER BY COUNT(rental_date) DESC
LIMIT 3;

#19- Quelles sont les 10 villes où on a fait le plus de locations?
SELECT city, COUNT(rental_date) FROM city AS c
JOIN address AS a ON c.city_id = a.city_id
JOIN customer AS cu ON a.address_id = cu.address_id
JOIN rental AS r ON cu.customer_id = r.customer_id
GROUP BY city
ORDER BY COUNT(rental_date) DESC
LIMIT 10;

#20- Lister les acteurs ayant joué dans au moins 1 film
SELECT first_name, last_name, COUNT(title) FROM actor AS a
JOIN film_actor AS fa ON a.actor_id = fa.actor_id
JOIN film AS f ON fa.film_id = f.film_id
GROUP BY first_name, last_name
HAVING COUNT(title) >=1;











