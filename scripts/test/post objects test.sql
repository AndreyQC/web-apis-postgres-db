INSERT INTO post."post" (title, post_text, user_id)
VALUES('перывый пост', 'что-то про первый пост', '1');

INSERT INTO post."post" (title, post_text, user_id)
VALUES('второй пост', 'что-то про второй пост', '2');

INSERT INTO post."post"
(title, post_text, user_id)
VALUES('последний пост', 'что-то про последний пост', '-1');

DELETE FROM post."post" 
WHERE title = 'последний пост';

update post."post" set user_id = 2;

delete from post."post";

select * from post."post";

update post."post" set user_id = 1;