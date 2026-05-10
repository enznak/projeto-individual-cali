// sessão
function validarSessao() {
    var email = sessionStorage.EMAIL_USUARIO;
    var nome = sessionStorage.NOME_USUARIO;

    var div_visitante = document.getElementById("div_visitante")
    var div_usuario = document.getElementById("div_usuario")
    var sessao = false

    if (email != null && nome != null) {
        sessao = true
        div_visitante.style.display = 'none'
        div_usuario.style.display = 'block'
    } else {
        sessao = false
        div_visitante.style.display = 'block'
        div_usuario.style.display = 'none'
    }
}

function limparSessao() {
    sessionStorage.clear();
    window.location = "../login.html";
}

// carregamento (loading)
function aguardar() {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "flex";
}

function finalizarAguardar(texto) {
    var divAguardar = document.getElementById("div_aguardar");
    divAguardar.style.display = "none";

    var divErrosLogin = document.getElementById("div_erros_login");
    if (texto) {
        divErrosLogin.style.display = "flex";
        divErrosLogin.innerHTML = texto;
    }
}

