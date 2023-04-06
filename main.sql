-- Conexão do banco de dados SQL Server utilizando Python

import pyodbc

def connect_db():
    server = 'your_server_name'
    database = 'your_database_name'
    username = 'your_username'
    password = 'your_password'
    driver = '{ODBC Driver 17 for SQL Server}' # altere o driver de acordo com a versão do SQL Server que você estiver usando

    connection_string = f"DRIVER={driver};SERVER={server};DATABASE={database};UID={username};PWD={password}"

    return pyodbc.connect(connection_string)

if __name__ == '__main__':
    with connect_db() as db:
        with open('schema.sql', 'r') as f:
            db.execute(f.read())


-- Criando o banco de dados 

CREATE TABLE users (
    id INT IDENTITY(1,1) PRIMARY KEY,
    username VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL
);

CREATE TABLE expenses (
    id INT IDENTITY(1,1) PRIMARY KEY,
    expense VARCHAR(255) NOT NULL,
    amount FLOAT NOT NULL,
    category VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    FOREIGN KEY (username) REFERENCES users(username)
);


-- Isso criará duas tabelas: users, que armazena informações sobre os usuários do aplicativo (id, nome de usuário e senha), e expenses, que armazena informações sobre as despesas dos usuários (id, nome da despesa, valor, categoria e nome de usuário do usuário que registrou a despesa).

-- Caso queira popular as tabelas podemos usar a instrução INSERT conforme abaixo:


INSERT INTO users (username, password)
VALUES
('johndoe', 'mypassword'),
('janedoe', 'mysecretpassword');

INSERT INTO expenses (expense, amount, category, username)
VALUES
('Café da manhã', 10.5, 'Alimentação', 'johndoe'),
('Transporte', 5.0, 'Transporte', 'janedoe'),
('Jantar', 30.0, 'Alimentação', 'johndoe');


