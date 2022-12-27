/*=================================================================================
 * 
 * 
 * 
 * 
 * 
 ===================================================================================*/

drop function  words.proc_language_create;

CREATE OR REPLACE FUNCTION words.proc_language_create (lng  JSON)  
RETURNS JSON  
LANGUAGE plpgsql  
AS  
$$  
    DECLARE  
    --- variables  
    BEGIN  
        return(select lng);
    END  
    
$$  