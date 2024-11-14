# Netflix Data Analysis with Python, SQL, and Tableau
### Data Collection
Data were downloaded on Kaggle as the data are here : https://www.kaggle.com/datasets/shivamb/netflix-shows 
and then uploaded the data to SQL using python, the codes of python exist in seperated file.
### Data Cleaning
1. check for any duplicates and created new table after dealing with these duplicates
2. there are variables like director, country and listedin have more than one value in one row which means that the movie or TV Show has more than one director, in more than one country, and has more than type like comedy, horror, drama and so on. To deal with that, new tables were created and only unique values were there, for example:
`SELECT show_id, director, value as director2
into netflix_director
--, value AS director 
FROM netflix_titles 
CROSS APPLY STRING_SPLIT(director, ',')
`
3. dealing with some of missing values in the data, there are many directors who directed movies in certain country, for the same director, there are movies which have missing in their country but there are another movies which their country has a value, so it's solved by the following code:
`use Analysis
insert into [dbo].[netflix_country]
select show_id,netflix.country--,dc.country2
from Analysis..netflix_titles netflix
inner join (
select director2,country2
from Analysis..netflix_director d
inner join Analysis..netflix_country c
on d.show_id= c.show_id 
group by director2,country2) dc
on netflix.director = dc.director2
where netflix.country is null`
4. for more details, look at Sql query for data cleaning
### Data Analysis
Some questions are answered:
1. for each director count the Number of movies and tv shows created by them
2. which country has highest number of comedy movies?
3. for each year (as per date_added to netflix), which director has maximum number of movies released
4. what's average duration of movies in each genre
5. find the list of directors who have created horror and comedy movies both
### Dashboard by Tabloau
final step was extracting queries to build dashboard, the queries answered the following questions:
1. Number of titles, countries, avgerage duration, director
2. Counts based on type of the show whether movie or TV 
3. Counts of shows categorized by country and year
4. top 5 categories in netflix
5. Top 5 directors
6. How many people who rated the movies, grouped by different ratings





