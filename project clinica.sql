-- Criar o banco de dados
CREATE DATABASE clinica_maia;
-- Visualizando o banco de dados
SHOW DATABASES;
-- Usando o banco de dados criado
USE clinica_maia;
-- Criando a tabela tb_clinica
CREATE TABLE tb_clinica(
	cli_id INT AUTO_INCREMENT PRIMARY KEY,
	cli_nome VARCHAR(100) NOT NULL,
	cli_cnpj VARCHAR(20) NOT NULL,
	cli_celular VARCHAR(15),
	cli_rua VARCHAR(255),
	cli_numero VARCHAR(10),
	cli_cep VARCHAR(10), 
	cli_bairro VARCHAR(100),
	cli_cidade VARCHAR(100), 
	cli_uf CHAR(2)
);
-- Visualizando a criação da tabela
SHOW TABLES;
-- Criando tb_especialidade
CREATE TABLE tb_especialidade (
    esp_id INT AUTO_INCREMENT PRIMARY KEY,
    esp_nome VARCHAR(100) NOT NULL,
    esp_descricao TEXT
);
-- Criando tb_profissional
CREATE TABLE tb_profissional(
	pro_id INT AUTO_INCREMENT PRIMARY KEY,
    pro_nome VARCHAR(100) NOT NULL,
    pro_cpf VARCHAR(20) NOT NULL,
    pro_crm VARCHAR(20) NOT NULL,
    pro_email VARCHAR(100) NOT NULL,
    pro_telefone VARCHAR(20) NOT NULL,
    pro_situacao BOOLEAN DEFAULT TRUE,
    pro_cliid INT,
    pro_espid INT,
    FOREIGN KEY (pro_cliid) REFERENCES tb_clinica(cli_id),
    FOREIGN KEY (pro_espid) REFERENCES tb_especialidade(esp_id)
);
-- Criando tb_procedimento
CREATE TABLE tb_procedimento(
	proc_id INT AUTO_INCREMENT PRIMARY KEY,
    proc_nome VARCHAR(100) NOT NULL,
    proc_descricao TEXT,
    proc_valor DECIMAL(10,2) NOT NULL
);
-- Criando tb_medicamento
CREATE TABLE tb_medicamento(
	med_id INT AUTO_INCREMENT PRIMARY KEY,
    med_nome VARCHAR(100) NOT NULL,
    med_dosagem DECIMAL(10,2) NOT NULL,
    med_tipo VARCHAR(100) NOT NULL
);
-- Criando tb_convenio
CREATE TABLE tb_convenio(
	con_id INT AUTO_INCREMENT PRIMARY KEY,
    con_nome VARCHAR(100) NOT NULL,
    con_codigo VARCHAR(15) NOT NULL,
    con_status BOOLEAN DEFAULT TRUE
);
-- Criando a tb_paciente
CREATE TABLE tb_paciente(
	pac_id INT AUTO_INCREMENT PRIMARY KEY,
    pac_nome VARCHAR(100),
    pac_cpf VARCHAR(15),
    pac_data_nascimento DATE,
    pac_sexo CHAR(1),
    pac_email VARCHAR(100),
    pac_celular VARCHAR(15),
	pac_rua VARCHAR(255),
	pac_numero VARCHAR(10),
	pac_cep VARCHAR(10), 
	pac_bairro VARCHAR(100),
	pac_cidade VARCHAR(100), 
	pac_uf CHAR(2),
    pac_cliid INT,
    pac_conid INT,
    FOREIGN KEY (pac_cliid) REFERENCES tb_clinica(cli_id),
    FOREIGN KEY (pac_conid) REFERENCES tb_convenio(con_id)
);
-- Criando tb_consulta
CREATE TABLE tb_consulta(
	cons_id INT AUTO_INCREMENT PRIMARY KEY,
    cons_data DATETIME,
    cons_diagnostico TEXT,
    cons_motivo TEXT,
    cons_pacid INT,
    cons_proid INT,
    FOREIGN KEY (cons_pacid) REFERENCES tb_paciente(pac_id),
    FOREIGN KEY (cons_proid) REFERENCES tb_profissional(pro_id)
);
-- Criando tb_prescricao
CREATE TABLE tb_prescricao(
	pres_id INT AUTO_INCREMENT PRIMARY KEY,
    pres_data DATE NOT NULL,
    pres_observacao TEXT NOT NULL,
    pres_consid INT,
    pres_medid INT,
    FOREIGN KEY (pres_consid) REFERENCES tb_consulta(cons_id),
    FOREIGN KEY (pres_medid) REFERENCES tb_medicamento(med_id)
);
-- Criando tb_consulta_procedimento
CREATE TABLE tb_consulta_procedimento(
	copr_id INT AUTO_INCREMENT PRIMARY KEY,
    copr_consid INT,
    copr_procid INT,
    FOREIGN KEY (copr_consid) REFERENCES tb_consulta(cons_id),
    FOREIGN KEY (copr_procid) REFERENCES tb_procedimento(proc_id)
);
-- Criando a tb_fatura
CREATE TABLE tb_fatura(
	fat_id INT AUTO_INCREMENT PRIMARY KEY,
    fat_valor DECIMAL(10,2) NOT NULL,
    fat_data_emissao DATETIME,
    fat_status_pagamento BOOLEAN,
    fat_data_vencimento DATE,
    fat_forma_pagamento VARCHAR(100),
    fat_consid INT,
    FOREIGN KEY (fat_consid) REFERENCES tb_consulta(cons_id)
);
-- Visualizando todas as tabelas
SHOW TABLES;
-- Inserindo dados na tabela tb_convenio
INSERT INTO tb_convenio (con_nome, con_codigo, con_status)
VALUES
('Unimed', 'UNM123', TRUE),
('Bradesco Saúde', 'BRS456', TRUE),
('Amil', 'AML789', TRUE),
('SulAmérica', 'SLA321', TRUE),
('NotreDame Intermédica', 'NDI654', TRUE),
('Particular', 'PTC000', FALSE),
('Prevent Senior', 'PVS111', TRUE),
('Hapvida', 'HPV222', TRUE),
('Santa Casa Saúde', 'STC333', TRUE),
('Porto Seguro Saúde', 'PSS444', TRUE);
	-- Inserindo dados na tabela tb_clinica
INSERT INTO tb_clinica (cli_nome, cli_cnpj, cli_celular, cli_rua, cli_numero, cli_cep, cli_bairro, cli_cidade, cli_uf) VALUES
	('Clínica Maia Unidade Centro', '00.000.000/0001-01', '(11)99999-0001', 'Rua A', '100', '01000-000', 'Centro', 'São Paulo', 'SP'),
	('Clínica Maia Unidade Sul',    '00.000.000/0001-02', '(11)99999-0002', 'Rua B', '200', '01000-001', 'Vila Mariana', 'São Paulo', 'SP'),
	('Clínica Maia Unidade Norte',  '00.000.000/0001-03', '(11)99999-0003', 'Rua C', '300', '01000-002', 'Santana', 'São Paulo', 'SP'),
	('Clínica Maia Unidade Leste',  '00.000.000/0001-04', '(11)99999-0004', 'Rua D', '400', '01000-003', 'Tatuapé', 'São Paulo', 'SP'),
	('Clínica Maia Unidade Oeste',  '00.000.000/0001-05', '(11)99999-0005', 'Rua E', '500', '01000-004', 'Perdizes', 'São Paulo', 'SP'),
	('Clínica Maia Santos',         '00.000.000/0001-06', '(13)98888-0006', 'Av. Oceânica', '10', '11000-000', 'Gonzaga', 'Santos', 'SP'),
	('Clínica Maia Campinas',       '00.000.000/0001-07', '(19)97777-0007', 'Av. Brasil', '1200', '13000-000', 'Cambuí', 'Campinas', 'SP'),
	('Clínica Maia Rio',            '00.000.000/0001-08', '(21)96666-0008', 'Rua das Laranjeiras', '55', '22000-000', 'Laranjeiras', 'Rio de Janeiro', 'RJ'),
	('Clínica Maia BH',             '00.000.000/0001-09', '(31)95555-0009', 'Av. Afonso Pena', '999', '30000-000', 'Centro', 'Belo Horizonte', 'MG'),
	('Clínica Maia Curitiba',       '00.000.000/0001-10', '(41)94444-0010', 'Rua XV', '150', '80000-000', 'Centro', 'Curitiba', 'PR');
	-- Inserindo dados na tabela tb_especialidade
INSERT INTO tb_especialidade (esp_nome, esp_descricao) VALUES
	('Cardiologia', 'Doenças do coração e sistema circulatório'),
	('Ortopedia', 'Doenças e lesões do sistema músculo-esquelético'),
	('Pediatria', 'Cuidado de crianças e adolescentes'),
	('Ginecologia', 'Saúde da mulher'),
	('Dermatologia', 'Pele, cabelos e unhas'),
	('Neurologia', 'Sistema nervoso'),
	('Endocrinologia', 'Hormônios e metabolismo'),
	('Oftalmologia', 'Olhos e visão'),
	('Otorrinolaringologia', 'Ouvidos, nariz e garganta'),
	('Urologia', 'Sistema urinário e masculino');
    -- Inserindo dados na tabela tb_procedimento
INSERT INTO tb_procedimento (proc_nome, proc_descricao, proc_valor) VALUES
	('Consulta clínica', 'Atendimento clínico geral', 200.00),
	('Exame de sangue', 'Hemograma completo', 80.00),
	('Eletrocardiograma', 'ECG de repouso', 150.00),
	('Raio-X', 'Radiografia simples', 120.00),
	('Ultrassom', 'Ultrassonografia abdominal', 250.00),
	('Teste de esforço', 'Ergometria', 300.00),
	('Curativo', 'Curativo simples', 50.00),
	('Retorno', 'Retorno ambulatorial', 100.00),
	('Mapeamento de pele', 'Dermatoscopia', 220.00),
	('Campimetria', 'Exame de campo visual', 180.00);
    -- Inserindo dados na tabela tb_medicamento
INSERT INTO tb_medicamento (med_nome, med_dosagem, med_tipo) VALUES
	('Paracetamol', 750.00, 'Comprimido'),
	('Ibuprofeno', 400.00, 'Comprimido'),
	('Amoxicilina', 500.00, 'Cápsula'),
	('Dipirona', 500.00, 'Gotas'),
	('Omeprazol', 20.00, 'Cápsula'),
	('Losartana', 50.00, 'Comprimido'),
	('Sinvastatina', 20.00, 'Comprimido'),
	('Loratadina', 10.00, 'Comprimido'),
	('Salbutamol', 100.00, 'Spray'),
	('Metformina', 850.00, 'Comprimido');
    -- Inserindo dados na tb_profissional e fazendo relação com tb_clinica e tb_especialidade
INSERT INTO tb_profissional (pro_nome, pro_cpf, pro_crm, pro_email, pro_telefone, pro_situacao, pro_cliid, pro_espid) VALUES
	('Ana Souza',       '000.000.000-01', 'CRM-1001', 'ana@clinica.com',  '(11)4000-1001', TRUE, 1, 1),
	('Bruno Lima',      '000.000.000-02', 'CRM-1002', 'bruno@clinica.com','(11)4000-1002', TRUE, 2, 2),
	('Carla Mendes',    '000.000.000-03', 'CRM-1003', 'carla@clinica.com','(11)4000-1003', TRUE, 3, 3),
	('Diego Rocha',     '000.000.000-04', 'CRM-1004', 'diego@clinica.com','(11)4000-1004', TRUE, 4, 4),
	('Eduarda Pires',   '000.000.000-05', 'CRM-1005', 'edu@clinica.com',  '(11)4000-1005', TRUE, 5, 5),
	('Fernanda Alves',  '000.000.000-06', 'CRM-1006', 'fer@clinica.com',  '(11)4000-1006', TRUE, 6, 6),
	('Gustavo Nunes',   '000.000.000-07', 'CRM-1007', 'gus@clinica.com',  '(11)4000-1007', TRUE, 7, 7),
	('Helena Castro',   '000.000.000-08', 'CRM-1008', 'helena@clinica.com','(11)4000-1008', TRUE, 8, 8),
	('Igor Ferreira',   '000.000.000-09', 'CRM-1009', 'igor@clinica.com', '(11)4000-1009', TRUE, 9, 9),
	('Juliana Martins', '000.000.000-10', 'CRM-1010', 'ju@clinica.com',   '(11)4000-1010', TRUE, 10, 10);
-- Inserirdo dados na tabela tb_paciente com referencia na tb_clinica e tb_convenio
INSERT INTO tb_paciente (pac_nome, pac_cpf, pac_data_nascimento, pac_sexo, pac_email, pac_celular,
                         pac_rua, pac_numero, pac_cep, pac_bairro, pac_cidade, pac_uf, pac_cliid, pac_conid) VALUES
('Mariana Alves',   '111.111.111-11', '1990-05-10', 'F', 'mariana@email.com', '(11)90000-1111', 'Rua 1', '10', '01010-000', 'Bairro 1', 'São Paulo', 'SP', 1, 1),
('Pedro Santos',    '222.222.222-22', '1985-03-22', 'M', 'pedro@email.com',   '(11)90000-2222', 'Rua 2', '20', '01020-000', 'Bairro 2', 'São Paulo', 'SP', 2, 2),
('Larissa Nogueira','333.333.333-33', '2001-12-01', 'F', 'larissa@email.com', '(11)90000-3333', 'Rua 3', '30', '01030-000', 'Bairro 3', 'São Paulo', 'SP', 3, 3),
('Felipe Souza',    '444.444.444-44', '1993-07-19', 'M', 'felipe@email.com',  '(11)90000-4444', 'Rua 4', '40', '01040-000', 'Bairro 4', 'São Paulo', 'SP', 4, 4),
('Daniela Reis',    '555.555.555-55', '1979-11-08', 'F', 'daniela@email.com', '(11)90000-5555', 'Rua 5', '50', '01050-000', 'Bairro 5', 'São Paulo', 'SP', 5, 5),
('Ricardo Lima',    '666.666.666-66', '1988-02-14', 'M', 'ricardo@email.com', '(13)90000-6666', 'Av. Praia', '60', '11010-000', 'Gonzaga', 'Santos', 'SP', 6, 6),
('Paula Moreira',   '777.777.777-77', '1999-09-09', 'F', 'paula@email.com',   '(19)90000-7777', 'Av. Brasil', '70', '13010-000', 'Cambuí', 'Campinas', 'SP', 7, 7),
('Rafael Costa',    '888.888.888-88', '1980-01-31', 'M', 'rafael@email.com',  '(21)90000-8888', 'Rua Limoeiro', '80', '22010-000', 'Laranjeiras', 'Rio de Janeiro', 'RJ', 8, 8),
('Sofia Martins',   '999.999.999-99', '2003-06-02', 'F', 'sofia@email.com',   '(31)90000-9999', 'Av. Afonso Pena', '90', '30010-000', 'Centro', 'Belo Horizonte', 'MG', 9, 9),
('Thiago Pereira',  '123.456.789-00', '1995-10-25', 'M', 'thiago@email.com',  '(41)90000-0000', 'Rua XV', '100', '80010-000', 'Centro', 'Curitiba', 'PR', 10, 10);
-- Inserindo dados tb_consulta com referencia na tb_paciente e tb_profissional
INSERT INTO tb_consulta (cons_data, cons_diagnostico, cons_motivo, cons_pacid, cons_proid) VALUES
('2024-06-10 09:00:00', 'Cefaleia', 'Dor de cabeça', 1, 1),
('2024-06-11 10:30:00', 'Dor lombar', 'Dor nas costas', 2, 2),
('2024-06-12 14:00:00', 'Infecção respiratória', 'Tosse e febre', 3, 3),
('2024-06-13 16:00:00', 'Rotina', 'Check-up anual', 4, 4),
('2024-06-14 11:15:00', 'Dermatite', 'Coceira e manchas', 5, 5),
('2024-06-15 08:45:00', 'Enxaqueca', 'Crises recorrentes', 6, 6),
('2024-06-16 13:00:00', 'Hipertensão', 'Acompanhamento', 7, 7),
('2024-06-17 15:30:00', 'Miopia', 'Avaliação de grau', 8, 8),
('2024-06-18 09:45:00', 'Rinite', 'Espirros constantes', 9, 9),
('2024-06-19 17:00:00', 'Cálculo renal', 'Dor lombar intensa', 10, 10);
-- Inserindo dados na tb_prescricao referenciando tb_consulta e tb_medicamento
INSERT INTO tb_prescricao (pres_data, pres_observacao, pres_consid, pres_medid) VALUES
('2024-06-10', 'Tomar após refeições', 1, 1),
('2024-06-11', 'Tomar com água', 2, 2),
('2024-06-12', 'Completar 7 dias', 3, 3),
('2024-06-13', 'Se dor, usar gotas', 4, 4),
('2024-06-14', 'Jejum de 30min antes', 5, 5),
('2024-06-15', 'Dose noturna', 6, 6),
('2024-06-16', 'Acompanhar exames', 7, 7),
('2024-06-17', '1x ao dia', 8, 8),
('2024-06-18', 'Usar conforme crise', 9, 9),
('2024-06-19', 'Após almoço e jantar', 10, 10);
-- Inserindo dados na tb_consulta_procedimento referenciando tb_consulta e tb_procedimento
INSERT INTO tb_consulta_procedimento (copr_consid, copr_procid) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 8),
(5, 9),
(6, 6),
(7, 1),
(8, 10),
(9, 2),
(10, 5);
-- Inserindo dados tb_fatura referenciando tb_consulta
INSERT INTO tb_fatura (fat_valor, fat_data_emissao, fat_status_pagamento, fat_data_vencimento, fat_forma_pagamento, fat_consid) VALUES
(200.00, '2024-06-10 10:00:00', TRUE,  '2024-06-20', 'Cartão', 1),
(80.00,  '2024-06-11 11:00:00', FALSE, '2024-06-21', 'Boleto', 2),
(150.00, '2024-06-12 15:00:00', TRUE,  '2024-06-22', 'Pix',    3),
(100.00, '2024-06-13 16:30:00', TRUE,  '2024-06-23', 'Cartão', 4),
(220.00, '2024-06-14 12:00:00', FALSE, '2024-06-24', 'Boleto', 5),
(300.00, '2024-06-15 09:00:00', TRUE,  '2024-06-25', 'Cartão', 6),
(200.00, '2024-06-16 13:30:00', TRUE,  '2024-06-26', 'Pix',    7),
(180.00, '2024-06-17 16:00:00', FALSE, '2024-06-27', 'Boleto', 8),
(80.00,  '2024-06-18 10:30:00', TRUE,  '2024-06-28', 'Pix',    9),
(250.00, '2024-06-19 18:00:00', FALSE, '2024-06-29', 'Cartão', 10);
	SHOW DATABASES; -- Consulta os bancos de dados criados
    SHOW TABLES; -- Consulta as tabelas criadas
    SELECT * FROM tb_clinica; -- Consultando os registros desta tabela
    SELECT * FROM tb_especialidade; -- Consultando os registros desta tabela
    -- Consultando todas as colunas de + de uma tabela
    SELECT
		*
    FROM
		tb_profissional
        left join tb_clinica on cli_id = pro_cliid
        left join tb_especialidade on esp_id = pro_espid;
    -- SELECIONANDO TODAS AS COLUNAS DE UMA TABELA;
SELECT * FROM tb_clinica;
SELECT cli_id, cli_nome FROM tb_clinica;
SELECT cli_id, cli_nome, cli_uf FROM tb_clinica;
-- SELECIONANDO TODAS AS TABELAS CRIADAS
SELECT * FROM tb_profissional;
SELECT * FROM tb_especialidade;
SELECT * FROM tb_paciente;
SELECT * FROM tb_consulta;
SELECT * FROM tb_consulta_procedimento;
SELECT * FROM tb_procedimento;
SELECT * FROM tb_prescricao;
SELECT * FROM tb_medicamento;
SELECT * FROM tb_convenio;
SELECT * FROM tb_paciente;
-- Selecionando pacientes do estado de SP e do sexo feminino
SELECT * FROM tb_paciente WHERE pac_uf = 'SP' and pac_sexo = 'F'; 
-- Selecionando pacientes do estado de SP ou do sexo feminino
SELECT * FROM tb_paciente WHERE pac_uf = 'SP' or pac_sexo = 'F';
-- Selecionando pacientes que não são do estado de SP 
SELECT * FROM tb_paciente WHERE pac_uf <> 'SP'; 
-- Selecionando pacientes cujo celular é exatamente '(11)'
SELECT * FROM tb_paciente WHERE pac_celular = '(11)';
-- Selecionando pacientes cujo celular começa com '(11)'
SELECT * FROM tb_paciente WHERE pac_celular like '(11)%';
-- Selecionando pacientes cujo celular contém '(11)' em qualquer parte
SELECT * FROM tb_paciente WHERE pac_celular like '%(11)%';
-- Selecionando pacientes cujo celular termina com '(11)'
SELECT * FROM tb_paciente WHERE pac_celular like '%(11)';
-- Selecionando pacientes cujo celular não começa com '(11)'
SELECT * FROM tb_paciente WHERE pac_celular not like '(11)%';
-- Selecionando pacientes cujo celular não contém '(11)' em nenhuma parte
SELECT * FROM tb_paciente WHERE pac_celular not like '%(11)%';
-- Selecionando pacientes cujo celular não termina com '(11)'
SELECT * FROM tb_paciente WHERE pac_celular not like '%(11)';