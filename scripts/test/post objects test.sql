INSERT INTO post."post" (title, post_text, user_id)
VALUES('перывый пост', 'что-то про первый пост', '1');

INSERT INTO post."post" (title, post_text, user_id)
VALUES('второй пост', 'что-то про второй пост', null);

INSERT INTO post."post"
(title, post_text, user_id)
VALUES('последний пост', 'что-то про последний пост', '-1');

DELETE FROM post."post" 
WHERE title = 'последний пост';

update post."post" set user_id = 2;

delete from post."post";

select * from post."post";

update post."post" set user_id = 1;


/*=============================================================================================
для чего нужен FK

===============================================================================================*/
-- дропним и создадим таблицу
drop table if exists  post.post;

CREATE TABLE post.post(
   id bigint GENERATED ALWAYS AS IDENTITY
             (MINVALUE 1 START WITH 1 CACHE 20)
             PRIMARY KEY,
   title text,
   post_text text,
   user_id bigint,
   publish_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   CONSTRAINT unique_post_title UNIQUE (title)
);  

-- вставим данные 

INSERT INTO post."post" (title, post_text, user_id)
values
    ('перывый пост', 'что-то про первый пост', 1),
    ('второй пост', 'что-то про второй пост', null),
    ('третий пост', 'что-то про третий пост', 0);

-- выведем
select * from post."post";


-- попытаемся вывести посты с именем пользователя

SELECT pst.id, 
        pst.title, 
        pst.post_text, 
        pst.user_id, 
        pst.publish_date, 
        pst.created_at, 
        pst.changed_at,
        usr.user_name 
FROM post.post as pst 
    inner join sys."user" as usr
        on usr.id =  pst.user_id;  


-- увидели то что ничего не вернулось    
    

SELECT 
    usr.id, 
    usr.user_name, 
    usr.created_at, 
    usr.changed_at
FROM sys."user" as usr;

-- давайте добавим посты существующих пользователей 

INSERT INTO post."post" (title, post_text, user_id)
values
    ('четвертый  пост', 'что-то про четвертый пост',101),
    ('пятый  пост', 'что-то про пятый пост', 121);


---- попытаемся вывести посты с именем пользователя

SELECT pst.id, 
        pst.title, 
        pst.post_text, 
        pst.user_id, 
        pst.publish_date, 
        pst.created_at, 
        pst.changed_at,
        usr.user_name 
FROM post.post as pst 
    inner join sys."user" as usr
        on usr.id =  pst.user_id;  
    
--задача - как сделать так чтобы было нельзя добавить пост от незареганоого пользака
    
-- это можно реализовать с помощью FK constraint
    
-- дропним и создадим таблицу c 
drop table if exists  post.post;

CREATE TABLE post.post(
   id bigint GENERATED ALWAYS AS IDENTITY
             (MINVALUE 1 START WITH 1 CACHE 20)
             PRIMARY KEY,
   title text,
   post_text text,
   user_id bigint,
   publish_date TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   CONSTRAINT unique_post_title UNIQUE (title),
   CONSTRAINT fk_post_user
      FOREIGN KEY(user_id) 
      REFERENCES sys."user"(id)   
);  

-- попробуем вставить некорректные данные 

INSERT INTO post."post" (title, post_text, user_id)
values
    ('перывый пост', 'что-то про первый пост', 1),
    ('второй пост', 'что-то про второй пост', null),
    ('третий пост', 'что-то про третий пост', 0);
    
-- низзя

-- введем корректные данные 

INSERT INTO post."post" (title, post_text, user_id)
values
    ('четвертый  пост', 'что-то про четвертый пост',101),
    ('пятый  пост', 'что-то про пятый пост', 121);


SELECT pst.id, 
        pst.title, 
        pst.post_text, 
        pst.user_id, 
        pst.publish_date, 
        pst.created_at, 
        pst.changed_at,
        usr.user_name 
FROM post.post as pst 
    inner join sys."user" as usr
        on usr.id =  pst.user_id;  
    
  -- но FK может еще кое что
-- попробуем удалить пользака
    
delete from sys."user" where id = 101;

cascade



    
    
