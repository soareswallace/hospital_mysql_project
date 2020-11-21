-- selecionar dados de uma tabela mediante alguma condição
-- selecionar um subconjunto de atributos de uma tabela
-- Retorna o nome, data de nascimento e CPF do indivíduo com CPF = "11111111111"
SELECT nomeCompleto, dataNascimento, CPF 
FROM Pessoa 
WHERE CPF = "11111111111";

-- selecionar todos os dados de uma tabela
-- Retrona todos os dados de Paciente
SELECT * 
FROM Paciente;

-- realizar seleção de dados sem apresentar duplicadas
-- Retorna as especialidades dos enfermeiros cadastrados sem repetições
SELECT DISTINCT Especialidade
FROM Enfermeiro;

-- aplicar produto cartesiano
-- Retorna o produto cartesiano a partir da tabela de Consulta e Prescreve
SELECT 
    CPF_Paciente, registroMS
FROM
    Consulta AS a
        CROSS JOIN
    Prescreve AS b;

-- atribuir “apelidos”
-- Atribui apelido a coluna CPF_Paciente da tabela Acompanha
SELECT CPF_Paciente 
AS paciente 
FROM Acompanha;

-- aplicar união
-- Retorna o CRM dos medicos Clinico Geral e dos Psiquiatra
SELECT CRM 
FROM Medico 
WHERE Especialidade = 'Clinico Geral' 
UNION SELECT CRM 
FROM Medico 
WHERE Especialidade = 'Psiquiatra';

-- aplicar intersecao
-- atribuir "apelidos"
-- realizar seleção sob condição que envolva outra seleção
-- Retorna os nomes das pessoas que sao funcionarios, ps: INTERSECT nao e suportado pelo MySQL
SELECT nomeCompleto AS Nome
FROM Pessoa
WHERE CPF IN (
SELECT CPF_Funcionario AS CPF
FROM Funcionario);

-- aplicar diferenca
-- realizar seleção sob condição que envolva outra seleção
-- Retorna  as matriculas dos funcionarios que nao sao pacientes do hospital, ps: EXCEPT nao e suportado pelo MySQL
SELECT matricula
FROM Funcionario
WHERE matricula NOT IN (
    SELECT matricula_funcionario
    FROM Funcionario_Paciente);

-- ordenar resultados de consultas de forma ascendente
-- realizar seleção sob condição que envolva outra seleção
-- ordena os funcionarios do hospital em ordem alfabetica
SELECT nomeCompleto AS Nome
FROM Pessoa
WHERE CPF IN (
SELECT CPF_Funcionario AS CPF
FROM Funcionario) 
ORDER BY Nome ASC;

-- consultar valores de atributos que iniciem por algum termo
-- Retorna pessoas cujo nome comeca por "Robert"
SELECT nomeCompleto
FROM Pessoa
WHERE nomeCompleto LIKE "Robert%";


-- realizar agrupamento de resultado de consulta
-- atribuir "apelidos"
-- utilizar função de agregação
-- Retorna a quantidade de Medicos e agrupa-os por Especialidade
SELECT Especialidade, count(CRM) AS Qtde 
FROM Medico 
GROUP BY Especialidade;

-- realizar consulta de seleção-projeção-junção
SELECT data_admissao, CNTPS 
FROM Funcionario, Medico
WHERE salario > 2000 AND matricula=matricula_medico;

-- criar uma transação única
START TRANSACTION;
    UPDATE Paciente SET data_saida = NOW()
    WHERE CPF_Paciente="12925378901";
    UPDATE Paciente SET data_saida = NOW()
    WHERE CPF_Paciente="12745987901";
COMMIT;

-- CRIAÇÃO DE VIEW
CREATE VIEW paciente_sem_enfermeiro AS
SELECT CPF_Paciente
FROM Paciente
WHERE CPF_Paciente NOT IN (
    SELECT CPF_Paciente FROM Cuida
);

SELECT * FROM paciente_sem_enfermeiro;

-- criar usuário que possua a regra padrão para consulta da view (criadas anteriormente)
-- criar uma regra para consulta apenas na visualização criada
CREATE ROLE reader_view;
GRANT SELECT ON hospital.paciente_sem_enfermeiro TO 'reader_view';
CREATE USER 'viewer'@'localhost' IDENTIFIED BY 'viewer';
GRANT 'reader_view' TO 'viewer'@'localhost';
SET DEFAULT ROLE 'reader_view' TO 'viewer'@'localhost';

-- criar regra apenas para consultas do banco criado
-- criar usuário que possua a regra padrão para consulta (criada anteriormente)
CREATE ROLE role_for_select;
GRANT SELECT ON hospital.* TO 'role_for_select';
CREATE USER 'user_only_for_select'@'localhost' IDENTIFIED BY 'select';
GRANT 'role_for_select' TO 'user_only_for_select'@'localhost';
SET DEFAULT ROLE 'role_for_select' TO 'user_only_for_select'@'localhost';

-- criar regra para execução de comandos DDL
-- criar usuário que possua a regra padrão para comandos DDL (criada anteriormente)
CREATE ROLE role_for_ddl;
GRANT CREATE ON hospital.* TO 'role_for_ddl';
GRANT ALTER ON hospital.* TO 'role_for_ddl';
GRANT DROP ON hospital.* TO 'role_for_ddl';
CREATE USER 'user_ddl'@'localhost' IDENTIFIED BY 'ddl';
GRANT 'role_for_ddl' TO 'user_ddl'@'localhost';
SET DEFAULT ROLE 'role_for_ddl' TO 'user_ddl'@'localhost';

-- criar usuário que possua a regra padrão para comandos DML e DQL (criada anteriormente)
-- criar regra para execução de comandos DML e DQL
CREATE ROLE role_for_dml_dql;
GRANT INSERT ON hospital.* TO 'role_for_dml_dql';
GRANT UPDATE ON hospital.* TO 'role_for_dml_dql';
GRANT DELETE ON hospital.* TO 'role_for_dml_dql';
GRANT SELECT ON hospital.* TO 'role_for_dml_dql';
CREATE USER 'user_dml_dql'@'localhost' IDENTIFIED BY 'dml_dql';
GRANT 'role_for_dml_dql' TO 'user_dml_dql'@'localhost';
SET DEFAULT ROLE 'role_for_dml_dql' TO 'user_dml_dql'@'localhost';
