# Q:1 : Afficher tout les emprunt ayant été réalisé en 2006. Le mois doit être écrit en toute
# lettre et le résultat doit s’afficher dans une seul colonne.
SELECT *,date_format(rental_date, '%d %M %y')
FROM sakila.rental
where year(rental_date)=2006;
# Q:2 Afficher la colonne qui donne la durée de location des films en jour.
select *, datediff(return_date, rental_date) as duree_location
from sakila.rental;
# Q:3 Afficher les emprunts réalisés avant 1h du matin en 2005. Afficher la date dans un
# format lisible.
select *,date_format(rental_date, '%d %M %y') 
from sakila.rental
where year(rental_date)= 2005 AND
HOUR (rental_date) <1;
# Q:4 Afficher les emprunts réalisé entre le mois d’avril et le moi de mai. La liste doit être
# trié du plus ancien au plus récent.
select * 
from sakila.rental
where month(rental_date) IN (4,5) order by rental_date ;
# Q:5 Lister les film dont le nom ne commence pas par le « Le »
select * 
from film
where title not like 'le%';
# Q:6 Lister les films ayant la mention « PG-13 » ou « NC-17 ». Ajouter une colonne qui
# affichera « oui » si « NC-17 » et « non » Sinon.

# les jointures:
use sakila;
# Q:1 Lister les 10 premiers films ainsi que leur langu
select title, name as langue
 from film join language
 on film.language_id = language.language_id
 limit 10;
# Q:2 Afficher les film dans les quel à joué « JENNIFER DAVIS » sortie en
# 2006
select film.title , actor.first_name , actor.last_name ,film.release_year
from actor
join film_actor 
on actor.actor_id = film_actor.actor_id
join film
ON film.film_id = film_actor.film_id
WHERE actor.first_name = 'JENNIFER' AND actor.last_name = 'DAVIS' AND film.release_year = 2006;
# Q:3 Afficher le noms des client ayant emprunté « ALABAMA DEVIL »
select title , customer.first_name , customer.last_name 
from customer
join rental
     on rental.customer_id = customer.customer_id
join inventory
     on inventory.inventory_id = rental.inventory_id
join film
     on film.film_id = inventory.film_id
where title ='ALABAMA DEVIL';
# Q:4 Afficher les films louer par des personne habitant à « Woodridge ».
# Vérifié s’il y a des films qui n’ont jamais été emprunté.

select F.title
from film as F
join inventory as I on F.film_id = I.film_id
join rental as R on I.inventory_id = R.inventory_id
join customer as C on R.customer_id = C.customer_id
join address as A on C.address_id = A.address_id
join city as CI on A.city_id = CI.city_id
where city = 'Woodridge'


UNION 

select F.title
from film as F
join inventory as I on F.film_id = I.film_id
 left join rental as R on I.inventory_id = R.inventory_id
where R.rental_id IS NULL;
#Q:5 Quel sont les 10 films dont la durée d’emprunt à été la plus courte
SELECT F.title,
TIMESTAMPDIFF(HOUR, UNIX_TIMESTAMP(RE.rental_date), UNIX_TIMESTAMP(RE.return_date)) as Duree
FROM rental AS RE
INNER JOIN inventory AS INV 
ON INV.inventory_ID=RE.inventory_id 
INNER JOIN film AS F 
ON F.film_id=INV.film_id 
HAVING Duree IS NOT NULL 
ORDER BY Duree ASC 
LIMIT 10;
select title,datediff(R.return_date,R.rental_date) 
from film as F
join inventory as I on F.film_id = I.film_id
join rental as R on I.inventory_id = R.inventory_id
where datediff(R.return_date,R.rental_date)  IS NOT NULL
ORDER BY datediff(R.return_date,R.rental_date) 
LIMIT 10;
 # Q:6 Lister les films de la catégorie « Action » ordonnés par ordre
 # alphabétique
 select F.title from film as F
join film_category as FC on FC.film_id = F.film_id
join category as C on FC.category_id = C.category_id
where C.name = 'action'
ORDER BY F.title;
#Q:7 Quel sont les films dont la duré d’emprunt à été inférieur à 2 jour
select distinct f.title,datediff(r.return_date,r.rental_date)
from film as f 
join inventory as i on f.film_id = i.film_id
join rental as r on i.inventory_id = r.inventory_id 
where datediff(r.return_date, r.rental_date)<2
and datediff(r.return_date, r.rental_date) is not null;
  
  
#  exemple pour mieux comprendre les jointures
SELECT 
    title, language.name
FROM
    film
        LEFT JOIN
    language ON film.language_id = language.language_id;
SELECt
    title, language.name
FROM
    film
        RIGHT JOIN
    language ON film.language_id = language.language_id;
    
    
# mise en pratique des agregations:

# 1. Afficher le nombre de films dans les quels à joué l'acteur « JOHNNY
# LOLLOBRIGIDA », regroupé par catégorie.

select count(title),category.name 
from film
join film_actor
on film.film_id = film_actor.film_id
join actor
on actor.actor_id = film_actor.actor_id
join film_category
on film.film_id = film_category.film_id
join category
on category.category_id = film_category.category_id
where first_name = 'JOHNNY' 
and last_name = 'LOLLOBRIGIDA'
group by category.name 
;
#2. Ecrire la requête qui affiche les catégories dans les quels « JOHNNY
# LOLLOBRIGIDA » totalise plus de 3 films.

select category.name ,count(title) AS nb_films
from film
join film_category
on film.film_id = film_category.film_id
join category
on category.category_id = film_category.category_id
join film_actor
on film.film_id = film_actor.film_id
join actor
on actor.actor_id = film_actor.actor_id

where first_name = 'JOHNNY' 
and last_name = 'LOLLOBRIGIDA'
group by category.name
having nb_films > 3;
#3. Afficher la durée moyenne d'emprunt des films par acteurs.
SELECT actor.first_name ,actor.last_name, AVG(datediff(return_date,rental_date))
FROM rental 
JOIN inventory ON rental.inventory_id = inventory.inventory_id
JOIN film ON inventory.film_id = film.film_id
JOIN film_actor ON film.film_id = film_actor.film_id
JOIN actor ON film_actor.actor_id = actor.actor_id
GROUP BY actor.first_name , actor.last_name;
#4. L'argent total dépensé au vidéos club par chaque clients, classé par
# ordre décroissant.
SELECT sum(payment.amount),customer.last_name,customer.first_name FROM payment  JOIN customer  ON customer.customer_id = payment.customer_id JOIN store ON store.store_id = customer.store_id
GROUP BY customer.last_name, customer.first_name
ORDER BY sum(payment.amount) desc



#1- Quels acteurs ont le prénom "Scarlett "
select first_name,last_name from actor 
where first_name = 'Scarlett';
#2- Quels acteurs ont le nom de famille "Johansson "
select first_name,last_name from actor 
where last_name = 'Johansson';
#3- Combien de noms de famille d'acteurs distincts y a-t-il ?
select distinct count(last_name) from actor ;
#4- Quels noms de famille ne sont pas répétés ? 
select distinct first_name,last_name from actor 
#5- Quels noms de famille apparaissent plus d'une fois ? 
select last_name from actor
group by  last_name
having count(last_name) > 1
#6- Quel acteur est apparu dans le plus grand nombre de films ?
select actor.first_name,actor.last_name,actor.actor_id,count(actor.actor_id) as ca 
from actor
join film_actor
on actor.actor_id = film_actor.actor_id
group by actor_id 
order by ca DESC;
#7- Insérez un enregistrement représentant Mary Smith louant "Academy Dinosaur" de Mike Hillyer au magasin 1 aujourd'hui. 

#8- Quand "Academy Dinosaur" est-il sortie ? 
select release_year,title from film
where title =  "Academy Dinosaur";
#9- Quelle est la durée moyenne de tous les films ? 9- Quelle est la durée moyenne de tous les films ?
SELECT AVG(length) FROM film;
10- Quelle est la durée moyenne des films par catégorie ?
SELECT CA.name, AVG(F.length)
FROM film AS F
INNER JOIN film_category AS FC ON FC.film_id=F.film_id
INNER JOIN category AS CA ON CA.category_id=FC.category_id
GROUP BY CA.name
ORDER BY AVG(length) DESC;
11- Pourquoi cette requête renvoie-t-elle aucun resultats ?
select * from film natural join inventory
Le résultat d’une jointure naturelle est la création d’un tableau avec autant de lignes qu’il y a de
paires correspondant à l’association des colonnes de même nom
Dans ce cas la toutes les paires ne correspondent pas(notamment avec le last_update)






