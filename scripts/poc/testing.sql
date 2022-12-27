do $$ 
declare
   json_language json := '{"language_id":0,"language_name":"English","language_shortname":"en","created_at":null,"changed_at":null}';
   v_language_name text;
    v_language_shortname text; 
begin 
   v_language_shortname := json_language ->> 'language_shortname' ;
   raise notice 'json %', 
       v_language_shortname ;
   
end $$;

/*
CREATE FUNCTION insert_from_json(in_json_txt json) RETURNS void AS
$BODY$
  INSERT INTO table_name (name, age)
  SELECT (rec->>'name')::text , (rec->>'age')::integer  FROM
  json_array_elements(in_json_txt->'data') rec
$BODY$
  LANGUAGE sql 
*/