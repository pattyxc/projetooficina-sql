-- queries.sql
USE oficina;

SELECT * FROM cliente;
SELECT * FROM veiculo;

SELECT * FROM ordem_servico WHERE status = 'EM ANDAMENTO';

SELECT os.idOS,
       SUM(s.valor * oss.quantidade) + SUM(p.valor * osp.quantidade) AS total_os
FROM ordem_servico os
LEFT JOIN os_servico oss ON os.idOS = oss.idOS
LEFT JOIN servico s ON s.idServico = oss.idServico
LEFT JOIN os_peca osp ON os.idOS = osp.idOS
LEFT JOIN peca p ON p.idPeca = osp.idPeca
GROUP BY os.idOS;

SELECT nome, cpf_cnpj FROM cliente ORDER BY nome ASC;

SELECT c.nome, COUNT(os.idOS) AS qtde_os
FROM cliente c
JOIN veiculo v ON v.idCliente = c.idCliente
JOIN ordem_servico os ON os.idVeiculo = v.idVeiculo
GROUP BY c.idCliente
HAVING COUNT(os.idOS) >= 1;

SELECT os.idOS, c.nome AS cliente, v.modelo, s.descricao AS servico, f.nome AS mecanico
FROM ordem_servico os
JOIN veiculo v ON v.idVeiculo = os.idVeiculo
JOIN cliente c ON c.idCliente = v.idCliente
LEFT JOIN os_servico oss ON oss.idOS = os.idOS
LEFT JOIN servico s ON s.idServico = oss.idServico
LEFT JOIN os_funcionario ofu ON ofu.idOS = os.idOS
LEFT JOIN funcionario f ON f.idFuncionario = ofu.idFuncionario
ORDER BY os.idOS;

SELECT p.descricao, SUM(osp.quantidade) AS total_usada
FROM os_peca osp
JOIN peca p ON p.idPeca = osp.idPeca
GROUP BY p.idPeca
ORDER BY total_usada DESC;

SELECT c.nome, SUM(pg.valor) AS total_gasto
FROM cliente c
JOIN veiculo v ON v.idCliente = c.idCliente
JOIN ordem_servico os ON os.idVeiculo = v.idVeiculo
JOIN pagamento pg ON pg.idOS = os.idOS
GROUP BY c.idCliente
ORDER BY total_gasto DESC
LIMIT 1;
