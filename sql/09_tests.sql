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

----------les teste de partition
-----test de order-------
INSERT INTO ordres_parent
(utilisateur_id, paire_id, type_ordre, mode, quantite, prix, statut, created_at)
VALUES
(1, 1, 'buy', 'limit', 0.1, 42000, 'open', '2025-12-15');
---
SELECT * FROM ordres_2025_12;


---faire insertion (test de trades)
INSERT INTO trades_parent
(ordre_buy_id, ordre_sell_id, paire_id, prix, quantite, created_at)
VALUES
(1, 2, 1, 42000, 0.1, '2025-12-15');

SELECT * FROM trades_2025_12;

-------------teste de audit-----
--test-
INSERT INTO audit_trail_parent (table_cible, record_id, action, utilisateur_id, details)
VALUES 
('clients', 1, 'INSERT', 101, 'Nouvel enregistrement clients'),
('clients', 1, 'UPDATE', 101, 'Modification nom client'),
('clients', 1, 'DELETE', 101, 'Suppression du client');

SELECT * FROM audit_trail_insert;
SELECT * FROM audit_trail_update;
SELECT * FROM audit_trail_delete;

-----TEST Trrigers -----
INSERT INTO crypto.ordres (
    id, utilisateur_id, paire_id, type_ordre,
    mode, quantite, prix, statut, date_creation
)
VALUES (
    4, 1, 1, 1,
    'market', 5, 0,
    'EN_ATTENTE', CURRENT_DATE
);

--------Teste Trrigers--------
----Insertion Teste D'Erreur------
INSERT INTO crypto.utilisateurs (nom, email, statut) VALUES
('AYAOU OTHMANE', 'ayaou@crypto.com', 'actif');
SELECT * FROM crypto.audit_trail

----Teste With Ajout D'un utilusateur Apres l'exécution de Ordre-----
INSERT INTO crypto.ordres (utilisateur_id, paire_id, type_ordre, mode, quantite, prix, statut) VALUES
(6, 2, 'buy', 'limit', 0.10000000, 42000.00000000, 'open');
-----Test LATERAL JOIN – Statistiques par paire-----
SELECT
    p.paire_id,
    stats.nb_trades,
    stats.volume_total
FROM (
    SELECT DISTINCT paire_id
    FROM trades
) AS p
CROSS JOIN LATERAL (
    SELECT
        COUNT(*) AS nb_trades,
        COALESCE(SUM(t.quantite), 0) AS volume_total
    FROM trades t
    WHERE t.paire_id = p.paire_id
) AS stats
ORDER BY p.paire_id;

------Test DISTINCT ON – Dernier prix par paire
SELECT DISTINCT ON (paire_id)
    paire_id,
    prix,
    date_execution
FROM trades
ORDER BY paire_id, date_execution DESC;


------Test DISTINCT ON – Dernier statut par ordre
SELECT DISTINCT ON (id)
    id AS ordre_id,
    statut,
    date_creation
FROM ordres
ORDER BY id, date_creation DESC;

---Test RECURSIVE CTE – Détection d’anomalies---
WITH RECURSIVE ordre_sequence AS (
    SELECT
        id,
        utilisateur_id,
        date_creation,
        1 AS niveau
    FROM ordres

    UNION ALL

    SELECT
        o.id,
        o.utilisateur_id,
        o.date_creation,
        os.niveau + 1
    FROM ordres o
    JOIN ordre_sequence os
      ON o.utilisateur_id = os.utilisateur_id
     AND o.date_creation > os.date_creation
     AND o.date_creation <= os.date_creation + INTERVAL '10 seconds'
)
SELECT
    os.utilisateur_id,
    u.nom,
    MAX(os.niveau) AS nb_ordres_consecutifs
FROM ordre_sequence os
JOIN utilisateurs u ON u.id = os.utilisateur_id
GROUP BY os.utilisateur_id, u.nom
HAVING MAX(os.niveau) >= 5
ORDER BY nb_ordres_consecutifs DESC;


