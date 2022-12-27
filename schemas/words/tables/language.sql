/* table for languages
 * 
 * 
 * 
 * 
 * 
 */
drop table  words."language";

CREATE TABLE words.language(
   language_id bigint GENERATED ALWAYS AS IDENTITY
             (MINVALUE 1 START WITH 1 CACHE 20)
             PRIMARY KEY,
   language_name text,
   language_shortname text,
   created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   CONSTRAINT unique_words_language_name UNIQUE (language_name),
   CONSTRAINT unique_words_language_shortname UNIQUE (language_shortname)
);