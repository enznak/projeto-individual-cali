var quizModel = require("../models/quizModel");

function buscarPerguntasOpcoes(req, res) {
    var idQuiz = req.params.idQuiz;
    quizModel.buscarPerguntasOpcoes(idQuiz).then(function (resultado) {
        if (resultado.length > 0) {
            res.json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function inserirDadosCategoria(req, res) {
    var IdUsuario = req.body.IDServer;
    var pontos_estatico = req.body.estaticoServer;
    var pontos_dinamico = req.body.dinamicoServer;
    var pontos_carga = req.body.cargaServer;
    var pontos_repeticao = req.body.repeticaoServer;
    var pontos_funcional = req.body.funcionalServer;

    console.log(`ID: ${IdUsuario}, Estático: ${pontos_estatico}, Dinâmico: ${pontos_dinamico}, Carga: ${pontos_carga}, Repetição: ${pontos_repeticao}, Funcional: ${pontos_funcional}`);

    quizModel.inserirDadosCategoria(IdUsuario, pontos_estatico, pontos_dinamico, pontos_carga, pontos_repeticao, pontos_funcional)
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
    buscarPerguntasOpcoes,
    inserirDadosCategoria

}