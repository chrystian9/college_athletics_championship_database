-- -----------------------------------------------------
-- Schema campeonato_atletica
-- -----------------------------------------------------

CREATE SCHEMA IF NOT EXISTS campeonato_atletica DEFAULT CHARACTER SET utf8 ;
USE campeonato_atletica ;

-- -----------------------------------------------------
-- Table campeonato_atletica.universidade
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS campeonato_atletica.universidade (
  idUniversidade INT(5) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  categoria ENUM('G', 'P') NOT NULL,
  logradouro VARCHAR(50) NOT NULL,
  CEP CHAR(9) NOT NULL,
  cidade VARCHAR(30) NOT NULL,
  estado VARCHAR(2) NOT NULL,
  complemento VARCHAR(6) NULL,
  numero INT(5) NOT NULL,
  referencia VARCHAR(100) NULL,
  bairro VARCHAR(30) NOT NULL,
  PRIMARY KEY (idUniversidade)
);

-- -----------------------------------------------------
-- Table campeonato_atletica.atletica
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS campeonato_atletica.atletica (
  idAtletica INT(5) NOT NULL AUTO_INCREMENT,
  idUniversidade INT(5) NOT NULL,
  nome VARCHAR(75) NOT NULL,
  PRIMARY KEY (idAtletica, idUniversidade)
);

ALTER TABLE campeonato_atletica.atletica ADD CONSTRAINT fk_atletica_universidade 
    FOREIGN KEY (idUniversidade)
    REFERENCES campeonato_atletica.universidade (idUniversidade)
    ON DELETE CASCADE 
    ON UPDATE CASCADE;

-- -----------------------------------------------------
-- Table campeonato_atletica.esporte
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS campeonato_atletica.esporte (
  idEsporte INT(3) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  categoria VARCHAR(30) NOT NULL,
  regras MEDIUMBLOB NULL,
  PRIMARY KEY (idEsporte)
);


-- -----------------------------------------------------
-- Table campeonato_atletica.time
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS campeonato_atletica.time (
  idTime INT(3) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  idUniversidade INT(5) NOT NULL,
  idAtletica INT(5) NOT NULL,
  idEsporte INT(3) NOT NULL,
  PRIMARY KEY (idTime, idAtletica, idUniversidade)
);

ALTER TABLE campeonato_atletica.time ADD CONSTRAINT fk_time_atletica1 
    FOREIGN KEY (idAtletica , idUniversidade)
    REFERENCES campeonato_atletica.atletica (idAtletica , idUniversidade)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT;

ALTER TABLE campeonato_atletica.time ADD CONSTRAINT fk_time_esporte1 
    FOREIGN KEY (idEsporte)
    REFERENCES campeonato_atletica.esporte (idEsporte)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT;

-- -----------------------------------------------------
-- Table campeonato_atletica.pessoa
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS campeonato_atletica.pessoa (
  cpf CHAR(11) NOT NULL,
  nome VARCHAR(50) NOT NULL,
  dataNasc DATE NOT NULL,
  genero ENUM('M', 'F', 'O') NOT NULL,
  logradouro VARCHAR(50) NOT NULL,
  CEP CHAR(9) NOT NULL,
  cidade VARCHAR(30) NOT NULL,
  estado VARCHAR(2) NOT NULL,
  complemento VARCHAR(6) NULL,
  numero INT(5) NOT NULL,
  referencia VARCHAR(100) NULL,
  bairro VARCHAR(30) NOT NULL,
  PRIMARY KEY (cpf)
);


-- -----------------------------------------------------
-- Table campeonato_atletica.torneio
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS campeonato_atletica.torneio (
  idTorneio INT(5) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  data DATE NOT NULL,
  descricao VARCHAR(250) NOT NULL,
  regras MEDIUMBLOB NULL,
  logradouro VARCHAR(50) NOT NULL,
  CEP CHAR(9) NOT NULL,
  cidade VARCHAR(30) NOT NULL,
  estado VARCHAR(2) NOT NULL,
  complemento VARCHAR(6) NULL,
  numero INT(5) NOT NULL,
  referencia VARCHAR(100) NULL,
  bairro VARCHAR(30) NOT NULL,
  PRIMARY KEY (idTorneio)
);


-- -----------------------------------------------------
-- Table campeonato_atletica.disputa
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS campeonato_atletica.disputa (
  idDisputa INT(5) NOT NULL AUTO_INCREMENT,
  idTorneio INT(5) NOT NULL,
  dataHora DATETIME NOT NULL,
  idEsporte INT(3) NOT NULL,
  PRIMARY KEY (idDisputa, idTorneio)
);

ALTER TABLE campeonato_atletica.disputa ADD CONSTRAINT fk_disputa_torneio1
    FOREIGN KEY (idTorneio)
    REFERENCES campeonato_atletica.torneio (idTorneio)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE campeonato_atletica.disputa ADD CONSTRAINT fk_disputa_esporte1
    FOREIGN KEY (idEsporte)
    REFERENCES campeonato_atletica.esporte (idEsporte)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- -----------------------------------------------------
-- Table campeonato_atletica.curso
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS campeonato_atletica.curso (
  idCurso INT(5) NOT NULL AUTO_INCREMENT,
  nome VARCHAR(50) NOT NULL,
  idAtletica INT(5) NOT NULL,
  idUniversidade INT(5) NOT NULL,
  PRIMARY KEY (idCurso, idAtletica)
);

ALTER TABLE campeonato_atletica.curso ADD CONSTRAINT fk_curso_atletica1 
    FOREIGN KEY (idAtletica , idUniversidade)
    REFERENCES campeonato_atletica.atletica (idAtletica , idUniversidade)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- -----------------------------------------------------
-- Table campeonato_atletica.joga
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS campeonato_atletica.joga (
  pessoa_cpf VARCHAR(11) NOT NULL,
  time_idTime INT(3) NOT NULL,
  PRIMARY KEY (pessoa_cpf, time_idTime)
);

ALTER TABLE campeonato_atletica.joga ADD CONSTRAINT fk_pessoa_has_time_time1
    FOREIGN KEY (time_idTime)
    REFERENCES campeonato_atletica.time (idTime)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

ALTER TABLE campeonato_atletica.joga ADD CONSTRAINT fk_pessoa_has_time_pessoa1
    FOREIGN KEY (pessoa_cpf)
    REFERENCES campeonato_atletica.pessoa (cpf)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- -----------------------------------------------------
-- Table campeonato_atletica.telefone
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS campeonato_atletica.telefone (
  telefone VARCHAR(11) NOT NULL,
  pessoa_cpf VARCHAR(11) NOT NULL,
  PRIMARY KEY (telefone, pessoa_cpf)
);

ALTER TABLE campeonato_atletica.telefone ADD CONSTRAINT fk_telefone_pessoa1
    FOREIGN KEY (pessoa_cpf)
    REFERENCES campeonato_atletica.pessoa (cpf)
    ON DELETE CASCADE
    ON UPDATE CASCADE;

-- -----------------------------------------------------
-- Table campeonato_atletica.compete
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS campeonato_atletica.compete (
  time_idTime INT(3) NOT NULL,
  disputa_idDisputa INT(5) NOT NULL,
  disputa_idTorneio INT(5) NOT NULL,
  pontuacao FLOAT NOT NULL,
  PRIMARY KEY (time_idTime, disputa_idDisputa, disputa_idTorneio),
  CONSTRAINT fk_time_has_disputa_time1
    FOREIGN KEY (time_idTime)
    REFERENCES campeonato_atletica.time (idTime)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT fk_time_has_disputa_disputa1
    FOREIGN KEY (disputa_idDisputa , disputa_idTorneio)
    REFERENCES campeonato_atletica.disputa (idDisputa , idTorneio)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Questão c)

-- Inserção Dados
-- Universidade:
INSERT INTO campeonato_atletica.universidade (nome, categoria, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Universidade Federal de Lavras', 'G', ' Av. Doutor Sylvio Menicucci', '37200-900', 'Lavras', 'MG', null, 1001, null, 'Aquenta Sol');
INSERT INTO campeonato_atletica.universidade (nome, categoria, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Universidade Federal de Pernambuco', 'G', 'Av. Prof. Moraes Rego','50670-901', 'Recife', 'PE', null, 1235, null, ' Cidade Universitária');
INSERT INTO campeonato_atletica.universidade (nome, categoria, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Universidade Federal de Minas Gerais', 'G', ' Av. Pres. Antônio Carlos', '31270-901', 'Belo Horizonte', 'MG', null, 6627, null, 'Pampulha');
INSERT INTO campeonato_atletica.universidade (nome, categoria, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Universidade de Itaúna', 'P', 'Rodovia MG 431', '35680-142', 'Itaúna', 'MG', null, 247, null, 'Eldorado');
INSERT INTO campeonato_atletica.universidade (nome, categoria, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Pontifícia Universidade Católica de São Paulo', 'P', 'R. Monte Alegre', '05014-901', 'São Paulo', 'SP', null, 984, null, 'Perdizes');
INSERT INTO campeonato_atletica.universidade (nome, categoria, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Universidade Federal do Rio de Janeiro', 'G', 'Avenida Pedro Calmon', '21941-901', 'Rio de Janeiro', 'RJ', null, 550, null, 'Cidade Universitária da UFRJ');
INSERT INTO campeonato_atletica.universidade (nome, categoria, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Universidade Presbiteriana Mackenzie', 'P', 'R. da Consolação', '01302-907', 'São Paulo', 'SP', null, 930, null, 'Consolação');
INSERT INTO campeonato_atletica.universidade (nome, categoria, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Universidade Federal de São Paulo', 'G', 'R. Sena Madureira', '04021-001', 'São Paulo', 'SP', null, 1500, null, 'Vila Clementino');
INSERT INTO campeonato_atletica.universidade (nome, categoria, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Universidade Estadual de Maringá', 'G', 'Av. Colombo', '87020-900', 'Maringá', 'PR', null, 5790, null, 'Zona 7');
INSERT INTO campeonato_atletica.universidade (nome, categoria, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Universidade Federal do Rio Grande do Sul', 'G','Av. Paulo Gama', '90040-060', 'Porto Alegre', 'RS', null, 100, null, 'Farroupilha');

-- Inserindo Atlética
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Falcone', 1); -- Administração e administração pública
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Tatuzada', 1);
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Xarada', 1);
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Zebu', 1);
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Mafiosa', 2);
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Taurus', 3); -- Medicina Veterinária e Aquacultura 
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Grifo', 3); -- Engenharia
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('AALEB', 3);  -- Letras,  Ciência de Informação e Belas Artes
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('AAFO', 3); -- Odontologia
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('A.A.M.I', 4); -- Medicina
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Atlética Computação - UIT', 4); 
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('A.A.A.O.UIT', 4); -- Odontologia
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('A A.A.A. João Carvalhaes', 5); -- Psicologia
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Pucão', 5); -- Comunicação e Artes
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Atlética Leão XIII', 5); -- Economia 
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('atleticadoursao', 5); -- Relações Internacionais
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Associação Atlética Acadêmica Carlos Chagas', 6); -- Medicina
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('AAA Relações Internacionais', 6);
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('AAAAIQ', 6); -- Química
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Atlética Cláudio Besserman Vianna', 6); -- Comunicação Social
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Atlética de Fisioterapia UFRJ', 6);
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Atlética Arquitetura Mackenzie', 7);
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Associação Atlética Acadêmica João Mendes Júnior', 7); -- Direito
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Associação Atlética Acadêmica Pereira Barretto', 8); -- Medicina
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Associação Atlética Acadêmica Unifesp Osasco', 8); -- EPPEN
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Atlética XI de Setembro', 9); --  Administração, Ciências Contábeis, Ciências Econômicas e Secretariado Executivo Trilíngue
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Associação Atlética de Direito UEM', 9);
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('AAAEUEM - Associação Atlética Acadêmica de Engenharia da UEM', 9);
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Atlética Humanas UEM', 9);
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Associação Atlética Acadêmica XX de Setembro ', 10); -- Medicina
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Atlética AACE', 10); -- Ciencias Economicas
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Associação Atlética da Escola de Administração', 10); -- Administração
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('AAEE - UFRGS', 10); -- Engenharia
INSERT INTO campeonato_atletica.atletica(nome, idUniversidade)
VALUES('Associação Atlética Acadêmica do Campus Olímpico', 10); -- Educação Física, Fisioterapia e Dança

-- Inserção Esportes

INSERT INTO campeonato_atletica.esporte(nome, categoria, regras)
VALUES('Vôlei de Quadra', 'Terrestre', null ); 
INSERT INTO campeonato_atletica.esporte(nome, categoria, regras)
VALUES('Natação', 'Aquático', null); 
INSERT INTO campeonato_atletica.esporte(nome, categoria, regras)
VALUES('Futebol', 'Terrestre', null); 
INSERT INTO campeonato_atletica.esporte(nome, categoria, regras)
VALUES('Basquete', 'Terrestre', null); 
INSERT INTO campeonato_atletica.esporte(nome, categoria, regras)
VALUES('Polo Aquático', 'Aquático', null); 
INSERT INTO campeonato_atletica.esporte(nome, categoria, regras)
VALUES('Handebol', 'Terrestre', null); 

 -- Inserção Time
 
 -- Futebol
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Lobos F.C', 14, 5, 3);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Máfia F.C', 5, 2, 3);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Furacão 2000', 18, 6, 3);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Touros', 6, 3, 3);
-- Vôlei
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Equipe1', 15, 5, 1);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Equipe2',12, 4 , 1);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Equipe3', 20, 6, 1);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Equipe4',8, 3 , 1);
 -- Basquete
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time1', 15, 5, 4);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time2',12, 4 , 4);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time3', 20, 6, 4);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time4',8, 3 , 4);
-- Polo Aquático
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Gigantes de Aço', 28, 9, 5);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Gladiadores', 5, 2, 5);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Titans', 18, 6, 5);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('100Pressão', 6, 3, 5);
-- Handebol
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time5', 1, 1, 6);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time6', 34, 10, 6);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time7', 22, 7, 6);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time8', 24, 8, 6);
-- Natação
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time UIT', 11, 4, 2);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time PUC-SP', 16, 5, 2);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time Unifesp', 25, 8, 2);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time Mackenzie', 23, 7, 2);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time UFRJ', 20, 6, 2);
INSERT INTO campeonato_atletica.time(nome, idAtletica, idUniversidade, idEsporte)
VALUES('Time UFPE', 5, 2, 2);

 -- Inserindo Pessoas
 -- (basquete)
 
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23442444165', 'Maria Clara Ferreira Campos','2000-05-14', 'F', 'Rua São Bento', '01010-001','São Paulo', 'SP', null, 142, null, 'Centro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23293389233', 'Marina Silva Barbosa','1999-06-07', 'F', 'R. Maranhão', '01240-001','São Paulo', 'SP', null, 311, null, 'Higienópolis');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('39321323233', 'Vitória Nakamoto','2001-01-15', 'F', 'R. São Joaquim', '01508-001','São Paulo', 'SP', null, 123, null, 'Liberdade');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12392129394', 'Lívia Santos Barroso','1998-12-06', 'F', 'Rua Baronesa de Itu', '01231-001','São Paulo', 'SP', null, 90, null, 'Santa Cecília');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('13948292390', 'Júlia Alvarenga Prado','1999-11-08', 'F', 'R. Margarida', '01154-030','São Paulo', 'SP', null, 892, null, 'Barra Funda');


INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12231239424', 'Ana Maria Fonseca Souza','1998-05-12', 'F', 'Rua Zezé Lima', '35680-045','Itaúna', 'MG', null, 424, null, 'Centro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('89901294829', 'Bárbara Albuquerque Silva','1999-06-07', 'F', 'R. José Donato', '35680-194','Itaúna', 'MG', null, 314, null, 'Lourdes');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12492940002', 'Jéssica Oliveira Franco','2001-01-15', 'F', 'R José Drumond', '35680-199','Itaúna', 'MG', null, 42, null, 'Nova Vila Mozart');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23113234412', 'Thais Pereira','1998-12-06', 'F', 'R. Bolívia', '35680-274','Itaúna', 'MG', null, 842, null, 'Nogueira Machado');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('29399100032', 'Lara Teixeira Cavalcanti','1999-11-08', 'F', 'Av. Brasil', '35680-287','Itaúna', 'MG', null, 113, null, 'Residencial Morro do Sol');

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('34738478834', 'Luiza Cardoso Oliveira','2001-01-13', 'F', 'Av Jorge Curi', '22775-001','Rio de Janeiro', 'RJ', null, 424, null, 'Barra da Tijuca');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12093949294', 'Emanuelly Fontes Campos','2000-05-23', 'F', 'R. Britânia', '22641-650','Rio de Janeiro', 'RJ', null, 314, null, 'Itanhangá');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('37782888492', 'Gabriela Menezes','2000-02-14', 'F', 'R. Boa Vista', '21043-080','Rio de Janeiro', 'RJ', null, 42, null, 'Alto da Boa Vista');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23094999523', 'Alice Vilela Dias','1998-11-30', 'F', 'R. João de Barros', '22441-100','Rio de Janeiro', 'RJ', null, 842, null, 'Leblon');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('11244299539', 'Luciana Silveira Castro','1999-10-14', 'F', 'R. Barão da Torre', '22411-000','Rio de Janeiro', 'RJ', null, 113, null, 'Ipanema');

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23948293994', 'Luiza Cardoso Oliveira','2000-10-05', 'F', 'R. Ceará', '30150-310','Belo Horizonte', 'MG', null, 123, null, 'Savassi');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('11209994823', 'Emanuelly Fontes Campos','1997-11-16', 'F', 'Rua Stela de Souza', '31030-490','Belo Horizonte', 'MG', null, 324, null, 'Sagrada Família');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('39499923535', 'Gabriela Menezes','2001-07-27', 'F', 'R. Rio Novo', '31210-790','Belo Horizonte', 'MG', null, 143, null, 'Lagoinha');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('10220309423', 'Alice Vilela Dias','1998-09-21', 'F', 'R. Domingos Vieira', '30150-240','Belo Horizonte', 'MG', null, 42, null, 'Santa Efigênia');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('10004992344', 'Luciana Silveira Castro','1999-06-15', 'F', 'R Prof Pimenta da Veiga', '31170-190','Belo Horizonte', 'MG', null, 53, null, 'Cidade Nova');

-- (natação)
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('30942933423', 'Marcelo Silva Campos','1999-06-15', 'M', 'R Ozeas Alves', '35680-401','Itaúna', 'MG', null, 343, null, 'Vila Nazaré');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12030042999', 'Paulo Freitas Júnior','1999-06-15', 'M', 'R Vênus', '03362-060','São Paulo', 'SP', null, 114, null, 'Vila Formosa');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12999423049', 'Pedro Henrique de Faria','1999-06-15', 'M', 'R André Rovai', '06233-150','Osasco', 'SP', null, 567, null, 'Bonfim');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('20938483842', 'Luciano Torres Vilela','1999-06-15', 'M', 'R Pedro Inácio de Araújo', '05386-330','São Paulo', 'SP', null, 45, null, 'Vila São Silvestre');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('10283984939', 'Matheus Amorim Teixeira','1999-06-15', 'M', 'R Décio Vilares', '22041-040','Rio de Janeiro', 'RJ', null, 12, null, 'Copacabana');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('03949393994', 'Gabriel Souza Borges','1999-06-15', 'M', 'R Bruno Maia', '52011-110','Recife', 'PE', null, 892, null, 'Graças');

-- (Futebol)
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12345678910', 'Pedro Santos', '1999-05-17', 'M', 'Rua São Bento', '01010-000','São Paulo', 'SP', null, 45, null, 'Centro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)		
VALUES('13423421341', 'Marcos Silveira', '1999-04-25', 'M', 'Rua Sergio Malheiros','17032-750','Bauru', 'SP', null, 156, null, 'Jardim das Orquídeas');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)		
VALUES('31232434232', 'João Luiz Paiva Lima', '2000-02-11', 'M', 'Rua Dr. Otávio Bechelli', '17064-020','Bauru', 'SP', null, 90, null, 'Vila Bom Jesus');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)		
VALUES('52323404235', 'Marcelo Campos', '2001-05-08', 'M', 'Rua Antônio Ferreira de Menezes','13575-240','São Carlos', 'SP', null, 556, null, 'Jardim Medeiros');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)		
VALUES('16895554353', 'Pedro Castro', '1999-12-31', 'M', 'R. Cesar Hypólito','13572-402','São Carlos', 'SP', null, 112, null, 'Vila Monte Carlo');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)		
VALUES('55544443333', 'João Victor Frazão', '2000-07-18', 'M', 'R. Ipiranga','13400-480','Piracicaba', 'SP', null, 711, null, 'Centro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)		
VALUES('11122233344', 'Matheus Carvalho ', '1998-03-07', 'M', 'Rua Manoel Ferreira Pinto','13420-710','Piracicaba', 'SP', null, 87, null, 'Morumbi');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)		
VALUES('30294394852', 'Lucas Vilela Porto', '1998-09-14', 'M', 'R. João Renato da Silva','14811-163','Araraquara', 'SP', null, 55, null, 'Parque Gramado II');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)		
VALUES('12312353245', 'Yuri Lima', '2001-10-22', 'M', 'Rua 7 de Setembro','14800-390','Araraquara', 'SP', null, 192, null, 'Centro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)		
VALUES('30940324352', 'Carlos Eduardo Costa Silva', '1999-04-12', 'M', 'Rua Anália Franco','14030-170','Ribeirão Preto', 'SP', null, 532, null, 'Vila Virgínia');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)		
VALUES('23449394820', 'Yan Pereira', '1997-05-01', 'M', 'Rua São Francisco','14060-090','Ribeirão Preto', 'SP', null, 75, null, 'Ipiranga');

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('39483944321', 'Arthur Castro', '1998-03-16', 'M', 'Rua Treze de Maio','50100-160','Recife', 'PE', null, 14, null, 'Santo Amaro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('58374329485', 'Davi Oliveira Franco', '1999-12-04', 'M', 'Rua Castro Leão','50610-600','Recife', 'PE', null, 354, null, 'Madalena');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('34829473493', 'Bernardo Faria', '2000-02-13', 'M', 'Rua Jacobina','52011-180','Recife', 'PE', null, 9,null, 'Arruda');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('10298428475', 'Gabriel Souza Silva', '1999-05-08', 'M', 'Rua Sete de Setembro','55004-150','Caruaru', 'PE', null, 58, null, 'Nossa Sra Das Dores');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('11111111111', 'Caio Silveira Júnior', '2001-02-28', 'M', 'R. Santo Agostinho','55010-060','Caruaru', 'PE', null,132, null, 'João Mota');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('22222222222', 'João Pedro Nunes Alves', '2000-07-12', 'M', 'R. Lino Romério','55034-370', 'Caruaru','PE', null, 67, null, 'Caiuca');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23312341231', 'Bryann Nascimento ', '1999-05-08', 'M', 'Avenida Um','55645-000','Gravatá', 'PE', null, 765, null, 'Cruzeiro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('30498234875', 'Wesley Silveira', '2001-09-10', 'M', 'R. São Luis','55642-190','Gravatá', 'PE', null, 812, null, 'Prado');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('21937498732', 'Emanuel Mendonça Garcia', '2001-10-26', 'M', 'Rua Carlos Lima Cavalcante','53040-125','Gravatá', 'PE', null, 324, null, 'Norte');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('01390239484', 'Leonardo Alcântara Lopes', '1997-08-01', 'M', 'Av. Presidente Getúlio Vargas','54505-971','Cabo de Santo Agostinho', 'PE', null, 22, null, 'Centro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12849308239', 'Guilherme Teixeira', '1997-04-012', 'M', 'Rua Cinquenta e Cinco','54530-100','Cabo de Santo Agostinho', 'PE', null, 10, null, 'Garapu');
                
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('34983920111', 'Tomás Castro', '1998-03-04', 'M', 'R. Andiara','21051-000','Rio de Janeiro', 'RJ', null, 231, null, 'Higienópolis');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('90239109023', 'Nathan Castro', '1998-03-04', 'M', 'R. Andiara','21051-000','Rio de Janeiro', 'RJ', null, 231, null, 'Higienópolis');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('99999999999', 'Bruno Mendes', '2000-02-16', 'M', 'Rua Miguel Ângelo','20785-222','Rio de Janeiro', 'RJ', null, 8, null, 'Maria da Graça');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('48758748234', 'Marcelo Novaes Campus', '1999-05-10', 'M', 'Rua Claimundo de Melo','20740-323','Rio de Janeiro', 'RJ', null, 77, null, 'Piedade');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('20203032934', 'Michel Lima', '2001-02-18', 'M', 'R. Luís de Camões','Resende', '27534-060', 'RJ', null, 119, null, 'Alambari');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23948558342', 'João Matheus Silva Prado', '2000-07-07', 'M', 'Av. Riachuelo', '27510-132','Resende', 'RJ', null, 674, null, 'Nova Liberdade');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12903842342', 'Davi Oliveira Júnior', '1999-05-02', 'M', 'Rua Washington Luis', '27520-290','Resende', 'RJ', null, 70, null, 'Vila Julieta');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23984930203', 'Márcio Lombardi Marques', '2001-09-15', 'M', 'Rua Josefina Tavares Barbosa', '27511-640','Resende', 'RJ', null, 83, null, 'Barbosa Lima');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23049349895', 'Paulo de Jesus', '2001-10-08', 'M', 'Rua Sao João', '24320-340','Niterói', 'RJ', null, 32, null, 'Centro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('28372378123', 'Luciano Mendonça Santos', '1997-08-02', 'M', 'Rua Cadete Xavier Leal', '24020-220','Niterói', 'RJ', null, 625, null, 'Centro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12039910384', 'Gustavo Pinheiro', '1997-04-14', 'M', 'Rua Nossa Sra Auxiliadora', '24240-680','Niterói', 'RJ', null, 14, null, 'Santa Rosa');

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('34873843234', 'Kaique Rodrigues', '1999-03-05', 'M', 'R. Girassol','30451-726','Belo Horizonte', 'MG', null, 545, null, 'Jardim Vitória');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('90239109063', 'Miguel Henrique Martins', '2000-07-12', 'M', 'R. Otávio Carneiro', '31060-450','Belo Horizonte', 'MG', null, 239, null, 'Boa Vista');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('77777777777', 'João Guilherme Rocha Santos', '2000-02-10', 'M', 'Rua Dr. Júlio Otaviano Ferreira', '31170-200','Belo Horizonte', 'MG', null, 98, null, 'Cidade Nova');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('53481403888', 'Victor Müller Schmitz', '1999-05-24', 'M', 'R. Ipanema', '31360-330','Belo Horizonte', 'MG', null, 234, null, 'Dom Bosco');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12093493829', 'Luiz Araújo Paiva', '2001-02-27', 'M', 'R. Júlio Nogueira', '35501-327','Divinópolis', 'MG', null, 113, null, 'Bela Vista');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('29318109939', 'Francisco Magalhães', '1997-07-30', 'M', 'R. Itambé', '35502-041','Divinópolis', 'MG', null, 67, null, 'Ipiranga');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23988484842', 'Marcelo Ribeiro Melo', '1999-05-11', 'M', 'R. 21 de Abril', '35500-010','Divinópolis', 'MG', null, 750, null, 'Centro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12093943555', 'Breno Vieira Machado Costa', '2001-09-23', 'M', 'Rua Jesus Jota','35500-459','Divinópolis', 'MG', null, 843, null, 'Interlagos');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12492948582', 'João Vítor Menezes', '2001-10-14', 'M', 'Av. Ortízio Borges', '38408-263','Uberlândia', 'MG', null, 3, null, 'Santa Mônica');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('45464567959', 'Lucas Nascimento', '1997-08-22', 'M', 'Av. João Pinheiro', '38400-124','Uberlândia', 'MG', null, 623, null, 'Centro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('24231291434', 'João Lucas Batista', '1997-04-15', 'M', 'R. Platão', '38408-540','Uberlândia', 'MG', null, 23, null, 'Lagoinha');        

-- (vôlei)
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23487382133', 'Gabriel Souza Teixeira', '1999-11-15', 'M', 'Av J K de Oliveira', '35585-000','Pimenta', 'MG', null, 131, null, 'Centro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('93499204999', 'Wellington Menezes', '2000-02-10', 'M', 'R. Raul Laudares', '35585-000','Pimenta', 'MG', null, 43, null, 'Santa Maria');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('33311155395', 'Rodrigo Alves Campos', '2000-08-13', 'M', 'R. José Batista da Costa','35585-000','Pimenta', 'MG', null, 423, null, 'Novo Horizonte');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('45593959995', 'Álvaro Pontes', '1999-07-25', 'M', 'R. Primeiro de Janeiro','35585-000','Pimenta', 'MG', null, 93, null, 'Antônio Lara');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('31113331233', 'Fabiano Albuquerque de Jesus', '2001-01-04', 'M', 'R Carlos Chagas', '37925-000','Piumhi', 'MG', null, 147, null, 'Nova Piumhi'); 
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('47837778234', 'Maurício Prado Júnior', '1997-03-30', 'M', 'R. Higino Leonel','37925-000','Piumhi', 'MG', null, 534, null, 'Centro');

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23312333231', 'Daniel Pinheiro', '1999-12-23', 'M', 'R. Francisco Barcelos', '38065-330' ,'Uberaba', 'MG', null, 123, null, 'Fabrício');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('83942939481', 'Cristiano Campos Pontes', '2000-09-10', 'M', 'Av.Alexandre Barbosa', '38060-200','Uberaba', 'MG', null, 485, null, 'Mercês');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('44234124423', 'Rafael Cardoso Lima', '2000-02-10', 'M', 'Rua Nacib Cury', '38060-380','Uberaba', 'MG', null, 939, null, 'São Sebastião');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('39482093948', 'Leonardo Alves', '1999-08-20', 'M', 'R. Tobias Rosa', '38025-370','Uberaba', 'MG', null, 25, null, 'Abadia');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('33424334244', 'Iago Nogueira', '2001-12-11', 'M', 'R. Juracy da Silva Diniz', '32043-010','Contagem', 'MG', null, 43, null, 'Alvorada');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('82378788842', 'Márcio Campos Bastos', '1997-04-30', 'M', 'R. Francisco Camargos','32042-260' ,'Contagem', 'MG', null, 52, null, 'Vera Cruz');
        

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23129399413', 'Ivan Torres Carvalho', '1999-06-15', 'M', 'R. Oliva Maia', '28065-330' ,'Rio de Janeiro', 'RJ', null, 312, null, 'Madureira');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12938000239', 'Caio Frade Lopez', '2000-05-07', 'M', 'R. Gustavo Martins', '21220-480','Rio de Janeiro', 'RJ', null, 234, null, 'Irajá');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12093884113', 'Rodrigo Porto', '2000-04-11', 'M', 'Rua das Laranjeiras', '22240-004','Rio de Janeiro', 'RJ', null, 239, null, 'Laranjeiras');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('20938129888', 'Leandro Nogueira Pontes', '1999-09-12', 'M', 'Av. Rui Barbosa', '22250-903','Rio de Janeiro', 'RJ', null, 59, null, 'Flamengo');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('29387472834', 'Thiago Santos Teixeira', '2001-12-08', 'M', 'R. Tavares Bastos', '22221-030','Rio de Janeiro', 'RJ', null, 834, null, 'Catete');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('03948293934', 'Wesley Vieira Bastos', '1997-10-25', 'M', 'R. Campos da Paz','20250-460' ,'Rio de Janeiro', 'RJ', null, 492, null, 'Rio Comprido');        

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('39487238211', 'Lucas Macedo Vargas', '1998-12-10', 'M', 'R. Monte Sião', '30240-050' ,'Belo Horizonte', 'MG', null, 123, null, 'Serra');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('10938849291', 'João Pedro Santos Figueiredo', '2001-04-13', 'M', 'R. Paulo de Souza', '30250-410','Belo Horizonte', 'MG', null, 423, null, 'Fazendinha');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('10298848291', 'Alan Arantes', '1996-03-19', 'M', 'Rua Lavras', '30330-010','Belo Horizonte', 'MG', null, 555, null, 'São Pedro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('02004122123', 'Daniel Souza Carvalho', '1999-12-25', 'M', 'Rua Sessenta e Oito', '32070-200','Contagem', 'MG', null, 664, null, 'Tropical');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('39919999424', 'Thomas Schneider Maurer', '2000-07-30', 'M', 'R. Pérola', '32071-163','Contagem', 'MG', null, 90, null, 'Santa Luzia');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('39111134445', 'Samuel Rossi', '1997-11-22', 'M', 'R. Joaquim Rocha','32017-270' ,'Contagem', 'MG', null, 24, null, 'Betânia');

-- Handebol

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('39999422134', 'Michelle Karine Costa','2001-12-20', 'F', 'R. Expedicionário Sebastião Urbano', '37200-000','Lavras', 'MG', null, 1223, null, 'Dos Ipês');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('22233314533', 'Maria Clara Teixeira','1997-11-16', 'F', 'R. Dr. Samuel Gamomm', '37209-266','Lavras', 'MG', null, 329, null, 'Esplanada');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('09093452245', 'Vanessa Barbosa Couto','2000-12-06', 'F', 'R. Avelino Giarola', '37200-000','Lavras', 'MG', null, 124, null, 'Nilton Teixeira');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('39889233456', 'Ana Júlia Alvarenga Pedroso','1998-03-13', 'F', 'R. Ana Sáles', '37200-000','Lavras', 'MG', null, 87, null, 'Dona Flor');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12495829345', 'Lílian Milani Ricci','2000-05-15', 'F', 'R Floriano Peixoto', '37280-000','Candeias', 'MG', null, 777, null, 'Centro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('38888239582', 'Yasmin Rodrigues Alves','2001-08-12', 'F', 'R. José Caetano de Faria', '37280-000','Candeias', 'MG', null, 634, null, 'Jardim Paraíso');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23091928842', 'Bruna Tavares Rocha','2000-02-24', 'F', 'R. Doná Ritinha', '37280-000','Candeias', 'MG', null, 92, null, 'Alto do Cruzeiro');

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('38472888842', 'Melissa Borges','2001-12-20', 'F', 'R. Santo Guerra', '90240-170','Porto Alegre', 'RS', null, 234, null, 'Navegantes');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12009490200', 'Olívia Machado Porto','1997-11-16', 'F', 'Av. Agostini', '90460-040','Porto Alegre', 'RS', null, 355, null, 'Petrópolis');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('78784994902', 'Lorena Faria Galani','2000-12-06', 'F', 'Rua Serra da Mocidade', '91150-440','Porto Alegre', 'RS', null, 190, null, 'Sarandi');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('30300993000', 'Juliana Costa Souza','1998-03-13', 'F', 'Av. Cascais', '91230-210','Porto Alegre', 'RS', null, 45, null, 'Passo das Pedras');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12059999420', 'Ana Luiza Mendonça','2000-05-15', 'F', 'Rua Toropi', '90470-480','Porto Alegre', 'RS', null, 7, null, 'Petrópolis');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('34059992005', 'Fernanda Laudares Carvalho','2001-08-12', 'F', 'R. Paulino Chaves', '37280-000','Porto Alegre', 'RS', null, 78, null, 'Santo Antônio');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('11233329994', 'Nara Menezes Campus','2000-02-24', 'F', 'Av. Natal', '90880-110','Porto Alegre', 'RS', null, 23, null, 'Medianeira');

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('34938299999', 'Dayane Mello Santos','2002-10-12', 'F', 'R. Dr. Carlos GUimarães', '13024-200','Campinas', 'SP', null, 523, null, 'Cambuí');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('10299922888', 'Alana Duarte Lopez','1998-05-10', 'F', 'R. Presidente Alves', '13091-107','Campinas', 'SP', null, 993, null, 'Jardim Flamboyant');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('09828854441', 'Lívia Drummond Lima','2000-09-14', 'F', 'Rua Eduardo Nogueira', '13091-607','Campinas', 'SP', null, 482, null, 'Vila Madalena');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12093889123', 'Clara Cavalcanti','1999-02-15', 'F', 'R. São Salvador', '13076-540','Campinas', 'SP', null, 394, null, 'Rua São Salvador');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('33204999244', 'Valentina Borges Cardoso','1997-07-08', 'F', 'Rua Ary Barroso', '13076-110','Campinas', 'SP', null, 11, null, 'Taquaral');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('09882999123', 'Letícia Tavares','2000-04-12', 'F', 'R. Ramiro dos Santos', '13092-560','Campinas', 'SP', null, 98, null, 'Bairro das Palmeiras');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('11233332424', 'Emilly Frazão','1997-02-11', 'F', 'R. Santa Isabel', '13040-056','Campinas', 'SP', null, 3, null, 'Jardim Nova Europa');

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23099000239', 'Ana Maria Lombardi Gomes','2001-12-20', 'F', 'R. Caparaó', '03364-020','São Paulo', 'SP', null, 238, null, 'Vila Formosa');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('77328492348', 'Alice Queiroz Paiva','1997-11-16', 'F', 'R. Falanto', '03385-030','São Paulo', 'SP', null, 293, null, 'Capão da Embira');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('88239499988', 'Karine Almeida Dias','2000-12-06', 'F', 'Rua Francisco Xavier de Barros', '18081-210','Sorocaba', 'SP', null, 45, null, 'Jardim das Acácias');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('93924083999', 'Giulia Rossini','1998-03-13', 'F', 'R. Odorico Vieira', '18081-035','Sorocaba', 'SP', null, 583, null, 'Vila Gabriel');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12931123311', 'Maria Ribeiro Pontes','2000-05-15', 'F', 'R. Miguel Couto', '18013-220','Sorocaba', 'SP', null, 12, null, 'Vila Arruda');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('43742934922', 'Luciana Kim','2001-08-12', 'F', 'R. Solon', '01127-010','São Paulo', 'SP', null, 93, null, 'Bom Retiro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('44429399200', 'Raquel Nogueira Rosa','2000-02-24', 'F', 'Rua Moreira', '02468-080 ','São Paulo', 'SP', null, 23, null, 'Imirim');

-- Polo Aquático

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('30020020411', 'Fabrício Torres Alvarenga', '1999-02-05', 'M', 'Rua Sen Accioly Filho', '87080-480', 'Maringá', 'PR', null, 211, null, 'Vila Santa Izabel');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('03993942212', 'Gabriel Zimmer', '2000-11-16', 'M', 'R. La Paz', '87040-260', 'Maringá', 'PR', null, 388, null, 'Vila Morangueiro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('01099311244', 'Yuri Carvalho Lopez', '1998-10-31', 'M', 'Rua Ângelo Vinha', '87083-065', 'Maringá', 'PR', null, 34, null, 'Parque Alvamar');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('88848289994', 'Henrique Teixeira', '2002-09-14', 'M', 'Rua Frei Caneca', '87047-030', 'Maringá', 'PR', null, 902, null, 'Jardim Liberdade');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('55345523451', 'Rafael Pontes Vilela', '1999-08-29', 'M', 'Rua Espinela', '87083-062', 'Maringá', 'PR', null, 533, null, 'Jardim Real');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('99203004123', 'Paulo Machado Campos', '2000-01-05', 'M', 'Rua Acauã', '87075-230', 'Maringá', 'PR', null, 781, null, 'Jardim dos Pássaros');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('32934221234', 'Victor Fischer', '1997-05-05', 'M', 'R Rui Barbosa', '87020-090', 'Maringá', 'PR', null, 20, null, 'Jardim Ipiranga');

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('39902399941', 'Bruno Garcia Campos', '1998-03-12', 'M', 'Rua Miguel Leão', '50680-190', 'Recife', 'PE', null, 224, null, 'Iputinga');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('11293939991', 'Renato Torres', '2000-10-20', 'M', 'R. Maria Quitéria', '50731-040', 'Recife', 'PE', null, 123, null, 'Cordeiro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('91200042394', 'Juliano Faria Carvalho', '1998-08-30', 'M', 'R. Amélia', '52011-050', 'Recife', 'PE', null, 99, null, 'Graças');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23030449294', 'Caio Vieira Rossi', '2001-11-06', 'M', 'R. Lopes de Carvalho', '50610-170', 'Recife', 'PE', null, 342, null, 'Madalena');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('29299292941', 'Bernardo Barros', '2002-07-14', 'M', 'Rua Cosme Viana', '50820-580', 'Recife', 'PE', null, 3492, null, 'Afogados');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('10949912988', 'Pedro Carvalho Garcia', '1999-03-15', 'M', 'R. Vermelha', '50710-220', 'Recife', 'PE', null, 399, null, 'Torre');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23999420000', 'Marcos Henrique Silva', '1997-09-25', 'M', 'R da Coragem', '52041-580', 'Recife', 'PE', null, 14, null, 'Encruzilhada');

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23988488888', 'Marlos Silva Amaral', '1999-02-10', 'M', 'Rua Franz Weissman', '22775-051', 'Rio de Janeiro', 'RJ', null, 34, null, 'Jacarepaguá');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('12313123123', 'Ricardo Barros', '2001-07-03', 'M', 'Av. Olga Nobre', '22750-140', 'Rio de Janeiro', 'RJ', null, 930, null, 'Anil');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('29593920008', 'Lucas Castro Menezes', '1995-11-28', 'M', 'R. Rio do Sul', '22720-110', 'Rio de Janeiro', 'RJ', null, 12, null, 'Taquara');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('10101039482', 'Bruno Silveira', '2002-04-13', 'M', 'Rua da Chita', '21862-170', 'Rio de Janeiro', 'RJ', null, 48, null, 'Bangu');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('20000139921', 'Kaique Souza Silva', '2001-09-15', 'M', 'Rua Artur Chelles', '23094-270', 'Rio de Janeiro', 'RJ', null, 399, null, 'Santíssimo');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('19088288399', 'Paulo Pontes Figueiredo', '1998-06-20', 'M', 'Rua Serra Dourada', '22785-200', 'Rio de Janeiro', 'RJ', null, 900, null, 'Vargem Grande');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('58384729483', 'Marcelo Faria Júnior', '1999-12-13', 'M', 'Rua Goianinha', '22780-760', 'Rio de Janeiro', 'RJ', null, 12, null, 'Curicica');

INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('98237238794', 'Thalles Rossi Almeida', '2000-03-13', 'M', 'Rua Juqueri', '33130-160', 'Belo Horizonte', 'MG', null, 14, null, 'Santa Luzia');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('02944884829', 'João Lucas Nunes Alvarenga', '2001-11-24', 'M', 'Rua Teodomiro Pereira', '31170-500', 'Belo Horizonte', 'MG', null, 340, null, 'União');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('01020304892', 'Cristiano Machado Arantes', '1999-01-23', 'M', 'Rua Mantiqueira', '30622-700', 'Belo Horizonte', 'MG', null, 598, null, 'Santa Ines');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('23848728389', 'Juliano Souza Peixoto', '2000-07-29', 'M', 'Rua Genoveva de Souza', '31030-220', 'Belo Horizonte', 'MG', null, 600, null, 'Sagrada Família');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('59348255524', 'Matheus Costa', '1998-07-12', 'M', 'Rua dos Tupinambás', '30120-903', 'Belo Horizonte', 'MG', null, 73, null, 'Centro');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('02398900042', 'Pedro Henrique Nascimento Dias', '1997-10-25', 'M', 'Rua Bocaiúva', '31010-32', 'Belo Horizonte', 'MG', null, 159, null, 'Santa Teresa');
INSERT INTO campeonato_atletica.pessoa(cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('30949299394', 'Marcelo Faria Júnior', '1999-12-13', 'M', 'R. Padre Café', '30285-340', 'Belo Horizonte', 'MG', null, 64, null, 'Saudade');

-- Inserção torneio
INSERT campeonato_atletica.torneio(nome, data, descricao, regras, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Torneio de Futebol', '2021-10-20', 'O  Torneio de Futebol dos Jogos das Atléticas do Brasil
												terá início no dia 20 de outubro de
                                                2021 e contará com a participação de 4 times.', 
	   null, 'Avenida Prof. Almeida Prado', '05508-900', 'São Paulo', 'SP', null,
       1280, 'Campus da Universidade de São Paulo', 'Butantã');


INSERT campeonato_atletica.torneio(nome, data, descricao, regras, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Torneio de Handebol', '2021-10-22', 'O  Torneio de Handebol dos Jogos das Atléticas do Brasil
												terá início no dia 22 de outubro de
                                                2021 e contará com a participação de 4 times.', 
	   null, 'Avenida Prof. Almeida Prado', '05508-900', 'São Paulo', 'SP', null,
       1280, 'Campus da Universidade de São Paulo', 'Butantã');

INSERT campeonato_atletica.torneio(nome, data, descricao, regras, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Torneio de Polo Aquático', '2021-10-21', 'O  Torneio de Polo Aquático dos Jogos das Atléticas do Brasil
												terá início no dia 21 de outubro de
                                                2021 e contará com a participação de 4 times.', 
	   null, 'Avenida Prof. Almeida Prado', '05508-900', 'São Paulo', 'SP', null,
       1280, 'Campus da Universidade de São Paulo', 'Butantã');
       
INSERT campeonato_atletica.torneio(nome, data, descricao, regras, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Torneio de Basquete', '2021-10-21', 'O  Torneio de Basquete dos Jogos das Atléticas do Brasil
												terá início no dia 21 de outubro de
                                                2021 e contará com a participação de 4 times.', 
	   null, 'Avenida Prof. Almeida Prado', '05508-900', 'São Paulo', 'SP', null,
       1280, 'Campus da Universidade de São Paulo', 'Butantã');

INSERT campeonato_atletica.torneio(nome, data, descricao, regras, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Torneio de Vôlei', '2021-10-20', 'O  Torneio de Vôlei dos Jogos das Atléticas do Brasil
												terá início no dia 20 de outubro de
                                                2021 e contará com a participação de 4 times.', 
	   null, 'Avenida Prof. Almeida Prado', '05508-900', 'São Paulo', 'SP', null,
       1280, 'Campus da Universidade de São Paulo', 'Butantã');
       
INSERT campeonato_atletica.torneio(nome, data, descricao, regras, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro)
VALUES('Torneio de Natação', '2021-10-27', 'O  Torneio de Natação dos Jogos das Atléticas do Brasil
												terá início no dia 27 de outubro de
                                                2021 e contará com a participação de 6 times.', 
	   null, 'Avenida Prof. Almeida Prado', '05508-900', 'São Paulo', 'SP', null,
       1280, 'Campus da Universidade de São Paulo', 'Butantã');

-- Inserção disputa
INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(13245, '2021-10-20 15:00:00', 1, 3);   
INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(22213, '2021-10-21 12:30:00', 1, 3);         
INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(41234, '2021-10-23 19:00:00', 1, 3); 

INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(93942, '2021-10-22 14:30:00', 2, 6);   
INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(12441, '2021-10-22 10:00:00', 2, 6);         
INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(32094, '2021-10-24 18:15:00', 2, 6); 

INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(23041, '2021-10-20 12:30:00', 3, 5);   
INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(39492, '2021-10-21 13:00:00', 3, 5);         
INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(01249, '2021-10-22 09:00:00', 3, 5);  

INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(32492, '2021-10-21 14:00:00', 4, 4);   
INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(92099, '2021-10-22 16:00:00', 4, 4);         
INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(83223, '2021-10-25 20:30:00', 4, 4);  

INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(23929, '2021-10-23 17:45:00', 5, 1);   
INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(44144, '2021-10-24 10:00:00', 5, 1);         
INSERT campeonato_atletica.disputa(idDisputa, dataHora, idTorneio, idEsporte) 
VALUES(98883, '2021-10-26 21:30:00', 5, 1);   

INSERT INTO campeonato_atletica.curso(nome, idAtletica, idUniversidade)
VALUES('Administração Pública', 1, 1),
    ('Agronomia', 2, 1),
    ('ABI - Engenharias', 3, 1),
    ('Engenharia Agrícola', 3, 1),
    ('Engenharia Civil', 3, 1),
    ('Engenharia de Controle e Automação', 3, 1),
    ('Engenharia Física', 3, 1),
    ('Engenharia Mecânica', 3, 1),
    ('Engenharia Química', 3, 1),
    ('Engenharia Florestal', 3, 1),
    ('Engenharia de Materias', 3, 1),
    ('Engenharia de Alimentos', 3, 1),
    ('Engenharia Ambiental e Sanitária', 3, 1),
    ('Zootecnia', 4, 1),
    ('Medicina', 5, 2),
    ('Medicina Veterinaria', 6, 3),
    ('Aguacultura', 6, 3),
    ('Engenharia', 7, 3),
    ('Letras', 8, 3),
    ('Ciência da Informação', 8, 3),
    ('Belas Artes', 8, 3),
    ('Odontologia', 9, 3),
    ('Medicina', 10, 4),
    ('Ciência da Computação', 11, 4),
    ('Odontologia', 12, 4),
    ('Psicologia', 13, 5),
    ('Comunicação', 14, 5),
    ('Artes', 14, 5),
    ('Economia', 15, 5),
    ('Relações Internacionais', 16, 5),
    ('Medicina', 17, 6),
    ('Relações Internacionais', 18, 6),
    ('Química', 19, 6),
    ('Comunicação Social', 20, 6),
    ('Fisioterapia', 21, 6),
    ('Arquitetura', 22, 7),
    ('Direito', 23, 7),
    ('Medicina', 24, 8),
    ('EPPEN', 25, 8),
    ('Administração', 26, 9),
    ('Ciências Contábeis', 26, 9),
    ('Ciências Econômicas', 26, 9),
    ('Secretariado Executivo Trilíngue', 26, 9),
    ('Direito', 27, 9),
    ('Engenharia', 28, 9),
    ('Artes Cênicas', 29, 9),
    ('Artes Visuais', 29, 9),
    ('Ciências Sociais', 29, 9),
    ('Filosofia', 29, 9),
    ('Geografia', 29, 9),
    ('História', 29, 9),
    ('Letra', 29, 9),
    ('Música', 29, 9),
    ('Pedagogia', 29, 9),
    ('Medicina', 30, 10),
    ('Ciências Economicas', 31, 10),
    ('Administração', 32, 10),
    ('Engenharia', 33, 10),
    ('Educação Física', 34, 10),
    ('Fisioterapia', 34, 10),
    ('Dança', 34, 10);
    
INSERT INTO campeonato_atletica.telefone(telefone, pessoa_cpf)
VALUES('11904289401', '23442444165'),
    ('11946930894', '23293389233'),
    ('11981692793', '39321323233'),
    ('11914636932', '12392129394'),
    ('11957747812', '13948292390'),
    ('11924238339', '12231239424'),
    ('11919885393', '89901294829'),
    ('11949760508', '12492940002'),
    ('11996516654', '23113234412'),
    ('11989641432', '29399100032'),
    ('11925202372', '34738478834'),
    ('11950490040', '12093949294'),
    ('11983368697', '37782888492'),
    ('11902520070', '23094999523'),
    ('11944897783', '11244299539'),
    ('11967513945', '23948293994'),
    ('11965180553', '11209994823'),
    ('11940383441', '39499923535'),
    ('11904089175', '10220309423'),
    ('11903455749', '10004992344'),
    ('11935005211', '30942933423'),
    ('11921595373', '12030042999'),
    ('11994702569', '12999423049'),
    ('11926956446', '20938483842'),
    ('11936465785', '10283984939'),
    ('11961021538', '03949393994'),
    ('11978722864', '12345678910'),
    ('11933665125', '13423421341'),
    ('11945174088', '31232434232'),
    ('11968703139', '52323404235'),
    ('11901513940', '16895554353'),
    ('11901979820', '55544443333'),
    ('11915634035', '11122233344'),
    ('11935723064', '30294394852'),
    ('11969133082', '12312353245'),
    ('11925898178', '30940324352'),
    ('11959961403', '23449394820'),
    ('11989018476', '39483944321'),
    ('11928175017', '58374329485'),
    ('11956478058', '34829473493'),
    ('11931176240', '10298428475'),
    ('11953377389', '11111111111'),
    ('11959484429', '22222222222'),
    ('11914544938', '23312341231'),
    ('11908413790', '30498234875'),
    ('11956898544', '21937498732'),
    ('11934575215', '01390239484'),
    ('11973594343', '12849308239'),
    ('11949798316', '34983920111'),
    ('11938664390', '90239109023'),
    ('11929566424', '99999999999'),
    ('11984803527', '48758748234'),
    ('11912776095', '20203032934'),
    ('11924268994', '23948558342'),
    ('11911759975', '12903842342'),
    ('11949241880', '23984930203'),
    ('11937806863', '23049349895'),
    ('11942999170', '28372378123'),
    ('11982907005', '12039910384'),
    ('11935497282', '34873843234'),
    ('11911702310', '90239109023'),
    ('11984420945', '77777777777'),
    ('11937477103', '53481403888'),
    ('11927336345', '12093493829'),
    ('11972660341', '29318109939'),
    ('11959126516', '23988484842'),
    ('11905750854', '12093943555'),
    ('11932621745', '12492948582'),
    ('11900661324', '45464567959'),
    ('11933925871', '24231291434'),
    ('11941616135', '23487382133'),
    ('11984353895', '93499204999'),
    ('11939819591', '33311155395'),
    ('11901100565', '45593959995'),
    ('11998898833', '31113331233'),
    ('11948233382', '47837778234'),
    ('11910515440', '23312333231'),
    ('11985990379', '83942939481'),
    ('11974344056', '44234124423'),
    ('11960313757', '39482093948'),
    ('11977171101', '33424334244'),
    ('11956426811', '82378788842'),
    ('11945117285', '23129399413'),
    ('11989947196', '12938000239'),
    ('11980695805', '12093884113'),
    ('11909393591', '20938129888'),
    ('11991705407', '29387472834'),
    ('11918502670', '03948293934'),
    ('11952392761', '39487238211'),
    ('11974612413', '10938849291'),
    ('11953999952', '10298848291'),
    ('11964095072', '02004122123'),
    ('11911549690', '39919999424'),
    ('11943993386', '39111134445'),
    ('11943947748', '39999422134'),
    ('11984210031', '22233314533'),
    ('11955636234', '09093452245'),
    ('11949698603', '39889233456'),
    ('11969348108', '12495829345'),
    ('11956297558', '38888239582'),
    ('11936140805', '23091928842'),
    ('11963480574', '38472888842'),
    ('11940651454', '12009490200'),
    ('11975960397', '78784994902'),
    ('11917097470', '30300993000'),
    ('11992066619', '12059999420'),
    ('11976710110', '34059992005'),
    ('11927612911', '11233329994'),
    ('11930573330', '34938299999'),
    ('11903570498', '10299922888'),
    ('11987926668', '09828854441'),
    ('11960260762', '12093889123'),
    ('11959997310', '33204999244'),
    ('11985560284', '09882999123'),
    ('11902724290', '11233332424'),
    ('11993209446', '23099000239'),
    ('11994953876', '77328492348'),
    ('11994429697', '88239499988'),
    ('11964228447', '93924083999'),
    ('11947346638', '12931123311'),
    ('11921558442', '43742934922'),
    ('11970744731', '44429399200'),
    ('11963958041', '30020020411'),
    ('11933108133', '03993942212'),
    ('11914738118', '01099311244'),
    ('11907905791', '88848289994'),
    ('11969834495', '55345523451'),
    ('11922890683', '99203004123'),
    ('11910120725', '32934221234'),
    ('11991698934', '39902399941'),
    ('11931704573', '11293939991'),
    ('11998777860', '91200042394'),
    ('11955179509', '23030449294'),
    ('11924872358', '29299292941'),
    ('11927254589', '10949912988'),
    ('11972276980', '23999420000'),
    ('11969455308', '23988488888'),
    ('11903964700', '12313123123'),
    ('11952406222', '29593920008'),
    ('11900028640', '10101039482'),
    ('11960051529', '20000139921'),
    ('11940332891', '19088288399'),
    ('11912805733', '58384729483'),
    ('11920048840', '98237238794'),
    ('11978409506', '02944884829'),
    ('11915530024', '01020304892'),
    ('11913258287', '23848728389'),
    ('11973363383', '59348255524'),
    ('11909959722', '02398900042'),
    ('11977486735', '30949299394');    

INSERT INTO campeonato_atletica.joga(pessoa_cpf, time_idTime)
VALUES('23442444165', 9),
    ('23293389233', 9),
    ('39321323233', 9),
    ('12392129394', 9),
    ('13948292390', 9),
    ('12231239424', 10),
    ('89901294829', 10),
    ('12492940002', 10),
    ('23113234412', 10),
    ('29399100032', 10),
    ('34738478834', 11),
    ('12093949294', 11),
    ('37782888492', 11),
    ('23094999523', 11),
    ('11244299539', 11),
    ('23948293994', 12),
    ('11209994823', 12),
    ('39499923535', 12),
    ('10220309423', 12),
    ('10004992344', 12),
    ('30942933423', 21),
    ('12030042999', 22),
    ('12999423049', 23),
    ('20938483842', 24),
    ('10283984939', 25),
    ('03949393994', 26),
    ('12345678910', 1),
    ('13423421341', 1),
    ('31232434232', 1),
    ('52323404235', 1),
    ('16895554353', 1),
    ('55544443333', 1),
    ('11122233344', 1),
    ('30294394852', 1),
    ('12312353245', 1),
    ('30940324352', 1),
    ('23449394820', 1),
    ('39483944321', 2),
    ('58374329485', 2),
    ('34829473493', 2),
    ('10298428475', 2),
    ('11111111111', 2),
    ('22222222222', 2),
    ('23312341231', 2),
    ('30498234875', 2),
    ('21937498732', 2),
    ('01390239484', 2),
    ('12849308239', 2),
    ('34983920111', 3),
    ('90239109023', 3),
    ('99999999999', 3),
    ('48758748234', 3),
    ('20203032934', 3),
    ('23948558342', 3),
    ('12903842342', 3),
    ('23984930203', 3),
    ('23049349895', 3),
    ('28372378123', 3),
    ('12039910384', 3),
    ('34873843234', 4),
    ('90239109023', 4),
    ('77777777777', 4),
    ('53481403888', 4),
    ('12093493829', 4),
    ('29318109939', 4),
    ('23988484842', 4),
    ('12093943555', 4),
    ('12492948582', 4),
    ('45464567959', 4),
    ('24231291434', 4),
    ('23487382133', 5),
    ('93499204999', 5),
    ('33311155395', 5),
    ('45593959995', 5),
    ('31113331233', 5),
    ('47837778234', 5),
    ('23312333231', 6),
    ('83942939481', 6),
    ('44234124423', 6),
    ('39482093948', 6),
    ('33424334244', 6),
    ('82378788842', 6),
    ('23129399413', 7),
    ('12938000239', 7),
    ('12093884113', 7),
    ('20938129888', 7),
    ('29387472834', 7),
    ('03948293934', 7),
    ('39487238211', 8),
    ('10938849291', 8),
    ('10298848291', 8),
    ('02004122123', 8),
    ('39919999424', 8),
    ('39111134445', 8),
    ('39999422134', 17),
    ('22233314533', 17),
    ('09093452245', 17),
    ('39889233456', 17),
    ('12495829345', 17),
    ('38888239582', 17),
    ('23091928842', 17),
    ('38472888842', 18),
    ('12009490200', 18),
    ('78784994902', 18),
    ('30300993000', 18),
    ('12059999420', 18),
    ('34059992005', 18),
    ('11233329994', 18),
    ('34938299999', 19),
    ('10299922888', 19),
    ('09828854441', 19),
    ('12093889123', 19),
    ('33204999244', 19),
    ('09882999123', 19),
    ('11233332424', 19),
    ('23099000239', 20),
    ('77328492348', 20),
    ('88239499988', 20),
    ('93924083999', 20),
    ('12931123311', 20),
    ('43742934922', 20),
    ('44429399200', 20),
    ('30020020411', 13),
    ('03993942212', 13),
    ('01099311244', 13),
    ('88848289994', 13),
    ('55345523451', 13),
    ('99203004123', 13),
    ('32934221234', 13),
    ('39902399941', 14),
    ('11293939991', 14),
    ('91200042394', 14),
    ('23030449294', 14),
    ('29299292941', 14),
    ('10949912988', 14),
    ('23999420000', 14),
    ('23988488888', 15),
    ('12313123123', 15),
    ('29593920008', 15),
    ('10101039482', 15),
    ('20000139921', 15),
    ('19088288399', 15),
    ('58384729483', 15),
    ('98237238794', 16),
    ('02944884829', 16),
    ('01020304892', 16),
    ('23848728389', 16),
    ('59348255524', 16),
    ('02398900042', 16),
    ('30949299394', 16);

INSERT INTO campeonato_atletica.compete (time_idTime, disputa_idDisputa, disputa_idTorneio, pontuacao)
VALUES (1 , 13245, 1, 5),
    (2 , 13245, 1, 3),
    (3 , 13245, 1, 3),
    (4 , 13245, 1, 4),
    (1 , 22213, 1, 1),
    (2 , 22213, 1, 3),
    (3 , 22213, 1, 2),
    (4 , 22213, 1, 5),
    (1 , 41234, 1, 3),
    (2 , 41234, 1, 2),
    (3 , 41234, 1, 2),
    (4 , 41234, 1, 1),
    (17 , 93942, 2, 3),
    (18 , 93942, 2, 2),
    (19 , 93942, 2, 7),
    (20 , 93942, 2, 1),
    (17 , 12441, 2, 3),
    (18 , 12441, 2, 5),
    (19 , 12441, 2, 1),
    (20 , 12441, 2, 1),
    (17 , 32094, 2, 4),
    (18 , 32094, 2, 3),
    (19 , 32094, 2, 2),
    (20 , 32094, 2, 1),
    (13 , 23041, 3, 31),
    (14 , 23041, 3, 20),
    (15 , 23041, 3, 23),
    (16 , 23041, 3, 18),
    (13 , 39492, 3, 34),
    (14 , 39492, 3, 33),
    (15 , 39492, 3, 20),
    (16 , 39492, 3, 12),
    (13 , 01249, 3, 25),
    (14 , 01249, 3, 34),
    (15 , 01249, 3, 33),
    (16 , 01249, 3, 33),
    (9 , 32492, 4, 150),
    (10 , 32492, 4, 144),
    (11 , 32492, 4, 120),
    (12 , 32492, 4, 99),
    (9 , 92099, 4, 156),
    (10 , 92099, 4, 180),
    (11 , 92099, 4, 142),
    (12 , 92099, 4, 120),
    (9 , 83223, 4, 143),
    (10 , 83223, 4, 123),
    (11 , 83223, 4, 160),
    (12 , 83223, 4, 132),
    (5 , 23929, 5, 88),
    (6 , 23929, 5, 75),
    (7 , 23929, 5, 90),
    (8 , 23929, 5, 95),
    (5 , 44144, 5, 120),
    (6 , 44144, 5, 100),
    (7 , 44144, 5, 80),
    (8 , 44144, 5, 95),
    (5 , 98883, 5, 46),
    (6 , 98883, 5, 81),
    (7 , 98883, 5, 74),
    (8 , 98883, 5, 110);

-- Questão d)

UPDATE campeonato_atletica.time
SET nome = 'Tourada'
WHERE idTime = 516;

UPDATE campeonato_atletica.pessoa a JOIN campeonato_atletica.telefone b
	ON a.cpf = b.pessoa_cpf
SET telefone = '31995490031'
WHERE telefone = '11900661324';

UPDATE campeonato_atletica.pessoa
SET CEP = '22775-052'
WHERE cpf = '23988488888';

UPDATE campeonato_atletica.disputa
SET dataHora = '2021-10-20 15:00:00'
WHERE idDisputa = 13245;

UPDATE campeonato_atletica.compete c JOIN campeonato_atletica.time t 
	ON t.idTime = c.time_idTime
SET pontuacao = 12
WHERE nome = 'Equipe2';

-- Questão e)

DELETE t FROM campeonato_atletica.time t
	INNER JOIN atletica ON atletica.idAtletica = t.idAtletica
  WHERE atletica.nome LIKE '%ada';
  
DELETE u 
	FROM universidade u 
WHERE u.cidade = "Varginha";

DELETE p FROM pessoa p
WHERE p.cpf = "46776671109";

DELETE u 
	FROM universidade u
	INNER JOIN atletica ON u.idUniversidade = atletica.idUniversidade
	INNER JOIN campeonato_atletica.time t ON atletica.idAtletica = t.idAtletica
	INNER JOIN joga ON t.idTime = joga.time_idTime
	INNER JOIN pessoa ON joga.pessoa_cpf = pessoa.cpf
WHERE pessoa.nome = "Jonas Peçanha";

DELETE t FROM campeonato_atletica.time t
	INNER JOIN atletica ON atletica.idAtletica = t.idAtletica
	INNER JOIN universidade on universidade.idUniversidade = atletica.idUniversidade
  WHERE universidade.categoria = "P"

-- Questão f)

-- 1 Retorne o numero de pessoas que jogam para cada uma das universidades
SELECT `universidade`.`nome`, COUNT(DISTINCT `pessoa_cpf`) as 'Quantidade Atletas'
FROM universidade LEFT JOIN atletica ON universidade.idUniversidade = atletica.idUniversidade
LEFT JOIN `time` ON atletica.idAtletica = `time`.idAtletica
AND atletica.idUniversidade = `time`.idUniversidade
LEFT JOIN joga ON `time`.idTime = joga.time_idTime
GROUP BY `universidade`.`idUniversidade`;

-- 2 Retorne o nome das atleticas que possuem time de futebol
SELECT `atletica`.`nome` AS 'Nome Atleticas'
FROM atletica INNER JOIN `time` INNER JOIN esporte
ON atletica.idAtletica = `time`.idAtletica
AND atletica.idUniversidade = `time`.idUniversidade
AND `time`.idEsporte = esporte.idEsporte
WHERE esporte.nome = 'Futebol';

-- 3 Retorne o nome das cinco Universidades mais bem colocadas na categoria "X" e suas respectivas pontuações
SELECT `universidade`.`nome`, SUM(compete.pontuacao) as Pontos
FROM universidade
INNER JOIN atletica 
INNER JOIN `time` 
INNER JOIN esporte 
INNER JOIN compete 
ON universidade.idUniversidade = atletica.idUniversidade
AND atletica.idAtletica = `time`.idAtletica 
AND atletica.idUniversidade = `time`.idUniversidade
AND `time`.idEsporte = esporte.idEsporte
AND `time`.idTime = compete.time_idTime
WHERE esporte.categoria = 'X'
GROUP BY `universidade`.`nome`
ORDER BY Pontos DESC
LIMIT 5;

-- 4 Retorne o nome da universidade com maior numero de atletas com genero 'F' e esse numero
SELECT universidade.nome, COUNT(DISTINCT joga.pessoa_cpf) as atletasFem
FROM universidade INNER JOIN atletica INNER JOIN `time` INNER JOIN joga 
ON universidade.idUniversidade = atletica.idUniversidade
AND atletica.idAtletica = `time`.idAtletica 
AND atletica.idUniversidade = `time`.idUniversidade
AND `time`.idTime = joga.time_idTime
WHERE joga.pessoa_cpf NOT IN (SELECT cpf FROM pessoa WHERE genero = 'M')
GROUP BY universidade.idUniversidade
ORDER BY atletasFem DESC
LIMIT 1;

-- 5 Numero de atleticas da universidade "UFLA" que participaram de torneios entre 20XX e 20XX
SELECT COUNT(DISTINCT atletica.nome) AS 'Numero'
FROM universidade INNER JOIN atletica INNER JOIN `time` INNER JOIN compete INNER JOIN disputa
ON universidade.idUniversidade = atletica.idUniversidade AND 
atletica.idUniversidade = `time`.idUniversidade AND 
atletica.idAtletica = `time`.idAtletica AND
`time`.idTime = compete.time_idTime AND
compete.disputa_idDisputa = disputa.idDisputa AND
compete.disputa_idTorneio = disputa.idTorneio
WHERE universidade.nome = 'Universiade Federal de Lavras' AND
disputa.dataHora BETWEEN '2000-01-01' AND '2021-12-30'
GROUP BY universidade.idUniversidade;

-- 6 Atleticas da UFMG que não competem na modalidade x
SELECT atletica.nome AS 'Não competem na modalidade Terrestre' 
FROM universidade INNER JOIN atletica INNER JOIN `time` ON 
universidade.idUniversidade = atletica.idUniversidade AND 
atletica.idAtletica = `time`.idAtletica AND 
atletica.idUniversidade = `time`.idUniversidade 
WHERE universidade.nome = 'Universidade Federal de Minas Gerais' AND
 `time`.idEsporte = ANY (SELECT esporte.idEsporte FROM esporte WHERE categoria != 'Terrestre');
 
-- 7 Retorne a quantidade de cursos cada atletica representa (>2)
SELECT atletica.nome, COUNT(curso.idCurso) as qtdCursos
FROM atletica LEFT JOIN curso 
ON atletica.idAtletica = curso.idAtletica 
AND atletica.idUniversidade = curso.idUniversidade
GROUP BY atletica.idAtletica
HAVING qtdCursos > 2;

-- 8 Atletica que compete em maior numero de categorias
SELECT atletica.nome, COUNT(DISTINCT esporte.categoria) as qtdCategorias 
FROM atletica INNER JOIN `time` ON 
atletica.idAtletica = `time`.`idAtletica` AND 
atletica.idUniversidade = `time`.`idUniversidade` 
INNER JOIN esporte ON `time`.`idEsporte` = esporte.idEsporte 
GROUP BY atletica.idAtletica 
ORDER BY qtdCategorias 
DESC LIMIT 1;

-- 9 Pontuação média torneio X por esporte
SELECT esporte.nome AS 'Esporte', AVG(compete.pontuacao) as 'Media Pontuacao'
FROM esporte LEFT JOIN disputa ON esporte.idEsporte = disputa.idEsporte
LEFT JOIN compete ON disputa.idDisputa = compete.disputa_idDisputa AND disputa.idTorneio = compete.disputa_idTorneio
LEFT JOIN torneio ON torneio.idTorneio = disputa.idTorneio
WHERE torneio.nome = 'Torneio de Futebol'
GROUP BY esporte.idEsporte;

-- 10 Retorne Atleticas de faculdades Federais 
SELECT atletica.nome 
FROM atletica INNER JOIN universidade ON atletica.idUniversidade = universidade.idUniversidade
WHERE universidade.nome LIKE '%Federal%';

-- 11 Universidades cadastradas que não possuem atleticas cadastradas
SELECT universidade.nome
FROM universidade LEFT JOIN atletica ON universidade.idUniversidade = atletica.idUniversidade
WHERE atletica.nome IS NULL;

-- 12 Nome dos Times de futebol que jogaram no dia X ou dia Y na cidade de São Paulo
SELECT `time`.nome
FROM `time` INNER JOIN esporte ON `time`.idEsporte = esporte.idEsporte
INNER JOIN compete ON `time`.idTime = time_idTime
INNER JOIN disputa ON compete.disputa_idDisputa = disputa.idDisputa AND compete.disputa_idTorneio = disputa.idTorneio
INNER Join torneio ON disputa.idTorneio = torneio.idTorneio
WHERE esporte.nome = 'Futebol' AND torneio.cidade = 'São Paulo' AND date(dataHora) = '2021-10-21'
UNION
SELECT `time`.nome
FROM `time` INNER JOIN esporte ON `time`.idEsporte = esporte.idEsporte
INNER JOIN compete ON `time`.idTime = time_idTime
INNER JOIN disputa ON compete.disputa_idDisputa = disputa.idDisputa AND compete.disputa_idTorneio = disputa.idTorneio
INNER Join torneio ON disputa.idTorneio = torneio.idTorneio
WHERE esporte.nome = 'Futebol' AND torneio.cidade = 'São Paulo' AND date(dataHora) = '2021-10-20';

-- 13 Retorne o time de Futebol e quantidade de partidas que competiu mais vezes entre os que pontuaram mais de 5 pontos
SELECT `time`.`nome`
FROM `time` INNER JOIN esporte
ON `time`.idEsporte = esporte.idEsporte
WHERE esporte.nome = 'Futebol'
AND `time`.idTime
IN (SELECT idTime FROM (SELECT idTime, COUNT(idTime) AS partidas
	FROM `time` 
	INNER JOIN compete ON idTime = time_idTime
    GROUP BY idTime
	HAVING SUM(pontuacao) > 5
	ORDER BY partidas DESC) a)
LIMIT 1;

-- 14 Time que pontuou mais ou o mesmo que todos os outros times no campeonato Torneio de Vôlei (all)
SELECT times as time FROM resultado_disputa
	INNER JOIN disputa ON resultado_disputa.disputa = disputa.idDisputa
	INNER JOIN torneio ON disputa.idTorneio = torneio.idTorneio 
	WHERE torneio.nome = "Torneio de Vôlei"
	GROUP BY resultado_disputa.times
HAVING SUM(resultado_disputa.pontuacao) >= ALL(
    SELECT SUM(resultado_disputa.pontuacao) FROM resultado_disputa
    INNER JOIN disputa ON resultado_disputa.disputa = disputa.idDisputa
	INNER JOIN torneio ON disputa.idTorneio = torneio.idTorneio 
	WHERE torneio.nome = "Torneio de Vôlei"
	GROUP BY times
);

-- 15 Nome da pessoa cadastrada com o telefone 11902724290
SELECT DISTINCT p.nome FROM pessoa p, telefone t WHERE EXISTS (SELECT * FROM telefone WHERE telefone = '11900028640' AND p.cpf = telefone.pessoa_cpf);

-- Questão g)

CREATE VIEW atletica_faculdade AS SELECT
    atletica.nome,
    universidade.nome AS universidade,
    universidade.estado,
    universidade.categoria
    FROM atletica
INNER JOIN universidade ON universidade.idUniversidade = atletica.idUniversidade;
	

CREATE VIEW num_times AS SELECT
    esporte.nome,
    COUNT(*) AS 'quantidade de times'
    FROM time
INNER JOIN esporte ON time.idEsporte = esporte.idEsporte
GROUP BY campeonato_atletica.time.idEsporte;


CREATE VIEW resultado_disputa AS SELECT
    disputa.idDisputa as disputa,
	esporte.nome as esporte,
    disputa.dataHora,
    campeonato_atletica.time.nome AS times,
    compete.pontuacao
    FROM compete
INNER JOIN
	disputa ON disputa.idDisputa = compete.disputa_idDisputa
INNER JOIN
	campeonato_atletica.time ON campeonato_atletica.time.idTime = compete.time_idTime
INNER JOIN
    esporte ON campeonato_atletica.time.idEsporte = esporte.idEsporte
ORDER BY disputa.datahora, compete.pontuacao DESC;

-- Questão h)

-- CREATE
CREATE USER 'ana_luiza'@'localhost' IDENTIFIED BY '00000001'; 
CREATE USER 'arthur'@'localhost' IDENTIFIED BY '00000002'; 
CREATE USER 'chrystian'@'localhost' IDENTIFIED BY '00000003'; 
CREATE USER 'joao'@'localhost' IDENTIFIED BY '00000004'; 
CREATE USER 'thiago'@'localhost' IDENTIFIED BY '00000005'; 

-- GRANT
GRANT ALL ON campeonato_atletica TO 'thiago'@'localhost';
GRANT SELECT, INSERT ON campeonato_atletica.esporte TO 'arthur'@'localhost';
GRANT ALL ON campeonato_atletica.universidade TO 'ana_luiza'@'localhost';
GRANT SELECT, INSERT, UPDATE ON campeonato_atletica.pessoa TO 'joao'@'localhost';
GRANT SELECT, INSERT, UPDATE ON campeonato_atletica.telefone TO 'joao'@'localhost';
GRANT ALL ON campeonato_atletica.curso TO 'chrystian'@'localhost';
GRANT ALL ON campeonato_atletica.atletica TO 'chrystian'@'localhost';
GRANT DELETE ON campeonato_atleticas.pessoa TO 'arthur'@'localhost';
GRANT UPDATE (descricao) ON campeonato_atletica.torneio TO 'ana_luiza'@'localhost';
GRANT INSERT ON campeonato_atletica.joga TO 'joao'@'localhost';

-- REVOKE
REVOKE DELETE ON campeonato_atletica.pessoa FROM 'arthur'@'localhost';
REVOKE UPDATE (descricao) ON campeonato_atletica.torneio FROM 'ana_luiza'@'localhost';
REVOKE INSERT ON campeonato_atletica.joga FROM 'joao'@'localhost';

-- Questão i)

DELIMITER //
CREATE PROCEDURE ObtemPessoasSexo(IN pgenero CHAR(1))
BEGIN
	IF pgenero IN ('M', 'F', 'O') THEN
		SELECT nome FROM pessoa WHERE genero = pgenero;
	ELSE
		SIGNAL SQLSTATE '45000' SET message_text = 'O gênero especificado no parâmetro não pertence ao conjunto de gêneros do projeto!';
	END IF;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE ObtemQtdPessoasTime(IN pnome VARCHAR(50), OUT qtdPessoas INT)
BEGIN
	SELECT count(*) INTO qtdPessoas FROM joga WHERE time_idTime = (SELECT idTime FROM time WHERE nome = pnome);
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE InsereTelefone(IN ptelefone VARCHAR(11), IN pcpf CHAR(11))
BEGIN
	INSERT INTO telefone (pessoa_cpf, telefone) VALUES (pcpf, ptelefone);
END //
DELIMITER ;

CALL ObtemPessoasSexo('F');
--CALL ObtemPessoasSexo('G');

CALL ObtemQtdPessoasTime('Vasco', @qtdPessoas);
SELECT @qtdPessoas AS quantida_pessoas;

CALL InsereTelefone('03732229849', '01099311244');
SELECT * FROM telefone;

-- Questão j)

--INSERT--
DELIMITER //
CREATE TRIGGER verificaGenero
BEFORE INSERT ON pessoa
FOR EACH ROW
BEGIN
	IF NEW.genero NOT IN ('M', 'F', 'O') THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'Por favor, insira um genero válido';
	END IF;
END // 
DELIMITER ;

DELIMITER // 
CREATE TRIGGER verificaCEPUniversiade
BEFORE INSERT ON universidade
FOR EACH ROW
BEGIN
	IF NEW.cep = '00000-000' THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'Por favor, insira um cep válido!';
	END IF;
END // 
DELIMITER ;

DELIMITER // 
CREATE TRIGGER verificaPontuacaoCompete
BEFORE INSERT ON compete
FOR EACH ROW
BEGIN
	IF NEW.pontuacao < 0 THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'Por favor, não insira pontuação invalida, no caso negativa!';
	END IF;
END // 
DELIMITER ;

INSERT INTO pessoa (cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro) VALUES ('13458476610', 'Thiago Salles Santos', '2000-06-04', 'M', 'Itai', '37200-900', 'Divinópolis', 'MG', NULL, '500', 'Perto da padaria', 'Manoel Valinhas');
--Casos forão comentados pois os triggers geram erros como aviso de má conduta
--INSERT INTO pessoa (cpf, nome, dataNasc, genero, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro) VALUES ('13458476611', 'Paulo Ferreira Alburquerque', '2000-06-04', 'G', 'Itai', '37200-900', 'Divinópolis', 'MG', NULL, '500', 'Perto da padaria', 'Manoel Valinhas');
SELECT * FROM pessoa;

--Casos forão comentados pois os triggers geram erros como aviso de má conduta
--INSERT INTO universidade (nome, categoria, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro) VALUES ('UFLA', 'G', 'Perimentral', '00000-000', 'Lavras', 'MG', NULL, 254, NULL, 'Centro');
INSERT INTO universidade (nome, categoria, logradouro, CEP, cidade, estado, complemento, numero, referencia, bairro) VALUES ('UFLA', 'G', 'Perimentral', '37200-900', 'Lavras', 'MG', NULL, '254', NULL, 'Centro');
SELECT * FROM universidade;

INSERT INTO compete (time_idTime, disputa_idDisputa, disputa_idTorneio, pontuacao) VALUES (8, 22213, 1, 15);
--Casos forão comentados pois os triggers geram erros como aviso de má conduta
--INSERT INTO compete (time_idTime, disputa_idDisputa, disputa_idTorneio, pontuacao) VALUES (9, 22213, 1, -1);
SELECT * FROM compete;

--UPDATE--
DELIMITER // 
CREATE TRIGGER verificaNomeEsporte
BEFORE UPDATE ON esporte
FOR EACH ROW
BEGIN
	IF NEW.categoria != OLD.categoria THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'Por favor, não altere a categoria de um esporte!';
	END IF;
END // 
DELIMITER ;

DELIMITER // 
CREATE TRIGGER verificaDataNascPessoa
BEFORE UPDATE ON pessoa
FOR EACH ROW
BEGIN
	IF NEW.dataNasc != OLD.dataNasc THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'Por favor, não altere a data de nascimento de alguém!';
	END IF;
END // 
DELIMITER ;

DELIMITER // 
CREATE TRIGGER verificaEsporteTime
BEFORE UPDATE ON campeonato_atletica.time
FOR EACH ROW
BEGIN
	IF NEW.idEsporte != OLD.idEsporte
		SIGNAL SQLSTATE '45000' SET message_text = 'Por favor, não altere o esporte de um time!';
	END IF;
END // 
DELIMITER ;

--Casos forão comentados pois os triggers geram erros como aviso de má conduta
--UPDATE esporte SET categoria = 'Aquático' WHERE nome = 'Futebol';
--SELECT * FROM esporte;

--Casos forão comentados pois os triggers geram erros como aviso de má conduta
--UPDATE pessoa SET dataNasc = now() WHERE nome = 'Thiago Salles Santos';
--SELECT * FROM pessoa;

--Casos forão comentados pois os triggers geram erros como aviso de má conduta
--UPDATE campeonato_atletica.time SET idEsporte = 5 WHERE idEsporte = 1
--SELECT * FROM  campeonato_atletica.time

--DELETE--
DELIMITER //
CREATE TRIGGER verificaPessoaJogando
BEFORE DELETE ON pessoa
FOR EACH ROW
BEGIN
	IF EXISTS (SELECT * FROM joga WHERE pessoa_cpf = OLD.cpf) THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'Por favor, não delete um jogador participante de um time';
	END IF;
END // 
DELIMITER ;

DELIMITER //
CREATE TRIGGER verificaTimeEsporte
BEFORE DELETE ON esporte
FOR EACH ROW
BEGIN
	IF EXISTS (SELECT * FROM `time` WHERE idEsporte = OLD.idEsporte) THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'Por favor, não delete um esporte que possui time praticante!';
	END IF;
END // 
DELIMITER ;

DELIMITER //
CREATE TRIGGER verificaDeletarTorneio
BEFORE DELETE ON torneio
FOR EACH ROW
BEGIN
	IF EXISTS (SELECT * FROM compete c, `time` t, universidade u WHERE c.time_idTime = t.idTime AND t.idUniversidade = u.idUniversidade AND u.nome = 'Universidade Federal de Lavras' AND c.disputa_idTorneio = OLD.idTorneio) THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'Por favor, não delete um torneio que a Universidade de Lavras disputou!';
	END IF;
END // 
DELIMITER ;

--Casos forão comentados pois os triggers geram erros como aviso de má conduta
--DELETE FROM pessoa WHERE cpf = '01020304892';

--Casos forão comentados pois os triggers geram erros como aviso de má conduta
--DELETE FROM esporte WHERE idEsporte = 1;

--Casos forão comentados pois os triggers geram erros como aviso de má conduta
--DELETE FROM torneio WHERE idTorneio = 2;