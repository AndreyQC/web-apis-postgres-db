/* table for words
 * 
 * 
 * 
 * 
 * 
 */


CREATE TABLE words.word(
   word_id bigint GENERATED ALWAYS AS IDENTITY
             (MINVALUE 0 START WITH 0 CACHE 20)
             PRIMARY KEY,
   word TEXT,
   language_id bigint,
   created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP   
);