-- found ???? characters in title column refers to japanese movies but because of varchar this doesn't access foriegn characters

SELECT *
  FROM [Analysis].[dbo].[netflix_titles]
  order by title 

  -- solve the problem by creating an empty table with the new datatypes
  create table [dbo].[netflix_titles] (
  show_id varchar(10) null,
  type varchar(10) null,
  title nvarchar(200) null,
  director varchar(250) null,
  cast varchar(1000) null,
  country varchar(150) null,
  date_added varchar(20) null,
  release_year int null,
  rating varchar(10) null,
  duration varchar(10) null,
  listed_in varchar(100) null,
  description varchar(500) null)

  Go

  -- check for duplicates
  --1 duplicates in Show_id -- No duplicates
  select show_id, count(*)
  from Analysis..netflix_titles
  group by show_id
  having count(*) >1

  --2 duplicates in title

  select * 
  from [dbo].[netflix_titles]
  where title in (
  select title,type,count(*)
  from Analysis..netflix_titles
  group by title,type
  having count(*) >1)
  order by title

-- 

with cte_duplicate as(
select *,
row_number() over(partition by title, type order by show_id) as rn
from [dbo].[netflix_titles])

select * 
into netflix_without_duplicates
from cte_duplicate 
where rn =1

-- new table for listed in, director, country, cast

SELECT show_id, director, value as director2
into netflix_director
--, value AS director 
FROM netflix_titles 
CROSS APPLY STRING_SPLIT(director, ',')

SELECT show_id, listed_in, value as listedin2
into netflix_listedin
--, value AS director 
FROM netflix_titles 
CROSS APPLY STRING_SPLIT(listed_in, ',')

SELECT show_id, country, value as country2
into netflix_country
--, value AS director 
FROM netflix_titles 
CROSS APPLY STRING_SPLIT(country, ',')

SELECT show_id, cast, value as cast2
into netflix_cast
--, value AS director 
FROM netflix_titles 
CROSS APPLY STRING_SPLIT(cast, ',')

-- data type conversions for date added

-- populate missing values in country, duration columns
-- country columns 831 missing we fixed 196
use Analysis
insert into [dbo].[netflix_country]
select show_id,netflix.country,dc.country2
from Analysis..netflix_titles netflix
inner join (
select director2,country2
from Analysis..netflix_director d
inner join Analysis..netflix_country c
on d.show_id= c.show_id 
group by director2,country2) dc
on netflix.director = dc.director2
where netflix.country is null

-- duration columns 3 missing

with cte_duplicate as(
select *,
row_number() over(partition by title, type order by show_id) as rn
from [dbo].[netflix_titles])

select show_id,type,title, cast(date_added as date) as date_added, release_year,rating,
	case when duration is null then rating else duration end as duration, description
into netflix_final_duplicate
from cte_duplicate 
--where rn =1

drop table netflix_after_durationedit_wzduplicate








--know any database you worked on as the code above give us an error connecting to table
SELECT DB_NAME() AS CurrentDatabase;


