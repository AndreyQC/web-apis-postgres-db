/*=================================================================================
 * 
 * 
 * 
 * 
 * 
 ===================================================================================*/

drop function if exists words.fun_language_create;

CREATE OR REPLACE FUNCTION words.fun_language_create (p_language  JSON, p_user JSON, p_session JSON)  
RETURNS JSON  
LANGUAGE plpgsql  
AS  
$$  
    DECLARE  
    --- variables  
    BEGIN  
        /*-------------------------------------------------------------------------
         * логика
         * 1.раскидать json по переменным
         * 2.проверить что языка нет с таким названием и с таким сокращением
         *      если есть   -   вернуть ошибку 
         *      если нет    -   вставить
         * 3. вернуть новый язык
         */
        return(select p_language);
    END  
    
$$  