set echo off;

define user=training

prompt Dropping old user
begin
  execute immediate 'DROP USER &user CASCADE';
  exception when others then
  if sqlcode = -01918 then
    null;
  else
    raise;
  end if;
end;
/
commit;
--------------------------------------------------------------------------
-- Create new schema
--------------------------------------------------------------------------

CREATE USER &user IDENTIFIED BY &user;
GRANT CREATE DATABASE LINK, CREATE PROCEDURE, CREATE SESSION, RESOURCE, CREATE TABLE, CREATE VIEW, CREATE SYNONYM TO &user;

commit;
quit;
