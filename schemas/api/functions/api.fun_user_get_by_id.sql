/*=================================================================================
 * функция по получению пользователя
 * 
 * 
 * 
 ===================================================================================*/

drop function if exists api.fun_user_get_by_id;

CREATE OR REPLACE FUNCTION api.fun_user_get_by_id (p_json_user  JSON , p_json_current_user JSON, p_json_current_session JSON)  
RETURNS JSON  
LANGUAGE plpgsql   
AS  
$$  
    DECLARE  
        v_user_name text;
        v_user_id bigint;
        v_read_user_id bigint;
        v_created_at TIMESTAMP;
        v_changed_at TIMESTAMP;
        v_exception text;        
    BEGIN  
    /*-------------------------------------------------------------------------
     * логика
     * 1.раскидать json по переменным
     * 2.проверить что юзера нет с таким id
     *      если есть   -   вернуть ошибку 
     *      если нет    -   вставить
     */
        v_user_id := p_json_user ->> 'id' ; 
        
         
        SELECT 
            id, 
            user_name, 
            created_at, 
            changed_at
        FROM sys."user"
          where
                id = v_user_id
        INTO 
            v_read_user_id,
            v_user_name,
            v_created_at,
            v_changed_at;
            
            if v_read_user_id is null 
                then 
                            RAISE EXCEPTION 'user with id = [(%)] does not exist!', v_user_id;                    
                else
                            return json_build_object(   'id',v_read_user_id,
                                                        'user_name',v_user_name,
                                                        'created_at',v_created_at,
                                                        'changed_at',v_changed_at,
                                                        'saved_in_database',True) ;
                end if;   
        
    END  
    
$$  