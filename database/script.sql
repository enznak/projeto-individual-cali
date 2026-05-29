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

create table resultados_quiz (
	id_quiz int,
    constraint fkQuizQuiz foreign key (id_quiz) references quizzes(id),
    id_usuario int,
    constraint fkUsuarioQuiz foreign key (id_usuario) references usuarios(id),
	acertos decimal(2,0),
    erros decimal(2,0),
    primary key (id_quiz, id_usuario)
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
    opcaoE varchar(120),
    correta varchar(1)
);

create table movimentos (
    id int primary key auto_increment,
    nome varchar(45),
    tipo varchar(8),
    categoria varchar(13),
    constraint chkCat check (tipo in('push','pull','balance','dinamico'))
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

create table artigos (
    id int primary key auto_increment,
    autor int,
    foreign key (autor) references usuarios(id),
    tag varchar(20),
    titulo varchar(100),
    subtitulo varchar(200),
    p1 varchar(1000),
    p2 varchar(1000),
    p3 varchar(1000)
);

create view vw_kpi as
select mu.id_usuario as usuario,
    sum(mu.desbloqueado) as total,
    (
    select m2.categoria
    from movimentos_usuario mu2
    join movimentos m2 ON mu2.id_movimento = m2.id
    where mu2.id_usuario = usuario
    and mu2.desbloqueado = 1
    order by
    case m2.categoria
    when 'iniciante' then 1
    when 'intermediario' then 2
    when 'avançado' then 3
    when 'elite' then 4
    else 0
    end desc
    limit 1
    ) as nivel,
    (
	select m2.categoria
    from movimentos_usuario mu2
    join movimentos m2 on mu2.id_movimento = m2.id
    where mu2.id_usuario = usuario
    and mu2.desbloqueado = 1
    and m2.tipo = 'push'
    order by
    case m2.categoria
    when 'iniciante' then 1
    when 'intermediario' then 2
    when 'avançado' then 3
    when 'elite' then 4
    else 0
    end desc
    limit 1
    ) as push,
    (
	select m2.categoria
    from movimentos_usuario mu2
    join movimentos m2 ON mu2.id_movimento = m2.id
    where mu2.id_usuario = usuario
    and mu2.desbloqueado = 1
    and m2.tipo = 'pull'
    order by
    case m2.categoria
    when 'iniciante' then 1
    when 'intermediario' then 2
    when 'avançado' then 3
    when 'elite' then 4
    else 0
    end desc
    limit 1
        ) as pull,
	(
	select m2.categoria
    from movimentos_usuario mu2
    join movimentos m2 ON mu2.id_movimento = m2.id
    where mu2.id_usuario = usuario
    and mu2.desbloqueado = 1
    and m2.tipo = 'balance'
    order by
    case m2.categoria
    when 'iniciante' then 1
    when 'intermediario' then 2
    when 'avançado' then 3
    when 'elite' then 4
    else 0
    end DESC
    limit 1
    ) as balance,
    (
	select sum(rq.acertos)
    from resultados_quiz rq
    where rq.id_usuario = usuario
    ) as acertos,
	(
	select sum(rq.erros)
    from resultados_quiz rq
    where rq.id_usuario = usuario
    ) as erros
from movimentos_usuario mu
where mu.desbloqueado = 1
group by mu.id_usuario;

create view vw_categoria as
    select id,
    id_usuario as usuario,
    estatico,
    dinamico,
    carga,
    repeticao,
    funcional
from pontos_categoria;

create view vw_movimentos as
    select id_usuario as usuario,
    id_movimento as movimento,
    desbloqueado
from movimentos_usuario;

create view vw_quizperguntas as
    select id_quiz as quiz,
    pergunta,
    opcaoA,
    opcaoB,
    opcaoC,
    opcaoD,
    opcaoE,
    correta
from perguntas;

create view vw_artigos as
    select id,
    autor,
    tag,
    titulo,
    subtitulo,
    p1,
    p2,
    p3
from artigos;

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
    (default, 'pushup', 'push', 'iniciante'),
    (default, 'planchelean', 'push', 'iniciante'),
    (default, 'plancheleanpu', 'push', 'iniciante'),
    (default, 'planchetuck', 'push', 'intermediario'),
    (default, 'planchetuckpu', 'push', 'intermediario'),
    (default, 'planchetuckp', 'push', 'intermediario'),
    (default, 'planchestraddle', 'push', 'avançado'),
    (default, 'planchestraddlepu', 'push', 'avançado'),
    (default, 'planchestraddlep', 'push', 'avançado'),
    (default, 'planchefull', 'push', 'elite');

insert into movimentos values
    (default, 'australianpullup', 'pull', 'iniciante'),
    (default, 'pullup', 'pull', 'iniciante'),
    (default, 'chesttobarpullup', 'pull', 'iniciante'),
    (default, 'explosivepullup', 'pull', 'intermediario'),
    (default, 'archerpullup', 'pull', 'intermediario'),
    (default, 'typewriterpullup', 'pull', 'intermediario'),
    (default, 'muscleup', 'pull', 'avançado'),
    (default, 'frontlevertuck', 'pull', 'avançado'),
    (default, 'frontleveradvancedtuck', 'pull', 'avançado'),
    (default, 'frontleverfull', 'pull', 'elite');

insert into movimentos values
    (default, 'frogstand', 'balance', 'iniciante'),
    (default, 'crowpose', 'balance', 'iniciante'),
    (default, 'tripodheadstand', 'balance', 'iniciante'),
    (default, 'headstand', 'balance', 'intermediario'),
    (default, 'wallhandstand', 'balance', 'intermediario'),
    (default, 'elbowstand', 'balance', 'intermediario'),
    (default, 'handstand', 'balance', 'avançado'),
    (default, 'handstandpushupnegativa', 'balance', 'avançado'),
    (default, 'presstohandstand', 'balance', 'avançado'),
    (default, 'handstandpushup', 'balance', 'elite');
    
insert into usuarios values
(1, 'nick', 'nick@gmail.com', 'nicknick123', 1);

insert into artigos values
    (default, 1, 'INICIANTES', 'Os benefícios da calistenia para iniciantes', 'Comece de forma simples e descubra como o peso do próprio corpo pode transformar seu treino.',
'A calistenia é uma forma de treino que vem ganhando cada vez mais espaço entre pessoas que buscam uma maneira prática, acessível e eficiente de se exercitar. Por utilizar o peso do próprio corpo, ela permite que o praticante desenvolva força, controle e mobilidade sem depender de equipamentos complexos, o que torna o início da prática muito mais simples e democrático. Para quem está começando, isso representa uma grande vantagem, já que é possível adaptar os exercícios ao próprio ritmo e construir uma base sólida desde os primeiros treinos.',
'Outro benefício importante da calistenia é que ela trabalha o corpo de forma integrada, estimulando não apenas os músculos, mas também a coordenação, o equilíbrio e a consciência corporal. Movimentos como flexões, agachamentos, barras e pranchas ajudam a desenvolver um condicionamento mais completo, porque envolvem diferentes grupos musculares ao mesmo tempo. Isso faz com que o treino seja funcional e contribua não só para a estética, mas também para a melhora da postura, da resistência e da qualidade de movimento no dia a dia.',
'Com o passar do tempo, a prática constante mostra resultados que vão além da parte física. O praticante passa a perceber mais disposição, mais confiança e uma evolução gradual que motiva a continuar treinando. Por isso, a calistenia é uma excelente escolha para iniciantes que querem transformar o exercício em hábito, evoluir com segurança e descobrir como pequenas conquistas ao longo do caminho podem fazer toda a diferença.'),
    (default, 1, 'MULHERES', 'Força e evolução das mulheres na calistenia', 'Organize seus exercícios e evolua com consistência, segurança e equilíbrio.',
'A calistenia tem se tornado uma prática cada vez mais presente na rotina de muitas mulheres, principalmente por oferecer liberdade, versatilidade e um caminho claro de evolução. Ao contrário de ideias antigas que associavam certos tipos de treino apenas ao público masculino, hoje fica cada vez mais evidente que a calistenia é uma modalidade completa, capaz de atender diferentes objetivos e perfis. Ela permite que cada mulher avance no seu tempo, respeitando seus limites e construindo resultados de forma consistente.',
'Além de fortalecer o corpo, a calistenia ajuda no desenvolvimento da confiança, da disciplina e da autonomia. Treinar com o próprio peso corporal faz com que a praticante perceba melhor seus movimentos, entenda suas capacidades e conquiste maior controle sobre o corpo. Exercícios adaptáveis também tornam a prática acessível em diferentes contextos, seja em casa, ao ar livre ou em ambientes com estrutura mais simples. Isso amplia as possibilidades e faz com que o treino se encaixe melhor na rotina.',
'Outro ponto que torna a calistenia tão especial para mulheres é o impacto que ela gera para além do treino. Cada conquista, seja uma repetição a mais, uma variação mais difícil ou uma melhora na postura, contribui para fortalecer a sensação de progresso e superação. Essa evolução contínua inspira não só quem pratica, mas também outras mulheres que passam a enxergar na calistenia uma forma de cuidar do corpo, da mente e da própria autoestima ao mesmo tempo.'),
    (default, 1, 'ROTINA', 'Como montar uma rotina de treino de calistenia', 'Força, autonomia e evolução em uma modalidade que se adapta a diferentes objetivos e níveis.',
'Montar uma rotina de calistenia de forma organizada é um dos passos mais importantes para quem deseja evoluir com segurança e manter a constância nos treinos. Quando existe uma estrutura bem pensada, fica mais fácil equilibrar os exercícios, acompanhar o progresso e evitar a sensação de estar treinando sem direção. Uma rotina eficiente costuma incluir movimentos de empurrar, puxar, pernas e core, garantindo que o corpo seja trabalhado de maneira completa e equilibrada.',
'Para quem está começando, o ideal é não tentar fazer tudo de uma vez. O melhor caminho é iniciar com exercícios mais simples, poucas repetições e foco total na execução correta. Flexões adaptadas, agachamentos, prancha, barras assistidas e outros movimentos básicos já são suficientes para construir uma boa base. Conforme o corpo vai se adaptando, é possível aumentar a intensidade aos poucos, o que torna o processo mais seguro e evita frustrações no início da jornada.',
'Com o tempo, uma boa rotina deixa de ser apenas uma sequência de exercícios e passa a se tornar parte do estilo de vida. A regularidade cria disciplina, o descanso adequado ajuda na recuperação muscular e a progressão gradual permite que o praticante evolua sem exageros. Dessa forma, a calistenia se transforma em um treino sustentável, eficiente e motivador, ideal para quem busca resultados reais sem abrir mão da praticidade.');