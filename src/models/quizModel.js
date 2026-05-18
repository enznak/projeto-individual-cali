var database = require("../database/config");

function buscarPerguntasOpcoes(idQuiz) {

    var instrucaoSql = `SELECT 
    *
    FROM vw_quizperguntas
    WHERE quiz = ${idQuiz}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function inserirDadosCategoria(IdUsuario, pontos_estatico, pontos_dinamico, pontos_carga, pontos_repeticao, pontos_funcional) {

    var instrucaoSql = `INSERT INTO pontos_categoria (id_usuario, estatico, dinamico, carga, repeticao, funcional)
    VALUES (${IdUsuario}, ${pontos_estatico}, ${pontos_dinamico}, ${pontos_carga}, ${pontos_repeticao}, ${pontos_funcional})`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarPerguntasOpcoes,
    inserirDadosCategoria
}