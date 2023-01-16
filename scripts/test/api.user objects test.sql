select api.fun_user_create('{"id":0,"user_name":"Jony English"}','[]','[]');
select api.fun_user_create('{"id":0,"user_name":"Иван Русских"}','[]','[]');
select api.fun_user_create('{"id":0,"user_name":"Иван Русских"}','[]','[]');



select api.fun_user_get_list('[]','[]','[]','[]');

/*-------------------------------------------------------------------------------------------------------
 * 
 * ввод тестовых данных
-------------------------------------------------------------------------------------------------------*/


select * from sys."user";
"2023-01-11T22:23:11.323802+04:00"

/*-------------------------------------------------------------------------------------------------------
 * вывод в виде json
-------------------------------------------------------------------------------------------------------*/
SELECT json_agg(t) FROM sys."user" as t

select
    json_build_object(
      'id', t.id,
      'user_name', t.user_name,
      'created_at', t.created_at,
      'changed_at', t.changed_at
    ) as "user"
FROM sys."user" as t;  


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
    select * FROM sys.user as t;


DO $$
DECLARE
    uuid text;
BEGIN
  uuid := 'X-2132135671';
  -- Create a function using above id
  EXECUTE format('select * FROM sys.user as t');
END;
$$ LANGUAGE plpgsql;


[{"user_id":1,"user_name":"English","user_shortname":"en","created_at":"2022-12-27T12:12:03.590965+04:00","changed_at":"2022-12-27T12:12:03.590965+04:00"}, 
 {"user_id":2,"user_name":"Русский","user_shortname":"ru","created_at":"2022-12-27T12:13:36.797927+04:00","changed_at":"2022-12-27T12:13:36.797927+04:00"}]
 
 
 
 
 
 select words.fun_user_create('{"user_id":0,"user_name":"English","user_shortname":"en","created_at":null,"changed_at":null}')
 
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

select
    lng.id,
    json_build_object(
      'id', lng.id,
      'user_name', lng.user_name,
      'user_shortname', lng.user_shortname,
      'created_at', lng.created_at,
      'changed_at', lng.changed_at
    ) as user
FROM words."user" as lng;


truncate table  words."user" ;
select words.fun_user_create('{"id":0,"user_name":"English","user_shortname":"en","created_at":null,"changed_at":null}','[]','[]');
select words.fun_user_create('{"id":0,"user_name":"Русский","user_shortname":"ru","created_at":null,"changed_at":null}','[]','[]');
select words.fun_user_create('{"id":0,"user_name":"Français","user_shortname":"fr","created_at":null,"changed_at":null}','[]','[]');


select "user" from words.fun_user_get_list('[]','[]','[]');

