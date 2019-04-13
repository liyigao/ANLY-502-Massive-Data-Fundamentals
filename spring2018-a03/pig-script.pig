bigram = LOAD 'bigrams/googlebooks-eng-us-all-2gram-20120701-i?' AS (ngram, year:int, occurrences:int, books:int);
filtered = FILTER bigram BY (year>=1950 and year<=2009);
grouped = GROUP filtered BY ngram;
info = FOREACH grouped GENERATE group, COUNT(filtered) AS records, (int)MIN(filtered.year) AS first, (int)MAX(filtered.year) AS last, (int)SUM(filtered.occurrences) AS sum_occur, (int)SUM(filtered.books) AS sum_books;
appear = FILTER info BY records == 60;
result = FOREACH appear GENERATE group, sum_occur, sum_books, ((float)sum_occur/sum_books) AS avg, first, last, records;
sorted = ORDER result BY avg DESC;
top10 = LIMIT sorted 10;
STORE top10 INTO 'pig-results';
