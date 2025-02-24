-- exemple de vu permettant de calculer la sommes des dépenses et des revenus
-- alloués pour chacun des clients présent dans le dataset.

CREATE OR REPLACE VIEW `project.dataset.revenus_et_depenses` AS
SELECT
  c.client_id,
  c.nom_client,
  SUM(CASE WHEN t.type_transaction = 'revenu' THEN t.montant ELSE 0 END) AS total_revenus,
  SUM(CASE WHEN t.type_transaction = 'depense' THEN t.montant ELSE 0 END) AS total_depenses
FROM
  `project.dataset.transactions` t
JOIN
  `project.dataset.clients` c ON t.client_id = c.client_id
GROUP BY
  c.client_id, c.nom_client;