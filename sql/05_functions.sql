-- fonction VWAP
CREATE OR REPLACE FUNCTION crypto.fn_vwap(p_paire_id INT, p_date DATE)
RETURNS NUMERIC AS $$
DECLARE
    v_vwap NUMERIC;
BEGIN
    SELECT SUM(prix * quantite) / SUM(quantite)
    INTO v_vwap
    FROM crypto.trades
    WHERE paire_id = p_paire_id
      AND date_execution::DATE = p_date;

    RETURN v_vwap;
END;
$$ LANGUAGE plpgsql;

-- Fonction RSI

DROP FUNCTION IF EXISTS crypto.fn_rsi(integer, integer);

CREATE FUNCTION crypto.fn_rsi(p_paire_id INT, p_period INT)
RETURNS TABLE(trade_date DATE, rsi NUMERIC)
LANGUAGE SQL
AS $$
WITH ordered AS (
    SELECT
        date_execution::DATE AS trade_date,
        prix,
        prix - LAG(prix) OVER (ORDER BY date_execution) AS change
    FROM crypto.trades
    WHERE paire_id = p_paire_id
),
gains_losses AS (
    SELECT
        trade_date,
        GREATEST(change, 0) AS gain,
        GREATEST(-change, 0) AS loss
    FROM ordered
    WHERE change IS NOT NULL
),
avg_calc AS (
    SELECT
        trade_date,
        AVG(gain) OVER (
            ORDER BY trade_date
            ROWS BETWEEN p_period-1 PRECEDING AND CURRENT ROW
        ) AS avg_gain,
        AVG(loss) OVER (
            ORDER BY trade_date
            ROWS BETWEEN p_period-1 PRECEDING AND CURRENT ROW
        ) AS avg_loss
    FROM gains_losses
)
SELECT
    trade_date,
    CASE
        WHEN avg_loss = 0 AND avg_gain > 0 THEN 100
        WHEN avg_gain = 0 AND avg_loss > 0 THEN 0
        WHEN avg_loss = 0 THEN NULL
        ELSE 100 - (100 / (1 + avg_gain / avg_loss))
    END AS rsi
FROM avg_calc
WHERE avg_gain IS NOT NULL AND avg_loss IS NOT NULL;
$$;