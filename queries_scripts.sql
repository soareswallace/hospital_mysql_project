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


-- criar regra para execução de comandos DDL
-- CREATE ROLE ddl_role;
-- GRANT CREATE, ALTER, DROP ON hospital.* TO 'ddl_role';

-- criar regra apenas para consultas do banco criado
-- CREATE ROLE query_role;
-- GRANT SELECT ON hospital TO query_role;

-- CREATE USER consultor IDENTIFIED BY '1234';
-- GRANT 'query_role' TO 'consultor@localhost';


-- Select Enfermeiro.matricula_enfermeiro as enfermeiro,
-- Cuida.CPF_Paciente as paciente,

-- FROM Cuida 
-- INNER JOIN Enfermeiro 
-- ON Enfermeiro.matricula_enfermeiro = Cuida.matricula_enfermeiro;