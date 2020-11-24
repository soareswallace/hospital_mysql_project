/*
    Descriçao da operaçao em Algebra Relacional:
        π nomeCompleto, dataNascimento, CPF (σ CPF=11111111111(Pessoa))

    Requisitos atendidos:
        selecionar dados de uma tabela mediante alguma condição
        selecionar um subconjunto de atributos de uma tabela 

    Retorno:
        O nome, data de nascimento e CPF do indivíduo com CPF = "11111111111"
*/ 
SELECT nomeCompleto, dataNascimento, CPF 
FROM Pessoa 
WHERE CPF = "11111111111";

/*
    Descriçao da operaçao em Algebra Relacional: 
        Paciente

    Requisitos atendidos:
        selecionar todos os dados de uma tabela

    Retorno:
        todos os dados de Paciente

*/
SELECT * 
FROM Paciente;

/*
    Descriçao da operaçao em Algebra Relacional:
        π Especialidade (Enfermeiro)

    Requisitos atendidos:
        realizar seleção de dados sem apresentar duplicadas

    Retorno:
        as especialidades dos enfermeiros cadastrados sem repetições
*/
SELECT DISTINCT Especialidade
FROM Enfermeiro;

/*  
    Descriçao da operaçao em Algebra Relacional:
        PacientesConsulta ← π CPF_Paciente (Consulta)
        Remedios ← π registroMS (Prescreve)
        ρ a (PacientesConsulta)
        ρ b (Remedios)
        a x b


    Requisitos atendidos:
        aplicar produto cartesiano
        atribuir apelidos
      

    Retorno:
        Produto cartesiano entre as tabelas Consulta e Prescreve contendo os CPF dos Pacientes e registroMS dos Remedios
*/
SELECT 
    CPF_Paciente, registroMS
FROM
    Consulta AS a
        CROSS JOIN
    Prescreve AS b;


/*
    Descriçao da operaçao em Algebra Relacional:
        ρ (paciente, CPF_Acompanhante) (Acompanha)

    Requisitos atendidos:
        atribuir “apelidos”

    Retorno:
        Atribui apelido a coluna CPF_Paciente da tabela Acompanha

*/
SELECT CPF_Paciente 
AS paciente 
FROM Acompanha;


/*
    Descriçao da operaçao em Algebra Relacional:
        π CRM (σ Especialidade='Clinico Geral' (Medico)) ∪ π CRM (σ Especialidade='Psiquiatra' (Medico))

    Requisitos atendidos:
        aplicar união

    Retorno:
        o CRM dos medicos Clinico Geral e dos Psiquiatra

*/
SELECT CRM 
FROM Medico 
WHERE Especialidade = 'Clinico Geral' 
UNION SELECT CRM 
FROM Medico 
WHERE Especialidade = 'Psiquiatra';


/*
    Descriçao da operaçao em Algebra Relacional:
        CPF_FUNCIONARIO ← π CPF_Funcionario (Funcionario)
        CPF_Pessoa ← π CPF (Pessoa)

        FuncionariosPessoa ← CPF_FUNCIONARIO ∩ CPF_Pessoa

        π nomeCompleto (FuncionariosPessoa)



    Requisitos atendidos:
        aplicar intersecao
        atribuir "apelidos"
        realizar seleção sob condição que envolva outra seleção

    Retorno:
        nomes das pessoas que sao funcionarios
        ps: INTERSECT nao e suportado pelo MySQL

*/
SELECT nomeCompleto AS Nome
FROM Pessoa
WHERE CPF IN (
SELECT CPF_Funcionario AS CPF
FROM Funcionario);

/*
    Descriçao da operaçao em Algebra Relacional:
        funcionarioDoente ← π matricula_funcionario (Funcionario_Paciente)
        funcionario ← π matricula (Funcionario)

    funcionario - funcionarioDoente

    Requisitos atendidos:
        aplicar diferenca
        realizar seleção sob condição que envolva outra seleção

    Retorno:
        Matricula dos funcionarios que não estão doentes no hospital.
        ps: EXCEPT nao e suportado pelo MySQL

*/
SELECT matricula
FROM Funcionario
WHERE matricula NOT IN (
    SELECT matricula_funcionario
    FROM Funcionario_Paciente);


/*
    Descriçao da operaçao em Algebra Relacional:
        NAO SE APLICA

    Requisitos atendidos:
        ordenar resultados de consultas de forma ascendente
        realizar seleção sob condição que envolva outra seleção

    Retorno:
        Ordena os funcionarios do hospital em ordem alfabetica

*/
SELECT nomeCompleto AS Nome
FROM Pessoa
WHERE CPF IN (
SELECT CPF_Funcionario AS CPF
FROM Funcionario) 
ORDER BY Nome ASC;

/*
    Descriçao da operaçao em Algebra Relacional:
        NAO SE APLICA

    Requisitos atendidos:
        consultar valores de atributos que iniciem por algum termo

    Retorno:
        pessoas cujo nome comeca por "Robert"

*/
SELECT nomeCompleto
FROM Pessoa
WHERE nomeCompleto LIKE "Robert%";

/*
    Descriçao da operaçao em Algebra Relacional:
        NAO SE APLICA

    Requisitos atendidos:
        realizar agrupamento de resultado de consulta
        atribuir "apelidos"
        utilizar função de agregação

    Retorno:
        a quantidade de Medicos e agrupa-os por Especialidade

*/
SELECT Especialidade, count(CRM) AS Qtde 
FROM Medico 
GROUP BY Especialidade;

/*
    Descriçao da operaçao em Algebra Relacional:
        salarioMaiorQue2000 ← σ salario>2000 (Funcionario)
        funcionarioMedico ← π matricula_medico (Medico)
        MedicosMaisQue2000 ← salarioMaiorQue2000 ⋈ (matricula=matricula_medico) funcionarioMedico
        π (data_admissao, CNTPS) (MedicosMaisQue2000)

    Requisitos atendidos:
        realizar consulta de seleção-projeção-junção

    Retorno:
        A data de admissão e o CNTPS dos medicos que ganham mais que R$2000

*/
SELECT data_admissao, CNTPS 
FROM Funcionario, Medico
WHERE salario > 2000 AND matricula=matricula_medico;

/*
    Descriçao da operaçao em Algebra Relacional:
        NAO SE APLICA

    Requisitos atendidos:
        criar uma transação única

    Retorno:
        Executa uma transaçao setando data_saida de Paciente para AGORA
        para determinados pacientes.

*/
START TRANSACTION;
    UPDATE Paciente SET data_saida = NOW()
    WHERE CPF_Paciente="12925378901";
    UPDATE Paciente SET data_saida = NOW()
    WHERE CPF_Paciente="12745987901";
COMMIT;

/*
    Descriçao da operaçao em Algebra Relacional:
        NAO SE APLICA

    Requisitos atendidos:
        criar uma view a partir de mais de uma tabela

    Retorno:
        View que retorna os pacientes sem enfermeiro.

*/
CREATE VIEW paciente_sem_enfermeiro AS
SELECT CPF_Paciente
FROM Paciente
WHERE CPF_Paciente NOT IN (
    SELECT CPF_Paciente FROM Cuida
);

SELECT * FROM paciente_sem_enfermeiro;

/*
    Descriçao da operaçao em Algebra Relacional:
        NAO SE APLICA

    Requisitos atendidos:
        criar usuário que possua a regra padrão para consulta da view (criadas anteriormente)
        criar uma regra para consulta apenas na visualização criada

    Retorno:
        NAO SE APLICA

*/
CREATE ROLE reader_view;
GRANT SELECT ON hospital.paciente_sem_enfermeiro TO 'reader_view';
CREATE USER 'viewer'@'localhost' IDENTIFIED BY 'viewer';
GRANT 'reader_view' TO 'viewer'@'localhost';
SET DEFAULT ROLE 'reader_view' TO 'viewer'@'localhost';

/*
    Descriçao da operaçao em Algebra Relacional:
        NAO SE APLICA

    Requisitos atendidos:
        criar regra apenas para consultas do banco criado
        criar usuário que possua a regra padrão para consulta (criada anteriormente)

    Retorno:
        NAO SE APLICA

*/
CREATE ROLE role_for_select;
GRANT SELECT ON hospital.* TO 'role_for_select';
CREATE USER 'user_only_for_select'@'localhost' IDENTIFIED BY 'select';
GRANT 'role_for_select' TO 'user_only_for_select'@'localhost';
SET DEFAULT ROLE 'role_for_select' TO 'user_only_for_select'@'localhost';

/*
    Descriçao da operaçao em Algebra Relacional:
        NAO SE APLICA

    Requisitos atendidos:
        criar regra para execução de comandos DDL
        criar usuário que possua a regra padrão para comandos DDL (criada anteriormente)

    Retorno:
        NAO SE APLICA

*/
CREATE ROLE role_for_ddl;
GRANT CREATE ON hospital.* TO 'role_for_ddl';
GRANT ALTER ON hospital.* TO 'role_for_ddl';
GRANT DROP ON hospital.* TO 'role_for_ddl';
CREATE USER 'user_ddl'@'localhost' IDENTIFIED BY 'ddl';
GRANT 'role_for_ddl' TO 'user_ddl'@'localhost';
SET DEFAULT ROLE 'role_for_ddl' TO 'user_ddl'@'localhost';

/*
    Descriçao da operaçao em Algebra Relacional:
        NAO SE APLICA

    Requisitos atendidos:
        criar regra para execução de comandos DML e DQL
        criar usuário que possua a regra padrão para comandos DML e DQL (criada anteriormente)
      
    Retorno:
        NAO SE APLICA

*/
CREATE ROLE role_for_dml_dql;
GRANT INSERT ON hospital.* TO 'role_for_dml_dql';
GRANT UPDATE ON hospital.* TO 'role_for_dml_dql';
GRANT DELETE ON hospital.* TO 'role_for_dml_dql';
GRANT SELECT ON hospital.* TO 'role_for_dml_dql';
CREATE USER 'user_dml_dql'@'localhost' IDENTIFIED BY 'dml_dql';
GRANT 'role_for_dml_dql' TO 'user_dml_dql'@'localhost';
SET DEFAULT ROLE 'role_for_dml_dql' TO 'user_dml_dql'@'localhost';
