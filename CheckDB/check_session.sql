col username for a20
col name for a10
SELECT s.sid
     , s.serial#
     , s.module
     , s.username
     , s.con_id
     , p.name
FROM
    gv$session s, gv$pdbs p
WHERE s.username = 'xxx'
  AND s.con_id = p.con_id
ORDER BY
    s.con_id
;