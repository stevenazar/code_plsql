/*

Développement d'une procédure d'envoie des notifications via PLSQL:  
Une procédure PL/SQL qui envoie des notifications par email aux responsables dès qu'un événement de type "retard" 
ou "problème" est détecté pour une expédition.

*/

-- Exemple de procédure mais non exhaustive d'envoie de notification :

CREATE OR REPLACE PROCEDURE notify_event (
    p_expedition_id IN NUMBER,
    p_event_type IN VARCHAR2
) IS
    v_email VARCHAR2(100);
    v_message VARCHAR2(500);
BEGIN
    -- Sélectionner l'email du responsable associé à l’expédition
    SELECT e.responsible_email
    INTO v_email
    FROM expeditions e
    WHERE e.expedition_id = p_expedition_id;
    
    -- Construire le message de notification
    IF p_event_type = 'retard' THEN
        v_message := 'Alerte: L\'expédition ' || p_expedition_id || ' est en retard.';
    ELSE
        v_message := 'Alerte: Un problème a été détecté dans l\'expédition ' || p_expedition_id;
    END IF;
   
    COMMIT;
END;