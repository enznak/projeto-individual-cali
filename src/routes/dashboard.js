var express = require("express");
var router = express.Router();

var dashboardController = require("../controllers/dashboardController");

router.get("/pontos-categoria/:idUsuario", function (req, res) {
    dashboardController.buscarPontosCategoria(req, res);
});

router.get("/kpi-indicadores/:idUsuario", function (req, res) {
    dashboardController.buscarKpiIndicadores(req, res);
})

module.exports = router;