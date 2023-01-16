/*=================================================================================
 * функция по получению списка языков или одного по id, name, shortname
 * 
 * 
 * 
 * 
 ===================================================================================*/

--drop function if exists words.fun_language_get_list;

CREATE OR REPLACE FUNCTION words.fun_language_get_list (p_json_filter JSON, p_json_user JSON, p_json_session JSON)  
RETURNS  TABLE("language" json)  
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
     * 1.раскидать p_json_filter по переменным
     * 2.
     * 3. вернуть список 
     */
    RETURN QUERY
        select
            json_build_object(
              'id', lng.id,
              'language_name', lng.language_name,
              'language_shortname', lng.language_shortname,
              'created_at', lng.created_at,
              'changed_at', lng.changed_at
            ) as "language"
        FROM words."language" as lng;        
        
    end;    
$$  