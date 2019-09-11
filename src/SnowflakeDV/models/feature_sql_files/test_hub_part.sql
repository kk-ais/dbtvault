{{config(materialized='incremental', schema='test_vlt', enabled=true, tags='feature')}}

SELECT
                CAST(PART_PK AS BINARY(16)) AS PART_PK,
                CAST(PARTKEY AS NUMBER(38,0)) AS PARTKEY,
                CAST(LOADDATE AS DATE) AS LOADDATE,
                CAST(SOURCE AS VARCHAR(4)) AS SOURCE
 FROM (
    SELECT DISTINCT PART_PK, PARTKEY, LOADDATE, SOURCE,
           lag(SOURCE, 1)
           over(partition by PART_PK
           order by PART_PK) as FIRST_SOURCE
    FROM (
        SELECT DISTINCT a.PART_PK, a.PARTKEY, a.SOURCE, a.LOADDATE
        FROM DV_PROTOTYPE_DB.SRC_TEST_STG.STG_LINEITEM AS a
        LEFT JOIN {{ this }} AS c
        ON a.PART_PK = c.PART_PK
        AND c.PART_PK IS NULL
        UNION
        SELECT DISTINCT a.PART_PK, a.PARTKEY, a.SOURCE, a.LOADDATE
        FROM DV_PROTOTYPE_DB.SRC_TEST_STG.STG_PART AS a
        LEFT JOIN {{ this }} AS c
        ON a.PART_PK = c.PART_PK
        AND c.PART_PK IS NULL
        UNION
        SELECT DISTINCT a.PART_PK, a.PARTKEY, a.SOURCE, a.LOADDATE
        FROM DV_PROTOTYPE_DB.SRC_TEST_STG.STG_PARTSUPP AS a
        LEFT JOIN {{ this }} AS c
        ON a.PART_PK = c.PART_PK
        AND c.PART_PK IS NULL
        )
 AS b)
AS stg
WHERE FIRST_SOURCE IS NULL