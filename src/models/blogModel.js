var database = require("../database/config");

function buscarArtigosBlog(idArtigo) {

    var instrucaoSql = `SELECT 
    *
    FROM vw_artigos
    WHERE id = ${idArtigo}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    buscarArtigosBlog
}