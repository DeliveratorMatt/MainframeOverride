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
--I got a bit stuck here, finally looking all the way back to Hack the Mainframe 
--to figure out how to login as someone else.
--Once I did that, emptystack.sql appeared within my project directory, but then I got stuck again.
--Finally I figured out to do \d to see the list of tables, now with the new ones added.
--Now to look at how the data in messages is organized:
\d emptystack_accounts, \d emptystack_messages, \d emptystack_projects
--Next:
SELECT * FROM emptystack_messages LIMIT 5;
--This showed me that "from" and "to" use the usernames, not some alias.
--So now I need to find a message about taxis?
SELECT * FROM emptystack_messages WHERE body LIKE '%taxi%';
--nada. Maybe I look for messages "to" triple-cart-38?
Too overwhelming.
--I tried a few different things, but ultimately went back to my previous idea,
--only making the LIKE into an ILIKE to avoid casing issues:
SELECT * FROM emptystack_messages WHERE body ILIKE '%taxi%';
--That did it. The project's name is `TAXI`. The admin account is `your-boss-99`
SELECT * FROM emptystack_projects WHERE code ILIKE '%taxi%';
--Looks like the id code for the project is DczE0v2b. Now to get the boss login:
SELECT * FROM emptystack_accounts WHERE username = 'your-boss-99';
Looks like the boss is named Skylar Singer and their pw is `notagaincarter`.
--I quit out of my psql account and ran `node mainframe -stop`, entered the info I found, and succeeded.
