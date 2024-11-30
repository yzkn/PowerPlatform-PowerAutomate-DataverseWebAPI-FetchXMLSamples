SELECT fullname, account.name
FROM contact
JOIN account account ON account.primarycontactid = contact.contactid
