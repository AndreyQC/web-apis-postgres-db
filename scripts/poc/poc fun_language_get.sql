do $$ 
declare
   p_json_language json := '{"language_id":333}';
   p_json_user json := '{"user_id":1}';
   p_json_session json := '{"user_id":1}';
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
     * 2.
     * 3. вернуть новый язык
     */
   v_language_id := p_json_language ->> 'language_id' ;
   v_user_id := p_json_user ->> 'user_id' ;


   
--    raise notice 'json %', 
--          json_build_object('language_id',v_language_id) ;   
   
   return query( select * from words."language") ;
      
--    if exists(select 1 from words."language" where language_shortname  = v_language_shortname or language_name = v_language_name) then
--        RAISE EXCEPTION 'Language with short name (%) or name (%) already exists!', v_language_shortname, language_name; 
--    else
--        INSERT INTO words."language"
--            (
--                language_name, 
--                language_shortname
--            )
--        values
--            (
--                v_language_name, 
--                v_language_shortname
--            )
--        RETURNING 
--            language_id,
--            created_at,
--            changed_at
--        INTO 
--            v_language_id,
--            v_created_at,
--            v_changed_at;
--        
--        raise notice 'json %', 
--            json_build_object('language_id',v_language_id,'language_name',v_language_name,'language_shortname',v_language_shortname,'created_at',v_created_at,'changed_at',v_changed_at) ;        
--    end if;


end $$;