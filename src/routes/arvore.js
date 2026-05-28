var express = require("express");
var router = express.Router();

var arvoreController = require("../controllers/arvoreController");

router.post("/movimentos-usuario", function (req, res) {
    arvoreController.inserirMovimentos(req, res);
});

router.get("/buscarMovimentos/:idUsuario", function (req, res) {
    arvoreController.buscarArvore(req, res);
});

module.exports = router;