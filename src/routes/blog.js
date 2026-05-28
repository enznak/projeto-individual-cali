var express = require("express");
var router = express.Router();

var blogController = require("../controllers/blogController");

router.get("/buscarArtigos/:idArtigo", function (req, res) {
    blogController.buscarArtigosBlog(req, res);
});

module.exports = router;