--
--$$ LANGUAGE plpgsql;
--
--declare json_language JSON;
--
--select json_language;



select words.fun_language_create('{"language_id":0,"language_name":"греческий","language_shortname":"гр1","created_at":null,"changed_at":null}','{}','{}')

{"language_id" : 41, "language_name" : "греческий", "language_shortname" : "гр", "created_at" : "2022-12-28T22:38:00.639217", "changed_at" : "2022-12-28T22:38:00.639217"}