var express = require("express");
var router = express.Router();

var quizController = require("../controllers/quizController");

router.get("/quiz-perguntas/:idQuiz", function (req, res) {
    quizController.buscarPerguntasOpcoes(req, res);
});

router.post("/quiz-categoria", function (req, res) {
    quizController.inserirDadosCategoria(req, res);
})

module.exports = router;