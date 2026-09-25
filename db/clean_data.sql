SET client_encoding = 'UTF8';

-- Limpar tabelas mantendo integridade
DELETE FROM participacao;
DELETE FROM conquista;
DELETE FROM atividade_periodo;
DELETE FROM atividade;
DELETE FROM estudante;
DELETE FROM periodo_letivo;
DELETE FROM coordenador;

-- Inserir coordenadores com acentuação correta
INSERT INTO coordenador (id, nome, minibio, foto) VALUES
    (1, 'Fábio Luiz Faria da Silva', 'Docente responsável pela orientação de projetos de ensino, pesquisa e extensão, garantindo a infraestrutura técnica e o suporte pedagógico aos estudantes do IFMS Campus Campo Grande.', 'fabio.jpg'),
    (2, 'Rodrigo Cardoso', 'Docente responsável pela orientação de projetos de ensino, pesquisa e extensão, garantindo a infraestrutura técnica e o suporte pedagógico aos estudantes do IFMS Campus Campo Grande.', 'rodrigo.jpg');

-- Inserir períodos letivos
INSERT INTO periodo_letivo (id, ano, semestre) VALUES
    (1, 2025, 1),
    (2, 2025, 2),
    (3, 2026, 1),
    (4, 2026, 2);

-- Inserir estudantes (Apenas Lucas Vinicius, sem foto)
INSERT INTO estudante (id, nome, minibio, foto) VALUES
    (1, 'Lucas Vinicius Rodrigues Xavier', 'Estudante do curso superior de Tecnologia em Sistemas para Internet (TSI).', NULL);

-- Inserir atividades com acentuação correta (sem caracteres corrompidos)
INSERT INTO atividade (id, titulo, tipo, descricao, data_inicio, data_fim, situacao, coordenador_id) VALUES
    (1, 'Negrótica — Edital IFB', 'Projeto', 'Desenvolvimento de protótipos mecânicos e algoritmos de controle com integração de alunos do nível técnico e superior.', DATE '2025-03-01', DATE '2025-12-15', 'Concluída', 1),
    (2, 'Manutenção & Oficinas 2026', 'Estágio', 'Atividade contínua reunindo tarefas de organização dos kits de robótica, prototipagem e suporte a eventos externos do campus.', DATE '2026-02-05', DATE '2026-07-05', 'Em andamento', 1),
    (3, 'Negrótica OBR 2026', 'Projeto', 'Projeto PICTEC com quatro estudantes dos cursos técnicos focado em sensores autônomos e introdução à robótica competitiva.', DATE '2026-03-01', DATE '2026-12-18', 'Em andamento', 1),
    (4, 'Robótica nas Escolas Públicas', 'Oficina', 'Capacitação e formação em lógica de programação utilizando blocos e kits tecnológicos direcionada a estudantes da rede estadual.', DATE '2026-08-01', DATE '2026-12-20', 'Planejada', 1),
    (5, 'Oficina de Robótica com Arduino', 'Oficina', 'Capacitação prática introdutória voltada para novos estudantes do IFMS e escolas parceiras.', DATE '2026-04-10', DATE '2026-04-24', 'Concluída', 1),
    (6, 'OBR 2025 — Equipe Robótica', 'Competição', 'Participação oficial na etapa estadual da OBR com protótipo animatrônico na modalidade artística.', DATE '2025-08-15', DATE '2025-10-18', 'Concluída', 1);

-- Inserir vínculos entre atividades e períodos
INSERT INTO atividade_periodo (atividade_id, periodo_id) VALUES
    (1, 1),
    (1, 2),
    (2, 3),
    (3, 3),
    (3, 4),
    (4, 4),
    (5, 3),
    (6, 2);

-- Inserir participações com acentuação correta
INSERT INTO participacao (estudante_id, atividade_id, funcao, descricao_contribuicao) VALUES
    (1, 1, 'Pesquisador Bolsista', 'Programou o microcontrolador e auxiliou na integração mecânica do robô.'),
    (1, 2, 'Estagiário de Apoio Técnico', 'Organização dos kits e manutenção preventiva das bancadas do laboratório.'),
    (1, 3, 'Bolsista TSI', 'Implementou os algoritmos de controle PID dos motores e lógica dos sensores.'),
    (1, 4, 'Monitor de Oficinas', 'Ministrou módulos práticos de lógica básica para alunos das escolas parceiras.'),
    (1, 5, 'Instrutor de Arduino', 'Responsável pelos exercícios práticos de lógica e programação em C/C++.'),
    (1, 6, 'Líder da Equipe Artística', 'Conduziu a calibração do animatrônico na arena estadual da OBR 2025.');

-- Inserir conquistas com acentuação correta
INSERT INTO conquista (id, atividade_id, titulo, data, descricao) VALUES
    (1, 6, '2º Lugar na OBR Estadual (Modalidade Artística)', DATE '2025-10-18', 'Apresentação do protótipo animatrônico desenvolvido integralmente por estudantes do IFMS Campus Campo Grande na etapa Mato Grosso do Sul.'),
    (2, 1, 'Destaque em Inovação Tecnológica', DATE '2025-11-20', 'Reconhecimento pelo desenvolvimento do projeto de extensão focado na inclusão digital através da robótica educacional em escolas públicas.');

-- Resetar sequências
SELECT setval('coordenador_id_seq', (SELECT MAX(id) FROM coordenador));
SELECT setval('periodo_letivo_id_seq', (SELECT MAX(id) FROM periodo_letivo));
SELECT setval('estudante_id_seq', (SELECT MAX(id) FROM estudante));
SELECT setval('atividade_id_seq', (SELECT MAX(id) FROM atividade));
SELECT setval('conquista_id_seq', (SELECT MAX(id) FROM conquista));
