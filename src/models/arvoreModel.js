var database = require("../database/config")

async function inserirMovimentosPull(IdUsuario, push_moves, pull_moves, balance_moves) {
    console.log(push_moves)
    let move = false
    for (let i = 0; i < push_moves.length; i++) {
        move = Object.values(push_moves[i])
        var instrucaoSqlInsert = `INSERT INTO movimentos_usuario (id_movimento, id_usuario, desbloqueado)
    VALUES (${i + 1}, ${IdUsuario}, ${move})`;
        var instrucaoSqlUpdate = `UPDATE movimentos_usuario SET desbloqueado = ${move}, 
        WHERE id_movimento = ${i + 1}
        AND id_usuario = ${IdUsuario}`;

        try {
            console.log("Executando a instrução SQL: \n" + instrucaoSql);
            await database.executar(instrucaoSqlInsert)
        } catch {
            await database.executar(instrucaoSqlUpdate)
        }
    }
    return;
}


module.exports = {
    inserirMovimentosPull
}