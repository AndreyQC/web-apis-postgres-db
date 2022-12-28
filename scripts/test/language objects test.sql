

/*-------------------------------------------------------------------------------------------------------
 * 
 * ввод тестовых данных
-------------------------------------------------------------------------------------------------------*/
INSERT INTO words."language"
(language_name, language_shortname)
VALUES('English', 'en');

INSERT INTO words."language"
(language_name, language_shortname)
VALUES('Русский', 'ru');


select * from words."language";

/*-------------------------------------------------------------------------------------------------------
 * ввод в виде json
-------------------------------------------------------------------------------------------------------*/
SELECT json_agg(t) FROM words."language" as t

[{"language_id":1,"language_name":"English","language_shortname":"en","created_at":"2022-12-27T12:12:03.590965+04:00","changed_at":"2022-12-27T12:12:03.590965+04:00"}, 
 {"language_id":2,"language_name":"Русский","language_shortname":"ru","created_at":"2022-12-27T12:13:36.797927+04:00","changed_at":"2022-12-27T12:13:36.797927+04:00"}]
 
 
 
 
 
 select words.fun_language_create('{"language_id":0,"language_name":"English","language_shortname":"en","created_at":null,"changed_at":null}')