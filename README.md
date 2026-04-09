# AWS Customer Behavior Analytics Pipeline

## 🔹 Business Problem

An e-commerce business faced:

* Very low customer retention (~3%)
* Revenue concentrated among few customers
* Frequent delivery delays (~12 days avg)

Needed a scalable system to analyze customer behavior and operational performance.

---

## 🔹 Solution

Built an **end-to-end AWS data analytics pipeline** to transform raw data into actionable insights.

**Workflow:**
Data → Python Processing → S3 (Data Lake) → Glue (Catalog) → Athena (SQL) → Tableau

---

## 🔹 Architecture

![Architecture](architecture/architecture.png)

---

## 🔹 AWS Data Pipeline (Proof)

### S3 Data Lake (Raw → Processed → Curated)

![S3](outputs/screenshots/s3_bucket.png)

### Raw Data

![Raw](outputs/screenshots/raw_data.png)

### Processed Data

![Processed](outputs/screenshots/processed_data.png)

### Glue Catalog

![Glue](outputs/screenshots/glue_crawler.png)

### Athena (Tables + Query)

![Athena](outputs/screenshots/athena_tables.png)

---

## 🔹 Key Analysis

* Customer segmentation (high vs low value)
* Revenue trends & AOV
* Repeat vs one-time behavior
* Delivery delay analysis
* Retention vs delivery impact

📁 SQL: `/sql/athena_queries.sql`

---

## 🔹 Key Insights

* Retention is critically low (~3%)
* Repeat customers spend ~2x more
* Avg delivery delay ≈ 12 days
* Delays have weak correlation with retention
* Revenue dependency on top customers

---

## 🔹 Business Impact

* Identified high-value customer segment
* Highlighted retention as primary growth lever
* Exposed operational inefficiencies in delivery

---

## 🔹 Dashboard

![Dashboard](dashboard/tableau_dashboard.png)

---

## 🔹 Tech Stack

S3 • Glue • Athena • Python • SQL • Tableau

---
