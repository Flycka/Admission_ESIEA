<?php
session_start();
require_once 'mon-header.php';
require_once './BDD/Connexion.php';

$pdo = connect_bdd();

// Vérifier si une espèce a été sélectionnée précédemment
if (!isset($_SESSION['espece_selectionnee'])) {
    // Rediriger vers la page index.php si aucune espèce n'a été sélectionnée précédemment
    header("Location: index.php");
    exit();
}

// Récupérer l'espèce sélectionnée précédemment
$espece_id = $_SESSION['espece_selectionnee'];

// Récupérer la liste des animaux de l'espèce sélectionnée depuis la base de données
$stmt = $pdo->prepare("SELECT * FROM animal WHERE espece_id = ?");
$stmt->execute([$espece_id]);
$animaux = $stmt->fetchAll(PDO::FETCH_ASSOC);

// Vérifier la soumission du formulaire pour la sélection d'un animal
if ($_SERVER['REQUEST_METHOD'] === 'POST' && isset($_POST['animal'])) {
    // Stocker l'animal sélectionné dans la session et rediriger vers animal.php
    $_SESSION['animal_selectionne'] = $_POST['animal'];
    header("Location: animal.php");
    exit();
}
?>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="styles.css">
    <title>Page d'adoption</title>
</head>
<body>

<h1>Sélectionnez un animal à adopter :</h1>
<form id="form-container" method="POST" action="">
    <label>
        <select name="animal">
            <?php foreach ($animaux as $animal): ?>
                <option value="<?= $animal['id'] ?>"><?= $animal['nom'] ?></option>
            <?php endforeach; ?>
        </select>
    </label>
    <button type="submit">Valider</button>
</form>

</body>
</html>