/* table for translations
 * 
 * 
 * 
 * 
 * 
 */

--drop table if exists words.word_translation;

CREATE TABLE words.word_translation(
   original_word_id bigint ,
   translation_word_id bigint,
   comment TEXT,
   created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (original_word_id,translation_word_id)
);