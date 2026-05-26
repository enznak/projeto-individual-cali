var database = require("../database/config");

function buscarPerguntasOpcoes(idQuiz) {

    var instrucaoSql = `SELECT 
    *
    FROM vw_quizperguntas
    WHERE quiz = ${idQuiz}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

async function inserirDadosCategoria(IdUsuario, pontos_estatico, pontos_dinamico, pontos_carga, pontos_repeticao, pontos_funcional) {

    var instrucaoSqlInsert = `INSERT INTO pontos_categoria (id, id_usuario, estatico, dinamico, carga, repeticao, funcional)
    VALUES (${IdUsuario}, ${IdUsuario}, ${pontos_estatico}, ${pontos_dinamico}, ${pontos_carga}, ${pontos_repeticao}, ${pontos_funcional});`;

    var instrucaoSqlUpdate = `UPDATE pontos_categoria SET estatico = ${pontos_estatico}, dinamico = ${pontos_dinamico}, carga = ${pontos_carga}, repeticao = ${pontos_repeticao}, funcional = ${pontos_funcional} where id_usuario = ${IdUsuario};`;

    try {
        console.log("Executando a instrução SQL: \n" + instrucaoSqlInsert);
        await database.executar(instrucaoSqlInsert)
    } catch {
        console.log("Executando a instrução SQL: \n" + instrucaoSqlUpdate);
        await database.executar(instrucaoSqlUpdate)
    }
}

async function inserirDadosConhecimento(IdUsuario, acertos, erros) {

    var instrucaoSqlInsert = `INSERT INTO resultados_quiz (id_quiz, id_usuario, acertos, erros)
    VALUES (2, ${IdUsuario}, ${acertos}, ${erros});`;

    var instrucaoSqlUpdate = `UPDATE resultados_quiz SET acertos = ${acertos}, erros = ${erros} where id_usuario = ${IdUsuario} and id_quiz = 2;`;

    try {
        console.log("Executando a instrução SQL: \n" + instrucaoSqlInsert);
        await database.executar(instrucaoSqlInsert)
    } catch {
        console.log("Executando a instrução SQL: \n" + instrucaoSqlUpdate);
        await database.executar(instrucaoSqlUpdate)
    }
}

module.exports = {
    buscarPerguntasOpcoes,
    inserirDadosCategoria,
    inserirDadosConhecimento
}