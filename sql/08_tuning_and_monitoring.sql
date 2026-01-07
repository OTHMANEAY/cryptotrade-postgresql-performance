-- ===============================
-- TUNING SANS EXTENSION SERVEUR
-- ===============================

SET work_mem = '64MB';
SHOW work_mem;

ALTER TABLE crypto.ordres SET (fillfactor = 70);
ALTER TABLE crypto.trades SET (fillfactor = 70);

ANALYZE crypto.ordres;
ANALYZE crypto.trades;

-- Temp files
SELECT
    datname,
    temp_files,
    temp_bytes / 1024 / 1024 AS temp_mb
FROM pg_stat_database
WHERE temp_files > 0;

-- Cache hit ratio
SELECT
    datname,
    round(
        blks_hit * 100.0 / NULLIF(blks_hit + blks_read, 0),
        2
    ) AS cache_hit_ratio
FROM pg_stat_database;

-- Locks
SELECT
    locktype,
    mode,
    COUNT(*)
FROM pg_locks
GROUP BY locktype, mode;
