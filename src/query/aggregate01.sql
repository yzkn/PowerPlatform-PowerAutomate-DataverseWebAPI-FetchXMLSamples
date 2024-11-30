-- SQL 4 CDSでの自動生成結果（集計に関する属性が消えている）

-- SELECT ya_column14, ya_column14, ya_column14, ya_column14, ya_column14, ya_column14, ya_column14
-- FROM ya_member
-- WHERE (ya_column14 IS NOT NULL AND ya_column14 < 10)



-- https://orgfa5b0cd9.api.crm7.dynamics.com/api/data/v9.2/FetchXMLToSQL(FetchXml=@p1)?@p1='<fetch>FetchXML</fetch>' で生成した例

-- Msg 40517, Level 16, State 1, Line 1
-- Keyword or statement option 'OVER' is not supported in this version of SQL Server.

-- select
-- AVG(IQ.ya_column140) as "Average"
-- , COUNT(*) as "Count"
-- , COUNT(IQ.ya_column141) as "ColumnCount"
-- , COUNT(DISTINCT IQ.ya_column142) as "CountDistinct"
-- , MAX(IQ.ya_column143) as "Maximum"
-- , MIN(IQ.ya_column144) as "Minimum"
-- , SUM(IQ.ya_column145) as "Sum"
-- , MAX("__AggLimitExceededFlag__") as "__AggregateLimitExceeded__" from (select top 50001 "ya_member0".ya_column14 as "ya_column140"
-- , "ya_member0".ya_column14 as "ya_column141"
-- , "ya_member0".ya_column14 as "ya_column142"
-- , "ya_member0".ya_column14 as "ya_column143"
-- , "ya_member0".ya_column14 as "ya_column144"
-- , "ya_member0".ya_column14 as "ya_column145"
-- , case when ROW_NUMBER() over(order by (SELECT 1)) > 50000 then 1 else 0 end as "__AggLimitExceededFlag__" from ya_Member as "ya_member0"
-- where ("ya_member0".ya_column14 is not null and "ya_member0".ya_column14 < 10)) as IQ  order by __AggregateLimitExceeded__ DESC



--

select
AVG(ya_column14) as "Average"
, COUNT(*) as "Count"
, COUNT(ya_column14) as "ColumnCount"
, COUNT(DISTINCT ya_column14) as "CountDistinct"
, MAX(ya_column14) as "Maximum"
, MIN(ya_column14) as "Minimum"
, SUM(ya_column14) as "Sum"
from ya_Member
where (ya_column14 is not null and ya_column14 < 10)
