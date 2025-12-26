CREATE TABLE ordres_parent (
    id BIGSERIAL,
    utilisateur_id INT,
    paire_id INT,
    type_ordre VARCHAR(10),
    mode VARCHAR(10),
    quantite NUMERIC(18,8),
    prix NUMERIC(18,8),
    statut VARCHAR(20),
    created_at TIMESTAMP NOT NULL,
    PRIMARY KEY (id, created_at)
)
PARTITION BY RANGE (created_at);
----Créer les partitions
CREATE TABLE ordres_2025_12
PARTITION OF ordres_parent
FOR VALUES FROM ('2025-12-01') TO ('2026-01-01');

CREATE TABLE ordres_2026_01
PARTITION OF ordres_parent
FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');

---- Creer les trades 
CREATE TABLE trades_parent (
    id BIGSERIAL,
    ordre_buy_id BIGINT,
    ordre_sell_id BIGINT,
    paire_id INT,
    prix NUMERIC(18,8),
    quantite NUMERIC(18,8),
    created_at TIMESTAMP NOT NULL,
    PRIMARY KEY (id, created_at)
)
PARTITION BY RANGE (created_at);
----creation des partition
CREATE TABLE trades_2025_12
PARTITION OF trades_parent
FOR VALUES FROM ('2025-12-01') TO ('2026-01-01');

CREATE TABLE trades_2026_01
PARTITION OF trades_parent
FOR VALUES FROM ('2026-01-01') TO ('2026-02-01');

------
---creation table audit----------
CREATE TABLE audit_trail_parent (
    id BIGSERIAL,
    table_cible TEXT,
    record_id BIGINT,
    action TEXT NOT NULL,
    utilisateur_id INT,
    details TEXT,
    created_at TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (id, action)
)
PARTITION BY LIST (action);
--- creation des partition
CREATE TABLE audit_trail_insert
PARTITION OF audit_trail_parent
FOR VALUES IN ('INSERT');

CREATE TABLE audit_trail_update
PARTITION OF audit_trail_parent
FOR VALUES IN ('UPDATE');

CREATE TABLE audit_trail_delete
PARTITION OF audit_trail_parent
FOR VALUES IN ('DELETE');
