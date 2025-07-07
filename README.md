# 🏫 Projeto: Teste final | Code for all

## 📌 Objetivo

Este projeto foi desenvolvido no âmbito de um desafio prático do curso "Introdução à Análise de Dados com SQL" da Code for All_. O objetivo era modelar e analisar uma base de dados de uma escola, aplicando conhecimentos de SQL relacional: criação de tabelas, chaves primárias e estrangeiras, normalização, `JOINs`, `VIEWS` e agregações.

---

## 🗃️ Estrutura da Base de Dados

A base de dados representa uma escola com alunos, professores, disciplinas e turmas.

### Tabelas principais:
- `classes` – Turmas
- `subjects` – Disciplinas
- `teachers` – Professores
- `students` – Alunos

### Tabela relacional adicionada:
- `teachers_classes` – Relação entre professores, disciplinas e turmas (N:N)

---

## 🔧 Funcionalidades Implementadas

### ✅ Criação de tabelas com relações e ações referenciais
- `ON DELETE CASCADE`, `ON DELETE SET NULL`
- Uso de `AUTO_INCREMENT`, `PRIMARY KEY`, `FOREIGN KEY`

### ✅ Inserção de dados simulados
- Dados de 5 alunos, 8 professores, 4 disciplinas e 3 turmas

### ✅ Queries e tarefas:
1. Modelação da relação N:N entre turmas e professores por disciplina
2. Inserção de registos na tabela relacional `teachers_classes`
3. Consulta de professores que ensinam História (`JOIN` com filtro)
4. Consulta de todos os professores mesmo sem disciplina atribuída (`LEFT JOIN`)
5. Criação de uma `VIEW` para mostrar quem dá que disciplina em cada turma
6. Contagem de alunos por turma (`GROUP BY + COUNT`)

---

## 📈 Exemplos de Queries

### 🔹 Professores que ensinam História
```sql
SELECT t.name AS teacher_name, s.name AS subject_name
FROM teachers t
JOIN subjects s ON s.id = t.subject_id
WHERE s.name = 'History';
```

### 🔹 Contagem de alunos por turma
```sql
SELECT c.id AS class_number, COUNT(s.id) AS student_number
FROM classes AS c, students AS s
WHERE s.class_id = c.id
GROUP BY c.id;
```

### 🔹 `VIEW`: professor + disciplina + turma
```sql
CREATE VIEW class_subject_teacher_view AS
SELECT t.name AS teacher_name, s.name AS subject_name, c.id AS class_id
FROM teachers_classes tc
JOIN subjects s ON tc.id_subject = s.id
JOIN classes c ON tc.id_class = c.id
JOIN teachers t ON tc.id_teacher = t.id;
```

---

## 🧠 Aprendizagens

- Modelação de dados relacionais N:N com tabela intermédia
- Utilização de `JOINs`, `LEFT JOINs`, `GROUP BY` e `VIEWS`
- Criação e manutenção de esquemas no MySQL Workbench
- Boas práticas com integridade referencial

---


## 📂 Estrutura de Ficheiros

```
📁 school_management_project/
│
├─ README.md              # Descrição do projeto
├─ school_schema.sql      # Script com CREATE e INSERTs
├─ school_queries.sql     # Todas as queries e soluções
```

