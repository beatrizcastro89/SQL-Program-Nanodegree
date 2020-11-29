/* SELECT, FROM */
/* SELECT indicates which column(s) you want to be given the data for.
FROM specifies from which table(s) you want to select the columns. Notice the
columns need to exist in this table. If you want to be provided with the data
from all columns in the table, you use "*", like so:
SELECT * FROM orders
Note that using SELECT does not create a new table with these columns in the
database, it just provides the data to you as the results, or output, of this
command. You will use this SQL SELECT statement in every query in this course,
but you will be learning a few additional statements and operators that can be
used along with them to ask more advanced questions of your data. */
SELECT id, account_id, occurred_at
FROM orders;

/* LIMIT */
/* We have already seen the SELECT (to choose columns) and FROM (to choose
tables) statements. The LIMIT statement is useful when you want to see just the
first few rows of a table. This can be much faster for loading than if we load
the entire dataset. The LIMIT command is always the very last part of a query.*/
SELECT occurred_at, account_id, channel
FROM web_events
LIMIT 15

/* ORDER BY */
/* AFTER FROM, BEFORE LIMIT */
/* The ORDER BY statement allows us to sort our results using the data in any
column. If you are familiar with Excel or Google Sheets, using ORDER BY is
similar to sorting a sheet using a column. A key difference, however, is that
using ORDER BY in a SQL query only has temporary effects, for the results of
that query, unlike sorting a sheet by column in Excel or Sheets. In other words,
when you use ORDER BY in a SQL query, your output will be sorted that way, but
then the next query you run will encounter the unsorted data again. It's
important to keep in mind that this is different than using common spreadsheet
software, where sorting the spreadsheet by column actually alters the data in
that sheet until you undo or change that sorting. This highlights the meaning
and function of a SQL "query." The ORDER BY statement always comes in a query
after the SELECT and FROM statements, but before the LIMIT statement. If you
are using the LIMIT statement, it will always appear last. As you learn
additional commands, the order of these statements will matter more. */
/* ORDER BY * DESC - ORDER IN DESCENDING ORDER */
/* DEFAULT IS ASCENDING ORDER */
SELECT id, occurred_at, total_amt_usd
FROM orders
ORDER BY occurred_at
LIMIT 10;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd
LIMIT 20;

/* USING ORDER BY WITH MORE THAN ONE COLUMN */
SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY account_id, total_amt_usd DESC;

SELECT id, account_id, total_amt_usd
FROM orders
ORDER BY total_amt_usd DESC, account_id;

/* WHERE */
/* Using the WHERE statement, we can display subsets of tables based on
conditions that must be met. You can also think of the WHERE command as
filtering the data.*/
/* GOES AFTER FROM, BEFORE ORDER BY OR LIMIT */
/* Common symbols used in WHERE statements include:
> (greater than)
< (less than)
>= (greater than or equal to)
<= (less than or equal to)
= (equal to)
!= (not equal to) */
SELECT *
FROM orders
WHERE gloss_amt_usd >= 1000
LIMIT 5;

SELECT *
FROM orders
WHERE total_amt_usd < 500
LIMIT 10;

/* The WHERE statement can also be used with non-numeric data. We can use the
= and != operators here. You need to be sure to use single quotes (just be
careful if you have quotes in the original text) with the text data, not double
quotes. Commonly when we are using WHERE with non-numeric data fields, we use
the LIKE, NOT, or IN operators. */
SELECT name, website, primary_poc
FROM accounts
WHERE name = 'Exxon Mobil';

/* DERIVED COLUMNS */
/* Creating a new column that is a combination of existing columns is known as
a derived column (or "calculated" or "computed" column). Usually you want to
give a name, or "alias," to your new column using the AS keyword.
This derived column, and its alias, are generally only temporary, existing just
for the duration of your query. The next time you run a query and access this
table, the new column will not be there.
If you are deriving the new column from existing columns using a mathematical
expression, then these familiar mathematical operators will be useful:
* (Multiplication)
+ (Addition)
- (Subtraction)
/ (Division)
*/
SELECT (standard_amt_usd / standard_qty) AS standard_unit_price, id, account_id
FROM orders
LIMIT 10;

SELECT (standard_amt_usd / (standard_amt_usd + gloss_amt_usd + poster_amt_usd))
AS standard_percentage, (gloss_amt_usd / (standard_amt_usd + gloss_amt_usd +
  poster_amt_usd)) AS gloss_percentage, (poster_amt_usd / (poster_amt_usd +
    gloss_amt_usd + poster_amt_usd)) AS poster_percentage, id, account_id
FROM orders
LIMIT 10;

/* LOGICAL OPERATORS */
/* In the next concepts, you will be learning about Logical Operators.
Logical Operators include:

LIKE
This allows you to perform operations similar to using WHERE and =, but for
cases when you might not know exactly what you are looking for.

IN
This allows you to perform operations similar to using WHERE and =,
but for more than one condition.

NOT
This is used with IN and LIKE to select all of the rows NOT LIKE or NOT IN a
certain condition.

AND & BETWEEN
These allow you to combine operations where all combined conditions
must be true.

OR
This allow you to combine operations where at least one of the combined
conditions must be true./*

/* LIKE */
/* The LIKE operator is extremely useful for working with text. You will use
LIKE within a WHERE clause. The LIKE operator is frequently used with %. The %
tells us that we might want any number of characters leading up to a particular
set of characters or following a certain set of characters. Remember you will
need to use single quotes for the text you pass to the LIKE operator, because
of this lower and uppercase letters are not the same within the string.
Searching for 'T' is not the same as searching for 't'. In other SQL
environments (outside the classroom), you can use either single or double
quotes. */
SELECT *
FROM accounts
WHERE name LIKE 'C%';

SELECT *
FROM accounts
WHERE name LIKE '%one%';

SELECT *
FROM accounts
WHERE name LIKE '%s';

/* IN */
/* The IN operator is useful for working with both numeric and text columns.
This operator allows you to use an =, but for more than one item of that
particular column. We can check one, two or many column values for which we
want to pull data, but all within the same query. In the upcoming concepts, you
will see the OR operator that would also allow us to perform these tasks, but
the IN operator is a cleaner way to write these queries.

In most SQL environments, you can use single or double quotation marks - and
you may NEED to use double quotation marks if you have an apostrophe within
the text you are attempting to pull. */
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords');

/* NOT */
/* The NOT operator is an extremely useful operator for working with the
previous two operators we introduced: IN and LIKE. By specifying NOT LIKE or
NOT IN, we can grab all of the rows that do not meet a particular criteria. */
SELECT name, primary_poc, sales_rep_id
FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');

SELECT *
FROM web_events
WHERE channel NOT IN ('organic', 'adwords');

SELECT *
FROM accounts
WHERE name NOT LIKE 'C%';

SELECT *
FROM accounts
WHERE name NOT LIKE '%one';

SELECT *
FROM accounts
WHERE name NOT LIKE '%s';

/* AND */
/* The AND operator is used within a WHERE statement to consider more than one
logical clause at a time. Each time you link a new statement with an AND, you
will need to specify the column you are interested in looking at. You may link
as many statements as you would like to consider at the same time. This
operator works with all of the operations we have seen so far including
arithmetic operators (+, *, -, /). LIKE, IN, and NOT logic can also be linked
together using the AND operator. */

/* BETWEEN */
/* Sometimes we can make a cleaner statement using BETWEEN than we can using
AND. Particularly this is true when we are using the same column for different
parts of our AND statement. In the previous video, we probably should have
used BETWEEN. */
SELECT *
FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;

SELECT NAME
FROM accounts
WHERE name NOT LIKE 'C%' AND name LIKE '%s';

SELECT occurred_at, gloss_qty
FROM orders
WHERE gloss_qty BETWEEN 24 AND 29;

SELECT *
FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01'
AND '2017-01-01'
ORDER BY occurred_at DESC;

/* OR */
/* Similar to the AND operator, the OR operator can combine multiple
statements. Each time you link a new statement with an OR, you will need to
specify the column you are interested in looking at. You may link as many
statements as you would like to consider at the same time. This operator works
with all of the operations we have seen so far including arithmetic operators
(+, *, -, /), LIKE, IN, NOT, AND, and BETWEEN logic can all be linked together
using the OR operator.

When combining multiple of these operations, we frequently might need to use
parentheses to assure that logic we want to perform is being
executed correctly.  */
SELECT id
FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

SELECT *
FROM orders
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);

SELECT name
FROM accounts
WHERE (name LIKE 'C%' OR name LIKE 'W%')
AND ((primary_poc LIKE '%ana%' OR primary_poc LIKE '%Ana%')
AND primary_poc NOT LIKE '%eana%');

/* Commands

Statement |	How to Use It	| Other Details
SELECT |	SELECT Col1, Col2, ...	| Provide the columns you want
FROM |	FROM Table	| Provide the table where the columns exist
LIMIT |	LIMIT 10	| Limits based number of rows returned
ORDER BY |	ORDER BY Col	| Orders table based on the column. Used with DESC.
WHERE	| WHERE Col > 5	| A conditional statement to filter your results
LIKE	| WHERE Col LIKE '%me%'	| Only pulls rows where column has 'me' within
the text
IN	| WHERE Col IN ('Y', 'N') |	A filter for only rows with column of 'Y' or 'N'
NOT	| WHERE Col NOT IN ('Y', 'N') |	NOT is frequently used with LIKE and IN
AND	| WHERE Col1 > 5 AND Col2 < 3	| Filter rows where two or more conditions
must be true
OR	| WHERE Col1 > 5 OR Col2 < 3	| Filter rows where at least one condition
must be true
BETWEEN	| WHERE Col BETWEEN 3 AND 5	| Often easier syntax than using an AND
Other Tips
Though SQL is not case sensitive (it doesn't care if you write your statements
as all uppercase or lowercase), we discussed some best practices.
The order of the key words does matter!

Notice, you can retrieve different columns than those being used in the
ORDER BY and WHERE statements. Assuming all of these column names existed in
this way (col1, col2, col3, col4, col5) within a table called table1, this
query would run just fine. */
