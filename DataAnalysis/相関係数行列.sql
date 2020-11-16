-- iris_data

select * from iris_data;
--sepal_length,sepal_width,petal_length,petal_width,species
select corr(sepal_length,sepal_width) from iris_data;
select corr(*) from iris_data;



SELECT 
    t1.column_name column_name1,
    t2.column_name column_name2
FROM ALL_TAB_COLUMNS t1 INNER JOIN ALL_TAB_COLUMNS t2 ON t1.column_name < t2.column_name
WHERE 
    t1.table_name = 'IRIS_DATA'
AND t1.table_name = t2.table_name
order by
    t1.column_name,
    t2.column_name



-- 結果表がある場合削除
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE RESULT_CORR_IRIS';
EXCEPTION
    WHEN OTHERS THEN NULL;
END;
/

--insert into iris_data values (4.9,3.0,1.4,0.2,'setosa');
DECLARE
    --SQLを作成するカーソル定義
    CURSOR CUR_COMMAND_LIST IS
--        SELECT 'INSERT INTO RESULT_CORR_IRIS select  ''' || t1.column_name || ''', '''  || t2.column_name  || ''',CORR(' ||t1.column_name|| ','||t2.column_name||') from iris_data' as cmd
        SELECT 'select  ''' || t1.column_name || ''', '''  || t2.column_name  || ''',CORR(' ||t1.column_name|| ','||t2.column_name||') from iris_data' as cmd
        FROM ALL_TAB_COLUMNS t1 INNER JOIN ALL_TAB_COLUMNS t2 ON t1.column_name < t2.column_name
        WHERE 
            t1.table_name = 'IRIS_DATA'
        AND t1.table_name = t2.table_name
        order by
            t1.column_name,
            t2.column_name;

    --レコード変数を定義
    REC_COMMAND_LIST CUR_COMMAND_LIST%ROWTYPE;

BEGIN
    -- 結果表の作成
    EXECUTE IMMEDIATE 'CREATE TABLE RESULT_CORR_IRIS (column_name1 VARCHAR2(30),column_name2 VARCHAR2(30),correlation number)';

    --カーソルオープン
    OPEN CUR_COMMAND_LIST;
    LOOP
	    --1行フェッチする。
        FETCH CUR_COMMAND_LIST INTO REC_COMMAND_LIST;
	    --データが存在しない場合は終了
        EXIT WHEN CUR_COMMAND_LIST%NOTFOUND;
	    --SQLを実行
        EXECUTE IMMEDIATE REC_COMMAND_LIST.cmd;
    END LOOP;
    --カーソルを閉じる
    CLOSE CUR_COMMAND_LIST;
END;
/