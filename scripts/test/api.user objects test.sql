/*==================================================================================================
 * очистка таблицы
==================================================================================================== */

truncate table sys.user;

/*==================================================================================================
 * ввод тестовых данных c помощью функции
==================================================================================================== */

select api.fun_user_create('{"id":0,"user_name":"Jony English"}','[]','[]');
select api.fun_user_create('{"id":0,"user_name":"Иван Русских"}','[]','[]');
-- данный вызов должен упасть
select api.fun_user_create('{"id":0,"user_name":"Иван Русских"}','[]','[]');

select api.fun_user_create('{"id":0,"user_name":"Андрей Потапов"}','[]','[]');


/*==================================================================================================
 * проверка api.fun_user_get_list
 * просто пока получение списком
====================================================================================================*/

select "user" from api.fun_user_get_list('{"filter":{}}','{"order":{}}','{"current_user":{}}','{"current_session":{}}');

select "user" from api.fun_user_get_list('{"filter":{}}','{"order":{}}','{"current_user":{}}','{"current_session":{}}');
/*
 *      {"id" : 21, "user_name" : "Jony English", "created_at" : "2023-01-18T14:39:36.261509+04:00", "changed_at" : "2023-01-18T14:39:36.261509+04:00"}
        {"id" : 41, "user_name" : "Иван Русских", "created_at" : "2023-01-18T14:41:58.063725+04:00", "changed_at" : "2023-01-18T14:41:58.063725+04:00"}
 */

/*==================================================================================================
 * проверка api.fun_user_get_list
 * с помощью обычного селекта
====================================================================================================*/
select * from sys."user";

/*==================================================================================================
 * проверка api.fun_user_update 
 * обновление пользователя
====================================================================================================*/

select api.fun_user_update('{"id":82,"user_name":"Иван Русских ЦАРЕВИЧ"}','{"current_user":{}}','{"current_session":{}}');

--{"id" : 41, "user_name" : "Иван Русских ЦАРЕВИЧ", "created_at" : "2023-01-18T14:41:58.063725", "changed_at" : "2023-01-18T19:03:47.840165"}

select api.fun_user_update('{"id":41,"user_name":"Иван Русских ЦАРЕВИЧ"}','{"current_user":{}}','{"current_session":{}}');
--{"id" : null, "user_name" : null, "created_at" : null, "changed_at" : null}


/*==================================================================================================
 * проверка api.fun_user_get_by_id 
 * обновление пользователя
====================================================================================================*/

select * from api.fun_user_get_by_id('{"id":8}','{"current_user":{}}','{"current_session":{}}');
---{"id" : 82, "user_name" : "Иван Русских ЦАРЕВИЧ", "created_at" : "2023-01-18T19:32:18.092011", "changed_at" : "2023-01-18T19:34:32.309395", "saved_in_database" : true}

select * from api.fun_user_get_by_id('{"id":82,"user_name":"Иван Русских ЦАРЕВИЧ"}','{"current_user":{}}','{"current_session":{}}');

/*-------------------------------------------------------------------------------------------------------
 * вывод в виде json
-------------------------------------------------------------------------------------------------------*/

/*===========================================================
 * вот это работает подольше так как группировка на уровне таблицы
 ==============================================================*/
SELECT json_agg(t) FROM sys."user" as t
/*===========================================================
 * вот это побыстрее 
 ==============================================================*/
select
    json_build_object(
      'id', t.id,
      'user_name', t.user_name,
      'created_at', t.created_at,
      'changed_at', t.changed_at
    ) as "user"
FROM sys."user" as t;  

/*===========================================================
 * пример динамики но тут не запускать - ругается но в функции все ок
 ==============================================================*/
        EXECUTE 
            $sql$select
            json_build_object('id', t.id,
              'user_name', t.user_name,
              'created_at', t.created_at,
              'changed_at', t.changed_at
            ) as u
            FROM sys.user as t;$sql$;
        
        do $$ 
        EXECUTE E'select * FROM sys.user'       
        end $$;



DO $$
DECLARE
    uuid text;
BEGIN
  uuid := 'X-2132135671';
  -- Create a function using above id
  EXECUTE format('select * FROM sys.user as t');
END;
$$ LANGUAGE plpgsql;

/*===========================================================
 * пример вложенных json
 ==============================================================*/
 SELECT
json_build_object(
  'user_id', user.id,
  'name', user.name,
  'pets', (
    SELECT json_agg(all_pets)
    FROM pets
  )
)
FROM words."user";




