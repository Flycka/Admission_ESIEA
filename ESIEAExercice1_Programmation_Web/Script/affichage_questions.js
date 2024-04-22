// Question exemple rentré en dur
const questionData = {
    question: "Quelle est la capitale de la France ?",
    reponse1: "Paris",
    reponse2: "Londres",
    reponseCorrecte: 1
};


function displayQuestion(data) {
    const questionContainer = document.getElementById('question-container');
    questionContainer.innerHTML = `
                <p>${data.question}</p>
                <div class="answer" id="answer1">${data.reponse1}</div>
                <div class="answer" id="answer2">${data.reponse2}</div>
            `;


    document.getElementById('answer1').addEventListener('click', function() {
        checkAnswer(1, data.reponseCorrecte);
    });

    document.getElementById('answer2').addEventListener('click', function() {
        checkAnswer(2, data.reponseCorrecte);
    });
}

function checkAnswer(selectedAnswer, correctAnswer) {
    const selectedElement = document.getElementById(`answer${selectedAnswer}`);
    if (selectedAnswer == correctAnswer) {
        selectedElement.classList.add('correct-answer');
    } else {
        selectedElement.classList.add('incorrect-answer');
        const correctElement = document.getElementById(`answer${correctAnswer}`);
        correctElement.classList.add('correct-answer');
    }


    document.getElementById('answer1').removeEventListener('click', checkAnswer);
    document.getElementById('answer2').removeEventListener('click', checkAnswer);
}


displayQuestion(questionData);