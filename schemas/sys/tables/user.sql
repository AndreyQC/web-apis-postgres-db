/* table for users
 * 
 * 
 * 
 * 
 * 
 */
drop table if exists  sys."user";

CREATE TABLE sys."user"(
   id bigint GENERATED ALWAYS AS IDENTITY
             (MINVALUE 1 START WITH 1 CACHE 20)
             PRIMARY KEY,
   user_name text,
   
   created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   CONSTRAINT unique_words_user_name UNIQUE (user_name)
);