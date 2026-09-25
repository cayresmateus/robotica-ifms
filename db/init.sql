-- Modelo completo do Portal do Laboratório de Robótica — IFMS Campus Campo Grande
-- Compatível com PostgreSQL

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
    CONSTRAINT ck_periodo_semestre CHECK (semestre IN (1, 2)),
    CONSTRAINT uk_periodo_ano_semestre UNIQUE (ano, semestre)
);

CREATE TABLE IF NOT EXISTS atividade (
    id             BIGSERIAL PRIMARY KEY,
    titulo         VARCHAR(200) NOT NULL,
    tipo           VARCHAR(100) NOT NULL,
    descricao      TEXT NOT NULL,
    data_inicio    DATE NOT NULL,
    data_fim       DATE,
    situacao       VARCHAR(50) NOT NULL,
    coordenador_id BIGINT NOT NULL REFERENCES coordenador (id) ON DELETE RESTRICT,
    CONSTRAINT ck_atividade_datas CHECK (data_fim IS NULL OR data_fim >= data_inicio)
);

CREATE TABLE IF NOT EXISTS atividade_periodo (
    atividade_id BIGINT NOT NULL REFERENCES atividade (id) ON DELETE CASCADE,
    periodo_id   BIGINT NOT NULL REFERENCES periodo_letivo (id) ON DELETE RESTRICT,
    PRIMARY KEY (atividade_id, periodo_id)
);

CREATE TABLE IF NOT EXISTS participacao (
    estudante_id           BIGINT NOT NULL REFERENCES estudante (id) ON DELETE CASCADE,
    atividade_id           BIGINT NOT NULL REFERENCES atividade (id) ON DELETE CASCADE,
    funcao                 VARCHAR(100),
    descricao_contribuicao TEXT,
    PRIMARY KEY (estudante_id, atividade_id)
);

CREATE TABLE IF NOT EXISTS conquista (
    id            BIGSERIAL PRIMARY KEY,
    atividade_id  BIGINT NOT NULL REFERENCES atividade (id) ON DELETE CASCADE,
    titulo        VARCHAR(200) NOT NULL,
    data          DATE,
    descricao     TEXT
);

-- Carga inicial de dados representativos (Memória do Laboratório de Robótica)
INSERT INTO coordenador (id, nome, minibio, foto) VALUES
    (1, 'Fábio Luiz Faria da Silva', 'Docente responsável pela orientação de projetos de ensino, pesquisa e extensão, garantindo a infraestrutura técnica e o suporte pedagógico aos estudantes do IFMS Campus Campo Grande.', 'fabio.jpg'),
    (2, 'Rodrigo Cardoso', 'Docente responsável pela orientação de projetos de ensino, pesquisa e extensão, garantindo a infraestrutura técnica e o suporte pedagógico aos estudantes do IFMS Campus Campo Grande.', 'rodrigo.jpg')
    ON CONFLICT (id) DO NOTHING;

INSERT INTO periodo_letivo (id, ano, semestre) VALUES
    (1, 2025, 1),
    (2, 2025, 2),
    (3, 2026, 1),
    (4, 2026, 2)
    ON CONFLICT (id) DO NOTHING;

INSERT INTO estudante (id, nome, minibio, foto) VALUES
    (1, 'Lucas Vinicius Rodrigues Xavier', 'Estudante do curso superior de Tecnologia em Sistemas para Internet (TSI).', NULL)
    ON CONFLICT (id) DO NOTHING;

INSERT INTO atividade (id, titulo, tipo, descricao, data_inicio, data_fim, situacao, coordenador_id) VALUES
    (1, 'Negrótica — Edital IFB', 'Projeto', 'Desenvolvimento de protótipos mecânicos e algoritmos de controle com integração de alunos do nível técnico e superior.', DATE '2025-03-01', DATE '2025-12-15', 'Concluída', 1),
    (2, 'Manutenção & Oficinas 2026', 'Estágio', 'Atividade contínua reunindo tarefas de organização dos kits de robótica, prototipagem e suporte a eventos externos do campus.', DATE '2026-02-05', DATE '2026-07-05', 'Em andamento', 1),
    (3, 'Negrótica OBR 2026', 'Projeto', 'Projeto PICTEC com quatro estudantes dos cursos técnicos focado em sensores autônomos e introdução à robótica competitiva.', DATE '2026-03-01', DATE '2026-12-18', 'Em andamento', 1),
    (4, 'Robótica nas Escolas Públicas', 'Oficina', 'Capacitação e formação em lógica de programação utilizando blocos e kits tecnológicos direcionada a estudantes da rede estadual.', DATE '2026-08-01', DATE '2026-12-20', 'Planejada', 1),
    (5, 'Oficina de Robótica com Arduino', 'Oficina', 'Capacitação prática introdutória voltada para novos estudantes do IFMS e escolas parceiras.', DATE '2026-04-10', DATE '2026-04-24', 'Concluída', 1),
    (6, 'OBR 2025 — Equipe Robótica', 'Competição', 'Participação oficial na etapa estadual da OBR com protótipo animatrônico na modalidade artística.', DATE '2025-08-15', DATE '2025-10-18', 'Concluída', 1)
    ON CONFLICT (id) DO NOTHING;

INSERT INTO atividade_periodo (atividade_id, periodo_id) VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (3, 3),
    (3, 4),
    (4, 4),
    (5, 3),
    (6, 2)
    ON CONFLICT DO NOTHING;

INSERT INTO participacao (estudante_id, atividade_id, funcao, descricao_contribuicao) VALUES
    (1, 1, 'Pesquisador Bolsista', 'Programou o microcontrolador e auxiliou na integração mecânica do robô.'),
    (1, 2, 'Estagiário de Apoio Técnico', 'Organização dos kits e manutenção preventiva das bancadas do laboratório.'),
    (1, 3, 'Bolsista TSI', 'Implementou os algoritmos de controle PID dos motores e lógica dos sensores.'),
    (1, 4, 'Monitor de Oficinas', 'Ministrou módulos práticos de lógica básica para alunos das escolas parceiras.'),
    (1, 5, 'Instrutor de Arduino', 'Responsável pelos exercícios práticos de lógica e programação em C/C++.'),
    (1, 6, 'Líder da Equipe Artística', 'Conduziu a calibração do animatrônico na arena estadual da OBR 2025.')
    ON CONFLICT DO NOTHING;

INSERT INTO conquista (id, atividade_id, titulo, data, descricao) VALUES
    (1, 6, '2º Lugar na OBR Estadual (Modalidade Artística)', DATE '2025-10-18', 'Apresentação do protótipo animatrônico desenvolvido integralmente por estudantes do IFMS Campus Campo Grande na etapa Mato Grosso do Sul.'),
    (2, 1, 'Destaque em Inovação Tecnológica', DATE '2025-11-20', 'Reconhecimento pelo desenvolvimento do projeto de extensão focado na inclusão digital através da robótica educacional em escolas públicas.')
    ON CONFLICT (id) DO NOTHING;

-- Sincronizar sequências
SELECT setval('coordenador_id_seq', (SELECT COALESCE(MAX(id), 1) FROM coordenador));
SELECT setval('periodo_letivo_id_seq', (SELECT COALESCE(MAX(id), 1) FROM periodo_letivo));
SELECT setval('estudante_id_seq', (SELECT COALESCE(MAX(id), 1) FROM estudante));
SELECT setval('atividade_id_seq', (SELECT COALESCE(MAX(id), 1) FROM atividade));
SELECT setval('conquista_id_seq', (SELECT COALESCE(MAX(id), 1) FROM conquista));
