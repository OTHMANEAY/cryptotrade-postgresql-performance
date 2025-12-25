----Vérifier les index créés-----
SELECT indexname, tablename
FROM pg_indexes
WHERE tablename IN ('ordres', 'trades', 'audit_trail')
ORDER BY tablename;



-----Vérifier le fillfactor----
SELECT relname, reloptions
FROM pg_class
WHERE relname = 'ordres';



-----Vérifier les extended statistics----
SELECT stxname
FROM pg_statistic_ext
WHERE stxname = 'stat_ordres_paire_date';


------Vérifier les index pour toutes les tables----
-- Tous les index
SELECT indexname, indexdef
FROM pg_indexes
WHERE schemaname = 'public';


------Vérifier la taille des index----
SELECT
    c.relname AS table_name,
    pg_size_pretty(pg_relation_size(c.oid)) AS table_size,
    pg_size_pretty(pg_indexes_size(c.oid)) AS indexes_size,
    CASE 
        WHEN pg_relation_size(c.oid) = 0 THEN NULL
        ELSE round(pg_indexes_size(c.oid)::numeric / pg_relation_size(c.oid), 2)
    END AS ratio_index_table
FROM pg_class c
WHERE c.relkind = 'r'  -- tables seulement
  AND c.relname IN (
      'ordres', 'trades', 'audit_trail',
      'utilisateurs', 'portefeuille',
      'cryptomonnaies', 'paire_trading',
      'prix_marche', 'statistique_marche',
      'detection_anomalie'
  );



  ------Vérifier l’usage des index (EXPLAIN / EXPLAIN ANALYZE)----
  EXPLAIN ANALYZE
SELECT *
FROM ordres
WHERE statut = 'EN_ATTENTE'
AND paire_id = 1
ORDER BY prix;

EXPLAIN ANALYZE
SELECT prix, quantite
FROM trades
WHERE paire_id = 2
ORDER BY date_execution DESC;



-------Vérifier les index partiels----
SELECT *
FROM pg_indexes
WHERE indexname = 'idx_ordres_paire_statut_prix';

EXPLAIN ANALYZE
SELECT *
FROM ordres
WHERE statut = 'EN_ATTENTE';


------Vérifier l’utilisation de INCLUDE sur trades----
EXPLAIN ANALYZE
SELECT prix, quantite
FROM trades
WHERE paire_id = 2
ORDER BY date_execution DESC;


-----Vérifier les index uniques ou redondants----
SELECT relname, indisunique, indisprimary
FROM pg_index i
JOIN pg_class c ON c.oid = i.indrelid
WHERE relname IN ('ordres', 'trades', 'audit_trail');









