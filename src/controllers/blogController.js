var blogModel = require("../models/blogModel");

function buscarArtigosBlog(req, res) {
    var idArtigo = req.params.idArtigo;
    blogModel.buscarArtigosBlog(idArtigo).then(function (resultado) {
        if (resultado.length > 0) {
            res.json(resultado[0]);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    buscarArtigosBlog
}
