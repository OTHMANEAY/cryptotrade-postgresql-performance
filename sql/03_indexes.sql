



/* =========================================================
   CRYPTOTRADE – INDEXATION & OPTIMISATION PERFORMANCE
   Script idempotent – peut être relancé sans erreur
   ========================================================= */

BEGIN;

/* =======================
    INDEX  ORDRES
   ======================= */

DROP INDEX IF EXISTS idx_ordres_paire_statut_prix;
CREATE INDEX idx_ordres_paire_statut_prix
ON ordres (paire_id, type_ordre, prix)
WHERE statut = 'EN_ATTENTE';

DROP INDEX IF EXISTS idx_ordres_utilisateur_date;
CREATE INDEX idx_ordres_utilisateur_date
ON ordres (utilisateur_id, date_creation DESC);

/* HOT updates */
ALTER TABLE ordres SET (fillfactor = 70);


------UTILISATEURS-----
CREATE INDEX IF NOT EXISTS idx_utilisateurs_email
ON utilisateurs (email);

CREATE INDEX IF NOT EXISTS idx_utilisateurs_statut
ON utilisateurs (statut);

-------PORTEFEUILLE------
CREATE INDEX IF NOT EXISTS idx_portefeuille_utilisateur
ON portefeuille (utulisateur_id);

CREATE INDEX IF NOT EXISTS idx_portefeuille_crypto
ON portefeuille (crypto_id);


-----CRYPTOMONNAIES----
CREATE INDEX IF NOT EXISTS idx_cryptomonnaies_symbole
ON cryptomonnaies (symbole);

CREATE INDEX IF NOT EXISTS idx_cryptomonnaies_statut
ON cryptomonnaies (statut);


------PAIRE_TRADING-----
CREATE INDEX IF NOT EXISTS idx_paire_trading_crypto_base
ON paire_trading (crypto_base_id);

CREATE INDEX IF NOT EXISTS idx_paire_trading_crypto_contre
ON paire_trading (crypto_contre_id);

CREATE INDEX IF NOT EXISTS idx_paire_trading_statut
ON paire_trading (statut);



------PRIX_MARCHE-----
CREATE INDEX IF NOT EXISTS idx_prix_marche_paire_date
ON prix_marche (paire_id, date_maj DESC);



------STATISTIQUE_MARCHE---
CREATE INDEX IF NOT EXISTS idx_statistique_marche_paire
ON statistique_marche (paire_id);

CREATE INDEX IF NOT EXISTS idx_statistique_marche_indicateur
ON statistique_marche (indicateur, periode);


-----DETECTION_ANOMALIE--- 
CREATE INDEX IF NOT EXISTS idx_detection_anomalie_date
ON detection_anomalie (date_detection DESC);

CREATE INDEX IF NOT EXISTS idx_detection_anomalie_utilisateur
ON detection_anomalie (utilisateur_id);









/* =======================
   INDEX  TRADES
   ======================= */

DROP INDEX IF EXISTS idx_trades_paire_date;
CREATE INDEX idx_trades_paire_date
ON trades (paire_id, date_execution DESC)
INCLUDE (prix, quantite);


/* =======================
   INDEX  AUDIT_TRAIL
   ======================= */

DROP INDEX IF EXISTS idx_audit_table_date;
CREATE INDEX idx_audit_table_date
ON audit_trail (table_cible, date_action DESC);


/* =======================
   EXTENDED STATISTICS
   ======================= */

DROP STATISTICS IF EXISTS stat_ordres_paire_date;
CREATE STATISTICS stat_ordres_paire_date
ON paire_id, date_creation
FROM ordres;

ANALYZE ordres;

COMMIT;
