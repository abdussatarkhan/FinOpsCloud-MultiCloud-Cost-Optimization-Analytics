-- ============================================================================
-- FinOpsCloud: Enterprise Multi-Cloud Cost & FinOps Intelligence
-- Star Schema DDL (PostgreSQL 16 Enterprise Spec)
-- ============================================================================

CREATE SCHEMA IF NOT EXISTS finops_dw;
SET search_path TO finops_dw, public;

-- Date Dimension
CREATE TABLE IF NOT EXISTS dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL UNIQUE,
    day_name VARCHAR(12) NOT NULL,
    is_weekend BOOLEAN NOT NULL,
    month INT NOT NULL,
    quarter INT NOT NULL,
    year INT NOT NULL
);

CREATE TABLE IF NOT EXISTS dim_cloud_accounts (
    cloud_accounts_key SERIAL PRIMARY KEY,
    cloud_accounts_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dim_services (
    services_key SERIAL PRIMARY KEY,
    services_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dim_k8s_clusters (
    k8s_clusters_key SERIAL PRIMARY KEY,
    k8s_clusters_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS dim_cost_centers (
    cost_centers_key SERIAL PRIMARY KEY,
    cost_centers_code VARCHAR(32) NOT NULL UNIQUE,
    name VARCHAR(100) NOT NULL,
    category VARCHAR(50) NOT NULL,
    status_tier VARCHAR(20) DEFAULT 'ACTIVE',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_daily_cloud_spend (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_ri_savings_plans (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_idle_waste_events (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS fact_unit_cost_metrics (
    event_id BIGSERIAL PRIMARY KEY,
    date_key INT NOT NULL REFERENCES dim_date(date_key),
    metric_value_usd NUMERIC(12, 2) NOT NULL DEFAULT 0.00,
    operational_count INT NOT NULL DEFAULT 1,
    latency_duration_mins NUMERIC(8, 2) NOT NULL DEFAULT 0.0,
    is_sla_compliant BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

