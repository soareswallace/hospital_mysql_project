CREATE DATABASE hospital;
USE hospital;

DROP TABLE Prescreve;
DROP TABLE Consulta;
DROP TABLE Possui;
DROP TABLE Ocupa;
DROP TABLE Chefia;
DROP TABLE Cuida;
DROP TABLE Tecnico;
DROP TABLE Enfermeiro;
DROP TABLE Medico;
DROP TABLE Executa;
DROP TABLE Acompanha;
DROP TABLE Paciente;
DROP TABLE Funcionario_Paciente;
DROP TABLE Funcionario;
DROP TABLE Acompanhante;
DROP TABLE Tel_Pessoa;
DROP TABLE Pessoa;
DROP TABLE Leito;
DROP TABLE Prontuario;
DROP TABLE Remedio;
DROP TABLE Exame;

CREATE TABLE Pessoa (
    nomeCompleto VARCHAR(100) NOT NULL,
    CPF VARCHAR(11),
    dataNascimento DATE NOT NULL,
    CEP VARCHAR(8) NOT NULL,
    numero VARCHAR(10) NOT NULL,
    complemento VARCHAR(100),
    PRIMARY KEY(CPF)
);

CREATE TABLE Tel_Pessoa(
    fk_Pessoa_CPF VARCHAR(11) UNIQUE,
    Telefone VARCHAR(15) UNIQUE,
    FOREIGN KEY (fk_Pessoa_CPF) REFERENCES Pessoa(CPF) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Paciente (
    data_entrada DATE NOT NULL,
    data_saida DATE,
    CPF_Paciente VARCHAR(11) UNIQUE,
    CONSTRAINT FK_PacientePessoa_CPF FOREIGN KEY (CPF_Paciente) REFERENCES Pessoa(CPF) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Funcionario(
    matricula VARCHAR(16) UNIQUE NOT NULL,
    data_admissao DATE NOT NULL,
    data_demissao DATE,
    CNTPS VARCHAR(8) UNIQUE NOT NULL,
    salario FLOAT NOT NULL,
    carga_horaria INT NOT NULL,
    CPF_Funcionario VARCHAR (11) UNIQUE,
    CONSTRAINT FK_FuncionarioPessoa_CPF FOREIGN KEY (CPF_Funcionario) REFERENCES Pessoa(CPF) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Funcionario_Paciente(
    tempo_de_dispensa INT NOT NULL,
    matricula_funcionario VARCHAR(16) UNIQUE,
    CONSTRAINT FK_MatriculaFuncionario FOREIGN KEY (matricula_funcionario) REFERENCES Funcionario(matricula) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Acompanhante (
    CPF_Acompanhante VARCHAR(11) UNIQUE,
    CONSTRAINT FK_AcompanhantePessoa_CPF FOREIGN KEY (CPF_Acompanhante) REFERENCES Pessoa(CPF) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Medico (
    CRM VARCHAR(10) UNIQUE NOT NULL,
    Especialidade VARCHAR(30) NOT NULL,
    matricula_medico VARCHAR(16) UNIQUE,
    CONSTRAINT FK_MedicoFuncionario_Matricula FOREIGN KEY (matricula_medico) REFERENCES Funcionario(matricula) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Tecnico (
    registro VARCHAR(6) UNIQUE NOT NULL,
    matricula_tecnico VARCHAR(16) UNIQUE,
    CONSTRAINT FK_TecnicoFuncionario_Matricula FOREIGN KEY (matricula_tecnico) REFERENCES Funcionario(matricula) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Enfermeiro (
    CRE VARCHAR(10) UNIQUE NOT NULL,
    Especialidade VARCHAR(30) NOT NULL,
    matricula_enfermeiro VARCHAR(16) UNIQUE,
    CONSTRAINT FK_EnfermeiroFuncionario_Matricula FOREIGN KEY (matricula_enfermeiro) REFERENCES Funcionario(matricula) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Acompanha (
    CPF_Paciente VARCHAR(11), 
    CPF_Acompanhante VARCHAR(11) UNIQUE,
    CONSTRAINT FK_Paciente_CPF FOREIGN KEY (CPF_Paciente) REFERENCES Paciente(CPF_Paciente) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Acompanhante_CPF FOREIGN KEY (CPF_Acompanhante) REFERENCES Acompanhante(CPF_Acompanhante) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Cuida (
    CPF_Paciente VARCHAR(11),
    matricula_enfermeiro VARCHAR(16),
    CONSTRAINT FK_PacienteCuida_CPF FOREIGN KEY (CPF_Paciente) REFERENCES Paciente(CPF_Paciente) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_EnfermeiroCuida_Matricula FOREIGN KEY (matricula_enfermeiro) REFERENCES Funcionario(matricula) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Chefia (
    matricula_enfermeiro_chefe VARCHAR(16),
    matricula_enfermeiro_chefiado VARCHAR(16) UNIQUE,
    CONSTRAINT FK_EnfermeiroChefe_Matricula FOREIGN KEY (matricula_enfermeiro_chefe) REFERENCES Funcionario(matricula) ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT FK_EnfermeiroChefiado_Matricula FOREIGN KEY (matricula_enfermeiro_chefiado) REFERENCES Funcionario(matricula) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Leito (
    id VARCHAR(36),
    ocupado BOOLEAN DEFAULT FALSE,
    PRIMARY KEY(id)
);

CREATE TABLE Ocupa (
    CPF_Paciente VARCHAR(11) UNIQUE,
    leito_ID VARCHAR (36) UNIQUE,
    CONSTRAINT FK_PacienteOcupa_CPF FOREIGN KEY (CPF_Paciente) REFERENCES Paciente(CPF_Paciente) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_LeitoID FOREIGN KEY (leito_ID) REFERENCES Leito(id) ON DELETE SET NULL ON UPDATE CASCADE
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

CREATE TABLE Possui (
    CPF_Paciente VARCHAR(11) UNIQUE NOT NULL,
    codigo_prontuario VARCHAR(36) UNIQUE,
    CONSTRAINT FK_PacienteProntuario_CPF FOREIGN KEY (CPF_Paciente) REFERENCES Paciente(CPF_Paciente) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_ProntuarioPossui FOREIGN KEY (codigo_prontuario) REFERENCES Prontuario(codigo) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Remedio (
    registroMS VARCHAR(13),
    droga VARCHAR(30) NOT NULL,
    nome_comercial VARCHAR(30) NOT NULL,
    PRIMARY KEY (registroMS)
);

CREATE TABLE Consulta (
    id VARCHAR(36),
    CPF_Paciente VARCHAR(11),
    matricula_medico VARCHAR(16),
    PRIMARY KEY (id),
    CONSTRAINT FK_PacienteConsulta_CPF FOREIGN KEY (CPF_Paciente) REFERENCES Paciente(CPF_Paciente) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_MedicoConsulta_Matricula FOREIGN KEY (matricula_medico) REFERENCES Funcionario(matricula) ON DELETE CASCADE ON UPDATE CASCADE
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

CREATE TABLE Executa (
    CPF_Paciente VARCHAR(11) NOT NULL,
    codigo_exame VARCHAR(36) UNIQUE NOT NULL,
    matricula_tecnico VARCHAR(16) NOT NULL,
    CONSTRAINT FK_PacienteExame_CPF FOREIGN KEY (CPF_Paciente) REFERENCES Paciente(CPF_Paciente) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_CodigoExame FOREIGN KEY (codigo_exame) REFERENCES Exame(codigo) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_Tecnico FOREIGN KEY (matricula_tecnico) REFERENCES Funcionario(matricula) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Prescreve (
    id_consulta VARCHAR(36),
    registroMS VARCHAR(13),
    CONSTRAINT FK_id_consulta FOREIGN KEY (id_consulta) REFERENCES Consulta(id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_RemedioPescrito FOREIGN KEY (registroMS) REFERENCES Remedio(registroMS) ON DELETE SET NULL ON UPDATE CASCADE
);

