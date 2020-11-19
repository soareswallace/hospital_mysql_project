-- Populando tabela Pessoa
INSERT INTO Pessoa (nomeCompleto, CPF, dataNascimento, idade, CEP, Numero)
VALUES ("Wallace Soares", "11111111111", SUBDATE(NOW(), INTERVAL 24 YEAR), 24, "52011050", "31");

INSERT INTO Pessoa (nomeCompleto, CPF, dataNascimento, idade, CEP, Numero)
VALUES ("Eden Filho", "22222222222", SUBDATE(NOW(), INTERVAL 30 YEAR), 30, "52086050", "312");

INSERT INTO Pessoa (nomeCompleto, CPF, dataNascimento, idade, CEP, Numero, Complemento)
VALUES ("Julia Feitosa", "33333333333", SUBDATE(NOW(), INTERVAL 50 YEAR), 50, "52054050", "311", "Apt 701");

INSERT INTO Pessoa (nomeCompleto, CPF, dataNascimento, idade, CEP, Numero)
VALUES ("Pedro Basilio", "44444444444", SUBDATE(NOW(), INTERVAL 70 YEAR), 70, "52013750", "431");

INSERT INTO Pessoa (nomeCompleto, CPF, dataNascimento, idade, CEP, Numero)
VALUES ("Umdostrês de Oliveria Quatro", "55555555555", SUBDATE(NOW(), INTERVAL 35 YEAR), 35, "52981050", "1");

INSERT INTO Pessoa (nomeCompleto, CPF, dataNascimento, idade, CEP, Numero)
VALUES ("Xerox Silva", "66666666666", SUBDATE(NOW(), INTERVAL 56 YEAR), 56, "55211050", "31321");

INSERT INTO Pessoa (nomeCompleto, CPF, dataNascimento, idade, CEP, Numero)
VALUES ("Fotocopia Silva", "77777777777", SUBDATE(NOW(), INTERVAL 76 YEAR), 76, "52009050", "3311");



INSERT INTO Funcionario (matricula, data_admissao, data_demissao, CNTPS, salario, carga_horaria, CPF_Funcionario)
VALUES ("913728461928", SUBDATE(NOW(), INTERVAL 5 YEAR), NULL, "52009050", 3311, 40, "77777777777");
INSERT INTO Funcionario (matricula, data_admissao, data_demissao, CNTPS, salario, carga_horaria, CPF_Funcionario)
VALUES ("913728467628", SUBDATE(NOW(), INTERVAL 3 YEAR), NULL, "52003460", 3311, 40, "66666666666");
INSERT INTO Funcionario (matricula, data_admissao, data_demissao, CNTPS, salario, carga_horaria, CPF_Funcionario)
VALUES ("9137284656428", SUBDATE(NOW(), INTERVAL 10 YEAR), NULL, "52006540", 3311, 40, "55555555555");
INSERT INTO Funcionario (matricula, data_admissao, data_demissao, CNTPS, salario, carga_horaria, CPF_Funcionario)
VALUES ("91656428", SUBDATE(NOW(), INTERVAL 30 YEAR), NULL, "53406540", 3311, 40, "44444444444");
INSERT INTO Funcionario (matricula, data_admissao, data_demissao, CNTPS, salario, carga_horaria, CPF_Funcionario)
VALUES ("916428", SUBDATE(NOW(), INTERVAL 10 YEAR), NULL, "53404540", 3311, 40, "11111111111");

INSERT INTO Tecnico (registro, matricula_tecnico) VALUES ("123456", "913728461928");

INSERT INTO Medico (CRM, Especialidade, matricula_medico) VALUES ("1234567890", "Clinico Geral", "913728467628");

INSERT INTO Enfermeiro (CRE, Especialidade, matricula_enfermeiro) VALUES ("1234567890", "Generalista", "9137284656428");
INSERT INTO Enfermeiro (CRE, Especialidade, matricula_enfermeiro) VALUES ("1234767890", "Pediatra", "916428");

INSERT INTO Funcionario_Paciente(tempo_de_dispensa, matricula_funcionario) VALUES (30, "91656428");

INSERT INTO Paciente (data_entrada, data_saida, CPF_Paciente) VALUES (NOW(), NULL, "33333333333");

INSERT INTO Acompanhante(CPF_Acompanhante) VALUES ("22222222222");

INSERT INTO Acompanha(CPF_Paciente, CPF_Acompanhante) VALUES ("33333333333", "22222222222");

INSERT INTO Cuida (CPF_Paciente, matricula_enfermeiro) VALUES ("22222222222", "9137284656428");

INSERT INTO Chefia (matricula_enfermeiro_chefe, matricula_enfermeiro_chefiado) VALUES ("9137284656428", "916428");

INSERT INTO Leito (id, ocupado) VALUES (UUID(), FALSE);

INSERT INTO Ocupa (CPF_Paciente, leito_ID) VALUES ("33333333333", (SELECT Leito.id FROM Leito WHERE Leito.ocupado = FALSE));

INSERT INTO Prontuario(codigo, matricula_medico, descricaoAtendimento, hipotesesDiagnosticadas, diagnosticoDefinitivo, data_entrada, data_saida)
VALUES (UUID(), "913728467628", "Sintomas de COVID", NULL, NULL, NOW(), NULL);

INSERT INTO Possui (CPF_Paciente, codigo_prontuario) VALUES ("33333333333", (SELECT codigo FROM Prontuario WHERE matricula_medico="913728467628"));

INSERT INTO Remedio (registroMS, droga, nome_comercial) VALUES ("1234567890112", "Cloroquina", "Nao serve para COVID");

INSERT INTO Consulta (id, CPF_Paciente, matricula_medico, remedioID) VALUES (UUID(), "33333333333", "913728467628", "1234567890112");

INSERT INTO Exame (codigo, matricula_func, info_exame, data_requisicao, data_realizacao, data_resultado) VALUES (UUID(), "913728461928", "Exame de COVID", NOW(), NOW(), NOW());

INSERT INTO Executa (CPF_Paciente, codigo_exame, matricula_tecnico) VALUES ("33333333333", (SELECT codigo FROM Exame WHERE matricula_func="913728461928"), "913728461928");

INSERT INTO Prescreve (id_consulta, registroMS) VALUES ((SELECT id FROM Consulta WHERE CPF_Paciente="33333333333"), "1234567890112");