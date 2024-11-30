-- SQL 4 CDSでの自動生成結果

SELECT ya_column01, ya_e, UserName.ya_column01
FROM ya_member
JOIN ya_member UserName ON UserName.ya_parent = ya_member.ya_memberid



-- https://orgfa5b0cd9.api.crm7.dynamics.com/api/data/v9.2/FetchXMLToSQL(FetchXml=@p1)?@p1='<fetch>FetchXML</fetch>' で生成した例

-- Msg 10337, Level 16, State 1, Line 1
-- Table alias ya_member0 is not unique amongst all top-level table and join aliases

-- See the Execution Plan tab for details of where this error occurred

select
"ya_member0".ya_column01 as "ya_column01"
, "ya_member0".ya_e as "ya_e"
, "UserName".ya_column01 as "UserName.ya_column01"
from ya_Member as "ya_member0" join ya_Member as "UserName" on ("ya_member0".ya_memberid  =  "UserName".ya_parent)



--

select
"ya_member00".ya_column01 as "ya_column01"
, "ya_member00".ya_e as "ya_e"
, "UserName".ya_column01 as "UserName.ya_column01"
from ya_Member as "ya_member00" join ya_Member as "UserName" on ("ya_member00".ya_memberid  =  "UserName".ya_parent)