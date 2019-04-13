CREATE EXTERNAL TABLE bigram (
ngram string,
year int,
occurrences int,
books int
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LOCATION '/user/hadoop/bigrams/';
INSERT OVERWRITE DIRECTORY 'hive-results'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
SELECT * FROM (SELECT ngram, SUM(occurrences), SUM(books), SUM(occurrences)/SUM(books) AS average, MIN(year) AS first, MAX(year) AS last, COUNT(year) AS records FROM (SELECT * FROM bigram WHERE year >= 1950 AND year <= 2009) a GROUP BY ngram) b WHERE records = 60 ORDER BY average DESC LIMIT 10;

