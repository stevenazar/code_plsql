/*
Exemple de tables métiers
users : Contient les informations des 
utilisateurs (ID utilisateur, nom, type de compte, etc.).
debates : Détails sur les débats sportifs 
(ID débat, nom du débat, sport, date, participants, etc.).
comments : Contient les commentaires des utilisateurs pendant un débat 
(ID commentaire, ID utilisateur, ID débat, commentaire, date, likes).
scores : Informations en temps réel sur les scores des matchs 
(ID score, ID débat, score équipe 1, score équipe 2, minute du match, date).
user_interactions : Enregistre les interactions des utilisateurs avec les débats 
(ID interaction, ID utilisateur, ID débat, type interaction, date).

*/

-- Voici une procédure PL/SQL permettant 
-- à un utilisateur d'ajouter un commentaire pendant un débat : 

CREATE OR REPLACE PROCEDURE add_comment (
    p_user_id IN NUMBER,
    p_debate_id IN NUMBER,
    p_comment_text IN VARCHAR2
) IS
BEGIN
    INSERT INTO comments (user_id, debate_id, comment_text, timestamp)
    VALUES (p_user_id, p_debate_id, p_comment_text, SYSDATE);
    COMMIT;
END;

-- Une fonction PL/SQL pour obtenir le score 
-- en temps réel d'un débat spécifique : 

CREATE OR REPLACE FUNCTION get_current_score (
    p_debate_id IN NUMBER
) RETURN VARCHAR2 IS
    v_score VARCHAR2(50);
BEGIN
    SELECT 'Team 1: ' || team1_score || ' - Team 2: ' || team2_score
    INTO v_score
    FROM scores
    WHERE debate_id = p_debate_id
    ORDER BY timestamp DESC
    FETCH FIRST 1 ROWS ONLY;
    
    RETURN v_score;
END;