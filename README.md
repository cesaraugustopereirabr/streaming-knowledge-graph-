# 🎬 Streaming Knowledge Graph (Modelo de Grafo de Conhecimento para Serviço de Streaming)

## 💡 Visão Geral

Este repositório contém o modelo de dados e o script de população (seed data) para um **Grafo de Conhecimento** focado em um serviço de *streaming*. O modelo utiliza a arquitetura de **Grafo de Propriedades** e é projetado para ser executado em plataformas como **Neo4j**, otimizando consultas complexas de recomendação, descoberta e análise de consumo.

## ⚙️ Arquitetura do Grafo

O modelo é composto pelas seguintes **entidades (nós)** e **conexões (relacionamentos)**, permitindo uma rica navegação e análise de afinidade.

### Entidades (Nós)

| Rótulo | Descrição | Propriedade Chave (Constraint/Index) |
| :--- | :--- | :--- |
| **User** | Consumidor do conteúdo. | `userId` (UNIQUE) |
| **Movie** | Conteúdo do tipo Filme. | `movieId` (UNIQUE) |
| **Series** | Conteúdo do tipo Série. | `seriesId` (UNIQUE) |
| **Actor** | Profissional de atuação. | `actorId` (UNIQUE) |
| **Director** | Profissional de direção. | `directorId` (UNIQUE) |
| **Genre** | Categoria do conteúdo. | `name` (UNIQUE) |

### Conexões (Relacionamentos)

| Relacionamento | De (Origem) | Para (Destino) | Propriedades Chave |
| :--- | :--- | :--- | :--- |
| **WATCHED** | `(:User)` | `(:Movie)` / `(:Series)` | `rating` (Integer), `watchedOn` (DateTime) |
| **ACTED_IN** | `(:Actor)` | `(:Movie)` / `(:Series)` | - |
| **DIRECTED** | `(:Director)` | `(:Movie)` / `(:Series)` | - |
| **IN_GENRE** | `(:Movie)` / `(:Series)` | `(:Genre)` | - |

## 🚀 Como Utilizar

### 1. Pré-requisitos

É necessário ter uma instância de um banco de dados de grafo que suporte a linguagem **Cypher**, como o **Neo4j Desktop** ou **AuraDB**.

### 2. Importação dos Dados

O arquivo `streaming_data.cypher` contém os comandos necessários para inicializar o banco de dados.

1.  **Limpar (Opcional):** Se estiver recarregando os dados, limpe o banco (use com cautela!):
    ```cypher
    MATCH (n) DETACH DELETE n;
    ```
2.  **Carregar:** Execute o conteúdo completo do arquivo `data/streaming_data.cypher` no seu *driver* Cypher ou *browser* de console. O script garante:
    * Criação de **Constraints e Índices** para integridade de dados e performance.
    * População de 10+ nós de cada tipo (`User`, `Movie`, `Series`, etc.).
    * Criação dos relacionamentos (`WATCHED`, `ACTED_IN`, `DIRECTED`, `IN_GENRE`) com suas respectivas propriedades.

## 🔍 Exemplo de Consulta (Cypher)

Para encontrar filmes assistidos pelo usuário `neo_user_alpha` que foram dirigidos por Christopher Nolan:

```cypher
MATCH (u:User {username: 'neo_user_alpha'})-[:WATCHED]->(content)
MATCH (d:Director {name: 'Christopher Nolan'})-[:DIRECTED]->(content)
RETURN content.title AS Title, d.name AS Director, u.username AS User;
