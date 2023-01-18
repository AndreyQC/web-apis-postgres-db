/*=================================================================================
 * 2023-01-12 функция по получению списка пользователей
 * 
 * 
 * 
 * 
 ===================================================================================*/

drop function if exists api.fun_user_get_list;

CREATE OR REPLACE FUNCTION api.fun_user_get_list (p_json_filter JSON, p_json_order JSON, p_json_current_user JSON, p_json_current_session JSON)  
RETURNS  TABLE("user" json)  
LANGUAGE plpgsql  
AS  
$$  
    DECLARE  
        v_user_name text;
        v_user_id bigint;
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
        EXECUTE 
            $s$select
            json_build_object(
              'id', t.id,
              'user_name', t.user_name,
              'created_at', t.created_at,
              'changed_at', t.changed_at,
              'saved_in_database',True
            ) as "user"
            FROM sys.user as t $s$;  
        
    end;    
$$  