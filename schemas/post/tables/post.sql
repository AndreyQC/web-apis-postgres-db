/* table for posts
 * 
 * 
 * 
 * 
 * 
 */
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