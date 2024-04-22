-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : lun. 22 avr. 2024 à 09:57
-- Version du serveur : 5.7.17
-- Version de PHP : 8.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `adoption`
--

-- --------------------------------------------------------

--
-- Structure de la table `adoption`
--

CREATE TABLE `adoption` (
  `id` int(11) NOT NULL,
  `date_reservation` datetime NOT NULL,
  `date_eff_adoption` datetime NOT NULL,
  `adop_payee` tinyint(1) NOT NULL,
  `client_id` tinyint(6) NOT NULL,
  `espece_id` tinyint(6) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure de la table `animal`
--

CREATE TABLE `animal` (
  `id` smallint(6) NOT NULL,
  `sexe` char(1) NOT NULL,
  `date_naissance` datetime NOT NULL,
  `nom` varchar(30) NOT NULL,
  `commentaire` text NOT NULL,
  `espece_id` int(6) NOT NULL,
  `disponible` tinyint(6) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `animal`
--

INSERT INTO `animal` (`id`, `sexe`, `date_naissance`, `nom`, `commentaire`, `espece_id`, `disponible`) VALUES
(1, 'F', '2024-04-08 09:14:03', 'Lux', 'Femelle de 12 ans', 2, 1),
(2, 'M', '2024-01-16 09:15:41', 'Nono', 'Male de 2 mois', 2, 0),
(3, 'M', '2024-01-16 09:15:41', 'tintin', 'Male de 2 mois', 2, 0),
(4, 'F', '2024-04-08 09:14:03', 'tina', 'Femelle de 6 ans', 2, 1),
(5, 'F', '2024-04-08 09:14:03', 'Lumen', 'Femelle de 3 ans', 2, 0),
(6, 'M', '2023-10-16 14:15:56', 'Felix', 'jhgfds', 1, 1);

-- --------------------------------------------------------

--
-- Structure de la table `client`
--

CREATE TABLE `client` (
  `id` smallint(5) NOT NULL,
  `nom` varchar(100) NOT NULL,
  `prenom` varchar(60) NOT NULL,
  `adresse` varchar(200) NOT NULL,
  `code_postal` varchar(6) NOT NULL,
  `ville` varchar(60) NOT NULL,
  `pays` varchar(60) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `client`
--

INSERT INTO `client` (`id`, `nom`, `prenom`, `adresse`, `code_postal`, `ville`, `pays`, `email`) VALUES
(1, 'lorenzini', 'elodie', 'ferhgd', '47000', 'agen', 'france', 'dfgjghgfd@yjhgfds.fr');

-- --------------------------------------------------------

--
-- Structure de la table `espece`
--

CREATE TABLE `espece` (
  `id` int(6) NOT NULL,
  `nom_courant` varchar(30) NOT NULL,
  `nom_latin` varchar(30) NOT NULL,
  `description` text NOT NULL,
  `prix` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Déchargement des données de la table `espece`
--

INSERT INTO `espece` (`id`, `nom_courant`, `nom_latin`, `description`, `prix`) VALUES
(1, 'Chien', 'Canis lupus familiaris', 'Le Chien est la sous-espèce domestique de Canis lupus, un mammifère de la famille des Canidés', 100),
(2, 'Chat', 'Chat', 'Félin', 150);

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `animal`
--
ALTER TABLE `animal`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `client`
--
ALTER TABLE `client`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `espece`
--
ALTER TABLE `espece`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `animal`
--
ALTER TABLE `animal`
  MODIFY `id` smallint(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `client`
--
ALTER TABLE `client`
  MODIFY `id` smallint(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT pour la table `espece`
--
ALTER TABLE `espece`
  MODIFY `id` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
