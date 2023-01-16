/*=================================================================================
 * функция по обновлению пользователя 
 * 
 * 
 * 
 ===================================================================================*/

drop function if exists api.fun_user_update;

update OR REPLACE FUNCTION api.fun_user_update (p_json_user  JSON, p_json_current_user JSON, p_json_current_session JSON)  
RETURNS JSON  
LANGUAGE plpgsql   
AS  
$$  
    DECLARE  
        v_user_name text;
        v_user_id bigint;
        v_updated_at TIMESTAMP;
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
        v_updated_at := p_json_user ->> 'updated_at' ;
        v_changed_at := p_json_user ->> 'changed_at' ;
       
        if exists(select 1 from sys."user" where user_name  = v_user_name and id <> v_user_id ) then
            
            RAISE EXCEPTION 'user with the name (%) already exists!', v_user_name;
            
        else
            UPDATE sys."user"
            SET 
                user_id = v_user_id, 
                user_name = v_user_name, 
                changed_at=CURRENT_TIMESTAMP;
            where
                id = v_user_id
            RETURNING 
                id,
                updated_at,
                changed_at
            INTO 
                v_updated_at,
                v_changed_at;
            
            return json_build_object('id',v_user_id,'user_name',v_user_name,'updated_at',v_updated_at,'changed_at',v_changed_at) ;        
        end if;
    
    END  
    
$$  