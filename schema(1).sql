-- schema.sql
-- Esquema de Banco de Dados: Oficina Mecânica (MySQL 8+)

DROP DATABASE IF EXISTS oficina;
CREATE DATABASE oficina CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE oficina;

CREATE TABLE cliente (
  idCliente INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  cpf_cnpj VARCHAR(20) UNIQUE NOT NULL,
  telefone VARCHAR(20),
  endereco VARCHAR(150)
);

CREATE TABLE veiculo (
  idVeiculo INT AUTO_INCREMENT PRIMARY KEY,
  idCliente INT NOT NULL,
  marca VARCHAR(50) NOT NULL,
  modelo VARCHAR(50) NOT NULL,
  ano INT,
  placa VARCHAR(10) UNIQUE,
  CONSTRAINT fk_veiculo_cliente FOREIGN KEY (idCliente) REFERENCES cliente(idCliente) ON DELETE CASCADE
);

CREATE TABLE funcionario (
  idFuncionario INT AUTO_INCREMENT PRIMARY KEY,
  nome VARCHAR(100) NOT NULL,
  funcao VARCHAR(50) NOT NULL
);

CREATE TABLE servico (
  idServico INT AUTO_INCREMENT PRIMARY KEY,
  descricao VARCHAR(100) NOT NULL,
  valor DECIMAL(10,2) NOT NULL CHECK (valor >= 0)
);

CREATE TABLE peca (
  idPeca INT AUTO_INCREMENT PRIMARY KEY,
  descricao VARCHAR(100) NOT NULL,
  valor DECIMAL(10,2) NOT NULL CHECK (valor >= 0),
  quantidade_estoque INT NOT NULL DEFAULT 0 CHECK (quantidade_estoque >= 0)
);

CREATE TABLE ordem_servico (
  idOS INT AUTO_INCREMENT PRIMARY KEY,
  idVeiculo INT NOT NULL,
  data_abertura DATE NOT NULL,
  data_fechamento DATE,
  status ENUM('ABERTA','EM ANDAMENTO','CONCLUIDA') DEFAULT 'ABERTA',
  CONSTRAINT fk_os_veiculo FOREIGN KEY (idVeiculo) REFERENCES veiculo(idVeiculo)
);

CREATE TABLE os_servico (
  idOS INT NOT NULL,
  idServico INT NOT NULL,
  quantidade INT NOT NULL DEFAULT 1 CHECK (quantidade > 0),
  PRIMARY KEY (idOS, idServico),
  CONSTRAINT fk_oss_os FOREIGN KEY (idOS) REFERENCES ordem_servico(idOS) ON DELETE CASCADE,
  CONSTRAINT fk_oss_serv FOREIGN KEY (idServico) REFERENCES servico(idServico)
);

CREATE TABLE os_peca (
  idOS INT NOT NULL,
  idPeca INT NOT NULL,
  quantidade INT NOT NULL CHECK (quantidade > 0),
  PRIMARY KEY (idOS, idPeca),
  CONSTRAINT fk_osp_os FOREIGN KEY (idOS) REFERENCES ordem_servico(idOS) ON DELETE CASCADE,
  CONSTRAINT fk_osp_peca FOREIGN KEY (idPeca) REFERENCES peca(idPeca)
);

CREATE TABLE os_funcionario (
  idOS INT NOT NULL,
  idFuncionario INT NOT NULL,
  PRIMARY KEY (idOS, idFuncionario),
  CONSTRAINT fk_osf_os FOREIGN KEY (idOS) REFERENCES ordem_servico(idOS) ON DELETE CASCADE,
  CONSTRAINT fk_osf_func FOREIGN KEY (idFuncionario) REFERENCES funcionario(idFuncionario)
);

CREATE TABLE pagamento (
  idPagamento INT AUTO_INCREMENT PRIMARY KEY,
  idOS INT NOT NULL,
  forma ENUM('PIX','CARTAO','BOLETO','DINHEIRO') NOT NULL,
  valor DECIMAL(10,2) NOT NULL CHECK (valor > 0),
  CONSTRAINT fk_pag_os FOREIGN KEY (idOS) REFERENCES ordem_servico(idOS) ON DELETE CASCADE
);
