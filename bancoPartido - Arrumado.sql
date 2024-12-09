-- Criação do banco de dados
CREATE DATABASE sistemapolitico2;
USE sistemapolitico2;

-- Criação da tabela eleicao
CREATE TABLE eleicao (
    id_eleicao INT AUTO_INCREMENT PRIMARY KEY,
    ano INT NOT NULL UNIQUE,
    resultado VARCHAR(50),
    descricao VARCHAR(255)
);

-- Criação da tabela campanha
CREATE TABLE campanha (
    id_campanha INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    orcamento_estimado DECIMAL(10,2),
    valor_gasto DECIMAL(10,2),
    data_inicio DATE,
    data_termino DATE,
    eleicao_id_eleicao INT NOT NULL,
    FOREIGN KEY (eleicao_id_eleicao) REFERENCES eleicao(id_eleicao) ON DELETE CASCADE
);

-- Criação da tabela candidato
CREATE TABLE candidato (
    id_candidato INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    cargo_publico VARCHAR(50),
    estado VARCHAR(50),
    cidade VARCHAR(50),
    campanha_id_campanha INT NOT NULL,
    FOREIGN KEY (campanha_id_campanha) REFERENCES campanha(id_campanha) ON DELETE CASCADE
);

-- Criação da tabela cargo_interno
CREATE TABLE cargo_interno (
    id_cargo_interno INT AUTO_INCREMENT PRIMARY KEY,
    tipo_cargo VARCHAR(50),
    data_inicio DATE
);

-- Criação da tabela filiado
CREATE TABLE filiado (
    id_filiado INT AUTO_INCREMENT PRIMARY KEY,
    cpf VARCHAR(11) NOT NULL UNIQUE,
    nome VARCHAR(100),
    fone VARCHAR(15),
    data_filiacao DATE,
    logradouro VARCHAR(100),
    numero VARCHAR(10),
    cidade VARCHAR(50),
    estado VARCHAR(50),
    cargo_interno_id_cargo_interno INT NOT NULL,
    FOREIGN KEY (cargo_interno_id_cargo_interno) REFERENCES cargo_interno(id_cargo_interno) ON DELETE CASCADE
);

-- Criação da tabela evento
CREATE TABLE evento (
    id_evento INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    data DATE,
    local VARCHAR(100),
    filiados_participantes INT,
    custo_estimado DECIMAL(10,2)
);

-- Criação da tabela filiado_has_evento
CREATE TABLE filiado_has_evento (
    filiado_id_filiado INT NOT NULL,
    evento_id_evento INT NOT NULL,
    PRIMARY KEY (filiado_id_filiado, evento_id_evento),
    FOREIGN KEY (filiado_id_filiado) REFERENCES filiado(id_filiado) ON DELETE CASCADE,
    FOREIGN KEY (evento_id_evento) REFERENCES evento(id_evento) ON DELETE CASCADE
);

-- Criação da tabela doacao
CREATE TABLE doacao (
    id_doacao INT AUTO_INCREMENT PRIMARY KEY,
    origem_doacao VARCHAR(100),
    nome_doador VARCHAR(100),
    valor_doacao DECIMAL(10,2),
    data DATE,
    forma_pagamento VARCHAR(50),
    filiado_id_filiado INT NOT NULL,
    campanha_id_campanha INT NOT NULL,
    FOREIGN KEY (filiado_id_filiado) REFERENCES filiado(id_filiado) ON DELETE CASCADE,
    FOREIGN KEY (campanha_id_campanha) REFERENCES campanha(id_campanha) ON DELETE CASCADE
);

-- Area dos alters
ALTER TABLE eleicao ADD COLUMN descricao_vitoria VARCHAR(255) AFTER resultado;
ALTER TABLE eleicao ADD UNIQUE (ano);

ALTER TABLE campanha ADD COLUMN descricao_extra VARCHAR(255) AFTER valor_gasto;
ALTER TABLE campanha ADD INDEX (eleicao_id_eleicao);

ALTER TABLE candidato ADD COLUMN email VARCHAR(100) AFTER cidade;
ALTER TABLE candidato ADD COLUMN senha VARCHAR(100) AFTER email;

ALTER TABLE cargo_interno ADD COLUMN descricao TEXT AFTER tipo_cargo;
ALTER TABLE cargo_interno ADD INDEX (data_inicio);

ALTER TABLE filiado ADD COLUMN senha VARCHAR(100) AFTER fone;
ALTER TABLE filiado ADD COLUMN email VARCHAR(100) AFTER senha;

ALTER TABLE doacao ADD COLUMN comprovante BLOB AFTER forma_pagamento;
ALTER TABLE doacao ADD INDEX (valor_doacao);

ALTER TABLE evento ADD COLUMN descricao TEXT AFTER custo_estimado;
ALTER TABLE evento ADD COLUMN horario TIME AFTER data;

ALTER TABLE filiado_has_evento ADD COLUMN status VARCHAR(50) DEFAULT 'Pendente' AFTER evento_id_evento;
ALTER TABLE filiado_has_evento ADD INDEX (evento_id_evento);


-- Area dos inserts
INSERT INTO eleicao (ano, resultado, descricao) VALUES (2022, 'Vencedor Partido A', 'Eleição presidencial com vitória do Partido A.');
INSERT INTO eleicao (ano, resultado, descricao) VALUES (2024, 'Resultado em andamento', 'Eleição estadual em andamento.');
INSERT INTO eleicao (ano, resultado, descricao) VALUES (2020, 'Vencedor Partido B', 'Eleição municipal marcada por alta participação.');
INSERT INTO eleicao (ano, resultado, descricao) VALUES (2018, 'Vencedor Partido C', 'Eleição geral para cargos federais.');
INSERT INTO eleicao (ano, resultado, descricao) VALUES (2016, 'Vencedor Partido D', 'Eleição com foco em campanhas ambientais.');

INSERT INTO campanha (nome, orcamento_estimado, valor_gasto, data_inicio, data_termino, eleicao_id_eleicao, descricao_extra) 
VALUES ('Campanha Estadual', 500000.00, 250000.00, '2024-01-01', '2024-12-31', 2,'Foco em mídias digitais.');

INSERT INTO campanha (nome, orcamento_estimado, valor_gasto, data_inicio, data_termino, eleicao_id_eleicao, descricao_extra) 
VALUES ('Campanha Federal', 1000000.00, 800000.00, '2023-01-01', '2023-12-31', 1, 'Apoio de movimentos sociais.');

INSERT INTO campanha (nome, orcamento_estimado, valor_gasto, data_inicio, data_termino, eleicao_id_eleicao, descricao_extra) 
VALUES ('Campanha Municipal', 300000.00, 200000.00, '2022-01-01', '2022-12-31', 3,  'Distribuição de materiais impressos.');

INSERT INTO campanha (nome, orcamento_estimado, valor_gasto, data_inicio, data_termino, eleicao_id_eleicao, descricao_extra) 
VALUES ('Campanha Estadual SP', 700000.00, 400000.00, '2020-01-01', '2020-12-31', 4, 'Engajamento em redes sociais.');

INSERT INTO campanha (nome, orcamento_estimado, valor_gasto, data_inicio, data_termino, eleicao_id_eleicao,descricao_extra) 
VALUES ('Campanha Estadual RJ', 600000.00, 300000.00, '2019-01-01', '2019-12-31', 5,  'Parceria com ONGs locais.');

INSERT INTO candidato (nome, cargo_publico, estado, cidade, campanha_id_campanha, email) 
VALUES ('João da Silva', 'Governador', 'SP', 'São Paulo', 1, 'joao.silva@example.com');

INSERT INTO candidato (nome, cargo_publico, estado, cidade, campanha_id_campanha, email) 
VALUES ('Maria Souza', 'Presidente', 'RS', 'Porto Alegre', 2, 'maria.souza@example.com');

INSERT INTO candidato (nome, cargo_publico, estado, cidade, campanha_id_campanha, email) 
VALUES ('Carlos Pereira', 'Prefeito', 'RJ', 'Rio de Janeiro', 3, 'carlos.pereira@example.com');

INSERT INTO candidato (nome, cargo_publico, estado, cidade, campanha_id_campanha, email) 
VALUES ('Ana Costa', 'Governador', 'MG', 'Belo Horizonte', 4, 'ana.costa@example.com');

INSERT INTO candidato (nome, cargo_publico, estado, cidade, campanha_id_campanha, email) 
VALUES ('Paulo Lima', 'Deputado Estadual', 'PR', 'Curitiba', 5, 'paulo.lima@example.com');

INSERT INTO cargo_interno (tipo_cargo, data_inicio, descricao) VALUES ('Presidente', '2020-01-01', 'Liderança principal do partido.');
INSERT INTO cargo_interno (tipo_cargo, data_inicio, descricao) VALUES ('Vice-Presidente', '2021-01-01', 'Apoio à presidência.');
INSERT INTO cargo_interno (tipo_cargo, data_inicio, descricao) VALUES ('Tesoureiro', '2019-05-15', 'Gerenciamento financeiro.');
INSERT INTO cargo_interno (tipo_cargo, data_inicio, descricao) VALUES ('Secretário', '2018-03-20', 'Responsável pela documentação.');
INSERT INTO cargo_interno (tipo_cargo, data_inicio, descricao) VALUES ('Membro do Conselho', '2017-08-10', 'Planejamento estratégico.');

INSERT INTO filiado (cpf, nome, fone, data_filiacao, logradouro, numero, cidade, estado, cargo_interno_id_cargo_interno, email, senha) 
VALUES ('12345678901', 'Pedro Alves', '51999999999', '2020-02-01', 'Rua F', '100', 'Porto Alegre', 'RS', 1, 'pedro@gmail.com', 'senha123');

INSERT INTO filiado (cpf, nome, fone, data_filiacao, logradouro, numero, cidade, estado, cargo_interno_id_cargo_interno, email, senha) 
VALUES ('23456789012', 'Carla Mendes', '21988888888', '2021-06-15', 'Rua G', '200', 'Rio de Janeiro', 'RJ', 2, 'carla@yahoo.com', 'senha456');

INSERT INTO filiado (cpf, nome, fone, data_filiacao, logradouro, numero, cidade, estado, cargo_interno_id_cargo_interno, email, senha) 
VALUES ('34567890123', 'José Nunes', '31977777777', '2019-10-10', 'Rua H', '300', 'Belo Horizonte', 'MG', 3, 'jose@hotmail.com', 'senha789');

INSERT INTO filiado (cpf, nome, fone, data_filiacao, logradouro, numero, cidade, estado, cargo_interno_id_cargo_interno, email, senha) 
VALUES ('45678901234', 'Ana Ramos', '41966666666', '2018-04-20', 'Rua I', '400', 'Curitiba', 'PR', 4,  'ana@outlook.com', 'senha012');

INSERT INTO filiado (cpf, nome, fone, data_filiacao, logradouro, numero, cidade, estado, cargo_interno_id_cargo_interno, email, senha) 
VALUES ('56789012345', 'Rafael Costa', '51955555555', '2020-01-10', 'Rua J', '500', 'Porto Alegre', 'RS', 5,  'rafael@gmail.com', 'senha345');



INSERT INTO doacao (
    origem_doacao, 
    nome_doador, 
    valor_doacao, 
    data, 
    forma_pagamento, 
    comprovante, 
    filiado_id_filiado, 
    campanha_id_campanha
) VALUES
('Pessoa Física', 'João Silva', 1500.00, '2024-01-10', 'Transferência Bancária', NULL, 1, 1);

INSERT INTO doacao (
    origem_doacao, 
    nome_doador, 
    valor_doacao, 
    data, 
    forma_pagamento, 
    comprovante, 
    filiado_id_filiado, 
    campanha_id_campanha
) VALUES
('Empresa', 'Tech Solutions LTDA', 5000.00, '2024-02-15', 'Cartão de Crédito', NULL, 2, 1);

INSERT INTO doacao (
    origem_doacao, 
    nome_doador, 
    valor_doacao, 
    data, 
    forma_pagamento, 
    comprovante, 
    filiado_id_filiado, 
    campanha_id_campanha
) VALUES
('Pessoa Física', 'Maria Oliveira', 200.00, '2024-03-01', 'Pix', NULL, 3, 2);

INSERT INTO doacao (
    origem_doacao, 
    nome_doador, 
    valor_doacao, 
    data, 
    forma_pagamento, 
    comprovante, 
    filiado_id_filiado, 
    campanha_id_campanha
) VALUES
('ONG', 'Green Future', 2500.00, '2024-03-10', 'Boleto', NULL, 4, 3);

INSERT INTO doacao (
    origem_doacao, 
    nome_doador, 
    valor_doacao, 
    data, 
    forma_pagamento, 
    comprovante, 
    filiado_id_filiado, 
    campanha_id_campanha
) VALUES
('Pessoa Física', 'Carlos Andrade', 100.00, '2024-03-20', 'Dinheiro', NULL, 5, 2);




INSERT INTO evento (nome, data, local, filiados_participantes, custo_estimado, descricao) 
VALUES ('Conferência Estadual', '2024-03-10', 'São Paulo', 200, 50000.00,  'Discussão de políticas estaduais.');

INSERT INTO evento (nome, data, local, filiados_participantes, custo_estimado, descricao) 
VALUES ('Reunião Anual', '2024-04-15', 'Rio de Janeiro', 150, 30000.00,  'Prestação de contas do ano.');

INSERT INTO evento (nome, data, local, filiados_participantes, custo_estimado, descricao) 
VALUES ('Workshop de Liderança', '2024-05-20', 'Belo Horizonte', 100, 20000.00, 'Treinamento para novos líderes.');

INSERT INTO evento (nome, data, local, filiados_participantes, custo_estimado, descricao) 
VALUES ('Comício Público', '2024-06-25', 'Curitiba', 500, 80000.00,  'Abertura da campanha eleitoral.');

INSERT INTO evento (nome, data, local, filiados_participantes, custo_estimado, descricao) 
VALUES ('Seminário de Sustentabilidade', '2024-07-30', 'Porto Alegre', 300, 60000.00, 'Debate sobre políticas ambientais.');

INSERT INTO filiado_has_evento (filiado_id_filiado, evento_id_evento,  status) 
VALUES (1, 1,'Confirmado');

INSERT INTO filiado_has_evento (filiado_id_filiado, evento_id_evento,  status) 
VALUES (2, 2,'Confirmado');

INSERT INTO filiado_has_evento (filiado_id_filiado, evento_id_evento,  status) 
VALUES (3, 3, 'Confirmado');

INSERT INTO filiado_has_evento (filiado_id_filiado, evento_id_evento,  status) 
VALUES (4, 4, 'Pendente');

INSERT INTO filiado_has_evento (filiado_id_filiado, evento_id_evento,  status) 
VALUES (5, 5,'Pendente');

-- Area dos updates
UPDATE eleicao
SET descricao = 'Eleição Geral de 2024 - Presidente e Governadores'
WHERE id_eleicao = 1;


UPDATE eleicao
SET resultado = 'Vencedor: João Silva, Partido XYZ', descricao = 'Eleições de 2024 com um grande número de eleitores participando.'
WHERE id_eleicao = 2;


UPDATE campanha
SET descricao_extra = 'Campanha focada em educação e saúde pública.'
WHERE id_campanha = 1;


UPDATE campanha
SET valor_gasto = 120000.00, descricao_extra = 'Campanha bem-sucedida com ênfase em infraestrutura urbana.'
WHERE id_campanha = 3;


UPDATE partido
SET lider = 'José da Silva'
WHERE id_partido = 1;


UPDATE partido
SET lider = 'Maria Oliveira', sigla = 'XYZ'
WHERE id_partido = 2;


UPDATE candidato
SET email = 'joao.silva@xyz.com'
WHERE id_candidato = 1;


UPDATE candidato
SET estado = 'São Paulo', cidade = 'São Paulo'
WHERE id_candidato = 2;


UPDATE cargo_interno
SET descricao = 'Cargo de Diretor Administrativo'
WHERE id_cargo_interno = 1;

UPDATE cargo_interno
SET descricao = 'Cargo de coordenador de eventos', data_inicio = '2023-01-01'
WHERE id_cargo_interno = 2;


UPDATE filiado
SET fone = '11987654321', cidade = 'Rio de Janeiro'
WHERE id_filiado = 1;


UPDATE filiado
SET logradouro = 'Rua A, 123', senha = 'novaSenha123'
WHERE id_filiado = 3;


UPDATE doacao
SET valor_doacao = 2000.00, forma_pagamento = 'Cheque'
WHERE id_doacao = 2;


UPDATE doacao
SET origem_doacao = 'Pessoa Jurídica', data = '2024-07-01'
WHERE id_doacao = 3;


UPDATE evento
SET custo_estimado = 70000.00, descricao = 'Evento com mais palestrantes internacionais'
WHERE id_evento = 2;


UPDATE evento
SET data = '2024-08-10', local = 'São Paulo - Expo Center Norte'
WHERE id_evento = 3;


UPDATE filiado_has_evento
SET status = 'Confirmado'
WHERE filiado_id_filiado = 1 AND evento_id_evento = 1;


UPDATE filiado_has_evento
SET status = 'Cancelado'
WHERE filiado_id_filiado = 3 AND evento_id_evento = 2;


UPDATE historico
SET observacoes = 'Doação realizada com sucesso e recebida em campanha.'
WHERE filiado_id_cpf = '12345678901' AND doacao_id_doacao = 1;


UPDATE historico
SET observacoes = 'Filiado participou ativamente do evento e apoiou o candidato.'
WHERE filiado_id_cpf = '23456789012' AND evento_id_evento = 2;

-- Area dos deletes
DELETE FROM eleicao
WHERE id_eleicao = 1;

DELETE FROM campanha
WHERE id_campanha = 3;

DELETE FROM partido
WHERE sigla = 'XYZ';

DELETE FROM candidato
WHERE id_candidato = 2;

DELETE FROM cargo_interno
WHERE id_cargo_interno = 1;

DELETE FROM filiado
WHERE cpf = '12345678901';

DELETE FROM doacao
WHERE id_doacao = 4;

DELETE FROM evento
WHERE id_evento = 3;

DELETE FROM filiado_has_evento
WHERE filiado_id_filiado = 1 AND evento_id_evento = 2;

DELETE FROM historico
WHERE filiado_id_cpf = '12345678901' AND doacao_id_doacao = 2;

-- Selects
-- Busca eleições cujo resultado contém a palavra 'Vencedor'
SELECT id_eleicao, ano, resultado, descricao
FROM eleicao
WHERE resultado LIKE '%Vencedor%';

-- Exibe eleições, campanhas e partidos associados
SELECT e.id_eleicao, e.ano, c.id_campanha, c.nome, p.sigla
FROM eleicao e
JOIN campanha c ON e.id_eleicao = c.eleicao_id_eleicao
JOIN partido p ON c.eleicao_id_eleicao = p.id_partido
ORDER BY e.ano DESC;

-- Exibe eleições ordenadas por ano em ordem crescente
SELECT id_eleicao, ano, resultado, descricao
FROM eleicao
ORDER BY ano ASC;

-- Exibe o número de campanhas por eleição
SELECT eleicao_id_eleicao, COUNT(id_campanha) AS total_campanhas
FROM campanha
GROUP BY eleicao_id_eleicao;

-- Exibe campanhas e os candidatos associados
SELECT c.id_campanha, c.nome, ca.id_candidato, ca.nome AS nome_candidato
FROM campanha c
JOIN candidato ca ON c.id_campanha = ca.campanha_id_campanha;

-- Exibe as eleições com mais de 3 campanhas associadas
SELECT e.id_eleicao, COUNT(c.id_campanha) AS total_campanhas
FROM eleicao e
JOIN campanha c ON e.id_eleicao = c.eleicao_id_eleicao
GROUP BY e.id_eleicao
HAVING COUNT(c.id_campanha) > 3;

-- Busca partidos cujo nome do líder contém 'Silva'
SELECT id_partido, sigla, lider
FROM partido
WHERE lider LIKE '%Silva%';

-- Exibe os partidos e seus candidatos
SELECT p.id_partido, p.sigla, ca.id_candidato, ca.nome AS nome_candidato
FROM partido p
JOIN candidato ca ON p.id_partido = ca.partido_id_partido;

-- Exibe a média de campanhas por partido
SELECT p.sigla, AVG(campanha_count) AS media_campanhas
FROM partido p
JOIN (SELECT eleicao_id_eleicao, COUNT(id_campanha) AS campanha_count
      FROM campanha
      GROUP BY eleicao_id_eleicao) AS subquery ON p.id_partido = subquery.eleicao_id_eleicao
GROUP BY p.sigla
;
-- Exibe os candidatos ordenados por nome em ordem alfabética
SELECT id_candidato, nome, cargo_publico, estado
FROM candidato
ORDER BY nome ASC;

-- Exibe candidatos e as campanhas em que estão envolvidos
SELECT ca.id_candidato, ca.nome, c.id_campanha, c.nome AS nome_campanha
FROM candidato ca
JOIN campanha c ON ca.campanha_id_campanha = c.id_campanha;

-- Exibe o candidato com o maior ID
SELECT MAX(id_candidato) AS id_candidato_maximo
FROM candidato;

-- Exibe o número de cargos internos por tipo de cargo
SELECT tipo_cargo, COUNT(id_cargo_interno) AS total_cargos
FROM cargo_interno
GROUP BY tipo_cargo;

-- Exibe os cargos internos ordenados pela data de início
SELECT id_cargo_interno, tipo_cargo, data_inicio
FROM cargo_interno
ORDER BY data_inicio DESC;

-- Exibe os tipos de cargos internos com mais de 2 registros
SELECT tipo_cargo, COUNT(id_cargo_interno) AS total
FROM cargo_interno
GROUP BY tipo_cargo
HAVING COUNT(id_cargo_interno) > 2;

-- Busca filiados cujo nome contém 'Maria'
SELECT id_filiado, nome, cpf
FROM filiado
WHERE nome LIKE '%Maria%';

-- Exibe filiados e o partido ao qual pertencem
SELECT f.id_filiado, f.nome, p.sigla
FROM filiado f
JOIN partido p ON f.partido_id_partido = p.id_partido;

-- Exibe o número de filiados por partido
SELECT p.sigla, COUNT(f.id_filiado) AS total_filiados
FROM partido p
JOIN filiado f ON p.id_partido = f.partido_id_partido
GROUP BY p.sigla;

-- Exibe doações ordenadas pelo valor
SELECT id_doacao, nome_doador, valor_doacao, data
FROM doacao
ORDER BY valor_doacao DESC;

-- Busca doações de doadores cujo nome contém 'Carlos'
SELECT id_doacao, nome_doador, valor_doacao
FROM doacao
WHERE nome_doador LIKE '%Carlos%';

-- Exibe o total de doações recebidas
SELECT SUM(valor_doacao) AS total_doacoes
FROM doacao;

-- Exibe eventos e o partido que os organizou
SELECT e.id_evento, e.nome, e.data, p.sigla
FROM evento e
JOIN partido p ON e.fk_id_partido = p.id_partido;

-- Exibe os eventos com custo maior que 50000
SELECT nome, custo_estimado
FROM evento
GROUP BY nome
HAVING custo_estimado > 50000;

-- Exibe a média de custo dos eventos por partido
SELECT p.sigla, AVG(e.custo_estimado) AS media_custos
FROM partido p
JOIN evento e ON p.id_partido = e.fk_id_partido
GROUP BY p.sigla;

-- Exibe filiados e eventos pelos quais estão participando, ordenados por status
SELECT f.id_filiado, e.id_evento, fe.status
FROM filiado_has_evento fe
JOIN filiado f ON fe.filiado_id_filiado = f.id_filiado
JOIN evento e ON fe.evento_id_evento = e.id_evento
ORDER BY fe.status;

-- Exibe o número de filiados por evento
SELECT e.id_evento, COUNT(fe.filiado_id_filiado) AS total_filiados
FROM evento e
JOIN filiado_has_evento fe ON e.id_evento = fe.evento_id_evento
GROUP BY e.id_evento;

-- Exibe os status de filiados em eventos, agrupados por status
SELECT fe.status, COUNT(fe.filiado_id_filiado) AS total_filiados
FROM filiado_has_evento fe
GROUP BY fe.status;

-- Exibe o histórico de doações e eventos ordenados por data
SELECT idhistorico, filiado_id_cpf, doacao_id_doacao, evento_id_evento
FROM historico
ORDER BY idhistorico DESC;

-- Exibe o histórico de filiados com detalhes sobre doações e eventos
SELECT h.idhistorico, h.filiado_id_cpf, d.valor_doacao, e.nome AS evento_nome
FROM historico h
JOIN doacao d ON h.doacao_id_doacao = d.id_doacao
JOIN evento e ON h.evento_id_evento = e.id_evento;

-- Exibe a média de doações associadas a cada filiado
SELECT h.filiado_id_cpf, AVG(d.valor_doacao) AS media_doacoes
FROM historico h
JOIN doacao d ON h.doacao_id_doacao = d.id_doacao
GROUP BY h.filiado_id_cpf;
