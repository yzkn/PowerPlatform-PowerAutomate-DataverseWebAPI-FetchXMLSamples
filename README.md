# PowerPlatform-PowerAutomate-DataverseWebAPI-FetchXMLSamples

Power Automate クラウドフローで FetchXML を使用して Dataverse テーブルのレコードを取得する

---

- [PowerPlatform-PowerAutomate-DataverseWebAPI-FetchXMLSamples](#powerplatform-powerautomate-dataversewebapi-fetchxmlsamples)
- [利用したツール](#利用したツール)
- [テーブル名の種類](#テーブル名の種類)
- [基本的なクエリ](#基本的なクエリ)
  - [件数（行数）指定＋列（属性）指定＋列の別名（エイリアス）＋フィルタリング＋ソート](#件数行数指定列属性指定列の別名エイリアスフィルタリングソート)
  - [重複除外](#重複除外)
  - [集計](#集計)
  - [結合](#結合)
    - [一対多](#一対多)
    - [多対一](#多対一)
- [FetchXMLでページングCookieを利用して大量データを読み込む](#fetchxmlでページングcookieを利用して大量データを読み込む)
- [レコード数のカウント](#レコード数のカウント)
  - [RetrieveTotalRecordCount関数](#retrievetotalrecordcount関数)
  - [ODataクエリでカウント](#odataクエリでカウント)
    - [テーブルにあるレコードが5000件未満の場合](#テーブルにあるレコードが5000件未満の場合)
    - [テーブルにあるレコードが5000件超の場合](#テーブルにあるレコードが5000件超の場合)
  - [FetchXMLでカウント](#fetchxmlでカウント)
- [行の関連付け](#行の関連付け)
  - [ODataクエリで関連付け](#odataクエリで関連付け)
    - [単一値ナビゲーションプロパティ](#単一値ナビゲーションプロパティ)
      - [関連付け](#関連付け)
        - [PATCH](#patch)
        - [PUT](#put)
      - [関連付け解除](#関連付け解除)
        - [PATCH](#patch-1)
        - [DELETE](#delete)
    - [コレクション値ナビゲーションプロパティ](#コレクション値ナビゲーションプロパティ)
      - [レコードをコレクションに追加](#レコードをコレクションに追加)
        - [一対多](#一対多-1)
        - [多対多](#多対多)
      - [レコードをコレクションから削除](#レコードをコレクションから削除)
- [演算子](#演算子)
  - [FetchXMLの演算子](#fetchxmlの演算子)
    - [条件演算子](#条件演算子)
  - [ODataクエリの演算子](#odataクエリの演算子)
    - [比較演算子](#比較演算子)
    - [論理演算子](#論理演算子)
    - [グループ化演算子](#グループ化演算子)
    - [OData クエリ関数](#odata-クエリ関数)
      - [文字列値でフィルタリングするときの留意事項 ^](#文字列値でフィルタリングするときの留意事項-)
    - [Dataverse クエリ関数](#dataverse-クエリ関数)
    - [関連テーブルの値に基づくフィルター](#関連テーブルの値に基づくフィルター)
      - [ルックアッププロパティのフィルター](#ルックアッププロパティのフィルター)
      - [ルックアップ列を表す単一値ナビゲーションプロパティの値に基づくフィルター](#ルックアップ列を表す単一値ナビゲーションプロパティの値に基づくフィルター)
        - [単一値ナビゲーションプロパティの階層のさらに上位にある値に基づくフィルター](#単一値ナビゲーションプロパティの階層のさらに上位にある値に基づくフィルター)
        - [ラムダ演算子](#ラムダ演算子)
          - [any](#any)
          - [all](#all)

---

<br><br><br><br><br>

# 利用したツール

- XRMToolBox
  - FetchXML Builder
  - SQL4CDS
  - \(SSMS\)

<br><br><br><br><br>

# テーブル名の種類

取引先企業テーブル（Accountテーブル）を例に示す。

| 名前                   | Name                  | 例                  | 説明                                                     |
| ---------------------- | --------------------- | ------------------- | -------------------------------------------------------- |
| スキーマ名             | SchemaName            | Account             | パスカルケースで定義した名前                             |
| コレクションスキーマ名 | CollectionSchemaName  | Accounts            | スキーマ名の複数形                                       |
| 論理名                 | LogicalName           | account             | スキーマ名をすべて小文字にした名前                       |
| 論理コレクション名     | LogicalCollectionName | accounts            | コレクションスキーマ名をすべて小文字にした名前           |
| エンティティセット名   | EntitySetName         | accounts            | Web APIでコレクションを識別するために使用される名前      |
|                        |                       |                     | 既定では論理コレクション名と同じだが、変更することも可能 |
| 表示名                 | DisplayName           | 取引先企業 Account  | スキーマ名と同じだが、スペースを含めることができる       |
| 表示コレクション名     | DisplayCollectionName | 取引先企業 Accounts | 表示名の複数形                                           |

- https://learn.microsoft.com/ja-jp/dynamics365/customerengagement/on-premises/developer/introduction-entities#names-used-in-entity-metadata
- https://learn.microsoft.com/ja-jp/power-apps/developer/data-platform/customize-entity-metadata#editable-table-properties
- https://learn.microsoft.com/ja-jp/power-apps/developer/data-platform/entity-metadata#table-names
- https://learn.microsoft.com/ja-jp/power-apps/developer/data-platform/webapi/web-api-service-documents?tabs=insomnia#entity-set-name

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

# FetchXMLでページングCookieを利用して大量データを読み込む

- [CountAllRecordsWithPagingCookiesInHttpAction](https://github.com/yzkn/PowerPlatform-PowerAutomate-DataverseWebAPI-CountRecords/blob/main/Flows/CountAllRecordsWithPagingCookiesInHttpAction_20241121035408.zip)

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

# レコード数のカウント

## RetrieveTotalRecordCount関数

5000件を超えるテーブルの合計行数の、過去24時間以内のスナップショットを取得する場合。

※実稼働環境かサンドボックス環境でないとカウントされていないらしい

```
https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/RetrieveTotalRecordCount(EntityNames=['account'])
```

```json
{
    "@odata.context": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/$metadata#Microsoft.Dynamics.CRM.RetrieveTotalRecordCountResponse",
    "EntityRecordCountCollection": {
        "Count": 1,
        "IsReadOnly": false,
        "Keys": [
            "account"
        ],
        "Values": [
            10
        ]
    }
}
```

<br><br><br><br>

## ODataクエリでカウント

<br><br><br>

### テーブルにあるレコードが5000件未満の場合

```
https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts?$select=accountid&$count=true
```

```json
{
    "@odata.context": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/$metadata#accounts(accountid)",
    "@odata.count": 10,
    "value": [
        {
            "@odata.etag": "W/\"3608658\"",
            "accountid": "2c974e2f-fcaa-ef11-b8e8-002248f17214"
        },
        （中略）
        {
            "@odata.etag": "W/\"3608649\"",
            "accountid": "3e974e2f-fcaa-ef11-b8e8-002248f17214"
        }
    ]
}
```

コレクションの数を表す数値だけを取得する場合。

```
https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts/$count
```

```
10
```

<br><br><br>

### テーブルにあるレコードが5000件超の場合

```
GET https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/ya_customers?$select=ya_customerid&$count=true
```

```json
{
    "@odata.context": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/$metadata#ya_customers(ya_customerid)",
    "@odata.count": 5000,
    "value": [
        {
            "@odata.etag": "W/\"3578333\"",
            "ya_customerid": "ec872f6c-bda0-ef11-8a69-000d3acf17ba"
        },
        （中略）
        {
            "@odata.etag": "W/\"3330103\"",
            "ya_customerid": "c7c5cdc5-56a1-ef11-8a69-000d3acf17ba"
        }
    ],
    "@odata.nextLink": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/ya_customers?$select=ya_customerid&$count=true&$skiptoken=%3Ccookie%20pagenumber=%222%22%20pagingcookie=%22%253ccookie%2520page%253d%25221%2522%253e%253cya_customerid%2520last%253d%2522%257bC7C5CDC5-56A1-EF11-8A69-000D3ACF17BA%257d%2522%2520first%253d%2522%257bEC872F6C-BDA0-EF11-8A69-000D3ACF17BA%257d%2522%2520%252f%253e%253c%252fcookie%253e%22%20istracking=%22False%22%20/%3E"
}
```

カウント値が5000で、ちょうど5000なのか、5000より大きいかを知りたい場合は、Preferリクエストヘッダーを追加する。

```
https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts?$select=accountid&$count=true
Prefer: odata.include-annotations="Microsoft.Dynamics.CRM.totalrecordcount,Microsoft.Dynamics.CRM.totalrecordcountlimitexceeded"
```

```json
{
    "@odata.count": 5000,
    "@Microsoft.Dynamics.CRM.totalrecordcount": 5000,
    "@Microsoft.Dynamics.CRM.totalrecordcountlimitexceeded": true,
    （中略）
}
```

<br><br><br><br>

## FetchXMLでカウント

[ページングCookie](#fetchxmlでページングcookieを利用して大量データを読み込む)を利用して、5000件超のレコードをカウントする。

- [CountAllRecordsWithPagingCookiesInHttpAction](https://github.com/yzkn/PowerPlatform-PowerAutomate-DataverseWebAPI-CountRecords/blob/main/Flows/CountAllRecordsWithPagingCookiesInHttpAction_20241121035408.zip)

ページングCookieによるページングを利用せずに、page属性とcount属性によるページングを利用した場合には、レコード数の上限は50000件（5000件／ページ　×　10ページ）となる。

<br><br><br><br><br>

# 行の関連付け

<br><br><br><br>

## ODataクエリで関連付け

| タイプ | 説明                                        | 設定先                                                                                           |
| ------ | ------------------------------------------- | ------------------------------------------------------------------------------------------------ |
| 一対多 | 1 つのレコードに多数のレコードを関連付ける  | account レコードの contact_customer_accountsコレクション値ナビゲーション プロパティ              |
| 多対一 | 多数のレコードを 1 つのレコードに関連付ける | contact レコードの parentcustomerid_account 単一値ナビゲーション プロパティ                      |
| 多対多 | 多数のレコードを多数のレコードに関連付ける  | systemuser / role レコードの systemuserroles_association コレクション値ナビゲーション プロパティ |

<br><br><br>

### 単一値ナビゲーションプロパティ

<br><br>

#### 関連付け

<br>

##### PATCH

```
PATCH https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/contacts(40974e2f-fcaa-ef11-b8e8-002248f17214) HTTP/1.1
If-Match: *
OData-MaxVersion: 4.0
OData-Version: 4.0
If-None-Match: null
Accept: application/json

{
  "parentcustomerid_account@odata.bind": "accounts(2c974e2f-fcaa-ef11-b8e8-002248f17214)"
}
```

<br>

##### PUT

```
PUT https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/contacts(40974e2f-fcaa-ef11-b8e8-002248f17214)/parentcustomerid_account/$ref HTTP/1.1
OData-MaxVersion: 4.0
OData-Version: 4.0
If-None-Match: null
Accept: application/json

{
  "@odata.id": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts(2c974e2f-fcaa-ef11-b8e8-002248f17214)"
}
```

※ `@odata.id` の値には、絶対URLを使用する

<br><br>

#### 関連付け解除

<br>

##### PATCH

```
PATCH https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/contacts(40974e2f-fcaa-ef11-b8e8-002248f17214) HTTP/1.1
If-Match: *
OData-MaxVersion: 4.0
OData-Version: 4.0
If-None-Match: null
Accept: application/json

{
  "parentcustomerid_account@odata.bind": null
}
```

以下のように、@odata.bind注釈を含めなくても良い。

```
{
  "parentcustomerid_account": null
}
```

<br>

##### DELETE

```
DELETE https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/contacts(40974e2f-fcaa-ef11-b8e8-002248f17214)/parentcustomerid_account/$ref HTTP/1.1
OData-MaxVersion: 4.0
OData-Version: 4.0
If-None-Match: null
Accept: application/json
```

<br><br><br>

### コレクション値ナビゲーションプロパティ

<br><br>

#### レコードをコレクションに追加

<br>

##### 一対多

```
POST https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts(2c974e2f-fcaa-ef11-b8e8-002248f17214)/contact_customer_accounts/$ref HTTP/1.1
OData-MaxVersion: 4.0
OData-Version: 4.0
If-None-Match: null
Accept: application/json

{
  "@odata.id": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/contacts(40974e2f-fcaa-ef11-b8e8-002248f17214)"
}
```

<br>

##### 多対多

```
POST https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/systemusers(c0429b81-5380-ef11-ac20-000d3a40bd7b)/systemuserroles_association/$ref HTTP/1.1
OData-MaxVersion: 4.0
OData-Version: 4.0
If-None-Match: null
Accept: application/json

{
  "@odata.id": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/roles(b9b08637-acf6-e711-a95a-000d3a11f5ee)"
}
```

<br><br>

#### レコードをコレクションから削除

```
DELETE https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts(2c974e2f-fcaa-ef11-b8e8-002248f17214)/contact_customer_accounts(40974e2f-fcaa-ef11-b8e8-002248f17214)/$ref HTTP/1.1
OData-MaxVersion: 4.0
OData-Version: 4.0
If-None-Match: null
Accept: application/json
```

```
DELETE https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts(2c974e2f-fcaa-ef11-b8e8-002248f17214)/contact_customer_accounts/$ref?$id=https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/contacts(40974e2f-fcaa-ef11-b8e8-002248f17214) HTTP/1.1
OData-MaxVersion: 4.0
OData-Version: 4.0
If-None-Match: null
Accept: application/json
```

<br><br><br><br><br>

# 演算子

<br><br><br><br>

## FetchXMLの演算子

<br><br><br>

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

<br><br><br><br>

## ODataクエリの演算子

<br><br><br>

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

<br><br><br>

### 論理演算子

| Operator | Description | 例                                                         |
| -------- | ----------- | ---------------------------------------------------------- |
| and      | 論理積      | $filter=revenue lt 100000 and revenue gt 2000              |
| or       | 論理和      | $filter=contains(name,'(sample)') or contains(name,'test') |
| not      | 論理否定    | $filter=not contains(name,'sample')                        |

<br><br><br>

### グループ化演算子

| Operator | Description | 例                                                                     |
| -------- | ----------- | ---------------------------------------------------------------------- |
| ()       | グループ化  | (contains(name,'sample') or contains(name,'test')) and revenue gt 5000 |

<br><br><br>

### OData クエリ関数

| Function   | 例                                |
| ---------- | --------------------------------- |
| contains   | $filter=contains(name,'(sample)') |
| endswith   | $filter=endswith(name,'Inc.')     |
| startswith | $filter=startswith(name,'a')      |

<br><br>

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

<br><br><br>

### Dataverse クエリ関数

```
https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts?$select=name,numberofemployees&$filter=Microsoft.Dynamics.CRM.Between(PropertyName='numberofemployees',PropertyValues=["5","2000"])
```

```json
{
    "@odata.context": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/$metadata#accounts(name,numberofemployees)",
    "value": [
        {
            "@odata.etag": "W/\"3608672\"",
            "name": "コントソ製薬 (サンプル)",
            "numberofemployees": 1500,
            "accountid": "38974e2f-fcaa-ef11-b8e8-002248f17214"
        }
    ]
}
```

| Group      | 関数                             | Description                                                                                                   | Example                                                                                                                                        |
| ---------- | -------------------------------- | ------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------- |
| 日付       | InFiscalPeriod                   | Query function that evaluates whether the value is within the specified fiscal period.                        | ?$filter=Microsoft.Dynamics.CRM.InFiscalPeriod(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                           |
|            | InFiscalPeriodAndYear            | Query function that evaluates whether the value is within the specified fiscal period and year.               | ?$filter=Microsoft.Dynamics.CRM.InFiscalPeriodAndYear(PropertyName=@p1,PropertyValue1=@p2,PropertyValue2=@p3)&@p1='name'&@p2=42&@p3=42         |
|            | InFiscalYear                     | Query function that evaluates whether the value is within the specified fiscal year.                          | ?$filter=Microsoft.Dynamics.CRM.InFiscalYear(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                             |
|            | InOrAfterFiscalPeriodAndYear     | Query function that evaluates whether the value is within or after the specified fiscal period and year.      | ?$filter=Microsoft.Dynamics.CRM.InOrAfterFiscalPeriodAndYear(PropertyName=@p1,PropertyValue1=@p2,PropertyValue2=@p3)&@p1='name'&@p2=42&@p3=42  |
|            | InOrBeforeFiscalPeriodAndYear    | Query function that evaluates whether the value is within or before the specified fiscal period and year.     | ?$filter=Microsoft.Dynamics.CRM.InOrBeforeFiscalPeriodAndYear(PropertyName=@p1,PropertyValue1=@p2,PropertyValue2=@p3)&@p1='name'&@p2=42&@p3=42 |
|            | Last7Days                        | Query function to evaluate whether the value is within the last seven days including today.                   | ?$filter=Microsoft.Dynamics.CRM.Last7Days(PropertyName=@p1)&@p1='name'                                                                         |
|            | LastFiscalPeriod                 | Query function to evaluate whether the value is within the last fiscal period.                                | ?$filter=Microsoft.Dynamics.CRM.LastFiscalPeriod(PropertyName=@p1)&@p1='name'                                                                  |
|            | LastFiscalYear                   | Query function to evaluate whether the value is within the last fiscal year.                                  | ?$filter=Microsoft.Dynamics.CRM.LastFiscalYear(PropertyName=@p1)&@p1='name'                                                                    |
|            | LastMonth                        | Query function to evaluate whether the value is within the last fiscal year.                                  | ?$filter=Microsoft.Dynamics.CRM.LastMonth(PropertyName=@p1)&@p1='name'                                                                         |
|            | LastWeek                         | Query function to evaluate whether the value is within the last week.                                         | ?$filter=Microsoft.Dynamics.CRM.LastWeek(PropertyName=@p1)&@p1='name'                                                                          |
|            | LastXDays                        | Query function to evaluate whether the value is within the last X days.                                       | ?$filter=Microsoft.Dynamics.CRM.LastXDays(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                                |
|            | LastXFiscalPeriods               | Query function to evaluate whether the value is within the last X fiscal periods.                             | ?$filter=Microsoft.Dynamics.CRM.LastXFiscalPeriods(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                       |
|            | LastXFiscalYears                 | Query function to evaluate whether the value is within the last X fiscal years.                               | ?$filter=Microsoft.Dynamics.CRM.LastXFiscalYears(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                         |
|            | LastXHours                       | Query function to evaluate whether the value is within the last X hours                                       | ?$filter=Microsoft.Dynamics.CRM.LastXHours(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                               |
|            | LastXMonths                      | Query function to evaluate whether the value is within the last X months.                                     | ?$filter=Microsoft.Dynamics.CRM.LastXMonths(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                              |
|            | LastXWeeks                       | Query function to evaluate whether the value is within the last X weeks.                                      | ?$filter=Microsoft.Dynamics.CRM.LastXWeeks(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                               |
|            | LastXYears                       | Query function to evaluate whether the value is within the last X years.                                      | ?$filter=Microsoft.Dynamics.CRM.LastXYears(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                               |
|            | LastYear                         | Query function to evaluate whether the value is within the last year.                                         | ?$filter=Microsoft.Dynamics.CRM.LastYear(PropertyName=@p1)&@p1='name'                                                                          |
|            | Next7Days                        | Query function to evaluate whether the value is within the next 7 days.                                       | ?$filter=Microsoft.Dynamics.CRM.Next7Days(PropertyName=@p1)&@p1='name'                                                                         |
|            | NextFiscalPeriod                 | Query function to evaluate whether the value is in the next fiscal period.                                    | ?$filter=Microsoft.Dynamics.CRM.NextFiscalPeriod(PropertyName=@p1)&@p1='name'                                                                  |
|            | NextFiscalYear                   | Query function to evaluate whether the value is in the next fiscal year.                                      | ?$filter=Microsoft.Dynamics.CRM.NextFiscalYear(PropertyName=@p1)&@p1='name'                                                                    |
|            | NextMonth                        | Query function to evaluate whether the value is in the next month.                                            | ?$filter=Microsoft.Dynamics.CRM.NextMonth(PropertyName=@p1)&@p1='name'                                                                         |
|            | NextWeek                         | Query function to evaluate whether the value is in the next week.                                             | ?$filter=Microsoft.Dynamics.CRM.NextWeek(PropertyName=@p1)&@p1='name'                                                                          |
|            | NextXDays                        | Query function to evaluate whether the value is in the next X days.                                           | ?$filter=Microsoft.Dynamics.CRM.NextXDays(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                                |
|            | NextXFiscalPeriods               | Query function to evaluate whether the value is in the next X fiscal periods.                                 | ?$filter=Microsoft.Dynamics.CRM.NextXFiscalPeriods(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                       |
|            | NextXFiscalYears                 | Query function to evaluate whether the value is in the next X fiscal years.                                   | ?$filter=Microsoft.Dynamics.CRM.NextXFiscalYears(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                         |
|            | NextXHours                       | Query function to evaluate whether the value is in the next X hours.                                          | ?$filter=Microsoft.Dynamics.CRM.NextXHours(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                               |
|            | NextXMonths                      | Query function to evaluate whether the value is in the next X months.                                         | ?$filter=Microsoft.Dynamics.CRM.NextXMonths(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                              |
|            | NextXWeeks                       | Query function to evaluate whether the value is in the next X weeks.                                          | ?$filter=Microsoft.Dynamics.CRM.NextXWeeks(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                               |
|            | NextXYears                       | Query function to evaluate whether the value is in the next X years.                                          | ?$filter=Microsoft.Dynamics.CRM.NextXYears(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                               |
|            | NextYear                         | Query function to evaluate whether the value is in the next X year.                                           | ?$filter=Microsoft.Dynamics.CRM.NextYear(PropertyName=@p1)&@p1='name'                                                                          |
|            | OlderThanXDays                   | Query function to evaluate whether the value is older than the specified amount of days.                      | ?$filter=Microsoft.Dynamics.CRM.OlderThanXDays(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                           |
|            | OlderThanXHours                  | Query function to evaluate whether the value is older than the specified amount of hours.                     | ?$filter=Microsoft.Dynamics.CRM.OlderThanXHours(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                          |
|            | OlderThanXMinutes                | Query function to evaluate whether the value is older than the specified amount of minutes.                   | ?$filter=Microsoft.Dynamics.CRM.OlderThanXMinutes(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                        |
|            | OlderThanXMonths                 | Query function to evaluate whether the value is older than the specified amount of months.                    | ?$filter=Microsoft.Dynamics.CRM.OlderThanXMonths(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                         |
|            | OlderThanXWeeks                  | Query function to evaluate whether the value is older than the specified amount of weeks.                     | ?$filter=Microsoft.Dynamics.CRM.OlderThanXWeeks(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                          |
|            | OlderThanXYears                  | Query function to evaluate whether the value is older than the specified amount of years.                     | ?$filter=Microsoft.Dynamics.CRM.OlderThanXYears(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2=42                                          |
|            | On                               | Query function to evaluate whether the value is on the specified date.                                        | ?$filter=Microsoft.Dynamics.CRM.On(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2='value'                                                  |
|            | OnOrAfter                        | Query function to evaluate whether the value is on or after the specified date.                               | ?$filter=Microsoft.Dynamics.CRM.OnOrAfter(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2='value'                                           |
|            | OnOrBefore                       | Query function to evaluate whether the value is on or before the specified date.                              | ?$filter=Microsoft.Dynamics.CRM.OnOrBefore(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2='value'                                          |
|            | ThisFiscalPeriod                 | Query function that evaluates whether the value is within the current fiscal period.                          | ?$filter=Microsoft.Dynamics.CRM.ThisFiscalPeriod(PropertyName=@p1)&@p1='name'                                                                  |
|            | ThisFiscalYear                   | Query function that evaluates whether the value is within the current fiscal year.                            | ?$filter=Microsoft.Dynamics.CRM.ThisFiscalYear(PropertyName=@p1)&@p1='name'                                                                    |
|            | ThisMonth                        | Query function that evaluates whether the value is within the current month.                                  | ?$filter=Microsoft.Dynamics.CRM.ThisMonth(PropertyName=@p1)&@p1='name'                                                                         |
|            | ThisWeek                         | Query function that evaluates whether the value is within the current week.                                   | ?$filter=Microsoft.Dynamics.CRM.ThisWeek(PropertyName=@p1)&@p1='name'                                                                          |
|            | ThisYear                         | Query function that evaluates whether the value is within the current year.                                   | ?$filter=Microsoft.Dynamics.CRM.ThisYear(PropertyName=@p1)&@p1='name'                                                                          |
|            | Today                            | Query function that evaluates whether the value equals today's date.                                          | ?$filter=Microsoft.Dynamics.CRM.Today(PropertyName=@p1)&@p1='name'                                                                             |
|            | Tomorrow                         | Query function that evaluates whether the value equals tomorrow's date.                                       | ?$filter=Microsoft.Dynamics.CRM.Tomorrow(PropertyName=@p1)&@p1='name'                                                                          |
|            | Yesterday                        | Query function that evaluates whether the value equals yesterday's date.                                      | ?$filter=Microsoft.Dynamics.CRM.Yesterday(PropertyName=@p1)&@p1='name'                                                                         |
| ID 値      | EqualBusinessId                  | Query function that evaluates whether the value is equal to the specified business ID.                        | ?$filter=Microsoft.Dynamics.CRM.EqualBusinessId(PropertyName=@p1)&@p1='name'                                                                   |
|            | EqualUserId                      | Query function that evaluates whether the value is equal to the ID of the user.                               | ?$filter=Microsoft.Dynamics.CRM.EqualUserId(PropertyName=@p1)&@p1='name'                                                                       |
|            | NotEqualBusinessId               | Query function that evaluate whether value is not equal to the specified business ID.                         | ?$filter=Microsoft.Dynamics.CRM.NotEqualBusinessId(PropertyName=@p1)&@p1='name'                                                                |
|            | NotEqualUserId                   | Query function that evaluate whether value is not equal to the specified user ID.                             | ?$filter=Microsoft.Dynamics.CRM.NotEqualUserId(PropertyName=@p1)&@p1='name'                                                                    |
| 階層       | Above                            | Query function that evaluates whether the entity is above the referenced entity in the hierarchy.             | ?$filter=Microsoft.Dynamics.CRM.Above(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2='value'                                               |
|            | AboveOrEqual                     | Query function that evaluates whether the entity is above or equal to the referenced entity in the hierarchy. | ?$filter=Microsoft.Dynamics.CRM.AboveOrEqual(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2='value'                                        |
|            | EqualUserOrUserHierarchy         | Query function that evaluates whether the entity equals current user or their reporting hierarchy.            | ?$filter=Microsoft.Dynamics.CRM.EqualUserOrUserHierarchy(PropertyName=@p1)&@p1='name'                                                          |
|            | EqualUserOrUserHierarchyAndTeams | Query function that evaluates whether the entity equals current user or their reporting hierarchy and teams.  | ?$filter=Microsoft.Dynamics.CRM.EqualUserOrUserHierarchyAndTeams(PropertyName=@p1)&@p1='name'                                                  |
|            | EqualUserOrUserTeams             | Query function that evaluates whether the entity equals current user or user teams.                           | ?$filter=Microsoft.Dynamics.CRM.EqualUserOrUserTeams(PropertyName=@p1)&@p1='name'                                                              |
|            | EqualUserTeams                   | Query function that evaluates whether the entity equals current user teams.                                   | ?$filter=Microsoft.Dynamics.CRM.EqualUserTeams(PropertyName=@p1)&@p1='name'                                                                    |
|            | NotUnder                         | Query function that evaluates whether the specified is not below the referenced record in the hierarchy.      | ?$filter=Microsoft.Dynamics.CRM.NotUnder(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2='value'                                            |
|            | Under                            | Query function that evaluates whether the entity is below the referenced record in the hierarchy.             | ?$filter=Microsoft.Dynamics.CRM.Under(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2='value'                                               |
|            | UnderOrEqual                     | Query function that evaluates whether the entity is under or equal to the referenced entity in the hierarchy. | ?$filter=Microsoft.Dynamics.CRM.UnderOrEqual(PropertyName=@p1,PropertyValue=@p2)&@p1='name'&@p2='value'                                        |
| 選択肢の列 | ContainValues                    | Query function that evaluates whether the choices column contains the values.                                 | ?$filter=Microsoft.Dynamics.CRM.ContainValues(PropertyName=@p1,PropertyValues=@p2)&@p1='name'&@p2=['value','value']                            |
|            | DoesNotContainValues             | Query function that evaluates whether the choices column does not contain the values.                         | ?$filter=Microsoft.Dynamics.CRM.DoesNotContainValues(PropertyName=@p1,PropertyValues=@p2)&@p1='name'&@p2=['value','value']                     |
| 次の範囲内 | Between                          | Query function to evaluate whether the value is between two values.                                           | ?$filter=Microsoft.Dynamics.CRM.Between(PropertyName=@p1,PropertyValues=@p2)&@p1='name'&@p2=['value','value']                                  |
|            | NotBetween                       | Query function to evaluate whether the value is not between two values.                                       | ?$filter=Microsoft.Dynamics.CRM.NotBetween(PropertyName=@p1,PropertyValues=@p2)&@p1='name'&@p2=['value','value']                               |
| 後         | In                               | Query function that evaluates whether the value exists in a list of values.                                   | ?$filter=Microsoft.Dynamics.CRM.In(PropertyName=@p1,PropertyValues=@p2)&@p1='name'&@p2=['value','value']                                       |
|            | NotIn                            | Query function to evaluate whether the value is not matched to a value in a subquery or a list.               | ?$filter=Microsoft.Dynamics.CRM.NotIn(PropertyName=@p1,PropertyValues=@p2)&@p1='name'&@p2=['value','value']                                    |
| 言語       | EqualUserLanguage                | Query function that evaluates whether the value is equal to the language for the user.                        | ?$filter=Microsoft.Dynamics.CRM.EqualUserLanguage(PropertyName=@p1)&@p1='name'                                                                 |

- [Dataverse クエリ関数](https://learn.microsoft.com/ja-jp/power-apps/developer/data-platform/webapi/query/filter-rows#dataverse-query-functions)
  - [完全なリスト](https://learn.microsoft.com/ja-jp/power-apps/developer/data-platform/webapi/reference/queryfunctions)

<br><br><br>

### 関連テーブルの値に基づくフィルター

<br><br>

#### ルックアッププロパティのフィルター

以下の2通りのフィルターは同等

```
systemuserid: 2a877c4f-2666-ef11-a670-002248f09e6b

https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/systemusers(2a877c4f-2666-ef11-a670-002248f09e6b)/user_accounts?$select=name
https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts?$filter=_owninguser_value eq 2a877c4f-2666-ef11-a670-002248f09e6b&$select=name
```

```json
{
    "@odata.context": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/$metadata#accounts(name)",
    "value": [
        {
            "@odata.etag": "W/\"3608658\"",
            "name": "フォース コーヒー (サンプル)",
            "accountid": "2c974e2f-fcaa-ef11-b8e8-002248f17214"
        },
        {
            "@odata.etag": "W/\"3608661\"",
            "name": "リビングウェア (サンプル)",
            "accountid": "2e974e2f-fcaa-ef11-b8e8-002248f17214"
        },
        {
            "@odata.etag": "W/\"3608625\"",
            "name": "アドベンチャー ワークス (サンプル)",
            "accountid": "30974e2f-fcaa-ef11-b8e8-002248f17214"
        },
        {
            "@odata.etag": "W/\"3608674\"",
            "name": "ファブリカム (サンプル)",
            "accountid": "32974e2f-fcaa-ef11-b8e8-002248f17214"
        },
        {
            "@odata.etag": "W/\"3608660\"",
            "name": "ブルー ヤンダー航空 (サンプル)",
            "accountid": "34974e2f-fcaa-ef11-b8e8-002248f17214"
        },
        {
            "@odata.etag": "W/\"3608667\"",
            "name": "シティ パワー アンド ライト (サンプル)",
            "accountid": "36974e2f-fcaa-ef11-b8e8-002248f17214"
        },
        {
            "@odata.etag": "W/\"3608672\"",
            "name": "コントソ製薬 (サンプル)",
            "accountid": "38974e2f-fcaa-ef11-b8e8-002248f17214"
        },
        {
            "@odata.etag": "W/\"3608651\"",
            "name": "アルパイン スキー ハウス (サンプル)",
            "accountid": "3a974e2f-fcaa-ef11-b8e8-002248f17214"
        },
        {
            "@odata.etag": "W/\"3608652\"",
            "name": "エー データム コーポレーション (サンプル)",
            "accountid": "3c974e2f-fcaa-ef11-b8e8-002248f17214"
        },
        {
            "@odata.etag": "W/\"3608649\"",
            "name": "コーホー ワイナリー (サンプル)",
            "accountid": "3e974e2f-fcaa-ef11-b8e8-002248f17214"
        }
    ]
}
```

<br><br>

#### ルックアップ列を表す単一値ナビゲーションプロパティの値に基づくフィルター

```
GET https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts?$filter=primarycontactid/fullname eq '早川 諭 (サンプル)'&$select=name,_primarycontactid_value
Accept: application/json
OData-MaxVersion: 4.0
OData-Version: 4.0
Prefer: odata.include-annotations="OData.Community.Display.V1.FormattedValue"
```

```json
{
    "@odata.context": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/$metadata#accounts(name,_primarycontactid_value)",
    "value": [
        {
            "@odata.etag": "W/\"3608658\"",
            "name": "フォース コーヒー (サンプル)",
            "_primarycontactid_value@OData.Community.Display.V1.FormattedValue": "早川 諭 (サンプル)",
            "_primarycontactid_value": "40974e2f-fcaa-ef11-b8e8-002248f17214",
            "accountid": "2c974e2f-fcaa-ef11-b8e8-002248f17214"
        }
    ]
}
```

<br>

##### 単一値ナビゲーションプロパティの階層のさらに上位にある値に基づくフィルター

```
https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts?$filter=primarycontactid/createdby/fullname eq 'Aw Admin'&$select=name,_primarycontactid_value&$expand=primarycontactid($select=fullname,_createdby_value;$expand=createdby($select=fullname))&$top=1
```

```json
{
    "@odata.context": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/$metadata#accounts(name,_primarycontactid_value,primarycontactid(fullname,_createdby_value,createdby(fullname)))",
    "value": [
        {
            "@odata.etag": "W/\"3608658\"",
            "name": "フォース コーヒー (サンプル)",
            "_primarycontactid_value": "40974e2f-fcaa-ef11-b8e8-002248f17214",
            "accountid": "2c974e2f-fcaa-ef11-b8e8-002248f17214",
            "primarycontactid": {
                "fullname": "早川 諭 (サンプル)",
                "_createdby_value": "2a877c4f-2666-ef11-a670-002248f09e6b",
                "contactid": "40974e2f-fcaa-ef11-b8e8-002248f17214",
                "createdby": {
                    "fullname": "Aw Admin",
                    "systemuserid": "2a877c4f-2666-ef11-a670-002248f09e6b",
                    "ownerid": "2a877c4f-2666-ef11-a670-002248f09e6b"
                }
            }
        }
    ]
}
```

<br>

##### ラムダ演算子

###### any

```
https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts?$select=name&$expand=contact_customer_accounts($select=fullname)&$filter=contact_customer_accounts/any(e:contains(e/fullname,%27%E6%97%A9%E5%B7%9D%27))
```

```json
{
    "@odata.context": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/$metadata#accounts(name,contact_customer_accounts(fullname))",
    "value": [
        {
            "@odata.etag": "W/\"3608658\"",
            "name": "フォース コーヒー (サンプル)",
            "accountid": "2c974e2f-fcaa-ef11-b8e8-002248f17214",
            "contact_customer_accounts": [
                {
                    "@odata.etag": "W/\"3608214\"",
                    "fullname": "早川 諭 (サンプル)",
                    "_parentcustomerid_value": "2c974e2f-fcaa-ef11-b8e8-002248f17214",
                    "contactid": "40974e2f-fcaa-ef11-b8e8-002248f17214"
                }
            ],
            "contact_customer_accounts@odata.nextLink": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts(2c974e2f-fcaa-ef11-b8e8-002248f17214)/contact_customer_accounts?$select=fullname"
        }
    ]
}
```

###### all

```
https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/accounts?$select=name&$filter=Account_Tasks/all(t:t/statecode eq 1)
```

```json
{
    "@odata.context": "https://orgfa5b0cd9.crm7.dynamics.com/api/data/v9.2/$metadata#accounts(name)",
    "value": [
        {
            "@odata.etag": "W/\"3608625\"",
            "name": "アドベンチャー ワークス (サンプル)",
            "accountid": "30974e2f-fcaa-ef11-b8e8-002248f17214"
        }
    ]
}
```

---

Copyright (c) 2024 YA-androidapp(https://github.com/yzkn) All rights reserved.
