# ***CS-4750 Quiz 3 Study Guide***


## **Routines**
- programs that execute on demand

### **Functions**

- type of subprogram that performs calculations and returns a single value
- used for computed results or need reusable logic for mathematical operations, string manipulation, or data processing
- cannot update data
- can return table value output and single value outputs
- needs to be called with the `SELECT` function

Create a function
```sql
CREATE FUNCTION <functionName> (
    @<parameter1Name> <data type>,
    @<parameter2Name> <data type>,
    ...
)
RETURNS <query or data type>
AS
BEGIN

    /* write function here */

END
```

### **Procedures**
- set of operations that does not return a value
- input and output parameters
- modify data, tasks such as logging operations or managing workflows
- results in single value or multiple rows

Example to create a procedure
```sql
CREATE PROCEDURE <procedureName>
    @<ParameterName1> <data type>,
    @<ParameterName2> <data type>,
    ...
    @<outputParameterName> <data type> OUTPUT

AS
    SET NOCOUNT ON;

    /* write procedure code */

    GO
```

Example to alter a procedure
```sql
ALTER PROCEDURE <procedureName>
    @<ParameterName1> <data type>,
    @<ParameterName2> <data type>
    ...
AS
BEGIN
    SET NOCOUNT ON;

    /*modified procedure code*/
END
GO
```

Drop a procedure
```sql
DROP PROCEDURE <stored procedure name>;
GO
```

Reaons for modification:
1. add/remove parameter
2. changing parameter data type
3. change intput to output
4. add default values

## **Triggers**

- special kind of stored procedure that automatically executes when specified occurs in database table or view
- Types
  - DDL - fires with DDL statements such as `CREATE`, `ALTER`, `DROP`, and `TRUNCATE`
  - Database Event Triggers - fires from statements such as `LOGON`, `LOGOFF`, `SHUTDOWN`, `SERVERERROR`, etc
  - DML - fires from executions of statements such as `INSERT`, `UPDATE`, and `DELETE`
- Benefits
  - data integrity check
  - auditing and logging
  - derived column generation
- Types of DML Triggers
  - `AFTER`: executes after triggering operation completes successfully
  - `INSTEAD OF`: replaces standard action with custom logic

Trigger Example
```sql
CREATE TRIGGER <triggerName>
ON <table_name>
AFTER | INSTEAD OF INSERT, UPDATE, DELETE
AS
BEGIN
    -- trigger logic
END
```



## **Security**

- confidentiality
- integrity
- availability

Six levels of impact
- database level
- application level => encrypt whenever possible
- operating system level => firewalls, virus protections, close malicious ports
- network level => another server for authentication, separate db and web server, limit connections to db from trusted sources, do not use default port
- physical level => lock and key; bakcups
- human level => give permissions to right users; do not share passwords

Can create roles that grant or revoke specific tasks

Setup triggers 

Encryption

### **Views**: relation defined by a query
- operates at database level
  
- increase security
- increase logical data independence
- increase physical data independence

Example

Based on `WHERE` clause
```sql
CREATE VIEW <viewName> AS

    (SELECT <attributes> 
    FROM <tableName> 
    WHERE <condition>)
```

Based on columns
```sql
CREATE VIEW <viewName> AS

(SELECT <attributes>
FROM <tableName>)
```

### **Encryption**
 - operates at storage level, specifically at database level

- Levels of Encryption
  - application-level
  - database-level (TDE)
    - uses AES and 3DES encryption algorithms
    - Steps
        1. create a master key
        2. create/obtain certificate protected by master key
        3. create database encryption key and protect it using the certificate
        4. set database to use encryption
  - storage-level
  - network-level

Column Encryption Example
```sql
-- Step 1: Create database master key
CREATE MASTER KEY ENCRYPTION BY PASSWORD = "<strong password>";

-- Step 2: Create certificate for encrypting the symmetric key
CREATE CERTIFICATE <CertificateName>
WITH SUBJECT = '<description of certificate>'

-- Step 3: Create symmetric key with AES_256 encryption, protected by certificate
CREATE SYMMETRIC KEY <KeyName>
WITH ALGORITHM = AES_256
ENCRYPTION BY CERTIFICATE <CertificateNameFromStep2>

-- Step 4: Add new column for storing encrypted postal codes
ALTER TABLE <TableName>
ADD <EncryptionName> VARBINARY(128); -- adjust size as needed

-- Step 5: Inserting data with encryption
-- Open the symmetric key to encrypt data
OPEN SYMMETRIC KEY <SymmetricKeyNameFromStep3>
DECRYPTION BY CERTIFICATE <CertificateNameFromStep3>;

SELECT name FROM sys.symmetric_keys

-- Insert customer data with encrypted postal code
INSERT INTO <TableName> (TableParameters)
VALUES
(InsertValues)

-- Close Symmetric Key
CLOSE SYMMETRIC KEY <SymmetricKeyFromStep3>;

-- Step 6: Query and decrypt the data
-- open symmetric key to derypt data
OPEN SYMMETRIC KEY <SymmetricKeyName>
DECRYPTION BY CERTIFICATE <CertificateName>;

SELECT 
    DataName,
    CONVERT(VARCHAR(10), DecryptByKey(<EncryptionNameFromStep4>)) AS <VariableName>
FROM <TableName>;

-- Close the symmetric key
CLOSE SYMMETRIC KEY <KeyName>;


-- Step 7: verify encrypted data in the table
SELECT 
    <attributeName>,
    <EncryptionScheme>
FROM <TableName>

-- how to handle updates

-- open symmetric key for encryption
OPEN SYMMETRIC KEY <KeyName>
DECRYPTION BY CERTIFICATE <CertificateName>;

-- update encrypted postal code
UPDATE <TableName>
SET <CertificateNameFromStep4> = EncryptByKey(Key_GUID('<KeyName>'), '20002')
WHERE <attributeName> = <value>;

-- close the symmetric key 
CLOSE SYMMETRIC KEY <KeyName>;

```


## **Indexing**: process of creating data structures to make data retrieval efficient

Benefits
- speeds up searches, joins, and filtering operations

Key can be any attribute

*Rule of Thumb: create index on attribute that is used frequently in search*

Indexing system has the search key and the address of the disk block where key value can be found

Index can speed up execution but makes insertions, deletions, and updates to the relation more complex and time-consuming

How to determine technique
    - access types
      - specified attribute value
      - or attribute based on range
    - access time
    - insertion time
    - deletion time
    - space overhead

Types of File Organization Mechanism
- sequential or ordered index
- hash file organization or hash index

Types
- primary index: based on primary key
- seconday index: created on non-key attributes
- clustered index: stores data rows in sorted order
- non-clustered index: separate from the data, points to rows
- unique index: ensures all indexed values are distinct
- dense index: recordis created for every search key value
- sparse index: one key-pointer pair per data block

Ordered Index Structures
- file may have several indices on different keys
- primary index or clusterd index
- secondary index or nonclustered index

Clustered Index syntax
```sql
CREATE CLUSTERED INDEX <IX_tablename_colname> ON <schema.tablename(colname)>
```

Unclustered Index syntax
```sql
CREATE NONCLUSTERED INDEX <IX_tablename_colname> ON <schema.tablename(colname)>
```

Dense Index (type of ordered index)
- record created for every search key value
- need more space
- support range queries

Sparse Index (type or ordered index)
- when dense indices are too large
- one key-pointer pair per data block
- space efficient but rquires more computation

Dense vs Sparse
- dense is redundant but are generally faster
- sparse require less space and less maintenance for insertion and deletion

For multi-level: use sparse index for index
- two-level sparse index
  - binary search on outer index
  - use linear search for inner index

B+ Tree
- tree-like file structure
  - links nodes with pointers
  - one root
  - each leaf as unique path; all are equal length
  - store keys only at leaves
  - guides key search via reference values from root to leaves
  - balance
  - n points and (n-1) key values
  - leaf nodes hold $ceil(\frac{n-1}{2}) <= \text{key values} <= n-1$
  - internal nodes hold $ceil(\frac{n}{2}) <= \text{pointers} <= n$
  - root nodes holds $1 <= \text{key values} <= (n-1)$
  - low n => tall thin B+ trees
    - consistent performance + constant lookup time
    - high overhead for insert/delete + need to reorganize
    - read heavy
  - high n => short and wide B+ trees
    - low overhead
    - varying performance
    - read/write mix
- Advantages and Disadvantages
  - index-sequential
    - disadvantages
      - performance degrades as sequential file grows because many overlow blocks are created
      - periodic reorganization of entire file is required
    - B+ tree
      - advantage
        - automatically reorganize itself with small, local changes (when insert or delete data)
        - range queries on index attributes are fast
      - disadvantages
        - extra insertion/deletion overhead, space overhead
- I/O cost: $$estimated cost = selectivity estimate x # tuples/blocks$$
- sequential scan is better when => selectivity is high and ratio between #tuples:#blocks is high

B Tree
- tree-like file structure
- each node points to data record

## **Query Optimization**

- Execution process
  - parsing: ensure query is valid
  - compilation: generates execution plan
  - execution: query is executed and results are returned
- Common Performance Issues
  - slower query response
  - locking and blocking
  - high CPU and memory usage
  - excessive I/O

- Tips
  - select only necessary columns
  - use indexes wisely
  - avoid unnecessary calculations in queries
  - use joins efficiently
  - optimize `where` clause
    - use as early as possible
    - avoid using `NOT IN`; prefer `NOT EXISTS` or `LEF JOIN`...`IS NULL`
  - use proper datatypes
  - tools such as SSMS Execution Plan Viewer and dynamic Management Views (DMVs)
    - find bottlenecks
  - batch queries where possible
  - avoid nested subqueries
  - use table variables carefully
    - use for breaking down complex databases
  - manage transactions properly
    - as short as possible
  - optimize `ORDER BY` clauses
- Index Maintenance
  - rebuild: fragmentation > 30%
  - reorganize: fragmentation is between 5-30%
  - automating index maintenance
- Design consideration
  - normalization vs denormalization
    - normalization: reduce redundancy but can slow down read operations
    - denormalization: optimized for read-heavy workloads at cost of data redundancy


## **Transactions**: group of operations or sequence of operation sthat need to be performed together

- Problems
  - write-write conflict
  - non-atomic operation
  - write-read conflict
  - read-write conflict

Transaction syntax
```sql
BEGIN TRANSACTION
    /* sql statements */
COMMIT --finialize

ROLLBACK -- undo everything
```

ACID Properties
- atomicity
  - log recorded are written
- consistency
- isolation
- durability
  - changed written in stable storage

## **Concurrency**

Non pre-emptive
- First come first serve
- shorted job first

Pre-emptive
- shortest remaining time first

## **Systems Design**

