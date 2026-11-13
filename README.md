<div align="center">
  <img src="./assets/session.svg?v=4" alt="Build console: an environment build plan next to a capability table listing environment_security, network_defense, offensive_labs and ai_security" width="100%" />
</div>

<br />

### `schema`

| column | value |
| :-- | :-- |
| `handle` | s9ss |
| `name` | Saudx0 |
| `role` | CS student · security environment development |
| `located` | Riyadh, Saudi Arabia · UTC+3 |
| `focus` | hardening, network defense, offensive labs, AI security |
| `state` | `building` |

### `indexes`

```sql
CREATE INDEX idx_security ON engineer (environment_hardening, network_defense);
CREATE INDEX idx_offense  ON engineer (enumeration, exploitation, reporting);
CREATE INDEX idx_systems  ON engineer (linux, python, docker, ci);
```

### `open_loops`

```sql
SELECT * FROM work WHERE state = 'in_progress';
```

```text
  a home lab i can build, break and rebuild without thinking about it
  hardening baselines that a small org can actually follow
  notes on securing model endpoints before someone else does it for me
```

### `reach`

```sql
SELECT contact FROM engineer WHERE handle = 's9ss';
-- → github.com/s9ss        open an issue, or start a discussion
```

<br />

<div align="center">
  <img src="./assets/footer.svg?v=4" width="100%" alt="assume breach" />
</div>
