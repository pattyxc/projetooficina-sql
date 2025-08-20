-- seed.sql
USE oficina;

INSERT INTO cliente (nome, cpf_cnpj, telefone, endereco) VALUES
('Ana Souza','12345678901','13999990000','Rua A, 100'),
('Bruno Lima','22233344455','13988887777','Av. B, 200'),
('Tech Motors LTDA','11222333444455','1133332222','Rua Comercial, 500');

INSERT INTO veiculo (idCliente, marca, modelo, ano, placa) VALUES
(1,'Toyota','Corolla',2018,'ABC1234'),
(2,'Honda','Civic',2020,'XYZ9876'),
(3,'Fiat','Toro',2022,'DEF5678');

INSERT INTO funcionario (nome, funcao) VALUES
('Carlos Mecânico','Mecânico'),
('João Eletricista','Eletricista'),
('Mariana Atendente','Atendente');

INSERT INTO servico (descricao, valor) VALUES
('Troca de Óleo',150.00),
('Revisão Completa',500.00),
('Alinhamento',100.00);

INSERT INTO peca (descricao, valor, quantidade_estoque) VALUES
('Filtro de Óleo',40.00,50),
('Pneu Aro 16',400.00,20),
('Bateria 60Ah',600.00,10);

INSERT INTO ordem_servico (idVeiculo, data_abertura, status) VALUES
(1,'2025-08-01','CONCLUIDA'),
(2,'2025-08-10','EM ANDAMENTO'),
(3,'2025-08-15','ABERTA');

INSERT INTO os_servico (idOS, idServico, quantidade) VALUES
(1,1,1),
(1,3,1),
(2,2,1),
(3,1,1);

INSERT INTO os_peca (idOS, idPeca, quantidade) VALUES
(1,1,1),
(1,2,2),
(2,3,1);

INSERT INTO os_funcionario (idOS, idFuncionario) VALUES
(1,1),
(1,2),
(2,1),
(3,2);

INSERT INTO pagamento (idOS, forma, valor) VALUES
(1,'PIX',290.00),
(2,'CARTAO',500.00);
