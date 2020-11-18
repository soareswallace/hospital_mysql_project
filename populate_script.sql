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


--Populando Funcionario
INSERT INTO Funcionario (matricula, data_admissao, data_demissao, CNTPS, salario, carga_horaria, CPF_Funcionario)
VALUES ("913728461928", SUBDATE(NOW(), INTERVAL 5 YEAR), NULL, "52009050", 3311, 40, "77777777777");

INSERT INTO Funcionario (matricula, data_admissao, data_demissao, CNTPS, salario, carga_horaria, CPF_Funcionario)
VALUES ("913728467628", SUBDATE(NOW(), INTERVAL 3 YEAR), NULL, "52003460", 3311, 40, "66666666666");

INSERT INTO Funcionario (matricula, data_admissao, data_demissao, CNTPS, salario, carga_horaria, CPF_Funcionario)
VALUES ("9137284656428", SUBDATE(NOW(), INTERVAL 10 YEAR), NULL, "52006540", 3311, 40, "55555555555");