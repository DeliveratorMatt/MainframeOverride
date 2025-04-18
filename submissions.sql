--First just exploring what the columns are of each table
\d emptystack_accounts
\d forum_accounts
\d forum_posts

--Find all the forum posts made in April 2048
--(Actually, I screwed up the syntax, and ended up finding the titles of the posts from April 2048):
SELECT title FROM forum_posts WHERE date between '2048-04-01' and '2048-04-30';
--Since only one was in English, and its topic was relevant, I then just looked at that post:
SELECT content FROM forum_posts WHERE title LIKE 'Get%';
--Then I realized I needed the username as well:
SELECT content, author, title FROM forum_posts WHERE title LIKE 'Get%';
--Looks like smart-money-44 is our man, so now I need to get his last name from forum_accounts (to find his dad):
SELECT last_name FROM forum_accounts WHERE username LIKE 'smart%';
--Hmm, that gave me two people; let me try again:
SELECT last_name FROM forum_accounts WHERE username LIKE 'smart-mo%';
--Still two people...
SELECT last_name FROM forum_accounts WHERE username = 'smart-money-44';
--That narrows it down to Steele. Need to find both Steeles:
SELECT * FROM forum_accounts WHERE last_name = 'Steele';
--Well crap there are three: Brad is the son, so we don't need to worry about him
--But we need to figure out which of Andrew and Kevin is the EmptyStack employee:
SELECT * FROM emptystack_accounts WHERE last_name = 'Steele';
--Once again there are two Steeles, but it's not Lance, since he is not on the forum
--Hence, Andrew is Brad's Dad! His username is triple-cart-38; password is password456 
