--FORCE_MATCHING_SIGNATUREが同一でSQL_IDが異なるSQLをベースに確認する

SELECT      '"' || cp.PDB_NAME
       || '","' || vs.PARSING_SCHEMA_NAME
       || '","' || vs.SQL_ID
       || '","' || vs.CHILD_NUMBER
       || '","' || vs.EXECUTIONS
       || '","' || vs.FORCE_MATCHING_SIGNATURE
       || '","' ||vs.LAST_ACTIVE_TIM
--       || '","' || vs.SQL_TEXT
       || '"'
FROM V$SQL vs
   , CDB_PDBS cp
WHERE vs.CON_ID = cp.CON_ID
  AND cp.PDB_NAME='xxx'
  AND vs.PARSING_SCHEMA_NAME = 'xxx'
;