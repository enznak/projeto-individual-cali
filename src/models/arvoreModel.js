var database = require("../database/config")

async function inserirMovimentos(IdUsuario, push_moves, pull_moves, balance_moves) {
    console.log("IdUsuario:", IdUsuario);
    console.log("push_moves:", push_moves);
    console.log("pull_moves:", pull_moves);
    console.log("balance_moves:", balance_moves);
    console.log(push_moves)
    let move = false
    for (let i = 0; i < push_moves.length; i++) {
        move = Object.values(push_moves[i])
        var instrucaoSqlInsert = `INSERT INTO movimentos_usuario (id_movimento, id_usuario, desbloqueado)
    VALUES (${i + 1}, ${IdUsuario}, ${move})`;
        var instrucaoSqlUpdate = `UPDATE movimentos_usuario SET desbloqueado = ${move} 
        WHERE id_movimento = ${i + 1}
        AND id_usuario = ${IdUsuario}`;

        try {
            console.log("Executando a instrução SQL: \n" + instrucaoSqlInsert);
            await database.executar(instrucaoSqlInsert)
        } catch {
            console.log("Executando a instrução SQL: \n" + instrucaoSqlUpdate);
            await database.executar(instrucaoSqlUpdate)
        }
    }

    for (let i = 0; i < pull_moves.length; i++) {
        move = Object.values(pull_moves[i])[0];

        let instrucaoSqlInsert = `INSERT INTO movimentos_usuario (id_movimento, id_usuario, desbloqueado)
        VALUES (${i + 11}, ${IdUsuario}, ${move})`;

        let instrucaoSqlUpdate = `UPDATE movimentos_usuario 
        SET desbloqueado = ${move}
        WHERE id_movimento = ${i + 11}
        AND id_usuario = ${IdUsuario}`;

        try {
            console.log("Executando INSERT:\n" + instrucaoSqlInsert);
            await database.executar(instrucaoSqlInsert);
        } catch (erro) {
            console.log("Executando UPDATE:\n" + instrucaoSqlUpdate);
            await database.executar(instrucaoSqlUpdate);
        }
    }

    for (let i = 0; i < balance_moves.length; i++) {
        move = Object.values(balance_moves[i])[0];

        let instrucaoSqlInsert = `INSERT INTO movimentos_usuario (id_movimento, id_usuario, desbloqueado)
        VALUES (${i + 21}, ${IdUsuario}, ${move})`;

        let instrucaoSqlUpdate = `UPDATE movimentos_usuario 
        SET desbloqueado = ${move}
        WHERE id_movimento = ${i + 21}
        AND id_usuario = ${IdUsuario}`;

        try {
            console.log("Executando INSERT:\n" + instrucaoSqlInsert);
            await database.executar(instrucaoSqlInsert);
        } catch (erro) {
            console.log("Executando UPDATE:\n" + instrucaoSqlUpdate);
            await database.executar(instrucaoSqlUpdate);
        }
    }

    return;
}

function buscarArvore(usuario) {

    var instrucaoSql = `SELECT 
    movimento, desbloqueado
    FROM vw_movimentos
    WHERE usuario = ${usuario}`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    inserirMovimentos,
    buscarArvore
}