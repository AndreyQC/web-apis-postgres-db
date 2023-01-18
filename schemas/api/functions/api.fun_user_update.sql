/*=================================================================================
 * функция по обновлению пользователя 
 * 
 * 
 * 
 ===================================================================================*/

drop function if exists api.fun_user_update;

CREATE OR REPLACE FUNCTION api.fun_user_update (p_json_user  JSON, p_json_current_user JSON, p_json_current_session JSON)  
RETURNS JSON  
LANGUAGE plpgsql   
AS  
$$  
    DECLARE  
        v_user_name text;
        v_user_id bigint;
        v_read_user_name text;
        v_read_user_id bigint;
        v_changed_at TIMESTAMP;
        v_created_at TIMESTAMP;
        v_exception text;        
    BEGIN  
    /*-------------------------------------------------------------------------
     * логика
     * 1.раскидать json по переменным
     * 2.проверить что юзера нет с таким названием 
     *      если есть   -   вернуть ошибку 
     *      если нет    -   обновить по ид
     *                      если по ид нет то вернуть ошибку
     */
        v_user_name := p_json_user ->> 'user_name' ;
        v_user_id := p_json_user ->> 'id' ; 
        v_changed_at := p_json_user ->> 'changed_at' ;
        v_created_at := p_json_user ->> 'created_at' ;
       
        if exists(select 1 from sys."user" where user_name  = v_user_name and id <> v_user_id ) then
            
            RAISE EXCEPTION 'user with the name (%) already exists!', v_user_name;
            
        else
            UPDATE sys."user"
            SET 
                user_name = v_user_name, 
                changed_at=CURRENT_TIMESTAMP
            where
                id = v_user_id
            returning
                id,
                user_name,
                created_at,
                changed_at
            into
                v_read_user_id,                
                v_read_user_name,
                v_created_at,
                v_changed_at;
            
            if v_read_user_id is null 
                then 
                            RAISE EXCEPTION 'user with id = [(%)] does not exist!', v_user_id;                    
                else
                            return json_build_object(   'id',v_read_user_id,
                                                        'user_name',v_read_user_name,
                                                        'created_at',v_created_at,
                                                        'changed_at',v_changed_at,
                                                        'saved_in_database',True) ;
                end if;
            
        
        end if;
    
    END  
$$  