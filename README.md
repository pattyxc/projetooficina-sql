# Oficina Mecânica – Esquema Lógico e Consultas (MySQL)

Este repositório é a entrega do **Desafio de Projeto – Oficina Mecânica em MySQL**.  
Projeto de banco de dados relacional para um cenário de **oficina mecânica**, incluindo clientes, veículos, ordens de serviço, serviços, peças, funcionários e pagamentos.

## Como executar

1. **Crie o schema**  
   - Abra o MySQL Workbench (ou CLI) e rode:
   ```sql
   SOURCE /path/para/schema.sql;
   ```

2. **Carregue dados de teste**  
   ```sql
   SOURCE /path/para/seed.sql;
   ```

3. **Rode as consultas de exemplo**  
   ```sql
   SOURCE /path/para/queries.sql;
   ```

> Requer **MySQL 8+** (usa `CHECK`, `ENUM`).

## Decisões de modelagem

- **Cliente → Veículo → OS**: relacionamento 1:N em cadeia.  
- **Serviços, Peças e Funcionários**: relacionados às OS via tabelas associativas N:N.  
- **Pagamentos**: associados diretamente à OS, permitindo múltiplos pagamentos por ordem.  
- **Status da OS**: controlado por `ENUM` (`ABERTA`, `EM ANDAMENTO`, `CONCLUIDA`).  
- **Peças**: controle de estoque simplificado com quantidade disponível.  

## Consultas que respondem às perguntas do desafio

- **Quais OS estão em andamento?** → query (2).  
- **Qual o valor total de cada OS?** → query (3).  
- **Quantas OS cada cliente possui?** → query (5).  
- **Qual cliente mais gastou na oficina?** → query (8).  
- **Quais peças foram mais utilizadas?** → query (7).  
- **Relação OS, cliente, veículo, serviços e mecânicos** → query (6).  

## Estrutura de repositório sugerida

```
oficina-sql/
├─ schema.sql
├─ seed.sql
├─ queries.sql
└─ README.md
```
