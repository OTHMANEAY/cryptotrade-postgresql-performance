---1.1 TRIGGER d’audit--
SET search_path TO crypto;

CREATE OR REPLACE FUNCTION fn_audit_trail()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO crypto.audit_trail (
        table_cible,
        record_id,
        action,
        utilisateur_id,
        date_action,
        details
    )
    VALUES (
        TG_TABLE_NAME,
        NEW.id,
        TG_OP,
        NEW.utilisateur_id,
        CURRENT_DATE,
        'Action automatique enregistrée'
    );

    RETURN NEW;
END;
$$;

----1.2 Trigger sur la table ordres----
--- Résultat : Chaque modification d’un ordre est automatiquement journalisée.----


DROP TRIGGER IF EXISTS trg_audit_ordres ON crypto.ordres;

CREATE TRIGGER trg_audit_ordres
AFTER INSERT OR UPDATE OR DELETE
ON crypto.ordres
FOR EACH ROW
EXECUTE FUNCTION fn_audit_trail();

---2.1 Fonction de détection-----
CREATE OR REPLACE FUNCTION fn_detection_anomalie()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
BEGIN
    IF NEW.quantite <= 0 THEN
        INSERT INTO crypto.detection_anomalie (
            type,
            ordre_id,
            utilisateur_id,
            date_detection,
            commentaire
        )
        VALUES (
            'Quantité invalide',
            NEW.id,
            NEW.utilisateur_id,
            CURRENT_DATE,
            'Quantité inférieure ou égale à zéro'
        );
    END IF;

    RETURN NEW;
END;
$$;
--2.2 Trigger sur ordres---
DROP TRIGGER IF EXISTS trg_detection_anomalie ON crypto.ordres;

CREATE TRIGGER trg_detection_anomalie
AFTER INSERT OR UPDATE
ON crypto.ordres
FOR EACH ROW
EXECUTE FUNCTION fn_detection_anomalie();

