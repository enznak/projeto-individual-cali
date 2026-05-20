var arvoreModel = require("../models/arvoreModel");

function inserirMovimentos(req, res) {
    var IdUsuario = req.body.IDServer;
    var push_moves = req.body.pushServer;
    var pull_moves = req.body.pullServer;
    var balance_moves = req.body.balanceServer;

    arvoreModel.inserirMovimentosPull(IdUsuario, push_moves)
        .then(
            function (resultado) {
                res.json(resultado);
            }
        ).catch(
            function (erro) {
                console.log(erro);
                console.log("Houve um erro ao inserir os dados.", erro.sqlMessage

                );
                res.status(500).json(erro.sqlMessage);
            });
}

module.exports = {
    inserirMovimentos
}