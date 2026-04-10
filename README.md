# AWS Customer Behavior Analytics Pipeline

## 🚨 Problem
E-commerce platforms often struggle with:
- Extremely low customer retention (~3%)
- Lack of visibility into customer behavior
- Revenue concentration among few users

---

## 💡 Solution
Built a scalable AWS-based analytics pipeline to process customer transaction data and generate actionable insights.

---

## 🏗️ Architecture
![Architecture](architecture/architecture.png)

---

## ⚙️ Pipeline Flow
Raw Data → S3 (Data Lake) → AWS Glue (ETL & Catalog) → Athena (SQL Analysis) → Tableau (Dashboard)

---

## 🛠️ Tech Stack
- AWS S3 (Data Storage)
- AWS Glue (ETL + Data Catalog)
- Amazon Athena (Serverless SQL)
- SQL
- Python (Data Preprocessing)
- Tableau (Visualization)

---

## 📊 Key Insights
- Repeat customers spend ~2x more than one-time users
- Customer retention is critically low (~3%)
- Revenue is concentrated among a small group of users
- Delivery delays have limited impact on retention

---

## 📈 Business Impact
- Identified retention as the biggest growth opportunity
- Suggested targeting high-value repeat customers
- Highlighted need for customer loyalty strategies

---

## 📸 Implementation Proof

### S3 Data Lake Structure
![S3](architecture/s3_data_lake_structure.png)

### Glue Data Catalog
![Glue](architecture/glue_catalog.png)

### Athena Query Execution
![Athena](architecture/athena_query_execution.png)

---

## 🚀 Future Improvements
- Real-time pipeline using AWS Kinesis
- Churn prediction using machine learning
- Automated ETL workflows

---

## 📌 Author
Sujal Gupta
