/*=================================================================================
 * функция по вставке нового языка
 * 
 * 
 * 
 * 
 ===================================================================================*/

--drop function if exists words.fun_language_create;

CREATE OR REPLACE FUNCTION words.fun_language_create (p_json_language  JSON, p_json_user JSON, p_json_session JSON)  
RETURNS JSON  
LANGUAGE plpgsql  
AS  
$$  
    DECLARE  
        v_language_name text;
        v_language_shortname text;
        v_user_id text;
        v_language_id bigint;
        v_created_at TIMESTAMP;
        v_changed_at TIMESTAMP;
        v_exception text;        
    BEGIN  
    /*-------------------------------------------------------------------------
     * логика
     * 1.раскидать json по переменным
     * 2.проверить что языка нет с таким названием и с таким сокращением
     *      если есть   -   вернуть ошибку 
     *      если нет    -   вставить
     * 3. вернуть новый язык
     */
        v_language_shortname := p_json_language ->> 'language_shortname' ;
        v_language_name := p_json_language ->> 'language_name' ;
        v_user_id := p_json_user ->> 'user_id' ;  
       
        if exists(select 1 from words."language" where language_shortname  = v_language_shortname or language_name = v_language_name) then
            
            RAISE EXCEPTION 'Language with short name (%) or name (%) already exists!', v_language_shortname, v_language_name;
            
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
                id,
                created_at,
                changed_at
            INTO 
                v_language_id,
                v_created_at,
                v_changed_at;
            
            return json_build_object('id',v_language_id,'language_name',v_language_name,'language_shortname',v_language_shortname,'created_at',v_created_at,'changed_at',v_changed_at) ;        
        end if;
    
    END  
    
$$  