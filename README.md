## Up and Running this project using Docker.

First pull the image from docker hub.
`docker pull mysql/mysql-server:latest`

Launch your MySQL container.

`docker run --name=<container_name> -d mysql/mysql-server:latest`

Check the default password that docker create for your database by looking at the logs. This command will show you the container logs. You should look out for the default password.

`docker logs <container_name>`

After copying the password you can access the MySQL by doing.

`docker exec -it <container_name> mysql -uroot -p`

Right after change your root password by running the following:

`ALTER USER 'root'@'localhost' IDENTIFIED BY 'newpassword';`

