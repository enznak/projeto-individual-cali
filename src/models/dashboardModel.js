var database = require("../database/config");

function buscarPontosCategoria(idUsuario) {

    var instrucaoSql = `SELECT 
    *
    FROM vw_categoria
    WHERE usuario = ${idUsuario}
    ORDER BY id DESC`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarKpiIndicadores(idUsuario) {

    var instrucaoSql = `SELECT nivel, acertos, erros, total, push, pull, balance FROM vw_kpi where usuario = ${idUsuario};`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);

}

module.exports = {
    buscarPontosCategoria,
    buscarKpiIndicadores
}
