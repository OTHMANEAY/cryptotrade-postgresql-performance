
-- STATISTIQUES & ANALYSES AVANCÉES
-- Tables : utilisateurs / ordres / trades
-- =====================================================


-- =====================================================
-- 1. LATERAL JOIN
-- Statistiques par utilisateur
-- =====================================================
SELECT
    u.id AS utilisateur_id,
    u.nom,
    u.statut,
    stats.nb_ordres,
    stats.volume_total
FROM utilisateurs u
CROSS JOIN LATERAL (
    SELECT
        COUNT(*) AS nb_ordres,
        COALESCE(SUM(o.quantite), 0) AS volume_total
    FROM ordres o
    WHERE o.utilisateur_id = u.id
) stats
ORDER BY u.id;


-- =====================================================
-- 2. LATERAL JOIN
-- Statistiques par paire (trades)
-- =====================================================
SELECT
    p.paire_id,
    stats.nb_trades,
    stats.volume_total
FROM (SELECT DISTINCT paire_id FROM trades) p
CROSS JOIN LATERAL (
    SELECT
        COUNT(*) AS nb_trades,
        COALESCE(SUM(t.quantite), 0) AS volume_total
    FROM trades t
    WHERE t.paire_id = p.paire_id
) stats
ORDER BY p.paire_id;


-- =====================================================
-- 3. DISTINCT ON
-- Dernier prix par paire
-- =====================================================
SELECT DISTINCT ON (paire_id)
    paire_id,
    prix,
    date_execution
FROM trades
ORDER BY paire_id, date_execution DESC;


-- =====================================================
-- 4. DISTINCT ON
-- Dernier statut de chaque ordre
-- =====================================================
SELECT DISTINCT ON (id)
    id AS ordre_id,
    utilisateur_id,
    statut,
    date_creation
FROM ordres
ORDER BY id, date_creation DESC;


-- =====================================================
-- 5. RECURSIVE CTE
-- Détection de comportements suspects
-- 5 ordres ou plus en moins de 10 secondes
-- =====================================================
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
    MAX(os.niveau) AS nombre_ordres_consecutifs
FROM ordre_sequence os
JOIN utilisateurs u ON u.id = os.utilisateur_id
GROUP BY os.utilisateur_id, u.nom
HAVING MAX(os.niveau) >= 5
ORDER BY nombre_ordres_consecutifs DESC;