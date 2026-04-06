{% docs __overview__ %}
# 🏀 NBA Analytics dbt Project

This dbt project is an end-to-end pipeline for **NBA game and team analytics**, transforming raw game data into analytics-ready datasets.

![NBA Banner](https://images.unsplash.com/photo-1519861531473-9200262188bf?fm=jpg&q=60&w=3000&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8YmFza2V0YmFsbHxlbnwwfHwwfHx8MA%3D%3D)

---

## 📊 Overview

The project models:

- Game-level data (home vs away)
- Team performance per game
- Season aggregates
- Advanced metrics (net stats, rankings)

The goal is to provide a **clean, scalable analytics layer** for:

- BI dashboards
- Data science
- Performance analysis

---

## 🧱 Data Model Architecture

The project follows a layered approach:

**Raw → Staging → Intermediate → Mart**

- **Raw**: Source tables from the NBA data feed  
- **Staging (`stg_`)**: Cleans and reshapes raw tables  
- **Intermediate (`int_`)**: Combines staging models, adds business logic  
- **Mart (`fct_`)**: Aggregated, analytics-ready tables

---

## 📈 Key Metrics

### Team Metrics
Points, field goals, three-pointers, free throws, rebounds, assists  
(e.g., `team_pts`, `team_fgm`, `team_fg3_pct`, `team_ast`)

### Opponent Metrics
Same structure as team metrics, prefixed with `opponent_`

### Net Metrics
Difference between team and opponent stats (e.g., `net_pts`, `net_fgm`)

### Rankings
Per season ranks for all metrics:

- `team_*_rank`  
- `opponent_*_rank`  
- `net_*_rank`

---
{% enddocs %}