create database arise;
use arise;

create table usuarios (
	id int primary key auto_increment,
	nome varchar(30) not null unique,
	email varchar(320) not null unique,
	senha varchar(100) not null,
	perm boolean not null
);

create table quizzes (
	id int primary key auto_increment,
    titulo varchar(120),
    descricao varchar(255)
);

create table pontos_categoria (
	id int primary key auto_increment,
    id_usuario int,
    constraint fkUsuario foreign key (id_usuario) references usuarios(id),
    estatico decimal(2,0),
    dinamico decimal(2,0),
    carga decimal(2,0),
    repeticao decimal(2,0),
    funcional decimal(2,0)
);

create table resultados_quiz (
	id int primary key auto_increment,
    id_usuario int,
    constraint fkUsuarioQuiz foreign key (id_usuario) references usuarios(id),
	acertos decimal(2,0)
);

create table perguntas (
	id int primary key auto_increment,
    id_quiz int,
    constraint fkQuiz foreign key (id_quiz) references quizzes(id),
	pergunta varchar(255),
	opcaoA varchar(120),
    opcaoB varchar(120),
    opcaoC varchar(120),
    opcaoD varchar(120),
    opcaoE varchar(120)
);

create table movimentos (
id int primary key auto_increment,
nome varchar(45),
categoria varchar(8),
constraint chkCat check (categoria in('push','pull','balance','dinamico'))
);

create table movimentos_usuario (
	id_movimento int,
    constraint fkMovimentoUsuario foreign key (id_movimento) references movimentos(id),
    id_usuario int,
    constraint fkUsuarioMovimento foreign key (id_usuario) references usuarios(id),
    data_movimento datetime default current_timestamp,
    constraint pkCompostaMU primary key (id_movimento, id_usuario),
    desbloqueado bool
);

create view vw_categoria as select id, id_usuario as usuario, estatico, dinamico, carga, repeticao, funcional from pontos_categoria;
select * from pontos_categoria;

create view vw_quizperguntas as select id_quiz as quiz, pergunta, opcaoA, opcaoB, opcaoC, opcaoD, opcaoE from perguntas;

insert into usuarios values
(default, 'nick', 'nick@gmail.com', 'nicknick123', true);

insert into pontos_categoria values
(default, 1,  10, 7, 4, 5, 1);

insert into quizzes values
(1, 'Categoria', '10 perguntas sobre suas preferências, hábitos e facilidades no treino de calistenia. O resultado revela qual categoria domina sua identidade como atleta.'),
(2, 'Conhecimento', 'O quanto você sabe sobre a modalidade? Responda às perguntas e teste seus conhecimentos.');

insert into perguntas values 
(default, 1, 'Quando você imagina o movimento mais impressionante da calistenia, qual vem primeiro?', 'Movimento suspenso no ar', 'Giros no ar usando a barra fixa', 'Barra fixa com muito peso extra', 'Muitas flexões sem parar', 'Rolar, agachar e se mover com fluidez'),
(default, 1, 'O que te motiva mais durante um treino?', 'Sustentar uma posição difícil por mais tempo', '', 'Modelar o corpo e ganhar massa muscular', 'Ganhar mais resistência', 'Sentir que me movo melhor no dia a dia'),
(default, 1, 'Como você estrutura sua semana de treino geralmente?', 'Foco em movimentos estáticos', '', 'Séries pesadas com pouco volume', 'Volume alto e muitas séries', 'Treino variado com diferentes padrões'),
(default, 1, 'Escolha um movimento', 'Front Lever', 'Swing 360', 'Dips', 'Muscle up', 'Agachamento'),
(default, 1, 'Como você se sente com movimentos no chão (rolamentos, bear crawl, locomotion)?', 'Nem sei o que isso é', 'Prefiro movimentos mais acelerados', 'Não é meu estilo', 'Somente aquecimento', 'Parte essencial do meu treino'),
(default, 1, 'Qual a sensação que você busca ao treinar?', '', '', '', '', ''),
(default, 1, '', '', '', '', '', ''),
(default, 1, '', '', '', '', '', ''),
(default, 1, '', '', '', '', '', ''),
(default, 1, '', '', '', '', '', '');

insert into movimentos values
(default, 'pushup', 'push'),
(default, 'planchelean', 'push'),
(default, 'plancheleanpu', 'push'),
(default, 'planchetuck', 'push'),
(default, 'planchetuckpu', 'push'),
(default, 'planchetuckp', 'push'),
(default, 'planchestraddle', 'push'),
(default, 'planchestraddlepu', 'push'),
(default, 'planchestraddlep', 'push'),
(default, 'planchefull', 'push');