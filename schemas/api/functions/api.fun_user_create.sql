/*=================================================================================
 * функция по вставке нового пользователя
 * 
 * 
 * 
 * 
 ===================================================================================*/

drop function if exists api.fun_user_create;

CREATE OR REPLACE FUNCTION api.fun_user_create (p_json_user  JSON, p_json_current_user JSON, p_json_current_session JSON)  
RETURNS JSON  
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
     * 1.раскидать json по переменным
     * 2.проверить что юзера нет с таким названием 
     *      если есть   -   вернуть ошибку 
     *      если нет    -   вставить
     * 3. вернуть нового пользака
     */
        v_user_name := p_json_user ->> 'user_name' ;
        v_user_id := p_json_user ->> 'user_id' ;  
       
        if exists(select 1 from sys."user" where user_name  = v_user_name ) then
            
            RAISE EXCEPTION 'user with  name (%) already exists!', v_user_name;
            
        else
            INSERT INTO sys."user"
                (
                    user_name
                )
            values
                (
                    v_user_name
                )
            RETURNING 
                id,
                created_at,
                changed_at
            INTO 
                v_user_id,
                v_created_at,
                v_changed_at;
            
            return json_build_object('id',v_user_id,'user_name',v_user_name,'created_at',v_created_at,'changed_at',v_changed_at) ;        
        end if;
    
    END  
    
$$  