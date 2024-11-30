-- FetchXML Builderでの自動生成結果

SELECT name, contact.fullname
FROM account
JOIN contact contact ON contact.contactid = account.primarycontactid



-- https://orgfa5b0cd9.api.crm7.dynamics.com/api/data/v9.2/FetchXMLToSQL(FetchXml=@p1)?@p1='<fetch>FetchXML</fetch>' で生成した例

select
"account0".name as "name"
, "contact".fullname as "contact.fullname"
from Account as "account0"
join Contact as "contact" on ("account0".primarycontactid  =  "contact".contactid)



--

SELECT name, contact.fullname
FROM account
JOIN contact contact ON contact.contactid = account.primarycontactid