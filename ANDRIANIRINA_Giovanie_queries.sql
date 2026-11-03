-- Use1 créer un compte utilisateur --
-- ici la personne peut créer son nom d'utilisateur en inserant son nom, prénom, son email et le mot de passe --
INSERT INTO users (name_user, firstname_user, email_user, password_user)
VALUES ('Jannie', 'Pont', 'jn@mail.com', 'jn45678');

-- Use2 Consulter les événements disponibles --
SELECT *
FROM events;

-- Use3 S'inscrire à un événement --
INSERT INTO reservations (date_reservation, status, fk_id_user, fk_id_event)
VALUES (CURDATE(), 'confirme', 2, 6);

-- Use4 Consulter mes inscriptions personnelles --
SELECT e.name_event, e.date_event
FROM reservations r
JOIN events e ON r.fk_id_event = e.id_event
WHERE r.fk_id_user = 2;


-- Use5  Créer un nouvel événement --
INSERT INTO events (name_event, description_event, date_event, location_event, fk_id_user)
VALUES ('Conférence IA', 'Découverte de l''IA', '2026-09-15', 'Paris', 1);

-- US7 : Analyser la popularité des événements --
SELECT e.name_event, COUNT(r.id_reservation) AS nombre_participants
FROM events e
LEFT JOIN reservations r ON e.id_event = r.fk_id_event
GROUP BY e.id_event, e.name_event
ORDER BY nombre_participants DESC;

-- US8 : Lister tous les utilisateurs enregistrés --
SELECT id_user, name_user, firstname_user, email_user
FROM users
ORDER BY name_user ASC;

-- US9 : Mettre à jour les informations d'un événement --
-- (exemple : modifier le lieu et la description de l'événement id=6)
UPDATE events
SET location_event = 'Ginasservis',
    description_event = 'Description corrigée et mise à jour'
WHERE id_event = 6
  AND fk_id_user = 1; -- sécurité : seul l'organisateur propriétaire peut modifier

-- US10 : Annuler son inscription à un événement --
-- (exemple : l'utilisateur id=2 annule sa réservation pour l'événement id=6)
DELETE FROM reservations
WHERE fk_id_user = 2
  AND fk_id_event = 6;

-- US11 : Supprimer un événement annulé --
-- Étape 1 : supprimer d'abord les réservations liées (respect des clés étrangères)
DELETE FROM reservations
WHERE fk_id_event = 6;

-- Étape 2 : supprimer l'événement
DELETE FROM events
WHERE id_event = 6
  AND fk_id_user = 1; --  seul l'organisateur propriétaire peut supprimer

