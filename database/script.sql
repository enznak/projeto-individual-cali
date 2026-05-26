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
	id int,
    id_usuario int,
    constraint fkUsuario foreign key (id_usuario) references usuarios(id),
    estatico decimal(2,0),
    dinamico decimal(2,0),
    carga decimal(2,0),
    repeticao decimal(2,0),
    funcional decimal(2,0),
    constraint pcComposta primary key (id, id_usuario)
);

select * from pontos_categoria;

drop table pontos_categoria;

create table resultados_quiz (
	id_quiz int,
    constraint fkQuizQuiz foreign key (id_quiz) references quizzes(id),
    id_usuario int,
    constraint fkUsuarioQuiz foreign key (id_usuario) references usuarios(id),
	acertos decimal(2,0),
    erros decimal(2,0),
    primary key (id_quiz, id_usuario)
);

select * from resultados_quiz;

create table perguntas (
	id int primary key auto_increment,
    id_quiz int,
    constraint fkQuiz foreign key (id_quiz) references quizzes(id),
	pergunta varchar(255),
	opcaoA varchar(120),
    opcaoB varchar(120),
    opcaoC varchar(120),
    opcaoD varchar(120),
    opcaoE varchar(120),
    correta varchar(1)
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

create view vw_quizperguntas as select id_quiz as quiz, pergunta, opcaoA, opcaoB, opcaoC, opcaoD, opcaoE, correta from perguntas;
drop view vw_quizperguntas;

insert into usuarios values
(default, 'nick', 'nick@gmail.com', 'nicknick123', true);
select * from usuarios;

insert into pontos_categoria values
(default, 1,  10, 7, 4, 5, 1);

insert into quizzes values
(1, 'Categoria', '10 perguntas sobre suas preferências, hábitos e facilidades no treino de calistenia. O resultado revela qual categoria domina sua identidade como atleta.');
insert into quizzes values
(2, 'Conhecimento', 'O quanto você sabe sobre a modalidade? Responda às perguntas e teste seus conhecimentos.');

insert into perguntas values 
(default, 1, 'Quando você imagina o movimento mais impressionante da calistenia, qual vem primeiro?', 'Movimento suspenso no ar', 'Giros no ar usando a barra fixa', 'Barra fixa com muito peso extra', 'Muitas flexões sem parar', 'Rolar, agachar e se mover com fluidez', null),
(default, 1, 'O que te motiva mais durante um treino?', 'Sustentar uma posição difícil por mais tempo', 'Aprender movimentos explosivos e acrobáticos', 'Modelar o corpo e ganhar massa muscular', 'Ganhar mais resistência', 'Sentir que me movo melhor no dia a dia', null),
(default, 1, 'Como você estrutura sua semana de treino geralmente?', 'Foco em movimentos estáticos', 'Treino de combos, giros e explosão', 'Séries pesadas com pouco volume', 'Volume alto e muitas séries', 'Treino variado com diferentes padrões', null),
(default, 1, 'Escolha um movimento', 'Front Lever', 'Swing 360', 'Dips com peso', 'Muscle up', 'Agachamento', null),
(default, 1, 'Como você se sente com movimentos no chão (rolamentos, bear crawl, locomotion)?', 'Nem sei o que isso é', 'Prefiro movimentos mais acelerados', 'Não é meu estilo', 'Somente aquecimento', 'Parte essencial do meu treino', null),
(default, 1, 'Qual a sensação que você busca ao treinar?', 'Controle total do corpo', 'Liberdade e explosão nos movimentos', 'Força bruta e intensidade', 'Superação pelo volume', 'Leveza e utilidade no movimento', null),
(default, 1, 'Qual resultado mais te atrai na calistenia?', 'Dominar isometrias avançadas', 'Executar movimentos plásticos e acrobáticos', 'Ficar mais forte e denso muscularmente', 'Fazer muitas repetições com facilidade', 'Ter um corpo mais útil e adaptável', null),
(default, 1, 'Em um treino ideal, o que não pode faltar?', 'Tentativas de holds', 'Transições e movimentos no ar', 'Sobrecarga progressiva', 'Séries longas até queimar', 'Locomoções e mobilidade', null),
(default, 1, 'Qual frase combina mais com você?', 'Quero travar posições impossíveis', 'Quero voar na barra', 'Quero empurrar e puxar cada vez mais peso', 'Quero performar por mais tempo', 'Quero me mover melhor em qualquer situação', null),
(default, 1, 'Se você tivesse que escolher um estilo como base, qual seria?', 'Estático', 'Dinâmico', 'Carga', 'Repetição', 'Funcional', null);

insert into perguntas values
(default, 2, 'O que é calistenia?', 'Um esporte praticado apenas com barras olímpicas', 'Um treino exclusivo de academia com máquinas', 'Um método de treino com foco no controle do corpo usando o peso corporal', 'Um tipo de corrida intervalada', 'Uma modalidade de ciclismo urbano', 'C'),
(default, 2, 'Qual destes movimentos é um exercício básico de puxada na calistenia?', 'Agachamento livre', 'Panturrilha em pé', 'Supino', 'Barra fixa', 'Corrida estacionária', 'D'),
(default, 2, 'Qual destes movimentos trabalha principalmente o padrão de empurrar?', 'Flexão de braço', 'Elevação de pernas', 'Back lever', 'Ponte de glúteo', 'Barra australiana', 'A'),
(default, 2, 'O que significa uma isometria na calistenia?', 'Treinar apenas com peso extra', 'Fazer o máximo de repetições possível', 'Treinar depois do treino', 'Sustentar uma posição sem movimento por um tempo', 'Ignorar grupos menores', 'D'),
(default, 2, 'Qual destes é um movimento estático?', 'Muscle up', 'L-sit', 'Back lever', 'Swing 360', 'Burpee', 'B'),
(default, 2, 'Qual destes é um movimento dinâmico?', 'Wall sit', 'Muscle up', 'Back lever', 'Planche', 'Hollow body hold', 'B'),
(default, 2, 'Para evoluir com mais segurança na calistenia, o mais indicado é:', 'Treinar com falha máxima todos os dias', 'Treinar sempre rápido', 'Treinar só com altas cargas', 'Evitar exercícios básicos', 'Respeitar técnica e progressão', 'E'),
(default, 2, 'Qual destas opções costuma ajudar na saúde dos ombros durante o treino?', 'Treinar com dor leve', 'Aquecimento e mobilidade', 'Treinar sem aquecer', 'Fazer todos os movimentos com peso extra', 'Nunca treinar ombros', 'B'),
(default, 2, 'O que é progressão na calistenia?', 'Uma sequência de variações que leva ao movimento avançado', 'Treinar só com anilhas', 'Fazer séries longas aleatórias', 'Treinar sem objetivo', 'Diminuir amplitude para terminar mais rápido', 'A'),
(default, 2, 'Qual destes fatores mais influencia sua evolução na calistenia?', 'Treinar uma vez por mês muito forte', 'Treinar sem descanso', 'Consistência ao longo do tempo', 'Evitar exercícios básicos', 'Treinar sem planejamento', 'C');

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