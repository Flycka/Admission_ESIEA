const express = require('express');
const path = require('path');

const app = express();
const port = 3000;

// Middleware pour parser les requêtes avec le corps en URL encodé
app.use(express.urlencoded({ extended: true }));

app.use('/styles', express.static(__dirname + '/Styles'));
app.use('/script', express.static(__dirname + '/Script'));

// Définir la route racine pour servir accueil.html
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'accueil.html'));
});

// Définir la route pour servir le formulaire de création
app.get('/formulaire_creation', (req, res) => {
    res.sendFile(path.join(__dirname, 'formulaire_creation.html'));
});

app.get('/affichage_questions.html', (req, res) => {
    res.sendFile(path.join(__dirname, 'affichage_questions.html'));
});

// Traitement du formulaire
app.get('/traitement', (req, res) => {
    const question = req.query.question;
    const reponse1 = req.query.reponse1;
    const reponse2 = req.query.reponse2;
    const reponseCorrecte = req.query.reponse_correcte;

    // Vérification de la réponse correcte
    let isCorrect = false;
    if (reponseCorrecte === '1' || reponseCorrecte === '2') {
        isCorrect = true;
    }

    // Répondre avec le résultat
    res.send(`Question: ${question}<br>
    Réponse 1: ${reponse1}<br>
    Réponse 2: ${reponse2}<br>
    Réponse correcte: ${reponseCorrecte}<br>
    La réponse est ${isCorrect ? 'correcte' : 'incorrecte'}.`);
});

// Démarrer le serveur
app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}/`);
});
