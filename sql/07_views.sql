SET search_path TO public;

CREATE OR REPLACE VIEW vue_derniers_prix AS
SELECT DISTINCT ON (paire_id)
       paire_id,
       prix,
       volume,
       date_maj
FROM prix_marche
ORDER BY paire_id, date_maj DESC;


----Avec Agreation-----
CREATE OR REPLACE VIEW vue_volume_7j AS
SELECT paire_id,
       SUM(volume) AS volume_total
FROM prix_marche
WHERE date_maj >= CURRENT_DATE - INTERVAL '7 days'
GROUP BY paire_id;




---Vues pour indicateurs financiers-----
CREATE OR REPLACE VIEW vue_vwap AS
SELECT paire_id,
       SUM(prix * volume)/SUM(volume) AS vwap
FROM prix_marche
GROUP BY paire_id;

-----Matérialized views----
CREATE MATERIALIZED VIEW mat_vwap AS
SELECT paire_id,
       SUM(prix * volume)/SUM(volume) AS vwap
FROM prix_marche
GROUP BY paire_id;

-- Rafraîchir les données périodiquement
REFRESH MATERIALIZED VIEW mat_vwap;




