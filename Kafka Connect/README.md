#   <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/apachekafka/apachekafka-original-wordmark.svg" width="40" height="40"/> DEMOS KAFKA CONNECT 
###  <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/docker/docker-original-wordmark.svg" width="40" height="40"/> Compose 
- docker compose up -d
#
## Acessar <img src="https://cdn.jsdelivr.net/gh/devicons/devicon/icons/mysql/mysql-original-wordmark.svg"  width="40" height="40"/> 
- docker exec -it mysql bash;
- mysql -uroot -p;
- password:| |
#### Para acessar seu banco
- use eldorado;

### Criando Tabela
- create table colaboradores (idt_colaborador MEDIUMINT NOT NULL AUTO_INCREMENT, num_cpf bigint, des_name VARCHAR(50), des_genero char(1), dat_nascimento date, dat_insert timestamp default CURRENT_TIMESTAMP(), PRIMARY KEY (idt_colaborador), unique(num_cpf));

### Inserindo Dados
- insert into colaboradores (num_cpf, des_name, des_genero, dat_nascimento) values (12345678910, 'Joao Paulo Silva', 'M','1992-09-28');
#
