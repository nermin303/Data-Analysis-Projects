

--1- number of titles, countries, avg duration, director

use Analysis
SELECT 
	(SELECT COUNT (*) FROM [dbo].[netflix_final_duplicate]) AS Titles
    (SELECT COUNT(DISTINCT TRIM(director2)) FROM [dbo].[netflix_director]) AS UniqueDirectors, --4988
    (SELECT COUNT(DISTINCT TRIM(country2)) FROM [dbo].[netflix_country]) AS UniqueCountries, --123
    (SELECT COUNT(DISTINCT TRIM(listedin2)) FROM [dbo].[netflix_listedin]) AS UniqueListedIn; --42


--2- COUNTS BASED ON TYPE OF THE SHOW WHETHER MOVIE OR TV SHOW
WITH Counts AS (
    SELECT 
        COUNT(DISTINCT TRIM(director2)) AS CountValue,
        'Director' AS Category,
        TRIM(n.type) AS Type
    FROM [dbo].[netflix_director] d
    INNER JOIN [dbo].[netflix_final_duplicate] n ON d.show_id = n.show_id
    WHERE TRIM(n.type) IN ('movie', 'Tv show')
    
    GROUP BY TRIM(n.type)

    UNION ALL

    SELECT 
        COUNT(DISTINCT TRIM(country2)) AS CountValue,
        'Country' AS Category,
        TRIM(n.type) AS Type
    FROM [dbo].[netflix_country] c
    INNER JOIN [dbo].[netflix_final_duplicate] n ON c.show_id = n.show_id
    WHERE TRIM(n.type) IN ('movie', 'Tv show')
    
    GROUP BY TRIM(n.type)
)

SELECT 
    Category,
    SUM(CASE WHEN Type = 'movie' THEN CountValue ELSE 0 END )AS MovieCount,
    SUM(CASE WHEN Type = 'Tv show' THEN CountValue ELSE 0 END) AS TVShowCount
FROM Counts
GROUP BY Category;

--3-Counts of shows categorized by country and year
SELECT COUNT(N.SHOW_ID) AS Titles,
YEAR(N.DATE_ADDED) AS YEAR, C.COUNTRY2 AS COUNTRY
FROM [dbo].[netflix_final_duplicate] N
inner join [dbo].[netflix_country] C on N.SHOW_ID = C.SHOW_ID
WHERE YEAR(N.DATE_ADDED) IS Not NULL
GROUP BY C.COUNTRY2, YEAR(N.DATE_ADDED)

--4- top 5 categories in netflix
SELECT 
    COUNT(TRIM(listedin2))	AS GenreCount,
    listedin2
FROM 
    [dbo].[netflix_listedin]
GROUP BY 
    listedin2
ORDER BY 
    GenreCount DESC;

-- 5- Top 5 directors

SELECT 
    COUNT(TRIM(director2))
	AS Directors,
    trim(director2) as Director
FROM 
    [dbo].[netflix_director]
GROUP BY 
    trim(director2)
ORDER BY 
    Directors desc

-- 6- Ratings 
SELECT 
    COUNT(TRIM(rating)) AS countRating, 
    TRIM(rating) AS rating 
FROM 
    [dbo].[netflix_final_duplicate]
WHERE 
    rating IS NOT NULL 
    AND TRIM(rating) NOT IN ('84 min', '74 min', '66 min')                                      
GROUP BY 
    TRIM(rating)
ORDER BY 
    countRating;

--7- Total movies by genre


















SELECT COUNT(c.SHOW_ID) AS Titles, YEAR(N.DATE_ADDED) AS YEAR,
 trim( c.country2) as cuntry
FROM [dbo].[netflix_final_duplicate] N
inner join [dbo].[netflix_country] C on N.SHOW_ID = C.SHOW_ID
WHERE YEAR(N.DATE_ADDED) IS NOT NULL
GROUP BY trim (c.country2), YEAR(N.DATE_ADDED)
ORDER BY YEAR(N.DATE_ADDED)



SELECT COUNT(c.SHOW_ID) AS Titles,--EAR(N.DATE_ADDED) AS YEAR,
 trim( c.country2) as cuntry
FROM [dbo].[netflix_final_duplicate] N
inner join [dbo].[netflix_country] C on N.SHOW_ID = C.SHOW_ID
GROUP BY trim (c.country2)
order by COUNT(c.SHOW_ID) desc
