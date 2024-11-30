# PowerPlatform-PowerAutomate-DataverseWebAPI-FetchXMLSamples

Power Automate クラウドフローで FetchXML を使用して Dataverse テーブルのレコードを取得する

---

<br><br><br><br><br>

# 利用したツール

- XRMToolBox
  - FetchXML Builder
  - SQL4CDS
  - \(SSMS\)

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

- [SQL](src/query/one2many01.sql)
  - [結果](src/result/one2many01.sql.json)
- [FetchXML](src/query/one2many01.xml)
  - [結果](src/result/one2many01.xml.json)
- [ODataクエリ](src/query/one2many01.odata)
  - [結果](src/result/one2many01.odata.json)

<br><br><br>

### 多対一

- [SQL](src/query/many2one01.sql)
  - [結果](src/result/many2one01.sql.json)
- [FetchXML](src/query/many2one01.xml)
  - [結果](src/result/many2one01.xml.json)
- [ODataクエリ](src/query/many2one01.odata)
  - [結果](src/result/many2one01.odata.json)

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
  - スコープ : [スコープ](src/action/scope_793c6d53-0597-4f42-8184-e601f264fb7c.json)をクラシックデザイナーにコピペ


<br><br><br><br><br>

# 演算子

## FetchXML

### 条件演算子

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

## ODataクエリ

### 比較演算子

列の型が一致する必要がある。

| Operator | Description | 例                        |
| -------- | ----------- | ------------------------- |
| eq       | 等しい      | $filter=revenue eq 100000 |
| ne       | 等しくない  | $filter=revenue ne 100000 |
| gt       | より大きい  | $filter=revenue gt 100000 |
| ge       | 以上        | $filter=revenue ge 100000 |
| lt       | より小さい  | $filter=revenue lt 100000 |
| le       | 以下        | $filter=revenue le 100000 |

### 論理演算子

| Operator | Description | 例                                                         |
| -------- | ----------- | ---------------------------------------------------------- |
| and      | 論理積      | $filter=revenue lt 100000 and revenue gt 2000              |
| or       | 論理和      | $filter=contains(name,'(sample)') or contains(name,'test') |
| not      | 論理否定    | $filter=not contains(name,'sample')                        |

### グループ化演算子

| Operator | Description | 例                                                                     |
| -------- | ----------- | ---------------------------------------------------------------------- |
| ()       | グループ化  | (contains(name,'sample') or contains(name,'test')) and revenue gt 5000 |

### OData クエリ関数

| Function   | 例                                |
| ---------- | --------------------------------- |
| contains   | $filter=contains(name,'(sample)') |
| endswith   | $filter=endswith(name,'Inc.')     |
| startswith | $filter=startswith(name,'a')      |

#### 文字列値でフィルタリングするときの留意事項 [^](https://learn.microsoft.com/ja-jp/power-apps/developer/data-platform/webapi/query/filter-rows#filter-using-string-values)

- 大文字小文字を区別しない

- フィルター条件では、特殊文字をURLエンコードする

```
contains(name,'+123') → contains(name,'%2B123')
```

| 特殊文字 | URLエンコード |
| -------- | ------------- |
| `$`      | `%24`         |
| `&`      | `%26`         |
| `+`      | `%2B`         |
| `,`      | `%2C`         |
| `/`      | `%2F`         |
| `:`      | `%3A`         |
| `;`      | `%3B`         |
| `=`      | `%3D`         |
| `?`      | `%3F`         |
| `@`      | `%40`         |

- ワイルドカード文字を使用することもできる

| Character | Description                                                                                             | T-SQL のドキュメントと例                                                                                                   |
| --------- | ------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------- |
| %         | 0 文字以上の任意の文字列に一致します。 このワイルドカード文字は、接頭辞または接尾辞として使用できます。 | https://learn.microsoft.com/ja-jp/sql/t-sql/language-elements/percent-character-wildcard-character-s-to-match-transact-sql |
| _         | アンダースコア文字を使用して、パターン マッチングを含む文字列比較操作で任意の 1 文字を照合します。      | https://learn.microsoft.com/ja-jp/sql/t-sql/language-elements/wildcard-match-one-character-transact-sql                    |
| []        | かっこで囲まれた指定範囲またはセット内の任意の 1 文字に一致します。                                     | https://learn.microsoft.com/ja-jp/sql/t-sql/language-elements/wildcard-character-s-to-match-transact-sql                   |
| [^]       | 角かっこで囲まれた指定範囲またはセット内にはない任意の 1 文字に一致します。                             | https://learn.microsoft.com/ja-jp/sql/t-sql/language-elements/wildcard-character-s-not-to-match-transact-sql               |

- 一重引用符はエスケープするか、値を二重引用符で囲む

```
// 文字列値の配列
https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/contacts?$select=fullname&$filter=Microsoft.Dynamics.CRM.In(PropertyName=@p1,PropertyValues=@p2)&@p1='lastname'&@p2=["OBrian","OBryan","O'Brian","O'Bryan"]

// 単一値
https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/contacts?$select=fullname&$filter=lastname eq 'O''Bryan'
```

### Dataverse クエリ関数

| Group      | 関数                             | Description                                                                                               | Example                                                                                                                                        |
| ---------- | -------------------------------- | --------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| 日付       | InFiscalPeriod                   | Query function that evaluates whether the value is within the specified fiscal period.                    | ?$filter=Microsoft.Dynamics.CRM.InFiscalPeriod(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                           |
|            | InFiscalPeriodAndYear            | Query function that evaluates whether the value is within the specified fiscal period and year.           | ?$filter=Microsoft.Dynamics.CRM.InFiscalPeriodAndYear(PropertyName=@p1,PropertyValue1=@p2,PropertyValue2=@p3)&@p1='name'&@p2=42&@p3=42         |
|            | InFiscalYear                     | Query function that evaluates whether the value is within the specified fiscal year.                      | ?$filter=Microsoft.Dynamics.CRM.InFiscalYear(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                             |
|            | InOrAfterFiscalPeriodAndYear     | Query function that evaluates whether the value is within or after the specified fiscal period and year.  | ?$filter=Microsoft.Dynamics.CRM.InOrAfterFiscalPeriodAndYear(PropertyName=@p1,PropertyValue1=@p2,PropertyValue2=@p3)&@p1='name'&@p2=42&@p3=42  |
|            | InOrBeforeFiscalPeriodAndYear    | Query function that evaluates whether the value is within or before the specified fiscal period and year. | ?$filter=Microsoft.Dynamics.CRM.InOrBeforeFiscalPeriodAndYear(PropertyName=@p1,PropertyValue1=@p2,PropertyValue2=@p3)&@p1='name'&@p2=42&@p3=42 |
|            | Last7Days                        | Query function to evaluate whether the value is within the last seven days including today.               | ?$filter=Microsoft.Dynamics.CRM.Last7Days(PropertyName=@p1)&@p1='name'                                                                         |
|            | LastFiscalPeriod                 | Query function to evaluate whether the value is within the last fiscal period.                            | ?$filter=Microsoft.Dynamics.CRM.LastFiscalPeriod(PropertyName=@p1)&@p1='name'                                                                  |
|            | LastFiscalYear                   | Query function to evaluate whether the value is within the last fiscal year.                              | ?$filter=Microsoft.Dynamics.CRM.LastFiscalYear(PropertyName=@p1)&@p1='name'                                                                    |
|            | LastMonth                        | Query function to evaluate whether the value is within the last fiscal year.                              | ?$filter=Microsoft.Dynamics.CRM.LastMonth(PropertyName=@p1)&@p1='name'                                                                         |
|            | LastWeek                         | Query function to evaluate whether the value is within the last week.                                     | ?$filter=Microsoft.Dynamics.CRM.LastWeek(PropertyName=@p1)&@p1='name'                                                                          |
|            | LastXDays                        | Query function to evaluate whether the value is within the last X days.                                   | ?$filter=Microsoft.Dynamics.CRM.LastXDays(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                                |
|            | LastXFiscalPeriods               | Query function to evaluate whether the value is within the last X fiscal periods.                         | ?$filter=Microsoft.Dynamics.CRM.LastXFiscalPeriods(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                       |
|            | LastXFiscalYears                 | Query function to evaluate whether the value is within the last X fiscal years.                           | ?$filter=Microsoft.Dynamics.CRM.LastXFiscalYears(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                         |
|            | LastXHours                       | Query function to evaluate whether the value is within the last X hours                                   | ?$filter=Microsoft.Dynamics.CRM.LastXHours(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                               |
|            | LastXMonths                      | Query function to evaluate whether the value is within the last X months.                                 | ?$filter=Microsoft.Dynamics.CRM.LastXMonths(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                              |
|            | LastXWeeks                       | Query function to evaluate whether the value is within the last X weeks.                                  | ?$filter=Microsoft.Dynamics.CRM.LastXWeeks(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                               |
|            | LastXYears                       | Query function to evaluate whether the value is within the last X years.                                  | ?$filter=Microsoft.Dynamics.CRM.LastXYears(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                               |
|            | LastYear                         | Query function to evaluate whether the value is within the last year.                                     | ?$filter=Microsoft.Dynamics.CRM.LastYear(PropertyName=@p1)&@p1='name'                                                                          |
|            | Next7Days                        |                                                                                                           |                                                                                                                                                |
|            | NextFiscalPeriod                 |                                                                                                           |                                                                                                                                                |
|            | NextFiscalYear                   |                                                                                                           |                                                                                                                                                |
|            | NextMonth                        |                                                                                                           |                                                                                                                                                |
|            | NextWeek                         |                                                                                                           |                                                                                                                                                |
|            | NextXDays                        |                                                                                                           |                                                                                                                                                |
|            | NextXFiscalPeriods               |                                                                                                           |                                                                                                                                                |
|            | NextXFiscalYears                 |                                                                                                           |                                                                                                                                                |
|            | NextXHours                       |                                                                                                           |                                                                                                                                                |
|            | NextXMonths                      |                                                                                                           |                                                                                                                                                |
|            | NextXWeeks                       |                                                                                                           |                                                                                                                                                |
|            | NextXYears                       |                                                                                                           |                                                                                                                                                |
|            | NextYear                         |                                                                                                           |                                                                                                                                                |
|            | OlderThanXDays                   |                                                                                                           |                                                                                                                                                |
|            | OlderThanXHours                  |                                                                                                           |                                                                                                                                                |
|            | OlderThanXMinutes                |                                                                                                           |                                                                                                                                                |
|            | OlderThanXMonths                 |                                                                                                           |                                                                                                                                                |
|            | OlderThanXWeeks                  |                                                                                                           |                                                                                                                                                |
|            | OlderThanXYears                  |                                                                                                           |                                                                                                                                                |
|            | On                               |                                                                                                           |                                                                                                                                                |
|            | OnOrAfter                        |                                                                                                           |                                                                                                                                                |
|            | OnOrBefore                       |                                                                                                           |                                                                                                                                                |
|            | ThisFiscalPeriod                 |                                                                                                           |                                                                                                                                                |
|            | ThisFiscalYear                   |                                                                                                           |                                                                                                                                                |
|            | ThisMonth                        |                                                                                                           |                                                                                                                                                |
|            | ThisWeek                         |                                                                                                           |                                                                                                                                                |
|            | ThisYear                         |                                                                                                           |                                                                                                                                                |
|            | Today                            |                                                                                                           |                                                                                                                                                |
|            | Tomorrow                         |                                                                                                           |                                                                                                                                                |
|            | Yesterday                        |                                                                                                           |                                                                                                                                                |
| ID 値      | EqualBusinessId                  |                                                                                                           |                                                                                                                                                |
|            | EqualUserId                      |                                                                                                           |                                                                                                                                                |
|            | NotEqualBusinessId               |                                                                                                           |                                                                                                                                                |
|            | NotEqualUserId                   |                                                                                                           |                                                                                                                                                |
| 階層       | Above                            |                                                                                                           |                                                                                                                                                |
|            | AboveOrEqual                     |                                                                                                           |                                                                                                                                                |
|            | EqualUserOrUserHierarchy         |                                                                                                           |                                                                                                                                                |
|            | EqualUserOrUserHierarchyAndTeams |                                                                                                           |                                                                                                                                                |
|            | EqualUserOrUserTeams             |                                                                                                           |                                                                                                                                                |
|            | EqualUserTeams                   |                                                                                                           |                                                                                                                                                |
|            | NotUnder                         |                                                                                                           |                                                                                                                                                |
|            | Under                            |                                                                                                           |                                                                                                                                                |
|            | UnderOrEqual                     |                                                                                                           |                                                                                                                                                |
| 選択肢の列 | ContainValues                    |                                                                                                           |                                                                                                                                                |
|            | DoesNotContainValues             |                                                                                                           |                                                                                                                                                |
| 次の範囲内 | Between                          |                                                                                                           |                                                                                                                                                |
|            | NotBetween                       |                                                                                                           |                                                                                                                                                |
| 後         | In                               |                                                                                                           |                                                                                                                                                |
|            | NotIn                            |                                                                                                           |                                                                                                                                                |
| 言語       | EqualUserLanguage                |                                                                                                           |                                                                                                                                                |

- [Dataverse クエリ関数](https://learn.microsoft.com/ja-jp/power-apps/developer/data-platform/webapi/query/filter-rows#dataverse-query-functions)
  - [完全なリスト](https://learn.microsoft.com/ja-jp/power-apps/developer/data-platform/webapi/reference/queryfunctions)

### ラムダ式

- [関連するコレクションの値でフィルターする](https://learn.microsoft.com/ja-jp/power-apps/developer/data-platform/webapi/query/filter-rows#filter-using-values-of-related-collections)


---

Copyright (c) 2024 YA-androidapp(https://github.com/yzkn) All rights reserved.
