<?php
session_start();
require_once 'mon-header.php';
require_once './BDD/Connexion.php';

$pdo = connect_bdd();

// Vérifier si un animal a été sélectionné précédemment
if (!isset($_SESSION['animal_selectionne'])) {
    // Rediriger vers la page adoption.php si aucun animal n'a été sélectionné précédemment
    header("Location: adoption.php");
    exit();
}

// Récupérer l'animal sélectionné précédemment
$animal_id = $_SESSION['animal_selectionne'];

// Récupérer les informations sur l'animal depuis la base de données
$stmt = $pdo->prepare("SELECT a.*, e.nom_courant FROM animal a INNER JOIN espece e ON a.espece_id = e.id WHERE a.id = ?");
$stmt->execute([$animal_id]);
$animal = $stmt->fetch(PDO::FETCH_ASSOC);

// Récupérer le prix de l'espèce de l'animal
$stmt = $pdo->prepare("SELECT prix FROM espece WHERE id = ?");
$stmt->execute([$animal['espece_id']]);
$prix = $stmt->fetchColumn();

// Formater la date de naissance
$date_naissance = date("d/m/Y", strtotime($animal['date_naissance']));
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <title>Information sur l'animal</title>
</head>
<body>

<h1>Information sur l'animal</h1>

<ul>
    <li><strong>Nom :</strong> <?= $animal['nom'] ?></li>
    <li><strong>Sexe :</strong> <?= $animal['sexe'] ?></li>
    <li><strong>Date de naissance :</strong> <?= $date_naissance ?></li>
    <li><strong>Commentaire :</strong> <?= $animal['commentaire'] ?></li>
    <li><strong>Espece :</strong> <?= $animal['nom_courant'] ?></li>
    <li><strong>Prix :</strong> <?= $prix ?> €</li>
</ul>

</body>
</html>
