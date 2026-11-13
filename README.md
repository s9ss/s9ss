<div align="center">
  <img src="./assets/session.svg?v=2" alt="A database session listing the engineer table: sql since 2021, python since 2022, machine_learning since 2024, llm_tooling since 2025" width="100%" />
</div>

<br />

### `schema`

| column | value |
| :-- | :-- |
| `handle` | s9ss |
| `name` | Saud AL-Mutairi |
| `role` | CS student · SQL AI engineer |
| `located` | Riyadh, Saudi Arabia · UTC+3 |
| `focus` | query engines, retrieval, LLM tooling |
| `state` | `building` |

### `indexes`

```sql
CREATE INDEX idx_languages ON engineer (sql, python, cpp, javascript);
CREATE INDEX idx_data      ON engineer (postgresql, bigquery, pandas);
CREATE INDEX idx_ml        ON engineer (pytorch, transformers, rag);
CREATE INDEX idx_infra     ON engineer (docker, linux, git, actions);
```

### `open_loops`

```sql
SELECT * FROM work WHERE state = 'in_progress';
```

```text
  a query-plan visualiser for postgres
  a retrieval eval harness that doesn't lie to me
  notes on index-only scans and when they fail
```

### `reach`

```sql
SELECT contact FROM engineer WHERE handle = 's9ss';
-- → github.com/s9ss        open an issue, or start a discussion
```

<br />

<div align="center">
  <img src="./assets/footer.svg?v=2" width="100%" alt="still querying" />
</div>
