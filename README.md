# PowerPlatform-PowerAutomate-DataverseWebAPI-FetchXMLSamples

Power Automate クラウドフローで FetchXML を使用して Dataverse テーブルのレコードを取得する

---

<br><br><br><br><br>

# 基本的なクエリ

<br><br><br><br>

## 件数（行数）指定＋列（属性）指定＋列の別名（エイリアス）＋フィルタリング＋ソート

- [SQL](src/query/select01.sql)
  - [結果](src/result/select01.sql.json)
- [FetchXML](src/query/select01.xml)
  - [結果](src/result/select01.xml.json)
- [ODataクエリ](src/query/select01.odata)
  - [結果](src/result/select01.odata.json)

<br><br><br><br>

## 重複除外

- [SQL](src/query/distinct01.sql)
  - [結果](src/result/distinct01.sql.json)
- [FetchXML](src/query/distinct01.xml)
  - [結果](src/result/distinct01.xml.json)
- [ODataクエリ](src/query/distinct01.odata)
  - [結果](src/result/distinct01.odata.json)

<br><br><br><br>

## 集計

ColumnCountは、FetchXMLとODataクエリで挙動が異なる

- [SQL](src/query/aggregate01.sql)
  - [結果](src/result/aggregate01.sql.json)
- [FetchXML](src/query/aggregate01.xml)
  - [結果](src/result/aggregate01.xml.json)
- [ODataクエリ](src/query/aggregate01.odata)
  - [結果](src/result/aggregate01.odata.json)

<br><br><br><br>

## 結合

<br><br><br>

### 一対多

```xml
<fetch>
  <entity name="ya_member">
    <attribute name="ya_column01" />
    <attribute name="ya_e" />
    <link-entity name="ya_member" from="ya_parent" to="ya_memberid" link-type="inner" alias="UserName">
      <attribute name="ya_column01" />
    </link-entity>
  </entity>
</fetch>
```

```
https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/ya_members?$select=ya_column01,ya_e&$expand=ya_Member_Parent_ya_Member($select=ya_column01)&$filter=(ya_Member_Parent_ya_Member/any(o1:(o1/ya_memberid ne null)))
```

```sql
SELECT ya_column01, ya_e, UserName.ya_column01
FROM ya_member
JOIN ya_member UserName ON UserName.ya_parent = ya_member.ya_memberid
```

```sql
-- https://orgfa5b0cd9.api.crm7.dynamics.com/api/data/v9.2/FetchXMLToSQL(FetchXml=@p1)?@p1='<fetch>FetchXML</fetch>' で生成した例
select
"ya_member0".ya_column01 as "ya_column01"
, "ya_member0".ya_e as "ya_e"
, "UserName".ya_column01 as "UserName.ya_column01"
from
 ya_Member as "ya_member0"
	 join ya_Member as "UserName" on ("ya_member0".ya_memberid  =  "UserName".ya_parent)
```

<br><br><br>

### 多対一

```xml
<fetch>
  <entity name="ya_member">
    <attribute name="ya_column01" />
    <link-entity name="systemuser" from="systemuserid" to="createdby" link-type="inner" alias="Creator">
      <attribute name='fullname' />
    </link-entity>
  </entity>
</fetch>
```

```
https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/ya_members?$select=ya_column01&$expand=createdby($select=fullname)&$filter=(createdby/systemuserid ne null)
```

```sql
SELECT ya_column01, Creator.fullname
FROM ya_member
JOIN systemuser Creator ON Creator.systemuserid = ya_member.createdby
```

<br><br><br><br><br>

# ページングCookieを利用して大量データを読み込む

- トリガー
  - 手動でフローをトリガーします
  - パラメーター
    - スキーマ名 : スキーマ名を指定してください（例：ya_Member）

- アクション
  - 変数を初期化する
    - アイテム数 : 整数 : 0
    - MoreRecords : ブール値 : false
    - ページングCookie : 文字列 : （空文字列）
    - ページ番号 : 整数 : 1
  - スコープ : 以下をコピペ（クラシックデザイナー）
    - <a href="src/action/scope_793c6d53-0597-4f42-8184-e601f264fb7c.json">スコープ</a>


<br><br><br><br><br>

# 条件演算子

| Operator                            | Description                                                                                                                 | 説明                                                                                                                                    | 選択肢 Choice | 日時 Datetime | 階層データ Hierarchical | 数値 Number | 所有者 Owner | 文字列 String | 一意識別子 Unique Identifier | N/A |
| ----------------------------------- | --------------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------------- | ------------- | ------------- | ----------------------- | ----------- | ------------ | ------------- | ---------------------------- | --- |
| above                               | Returns all records in referenced record's hierarchical ancestry line.                                                      | 参照されているレコードの階層の親子ラインにあるすべてレコードを返します。                                                                |               |               | ○                       |             |              |               |                              |     |
| begins-with                         | The string occurs at the beginning of another string.                                                                       | その文字列は、別の文字列の先頭にあります。                                                                                              |               |               |                         |             |              | ○             |                              |     |
| between                             | The value is between two values.                                                                                            | この値は 2 つの値の間です。                                                                                                             |               | ○             |                         | ○           |              |               |                              |     |
| contain-values                      | The choice value is one of the specified values.                                                                            | 選択値は、指定された値の 1 つです。                                                                                                     | ○             |               |                         |             |              |               |                              |     |
| ends-with                           | The string ends with another string.                                                                                        | 文字列は別の文字列で終わります。                                                                                                        |               |               |                         |             |              | ○             |                              |     |
| eq                                  | The values are compared for equality.                                                                                       | 値が等しいかどうかが比較されます。                                                                                                      | ○             | ○             | ○                       | ○           | ○            | ○             | ○                            |     |
| eq-businessid                       | The value is equal to the specified business ID.                                                                            | 値は、指定されたビジネス ID と同じです。                                                                                                |               |               |                         |             |              |               | ○                            |     |
| eq-or-above                         | Returns the referenced record and all records above it in the hierarchy.                                                    | 参照されているレコードと階層でそれより上にあるすべてのレコードを返します。                                                              |               |               | ○                       |             |              |               |                              |     |
| eq-or-under                         | Returns the referenced record and all child records below it in the hierarchy.                                              | 参照されているレコードと階層でそれより下にあるすべての子レコードを返します。                                                            |               |               | ○                       |             |              |               |                              |     |
| eq-userid                           | The value is equal to the specified user ID.                                                                                | 値は、指定されたユーザー ID と同じです。                                                                                                |               |               |                         |             |              |               | ○                            |     |
| eq-userlanguage                     | The value is equal to the language for the user.                                                                            | その文字列は、別の文字列の先頭にあります。                                                                                              |               |               |                         | ○           |              |               |                              |     |
| eq-useroruserhierarchy              | When hierarchical security models are used, Equals current user or their reporting hierarchy.                               | 階層セキュリティ モデルが使用されている場合、現在のユーザーまたはユーザーのレポート階層を等しくします。                                 |               |               | ○                       |             |              |               |                              |     |
| eq-useroruserhierarchyandteams      | When hierarchical security models are used, Equals current user and his teams or their reporting hierarchy and their teams. | 階層セキュリティ モデルが使用されている場合、現在のユーザーとユーザーのチームまたはユーザーのレポート階層とそのチームに等しくなります。 |               |               | ○                       |             |              |               |                              |     |
| eq-useroruserteams                  | The record is owned by a user or teams that the user is a member of.                                                        | レコードは、ユーザーまたはユーザーが所属するチームが所有しています。                                                                    |               |               |                         |             | ○            |               |                              |     |
| eq-userteams                        | The record is owned by a user or teams that the user is a member of.                                                        | レコードは、ユーザーまたはユーザーが所属するチームが所有しています。                                                                    |               |               |                         |             | ○            |               |                              |     |
| ge                                  | The value is greater than or equal to the compared value.                                                                   | 値が比較値以上である必要があります。                                                                                                    |               | ○             |                         | ○           |              | ○             |                              |     |
| gt                                  | The value is greater than the compared value.                                                                               | 値が比較する値より大きい。                                                                                                              |               | ○             |                         | ○           |              | ○             |                              |     |
| in                                  | The value exists in a list of values.                                                                                       | 値は値のリストに存在します。                                                                                                            | ○             |               |                         | ○           | ○            | ○             | ○                            |     |
| in-fiscal-period                    | The value is within the specified fiscal period.                                                                            | 指定された会計期間内の値である必要があります。                                                                                          |               | ○             |                         |             |              |               |                              |     |
| in-fiscal-period-and-year           | The value is within the specified fiscal period and year.                                                                   | 値は、指定された 会計期間 および年の範囲内にあります。                                                                                  |               | ○             |                         |             |              |               |                              |     |
| in-fiscal-year                      | The value is within the specified year.                                                                                     | 指定された年内の値である必要があります。                                                                                                |               | ○             |                         |             |              |               |                              |     |
| in-or-after-fiscal-period-and-year  | The value is within or after the specified fiscal period and year.                                                          | 指定された会計期間内または会計年度以降である必要があります。                                                                            |               | ○             |                         |             |              |               |                              |     |
| in-or-before-fiscal-period-and-year | The value is within or before the specified fiscal period and year.                                                         | 指定された会計期間および会計年度以前であること。                                                                                        |               | ○             |                         |             |              |               |                              |     |
| last-fiscal-period                  | The value is within the previous fiscal period.                                                                             | 前会計期間内の数値である必要があります。                                                                                                |               | ○             |                         |             |              |               |                              |     |
| last-fiscal-year                    | The value is within the previous fiscal year.                                                                               | 前年度内の値である必要があります。                                                                                                      |               | ○             |                         |             |              |               |                              |     |
| last-month                          | The value is within the previous month including first day of the last month and last day of the last month.                | 前月初日、前月末日を含む前月中の値です。                                                                                                |               | ○             |                         |             |              |               |                              |     |
| last-seven-days                     | The value is within the previous seven days including today.                                                                | 値は、今日を含む過去 7 日間の値です。                                                                                                   |               | ○             |                         |             |              |               |                              |     |
| last-week                           | The value is within the previous week including Sunday through Saturday.                                                    | 日曜から土曜までを含む前週の値です。                                                                                                    |               | ○             |                         |             |              |               |                              |     |
| last-x-days                         | The value is within the previous specified number of days.                                                                  | この値は、過去に指定された日数以内です。                                                                                                |               | ○             |                         |             |              |               |                              |     |
| last-x-fiscal-periods               | The value is within the previous specified number of fiscal periods.                                                        | 過去指定された会計期間内の値です。                                                                                                      |               | ○             |                         |             |              |               |                              |     |
| last-x-fiscal-years                 | The value is within the previous specified number of fiscal periods.                                                        | 過去指定された会計期間内の値です。                                                                                                      |               | ○             |                         |             |              |               |                              |     |
| last-x-hours                        | The value is within the previous specified number of hours.                                                                 | この値は前回指定した時間数以内です。                                                                                                    |               | ○             |                         |             |              |               |                              |     |
| last-x-months                       | The value is within the previous specified number of months.                                                                | この値は、過去に指定された月数以内です。                                                                                                |               | ○             |                         |             |              |               |                              |     |
| last-x-weeks                        | The value is within the previous specified number of weeks.                                                                 | この値は過去に指定された週数以内です。                                                                                                  |               | ○             |                         |             |              |               |                              |     |
| last-x-years                        | The value is within the previous specified number of years.                                                                 | この値は過去に指定された年数以内です。                                                                                                  |               | ○             |                         |             |              |               |                              |     |
| last-year                           | The value is within the previous year.                                                                                      | この値は前年度内の値です。                                                                                                              |               | ○             |                         |             |              |               |                              |     |
| le                                  | The value is less than or equal to the compared value.                                                                      | 値が比較値以下である必要があります。                                                                                                    |               | ○             |                         | ○           |              | ○             |                              |     |
| like                                | The character string is matched to the specified pattern.                                                                   | 文字列は指定されたパターン一致します。                                                                                                  |               |               |                         |             |              | ○             |                              |     |
| lt                                  | The value is less than the compared value.                                                                                  | 値が比較する値より小さい。                                                                                                              |               | ○             |                         | ○           |              | ○             |                              |     |
| ne                                  | The two values are not equal.                                                                                               | 2 つの値は等しくありません。                                                                                                            | ○             | ○             | ○                       | ○           | ○            | ○             | ○                            |     |
| ne-businessid                       | The value is not equal to the specified business ID.                                                                        | 値が指定されたビジネス ID と一致しません。                                                                                              |               |               |                         |             |              |               | ○                            |     |
| ne-userid                           | The value is not equal to the specified user ID.                                                                            | 値が指定されたユーザー ID と一致しません。                                                                                              |               |               |                         |             |              |               | ○                            |     |
| neq                                 | Deprecated. Use `ne` instead. Remains for backward compatability only.                                                      | 廃止されました。 代わりに `ne` を使用します。 下位互換性のためだけに残されています。                                                    |               |               |                         |             |              |               |                              | ○   |
| next-fiscal-period                  | The value is within the next fiscal period.                                                                                 | 次会計期間内の数値である必要があります。                                                                                                |               | ○             |                         |             |              |               |                              |     |
| next-fiscal-year                    | The value is within the next fiscal year.                                                                                   | 次会計年度内の数値である必要があります。                                                                                                |               | ○             |                         |             |              |               |                              |     |
| next-month                          | The value is within the next month.                                                                                         | 次月内の数値である必要があります。                                                                                                      |               | ○             |                         |             |              |               |                              |     |
| next-seven-days                     | The value is within the next seven days.                                                                                    | 値は 7 日以内である必要があります。                                                                                                     |               | ○             |                         |             |              |               |                              |     |
| next-week                           | The value is within the next week.                                                                                          | 次週内の数値である必要があります。                                                                                                      |               | ○             |                         |             |              |               |                              |     |
| next-x-days                         | The value is within the next specified number of days.                                                                      | 次の指定日数以内の値です。                                                                                                              |               | ○             |                         |             |              |               |                              |     |
| next-x-fiscal-periods               | The value is within the next specified number of fiscal periods.                                                            | 次の指定された会計期間内の値です。                                                                                                      |               | ○             |                         |             |              |               |                              |     |
| next-x-fiscal-years                 | The value is within the next specified number of fiscal years.                                                              | 次の指定された会計年度内の値です。                                                                                                      |               | ○             |                         |             |              |               |                              |     |
| next-x-hours                        | The value is within the next specified number of hours.                                                                     | 次の指定時間以内の値です。                                                                                                              |               | ○             |                         |             |              |               |                              |     |
| next-x-months                       | The value is within the next specified number of months.                                                                    | 次の指定月以内の値です。                                                                                                                |               | ○             |                         |             |              |               |                              |     |
| next-x-weeks                        | The value is within the next specified number of weeks.                                                                     | 次の指定週以内の値です。                                                                                                                |               | ○             |                         |             |              |               |                              |     |
| next-x-years                        | The value is within the next specified number of years.                                                                     | 次の指定年以内の値です。                                                                                                                |               | ○             |                         |             |              |               |                              |     |
| next-year                           | The value is within the next X years.                                                                                       | 値は今後 X 年以内である必要があります。                                                                                                 |               | ○             |                         |             |              |               |                              |     |
| not-begin-with                      | The string does not begin with another string.                                                                              | 文字列が別の文字列で始まりません。                                                                                                      |               |               |                         |             |              | ○             |                              |     |
| not-between                         | The value is not between two values.                                                                                        | 値は 2 つの値の間にありません。                                                                                                         |               | ○             |                         | ○           |              |               |                              |     |
| not-contain-values                  | The choice value is not one of the specified values.                                                                        | 選択された値が指定された値ではありません。                                                                                              | ○             |               |                         |             |              |               |                              |     |
| not-end-with                        | The string does not end with another string.                                                                                | 文字列が別の文字列で終わりません。                                                                                                      |               |               |                         |             |              | ○             |                              |     |
| not-in                              | The given value is not matched to a value in a subquery or a list.                                                          | 指定された値は、サブクエリまたはリストの値と一致しません。                                                                              |               |               |                         | ○           |              |               |                              |     |
| not-like                            | The character string does not match the specified pattern.                                                                  | 文字列は指定されたパターンに一致しません。                                                                                              |               |               |                         |             |              | ○             |                              |     |
| not-null                            | The value is not null.                                                                                                      | 値は null 値ではありません。                                                                                                            | ○             | ○             | ○                       | ○           | ○            | ○             | ○                            |     |
| not-under                           | Returns all records not below the referenced record in the hierarchy.                                                       | 階層で参照されているレコードの下にないすべてのレコードを返します。                                                                      |               |               | ○                       |             |              |               |                              |     |
| null                                | The value is null.                                                                                                          | 値は null 値です。                                                                                                                      | ○             | ○             | ○                       | ○           | ○            | ○             | ○                            |     |
| olderthan-x-days                    | The value is older than the specified number of days.                                                                       | 指定された日数より古い値です。                                                                                                          |               | ○             |                         |             |              |               |                              |     |
| olderthan-x-hours                   | The value is older than the specified number of hours.                                                                      | 指定された時間より古い値です。                                                                                                          |               | ○             |                         |             |              |               |                              |     |
| olderthan-x-minutes                 | The value is older than the specified number of minutes.                                                                    | 指定された分より古い値です。                                                                                                            |               | ○             |                         |             |              |               |                              |     |
| olderthan-x-months                  | The value is older than the specified number of months.                                                                     | 指定された月より古い値です。                                                                                                            |               | ○             |                         |             |              |               |                              |     |
| olderthan-x-weeks                   | The value is older than the specified number of weeks.                                                                      | 指定された週より古い値です。                                                                                                            |               | ○             |                         |             |              |               |                              |     |
| olderthan-x-years                   | The value is older than the specified number of years.                                                                      | 指定された年より古い値です。                                                                                                            |               | ○             |                         |             |              |               |                              |     |
| on                                  | The value is on a specified date.                                                                                           | 値は指定された日付のものです。                                                                                                          |               | ○             |                         |             |              |               |                              |     |
| on-or-after                         | The value is on or after a specified date.                                                                                  | 値は指定した日付以降のものです。                                                                                                        |               | ○             |                         |             |              |               |                              |     |
| on-or-before                        | The value is on or before a specified date.                                                                                 | 値は指定した日付以前のものです。                                                                                                        |               | ○             |                         |             |              |               |                              |     |
| this-fiscal-period                  | The value is within the current fiscal period.                                                                              | 現在の会計期間内の数値である必要があります。                                                                                            |               | ○             |                         |             |              |               |                              |     |
| this-fiscal-year                    | The value is within the current fiscal year.                                                                                | 値は当年度内のものである必要があります。                                                                                                |               | ○             |                         |             |              |               |                              |     |
| this-month                          | The value is within the current month.                                                                                      | 現在月内の数値である必要があります。                                                                                                    |               | ○             |                         |             |              |               |                              |     |
| this-week                           | The value is within the current week.                                                                                       | 現在週内の数値である必要があります。                                                                                                    |               | ○             |                         |             |              |               |                              |     |
| this-year                           | The value is within the current year.                                                                                       | 現在年内の数値である必要があります。                                                                                                    |               | ○             |                         |             |              |               |                              |     |
| today                               | The value equals today's date.                                                                                              | 値は今日の日付と同じです。                                                                                                              |               | ○             |                         |             |              |               |                              |     |
| tomorrow                            | The value equals tomorrow's date.                                                                                           | 値は明日の日付と同じです。                                                                                                              |               | ○             |                         |             |              |               |                              |     |
| under                               | Returns all child records below the referenced record in the hierarchy.                                                     | 階層で参照されているレコードの下にあるすべての子レコードを返します。                                                                    |               |               | ○                       |             |              |               |                              |     |
| yesterday                           | The value equals yesterday's date.                                                                                          | 値は昨日の日付と同じです。                                                                                                              |               | ○             |                         |             |              |               |                              |     |

---

Copyright (c) 2024 YA-androidapp(https://github.com/yzkn) All rights reserved.
