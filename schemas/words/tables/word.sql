/* table for words
 * 2022-12-28 added unique_words_word_word
 * 
 * 
 * 
 * 
 */
--drop table if exists words.word;

CREATE TABLE words.word(
   word_id bigint GENERATED ALWAYS AS IDENTITY
             (MINVALUE 0 START WITH 0 CACHE 20)
             PRIMARY KEY,
   word TEXT,
   language_id bigint,
   created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   CONSTRAINT unique_words_word_word UNIQUE (word)
);