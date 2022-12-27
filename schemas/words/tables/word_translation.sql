/* table for translations
 * 
 * 
 * 
 * 
 * 
 */

CREATE TABLE words.word_translation(
   word_id bigint ,
   translation_word_id bigint,
   comment TEXT,
   created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   changed_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
   PRIMARY KEY (word_id,translation_word_id)
);