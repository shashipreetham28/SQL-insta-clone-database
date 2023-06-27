-- 1)Find the 5 oldest users.
select username from users order by created_at limit 5;

-- 2) What day of the week do most users register on? We need to figure out when to schedule an ad campaign.
select dayofweek(created_at) as day_number, count(username) as c, dayname(created_at) as day from users group by day_number order by c desc;

-- 3)We want to target our inactive users with an email campaign.Find the users who have never posted a photo
select u.id,u.username from users u left join photos p on u.id = p.user_id where p.user_id is null;

-- 4)We're running a new contest to see who can get the most likes on a single photo.WHO WON??!!
select photo_id,count(l.user_id) as likes_count,u.username as name from likes l 
join photos p on l.photo_id = p.id join users u on p.user_id = u.id group by photo_id order by likes_count desc limit 1; 

-- 5)Our Investors want to know… How many times does the average user post?HINT - *total number of photos/total number of users*
select count(p.id)/count(u.id) as Avg_users_post from users u right join photos p  on u.id = p.id;

-- 6)user ranking by postings higher to lower
select u.username,count(p.image_url) as post_count from photos p 
right join users u on u.id = p.user_id group by username order by post_count desc;

-- 7) total numbers of users who have posted at least one time.
select count(*) as posted_users from users where id in (select user_id from photos);

-- 8) A brand wants to know which hashtags to use in a post
select t.id,t.tag_name,count(pt.tag_id) as tag_count from tags t join photo_tags pt on t.id = pt.tag_id group by tag_name order by tag_count desc limit 1;

-- 9)What are the top 5 most commonly used hashtags?
select id,tag_name,count(tag_id) as tag_count from tags t join photo_tags pt on t.id = pt.tag_id group by tag_name order by tag_count desc limit 5;

-- 10) We have a small problem with bots on our site...Find users who have liked every single photo on the site (SUBQUERY)
SELECT users.id,username, COUNT(users.id) As total_likes_by_user FROM users
JOIN likes ON users.id = likes.user_id GROUP BY users.id HAVING total_likes_by_user = (SELECT COUNT(*) FROM photos);

-- 11)Find users who have never commented on a photo.
select u.id, u.username from users u left join comments c on u.id = c.user_id where c.user_id is NUll; 
