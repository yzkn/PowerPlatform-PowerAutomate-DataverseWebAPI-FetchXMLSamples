# PowerPlatform-PowerAutomate-DataverseWebAPI-FetchXMLSamples

Power Automate クラウドフローで FetchXML を使用して Dataverse テーブルのレコードを取得する

---

<br><br><br><br><br>

# 基本的なクエリ

<br><br><br><br>

## SELECT TOP 123 * FROM ya_member WHERE ya_column14 > 45 ORDER BY createdon DESC;

件数（行数）指定＋列（属性）指定＋列の別名（エイリアス）＋フィルタリング＋ソート

```xml
<fetch top="123">
  <entity name="ya_member">
    <all-attributes />
    <!--
        <attribute name="ya_column01" alias="FullName" />
        <attribute name="ya_column02" alias="Surname" />
        <attribute name="ya_column03" alias="GivenName" />
        <attribute name="ya_column14" alias="RandomNumber" />
        <attribute name="ya_e" alias="EmailAddress" />
    -->
    <filter>
      <condition attribute="ya_column14" operator="gt" value="45" />
    </filter>
    <order attribute="createdon" descending="true" />
  </entity>
</fetch>
```

<br><br><br><br>

## SELECT DISTINCT ya_column02 FROM ya_member ORDER BY ya_column02;

重複除外

```xml
<fetch distinct="true">
  <entity name="ya_member">
    <attribute name="ya_column02" />
    <order attribute="ya_column02" />
  </entity>
</fetch>
```

<br><br><br><br>

## 集計

```xml
<fetch aggregate="true">
  <entity name="ya_member">
    <!--
    <attribute name="ya_column01" alias="FullName" />
    <attribute name="ya_column14" alias="Rand" />
    -->
    <attribute name="ya_column14" alias="Average" aggregate="avg" />
    <attribute name="ya_column14" alias="Count" aggregate="count" />
    <attribute name="ya_column14" alias="ColumnCount" aggregate="countcolumn" />
    <attribute name="ya_column14" alias="Maximum" aggregate="max" />
    <attribute name="ya_column14" alias="Minimum" aggregate="min" />
    <attribute name="ya_column14" alias="Sum" aggregate="sum" />
    <filter type="and">
      <condition attribute="ya_column14" operator="not-null" />
      <condition attribute="ya_column14" operator="lt" value="10" />
    </filter>
  </entity>
</fetch>
```

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

```sql
-- https://orgfa5b0cd9.api.crm7.dynamics.com/api/data/v9.2/FetchXMLToSQL(FetchXml=@p1)?@p1='<fetch>FetchXML</fetch>'
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

<details>
  <summary>スコープ</summary>

```json
{
    "id": "793c6d53-0597-4f42-8184-e601f264fb7c",
    "brandColor": "#8C3900",
    "connectionReferences": {
        "shared_webcontentsv2": {
            "connection": {
                "id": "/providers/Microsoft.PowerApps/apis/shared_webcontentsv2/connections/shared-webcontentsv2-c528766f-fdd7-43a2-9443-9579f114a78a"
            }
        }
    },
    "connectorDisplayName": "制御",
    "icon": "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMzIiIGhlaWdodD0iMzIiIHZlcnNpb249IjEuMSIgdmlld0JveD0iMCAwIDMyIDMyIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPg0KIDxwYXRoIGQ9Im0wIDBoMzJ2MzJoLTMyeiIgZmlsbD0iIzhDMzkwMCIvPg0KIDxwYXRoIGQ9Im04IDEwaDE2djEyaC0xNnptMTUgMTF2LTEwaC0xNHYxMHptLTItOHY2aC0xMHYtNnptLTEgNXYtNGgtOHY0eiIgZmlsbD0iI2ZmZiIvPg0KPC9zdmc+DQo=",
    "isTrigger": false,
    "operationName": "Dataverseコネクタ／100k件超",
    "operationDefinition": {
        "type": "Scope",
        "actions": {
            "Do_until": {
                "type": "Until",
                "expression": "@equals(variables('MoreRecords'),false)",
                "limit": {
                    "count": 2000,
                    "timeout": "PT1H"
                },
                "actions": {
                    "MoreRecordsの設定": {
                        "type": "SetVariable",
                        "inputs": {
                            "name": "MoreRecords",
                            "value": "@if(empty(string(outputs('行を一覧にする')?['body']?['@Microsoft.Dynamics.CRM.morerecords'])), false, outputs('行を一覧にする')?['body']?['@Microsoft.Dynamics.CRM.morerecords'])"
                        },
                        "runAfter": {
                            "行を一覧にする": [
                                "Succeeded"
                            ]
                        },
                        "description": "if(empty(string(outputs('行を一覧にする')?['body']?['@Microsoft.Dynamics.CRM.morerecords'])), false, outputs('行を一覧にする')?['body']?['@Microsoft.Dynamics.CRM.morerecords'])",
                        "metadata": {
                            "operationMetadataId": "f8a9ad25-1bbb-428c-8e4d-cac836941b21"
                        }
                    },
                    "ページングCookieの設定": {
                        "type": "SetVariable",
                        "inputs": {
                            "name": "ページングCookie",
                            "value": "paging-cookie=\"@{if(\r\n  empty(\r\n    outputs('行を一覧にする')?['body']?['@Microsoft.Dynamics.CRM.fetchxmlpagingcookie']\r\n  ),\r\n  '',\r\n  replace(\r\n    replace(\r\n      replace(\r\n        decodeUriComponent(\r\n          decodeUriComponent(\r\n            first(\r\n              split(\r\n                last(\r\n                  split(\r\n                    outputs('行を一覧にする')?['body']?['@Microsoft.Dynamics.CRM.fetchxmlpagingcookie'],\r\n                    'pagingcookie=\"'\r\n                  )\r\n                ),\r\n                '\" '\r\n              )\r\n            )\r\n          )\r\n        ),\r\n        '<',\r\n        '&lt;'\r\n      ),\r\n      '>',\r\n      '&gt;'\r\n    ),\r\n    '\"',\r\n    '&quot;'\r\n  )\r\n)}\""
                        },
                        "runAfter": {
                            "MoreRecordsの設定": [
                                "Succeeded"
                            ]
                        },
                        "description": "paging-cookie=\"@{if(empty(outputs('行を一覧にする')?['body']?['@Microsoft.Dynamics.CRM.fetchxmlpagingcookie']),'',replace(replace(replace(decodeUriComponent(decodeUriComponent(first(split(last(split(outputs('行を一覧にする')?['body']?['@Microsoft.Dynamics.CRM.fetc",
                        "metadata": {
                            "operationMetadataId": "ae3b2f48-6628-4641-b70f-dc73f6b396b4"
                        }
                    },
                    "ページ番号の値を増やす": {
                        "type": "IncrementVariable",
                        "inputs": {
                            "name": "ページ番号",
                            "value": 1
                        },
                        "runAfter": {
                            "ページングCookieの設定": [
                                "Succeeded"
                            ]
                        },
                        "metadata": {
                            "operationMetadataId": "e9bd4ba5-2c3f-4e25-8fa2-dd9e9f2e5aa3"
                        }
                    },
                    "アイテム数の値を増やす": {
                        "type": "IncrementVariable",
                        "inputs": {
                            "name": "アイテム数",
                            "value": "@length(outputs('行を一覧にする')?['body/value'])"
                        },
                        "runAfter": {
                            "ページ番号の値を増やす": [
                                "Succeeded"
                            ]
                        },
                        "description": "length(outputs('行を一覧にする')?['body/value'])",
                        "metadata": {
                            "operationMetadataId": "9c5a0df7-05eb-48d1-8205-96cf537f14c9"
                        }
                    },
                    "行を一覧にする": {
                        "type": "OpenApiConnection",
                        "inputs": {
                            "host": {
                                "connectionName": "shared_webcontentsv2",
                                "operationId": "InvokeHttp",
                                "apiId": "/providers/Microsoft.PowerApps/apis/shared_webcontentsv2"
                            },
                            "parameters": {
                                "request/method": "GET",
                                "request/url": "@{outputs('OrganizationURI')}/api/data/v9.2/@{toLower(triggerBody()?['text'])}s?fetchXml=@{encodeUriComponent(outputs('FetchXML'))}",
                                "request/headers": {
                                    "Content-Type": "application/json; charset=utf-8",
                                    "OData-MaxVersion": "4.0",
                                    "OData-Version": "4.0",
                                    "Accept": "application/json",
                                    "Prefer": "@{outputs('Prefer')}"
                                }
                            },
                            "authentication": {
                                "type": "Raw",
                                "value": "@json(decodeBase64(triggerOutputs().headers['X-MS-APIM-Tokens']))['$ConnectionKey']"
                            }
                        },
                        "runAfter": {
                            "FetchXML": [
                                "Succeeded"
                            ]
                        },
                        "description": "@{outputs('OrganizationURI')}/api/data/v9.2/@{toLower(triggerBody()?['text'])}s?fetchXml=@{encodeUriComponent(outputs('FetchXML'))}",
                        "metadata": {
                            "operationMetadataId": "e210702e-ba60-44e1-b402-756714573c60"
                        }
                    },
                    "FetchXML": {
                        "type": "Compose",
                        "inputs": "<fetch page=\"@{variables('ページ番号')}\" @{variables('ページングCookie')}>\n <entity name='ya_member'>\n  <all-attributes/>\n </entity>\n</fetch>",
                        "runAfter": {},
                        "description": "<fetch page=\"@{variables('ページ番号')}\" @{variables('ページングCookie')}>\n <entity name='ya_member'>\n  <all-attributes/>\n </entity>\n</fetch>",
                        "metadata": {
                            "operationMetadataId": "8bda05b6-cbfb-4162-a869-831ce6d039fa"
                        }
                    }
                },
                "runAfter": {
                    "Prefer": [
                        "Succeeded"
                    ]
                },
                "metadata": {
                    "operationMetadataId": "66975f5b-4381-433f-ad1c-0ef8c56d3810"
                }
            },
            "件数": {
                "type": "Compose",
                "inputs": "@variables('アイテム数')",
                "runAfter": {
                    "Do_until": [
                        "Succeeded"
                    ]
                },
                "metadata": {
                    "operationMetadataId": "c013eeb2-4399-40ad-91b6-5875273ac037"
                }
            },
            "Prefer": {
                "type": "Compose",
                "inputs": "odata.include-annotations=\"Microsoft.Dynamics.CRM.fetchxmlpagingcookie,Microsoft.Dynamics.CRM.morerecords\"",
                "runAfter": {
                    "OrganizationURI": [
                        "Succeeded"
                    ]
                },
                "metadata": {
                    "operationMetadataId": "399c8bdb-fd5c-4f13-8e0f-215e41792701"
                }
            },
            "OrganizationURI": {
                "type": "Compose",
                "inputs": "https://org*****.crm7.dynamics.com",
                "runAfter": {},
                "metadata": {
                    "operationMetadataId": "e02ef609-935e-4c4c-9b5d-8c47184440c3"
                }
            }
        },
        "runAfter": {
            "ページ番号を1で初期化する": [
                "Succeeded"
            ]
        },
        "metadata": {
            "operationMetadataId": "2ceb52da-2e29-4f0b-afb6-86b49bee0243"
        }
    }
}
```

</details>

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
