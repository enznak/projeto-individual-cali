var database = require("../database/config");

function buscarPontosCategoria(idUsuario) {

    var instrucaoSql = `SELECT 
    *
    FROM vw_categoria
    WHERE usuario = ${idUsuario}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarKpiIndicadores(idUsuario) {

    /* var instrucaoSql = `SELECT 
        dht11_temperatura as temperatura, 
        dht11_umidade as umidade,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
                        fk_aquario 
                        FROM medida WHERE fk_aquario = ${idAquario} 
                    ORDER BY id DESC LIMIT 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
*/ }

module.exports = {
    buscarPontosCategoria,
    buscarKpiIndicadores
}
