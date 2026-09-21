CREATE TABLE IF NOT EXISTS coordenador (
    id       BIGSERIAL PRIMARY KEY,
    nome     VARCHAR(150) NOT NULL,
    minibio  TEXT,
    foto     VARCHAR(500)
);

CREATE TABLE IF NOT EXISTS estudante (
    id       BIGSERIAL PRIMARY KEY,
    nome     VARCHAR(150) NOT NULL,
    minibio  TEXT,
    foto     VARCHAR(500)
);

CREATE TABLE IF NOT EXISTS periodo_letivo (
    id        BIGSERIAL PRIMARY KEY,
    ano       INTEGER NOT NULL,
    semestre  INTEGER NOT NULL,
    UNIQUE (ano, semestre)
);

CREATE TABLE IF NOT EXISTS atividade (
    id             BIGSERIAL PRIMARY KEY,
    titulo         VARCHAR(200) NOT NULL,
    tipo           VARCHAR(100),
    descricao      TEXT,
    data_inicio    DATE,
    data_fim       DATE,
    situacao       VARCHAR(50),
    coordenador_id BIGINT REFERENCES coordenador (id)
);

CREATE TABLE IF NOT EXISTS conquista (
    id            BIGSERIAL PRIMARY KEY,
    atividade_id  BIGINT REFERENCES atividade (id),
    titulo        VARCHAR(200) NOT NULL,
    data          DATE,
    descricao     TEXT
);

CREATE TABLE IF NOT EXISTS participacao (
    estudante_id          BIGINT NOT NULL REFERENCES estudante (id),
    atividade_id          BIGINT NOT NULL REFERENCES atividade (id),
    funcao                VARCHAR(100),
    descricao_contribuicao TEXT,
    PRIMARY KEY (estudante_id, atividade_id)
);

INSERT INTO coordenador (nome, minibio, foto) VALUES
    ('Maria Oliveira', 'Coordenadora do projeto de robotica do IFMS.', 'maria.jpg');

INSERT INTO estudante (nome, minibio, foto) VALUES
    ('Joao Silva', 'Estudante de Informatica e entusiasta de robotica.', 'joao.jpg'),
    ('Ana Souza', 'Estudante de Informatica com foco em eletronica.', 'ana.jpg');

INSERT INTO atividade (titulo, tipo, descricao, data_inicio, data_fim, situacao, coordenador_id) VALUES
    ('Oficina de Arduino', 'Oficina', 'Introducao a programacao de Arduino.', DATE '2026-03-10', DATE '2026-03-24', 'Em andamento', 1);

INSERT INTO conquista (atividade_id, titulo, data, descricao) VALUES
    (1, 'Primeiro robô montado', DATE '2026-03-24', 'Equipe concluiu a montagem do primeiro prototipo.');

INSERT INTO participacao (estudante_id, atividade_id, funcao, descricao_contribuicao) VALUES
    (1, 1, 'Programador', 'Desenvolveu o firmware do Arduino.'),
    (2, 1, 'Eletronica', 'Montou o circuito e os sensores.');
