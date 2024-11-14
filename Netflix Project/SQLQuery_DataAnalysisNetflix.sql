-- Netflix Data Analysis 
/*1- for each director count the no of movies and tv shows created by them in seperate columns 
	for directors who have created tv shows and movies both*/
use Analysis
select nd.director2,
count (distinct case when n.[type] = 'movie' then n.show_id end ) as noOfmovies,
count (distinct case when n.[type] = 'TV Show' then n.show_id end ) as noOftvshow
from [dbo].[netflix_final_duplicate]n
inner join [dbo].[netflix_director] nd
on n.show_id = nd.show_id
group by nd.director2
having count(distinct n.type) >1 

--2- which country has highest number of comedy movies united states

SELECT top 1
    TRIM(c.country2) AS country, 
    COUNT(DISTINCT l.show_id) AS noOfMovies
FROM 
    [dbo].[netflix_country] c
INNER JOIN 
    [dbo].[netflix_listedin] l ON c.show_id = l.show_id
INNER JOIN 
    [dbo].[netflix_final_duplicate] n ON l.show_id = n.show_id
WHERE 
    l.listedin2 = 'comedies' 
    AND n.type = 'movie'
GROUP BY 
    TRIM(c.country2)
ORDER BY 
    noOfMovies DESC

--3- for each year (as per date_added to netflix), which director has maximum number of movies released
;WITH cte AS (
    SELECT 
        nd.director2, 
        COUNT(n.show_id) AS noOfMovies, 
        YEAR(n.date_added) AS yearAdded
    FROM 
        [dbo].[netflix_final_duplicate] n
    INNER JOIN 
        [dbo].[netflix_director] nd ON n.show_id = nd.show_id
    WHERE 
        n.type = 'movie'
    GROUP BY 
        nd.director2, YEAR(n.date_added)
)
, cte2 as (
SELECT *,
rank () over( partition by yearAdded order by noOfMovies desc) as ranking -- rank 1 is the maximum
FROM 
    cte)

select * 
from cte2
where ranking =1
order by yearAdded, noOfMovies desc

-- 4- what's average duration of movies in each genre
select l.listedin2, AVG(cast(replace(n.duration, 'min', '') as int)) as duration
from [dbo].[netflix_final_duplicate] n
inner join [dbo].[netflix_listedin] l on n.show_id = l.show_id 
where n.type = 'movie'
group by l.listedin2
order by     average_duration DESC;

--5- find the list of directors who have created horror and comedy movies both
-- display director names along with number of comedy and horror movies directed by them

SELECT 
    TRIM(nd.director2) AS director 
	,count(distinct case when trim(l.listedin2) ='comedies' then n.show_id end) as noOfComedies
	,count(distinct case when trim(l.listedin2) ='horror movies' then n.show_id end) as noOfHorror

FROM 
    [dbo].[netflix_final_duplicate] n
INNER JOIN 
    [dbo].[netflix_director] nd ON n.show_id = nd.show_id
INNER JOIN 
    [dbo].[netflix_listedin] l ON n.show_id = l.show_id
WHERE 
    n.type = 'movie' 
    AND trim(l.listedin2) IN ('comedies', 'horror movies') 
GROUP BY 
    TRIM(nd.director2)
HAVING 
    COUNT(DISTINCT trim(l.listedin2)) = 2;

-- varify the answer lets say verify this director : Raditya Dika	2	1 Michael Tiddes	4	2  Kevin Smith 5	3 Steve Brill	5	1

select * from [dbo].[netflix_listedin] where show_id in (
select show_id
from [dbo].[netflix_director]
where trim(director2) ='Steve Brill' )

