<?php

session_start();

require_once 'mon-header.php';
require_once './BDD/Connexion.php';

$pdo = connect_bdd();

// Récupération de la liste des espèces animales depuis la base de données
$stmt = $pdo->query("SELECT * FROM espece");
$especes = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Vérification de la soumission du formulaire
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['espece'])) {
    $_SESSION['espece_selectionnee'] = $_POST['espece'];
    header("Location: adoption.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <title>Page d'accueil</title>
</head>
<body>

<h1>Sélectionnez une espèce animale :</h1>
<form id="form-container" method="POST" action="">
    <select name="espece">
        <?php foreach ($especes as $espece): ?>
            <option value="<?= $espece['id'] ?>"><?= $espece['nom_courant'] ?></option>
        <?php endforeach; ?>
    </select>
    <button type="submit">Valider</button>
</form>

</body>
</html>





