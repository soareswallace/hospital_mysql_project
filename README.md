# Iniciando este projeto usando Docker

Primeiro dê um pull da imagem do Docker Hub.
`docker pull mysql/mysql-server:latest`

Inicie o conatinaer da imagem do MySQL.

`docker run --name=<container_name> -d mysql/mysql-server:latest`

Mude a senha padrão criada ao iniciar o container. A senha pode ser vista olhando os logs do container usando o comando abaixo:

`docker logs <container_name>`

Agora com a senha em mãos você pode entrar no container usando a senha padrão criada durante a criação.

`docker exec -it <container_name> mysql -uroot -p`

Logo após entrar no container altere a senha para uma que você possa se lembrar usando o comando abaixo:

`ALTER USER 'root'@'localhost' IDENTIFIED BY 'newpassword';`

## Critérios do projeto

## Scripts
- [x] Ajuste no projeto lógico
- [x] Algebra relacional nos scripts
- [x] valor padrão para atributo criado
- [x] validação de dados a serem inseridos
- [x] ação de disparo referencial
- [x] selecionar todos os dados de uma tabela
- [x] selecionar um subconjunto de atributos de uma tabela
- [x] selecionar dados de uma tabela mediante alguma condição
- [x] realizar seleção de dados sem apresentar duplicadas
- [x] realizar consulta de seleção-projeção-junção
- [x] atribuir “apelidos”
- [x] aplicar união
- [x] aplicar interseção
- [x] aplicar diferença
- [x] aplicar produto cartesiano
- [x] realizar seleção sob condição que envolva outra seleção
- [x] consultar valores de atributos que iniciem por algum termo
- [x] ordenar resultados de consultas de forma ascendente
- [x] utilizar função de agregação
- [x] realizar agrupamento de resultado de consulta
- [x] criar regra apenas para consultas do banco criado
- [x] criar regra para execução de comandos DML e DQL
- [x] criar regra para execução de comandos DDL
- [x] criar usuário que possua a regra padrão para consulta (criada anteriormente)
- [x] criar usuário que possua a regra padrão para comandos DML e DQL (criada anteriormente)
- [x] criar usuário que possua a regra padrão para comandos DDL (criada anteriormente)
- [x] criar uma transação única
- [x] criar uma view a partir de mais de uma tabela
- [x] criar uma regra para consulta apenas na visualização criada
- [x] criar usuário que possua a regra padrão para consulta da view (criadas anteriormente)
