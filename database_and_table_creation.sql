CREATE DATABASE hospital;
USE hospital;

--CREATE DOMAIN TIPO_CPF AS CHAR(11); --NAO EH POSSIVEL CRIAR DOMAINS EM MYSQL

CREATE TABLE Pessoa (
    nomeCompleto VARCHAR(100) NOT NULL,
    CPF VARCHAR(11),
    dataNascimento DATE NOT NULL,
    idade INT  NOT NULL,
    CEP VARCHAR(8) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(100),
    PRIMARY KEY(CPF)
);

-- CRIAR TAS TABELAS QUE DERIVAM DE PESSOA

CREATE TABLE Leito (
    id VARCHAR(36),
    ocupado Boolean DEFAULT FALSE,
    PRIMARY KEY(id)
);

CREATE TABLE Prontuario(
    codigo VARCHAR(36),
    matricula_medico VARCHAR (100) NOT NULL,
    descricaoAtendimento VARCHAR(1000) NOT NULL,
    hipotesesDiagnosticadas VARCHAR (1000),
    diagnosticoDefinitivo VARCHAR (1000),
    data_entrada DATE NOT NULL,
    data_saida DATE,
    PRIMARY KEY (codigo)
);

CREATE TABLE Remedio (
    registroMS VARCHAR(13),
    droga VARCHAR(30) NOT NULL,
    nome_comercial VARCHAR(30) NOT NULL,
    PRIMARY KEY (registroMS)
);

CREATE TABLE Exame(
    codigo VARCHAR(36),
    matricula_func VARCHAR (100) NOT NULL,
    info_exame VARCHAR (1000) NOT NULL,
    data_requisicao DATE NOT NULL,
    data_realizacao DATE,
    data_resultado DATE,
    PRIMARY KEY(codigo)
);