-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : ven. 26 juin 2026 à 13:52
-- Version du serveur : 8.4.7
-- Version de PHP : 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `eventmanagement`
--

-- --------------------------------------------------------

--
-- Structure de la table `events`
--

DROP TABLE IF EXISTS `events`;
CREATE TABLE IF NOT EXISTS `events` (
  `id_event` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `name_event` varchar(45) NOT NULL,
  `description_event` varchar(45) DEFAULT NULL,
  `date_event` date NOT NULL,
  `location_event` varchar(255) DEFAULT NULL,
  `fk_id_user` int NOT NULL,
  PRIMARY KEY (`id_event`),
  KEY `fk_events_users_idx` (`fk_id_user`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `events`
--

INSERT INTO `events` (`id_event`, `name_event`, `description_event`, `date_event`, `location_event`, `fk_id_user`) VALUES
(6, 'Festival Éco-Citoyen Demain Vert', 'Un rassemblement familial et engagé axé sur l', '2025-03-25', 'Parc de la Villette, 211 Avenue Jean Jaurès, 75019 Paris', 1),
(7, 'Exposition Interactive sur l\'Odyssée Numériqu', 'Une immersion totale au cœur du numérique ', '2026-03-25', 'Ginasservis', 3),
(8, 'Le Grand Banquet des Saveurs', 'une soirée gastronomique réunissant cinq chef', '2025-07-22', 'Château de la Source, 45 Route de Châteauneuf, 45100 Orléans', 5),
(9, 'Le Trail des Lumières', 'Une course nocturne à la frontale à travers l', '2026-11-14', 'Domaine National de Saint-Cloud, 1 Avenue de la Grille d-Honneur, 92210 Saint-Cloud', 4),
(10, 'Salon du Livre et de la BD', 'Un week-end de rencontres et de dédicaces ave', '2026-05-16', 'Palais des Congrès, 2 Place de la Porte Maillot, 75017 Paris', 1),
(18, 'Conférence sur les innovations', 'Découverte de l\'IA', '2026-09-15', 'Montpellier', 1),
(26, 'Sourire', 'Découverte comment sourire', '2024-09-14', 'Montpellier', 4);

-- --------------------------------------------------------

--
-- Structure de la table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
CREATE TABLE IF NOT EXISTS `reservations` (
  `id_reservation` int NOT NULL AUTO_INCREMENT,
  `date_reservation` date DEFAULT NULL,
  `status` enum('confirme','non confirme') DEFAULT NULL,
  `fk_id_user` int NOT NULL,
  `fk_id_event` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id_reservation`),
  KEY `fk_reservations_users1_idx` (`fk_id_user`),
  KEY `fk_reservations_events1_idx` (`fk_id_event`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `reservations`
--

INSERT INTO `reservations` (`id_reservation`, `date_reservation`, `status`, `fk_id_user`, `fk_id_event`) VALUES
(16, '2026-06-26', 'confirme', 2, 6);

-- --------------------------------------------------------

--
-- Structure de la table `roles`
--

DROP TABLE IF EXISTS `roles`;
CREATE TABLE IF NOT EXISTS `roles` (
  `id_role` int NOT NULL AUTO_INCREMENT,
  `name_role` enum('participant','organisateur','admin') NOT NULL,
  PRIMARY KEY (`id_role`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `roles`
--

INSERT INTO `roles` (`id_role`, `name_role`) VALUES
(1, 'participant'),
(3, 'admin'),
(5, 'organisateur');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `name_user` varchar(45) NOT NULL,
  `firstname_user` varchar(45) DEFAULT NULL,
  `email_user` varchar(100) NOT NULL,
  `password_user` varchar(255) NOT NULL,
  `fk_id_role` int NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `email_user_UNIQUE` (`email_user`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id_user`, `name_user`, `firstname_user`, `email_user`, `password_user`, `fk_id_role`) VALUES
(1, 'Titi', 'toto chu', 'toto12@gmail.com', 'toto1234', 1),
(2, 'Tata', 'tato cha', 'tato132@gmail.com', 'toto2234', 1),
(3, 'Tyti', 'tyto che', 'tyto123@gmail.com', 'toto3234', 3),
(4, 'Teti', 'teto chu', 'teto162@gmail.com', 'teto1234', 5),
(5, 'Tuti', 'tuto cha', 'tuto142@gmail.com', 'tuto1934', 5),
(6, 'Jean', 'Clochard', 'jean@mail.com', 'mo123456', 1),
(7, 'Marie', 'Dupont', 'marie@mail.com', 'mar54872', 4),
(9, 'sophia', 'Dupont', 'sophiae@mail.com', 'mar54872', 1),
(11, 'Valerie', 'Matcha', 'valae@mail.com', 'val57872', 3),
(13, 'Jannie', 'Pont', 'jn@mail.com', 'jn45678', 5);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `events`
--
ALTER TABLE `events`
  ADD CONSTRAINT `fk_events_users` FOREIGN KEY (`fk_id_user`) REFERENCES `users` (`id_user`);

--
-- Contraintes pour la table `reservations`
--
ALTER TABLE `reservations`
  ADD CONSTRAINT `fk_reservations_events1` FOREIGN KEY (`fk_id_event`) REFERENCES `events` (`id_event`),
  ADD CONSTRAINT `fk_reservations_users1` FOREIGN KEY (`fk_id_user`) REFERENCES `users` (`id_user`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
