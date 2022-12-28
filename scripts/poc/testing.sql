do $$ 
declare
   v_json_language json := '{"language_id":0,"language_name":"туреческий","language_shortname":"тур","created_at":null,"changed_at":null}';
   v_json_user json := '{"user_id":1}';
   v_json_session json := '{"user_id":1}';
   v_language_name text;
   v_language_shortname text;
   v_user_id text;
   v_language_id bigint;
   v_created_at TIMESTAMP;
   v_changed_at TIMESTAMP;
begin 
        /*-------------------------------------------------------------------------
         * логика
         * 1.раскидать json по переменным
         * 2.проверить что языка нет с таким названием и с таким сокращением
         *      если есть   -   вернуть ошибку 
         *      если нет    -   вставить
         * 3. вернуть новый язык
         */    
   v_language_shortname := v_json_language ->> 'language_shortname' ;
   v_language_name := v_json_language ->> 'language_name' ;
   v_user_id := v_json_user ->> 'user_id' ;

   
   
    if exists(select 1 from words."language" where language_shortname  = v_language_shortname or language_name = v_language_name) then
        RAISE EXCEPTION 'Language with short name (%) or name (%) already exists!', v_language_shortname, language_name; 
    else
        INSERT INTO words."language"
            (
                language_name, 
                language_shortname
            )
        values
            (
                v_language_name, 
                v_language_shortname
            )
        RETURNING 
            language_id,
            created_at,
            changed_at
        INTO 
            v_language_id,
            v_created_at,
            v_changed_at;
        
        raise notice 'json %', 
            json_build_object('language_id',v_language_id,'language_name',v_language_name,'language_shortname',v_language_shortname,'created_at',v_created_at,'changed_at',v_changed_at) ;        
    end if;


end $$;

/*
CREATE FUNCTION insert_from_json(in_json_txt json) RETURNS void AS
$BODY$
  INSERT INTO table_name (name, age)
  SELECT (rec->>'name')::text , (rec->>'age')::integer  FROM
  json_array_elements(in_json_txt->'data') rec
$BODY$
  LANGUAGE sql
  
   CREATE OR REPLACE FUNCTION msgfailerror() 
RETURNS trigger AS 
$$
BEGIN 
  IF NEW.noces< new.first_column THEN 
    RAISE EXCEPTION 'cannot have a negative salary'; 
  END IF; 
  return new; 
END;
$$
LANGUAGE plpgsql; 


json_build_object('foo',1,'bar',2)
*/