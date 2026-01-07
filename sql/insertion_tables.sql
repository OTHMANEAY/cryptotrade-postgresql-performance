SET search_path TO crypto;

-- =====================================================
-- 1. UTILISATEURS
-- =====================================================
INSERT INTO utilisateurs (nom, email, statut) VALUES
('Alice Martin', 'alice@crypto.com', 'actif'),
('Bob Dupont', 'bob@crypto.com', 'actif'),
('Charlie Ben', 'charlie@crypto.com', 'actif'),
('Dina Elami', 'dina@crypto.com', 'suspendu'),
('Youssef Amine', 'youssef@crypto.com', 'actif');

-- =====================================================
-- 2. CRYPTOMONNAIES
-- =====================================================
INSERT INTO cryptomonnaies (nom, symbole, date_creation, statut) VALUES
('Bitcoin', 'BTC', '2009-01-03', 'actif'),
('Ethereum', 'ETH', '2015-07-30', 'actif'),
('Tether', 'USDT', '2014-10-06', 'actif'),
('Binance Coin', 'BNB', '2017-07-08', 'actif'),
('Cardano', 'ADA', '2017-09-29', 'actif');

-- =====================================================
-- 3. PAIRE_TRADING
-- =====================================================
INSERT INTO paire_trading (crypto_base_id, crypto_contre_id, statut, date_ouverture) VALUES
(1, 3, 'actif', '2023-01-01'), -- BTC/USDT
(2, 3, 'actif', '2023-01-01'), -- ETH/USDT
(4, 3, 'actif', '2023-01-01'), -- BNB/USDT
(5, 3, 'actif', '2023-01-01'), -- ADA/USDT
(2, 1, 'actif', '2023-01-01'); -- ETH/BTC

-- =====================================================
-- 4. PORTEFEUILLE
-- =====================================================
INSERT INTO portefeuille (utilisateur_id, crypto_id, solde_total, solde_bloque) VALUES
(1, 1, 0.50000000, 0),
(1, 3, 10000.00000000, 0),
(2, 2, 10.00000000, 1.50000000),
(3, 4, 25.00000000, 0),
(5, 5, 5000.00000000, 0);

-- =====================================================
-- 5. ORDRES
-- =====================================================
INSERT INTO ordres (utilisateur_id, paire_id, type_ordre, mode, quantite, prix, statut) VALUES
(1, 1, 'buy', 'limit', 0.10000000, 42000.00000000, 'open'),
(2, 2, 'sell', 'market', 1.50000000, NULL, 'executed'),
(3, 3, 'buy', 'limit', 5.00000000, 300.00000000, 'open'),
(5, 4, 'sell', 'limit', 1000.00000000, 0.45000000, 'open'),
(1, 5, 'buy', 'market', 0.20000000, NULL, 'executed');

-- =====================================================
-- 6. TRADES
-- =====================================================
INSERT INTO trades (ordre_buy_id, ordre_sell_id, paire_id, prix, quantite) VALUES
(1, 2, 1, 41950.00000000, 0.10000000),
(3, 4, 3, 305.00000000, 5.00000000),
(5, 2, 5, 0.07000000, 0.20000000),
(1, 4, 1, 42000.00000000, 0.05000000),
(3, 2, 2, 1600.00000000, 1.00000000);

-- =====================================================
-- 7. PRIX_MARCHE
-- =====================================================
INSERT INTO prix_marche (paire_id, prix, volume) VALUES
(1, 42050.00000000, 120.50000000),
(2, 1620.00000000, 350.00000000),
(3, 305.00000000, 500.00000000),
(4, 0.46000000, 800000.00000000),
(5, 0.07200000, 95.00000000);

-- =====================================================
-- 8. STATISTIQUE_MARCHE
-- =====================================================
INSERT INTO statistique_marche (paire_id, indicateur, valeur, periode) VALUES
(1, 'RSI', 55.30000000, '1h'),
(2, 'VWAP', 1580.00000000, '1d'),
(3, 'VOLATILITE', 2.50000000, '24h'),
(4, 'RSI', 62.00000000, '4h'),
(5, 'VWAP', 0.07100000, '1d');

-- =====================================================
-- 9. DETECTION_ANOMALIE
-- =====================================================
INSERT INTO detection_anomalie (type_anomalie, ordre_id, utilisateur_id, commentaire) VALUES
('volume_suspect', 1, 1, 'Volume élevé inhabituel'),
('prix_anormal', 3, 3, 'Écart de prix important'),
('ordre_rapide', 2, 2, 'Ordres multiples en peu de temps'),
('bot_detecte', 4, 5, 'Comportement automatisé'),
('risque_fraude', 5, 1, 'Risque élevé détecté');

-- =====================================================
-- 10. AUDIT_TRAIL
-- =====================================================
INSERT INTO audit_trail (table_cible, record_id, action, utilisateur_id, details) VALUES
('utilisateurs', 1, 'INSERT', 1, 'Création du compte'),
('ordres', 1, 'INSERT', 1, 'Création ordre BUY'),
('trades', 1, 'EXECUTE', 2, 'Trade exécuté'),
('portefeuille', 3, 'UPDATE', 3, 'Mise à jour du solde'),
('ordres', 4, 'CANCEL', 5, 'Annulation ordre');
