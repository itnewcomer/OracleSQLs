set linesize 200
set pages 2000
alter session set nls_date_format = 'yyyy/mm/dd hh24:mi:ss';
col TABLE_NAME for a40

SELECT at.TABLE_NAME    --テーブル名
     , at.NUM_ROWS      --件数
     , at.LAST_ANALYZED --統計情報を取得した日付
  FROM all_tables at
 WHERE at.OWNER = 'xxx' --オーナー名
;