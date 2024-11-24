# PowerPlatform-PowerAutomate-DataverseWebAPI-FetchXMLSamples

Power Automate クラウドフローで FetchXML を使用して Dataverse テーブルのレコードを取得する

---

# 基本的なクエリ

## SELECT TOP 123 * FROM ya_member WHERE ya_column14 > 45 ORDER BY createdon DESC;

```xml
<fetch top="123">
  <entity name="ya_member">
    <all-attributes />
    <!--
        <attribute name="ya_column01" />
        <attribute name="ya_column02" />
        <attribute name="ya_column03" />
        <attribute name="ya_column14" />
        <attribute name="ya_e" />
    -->
    <filter>
      <condition attribute="ya_column14" operator="gt" value="45" />
    </filter>
    <order attribute="createdon" descending="true" />
  </entity>
</fetch>
```

## SELECT DISTINCT ya_column02 FROM ya_member ORDER BY ya_column02;

```xml
<fetch distinct="true">
  <entity name="ya_member">
    <attribute name="ya_column02" />
    <order attribute="ya_column02" />
  </entity>
</fetch>
```

---

Copyright (c) 2024 YA-androidapp(https://github.com/yzkn) All rights reserved.
