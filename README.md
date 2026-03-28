# Data-Warehousing-Portfolio-Project 🚀
Building the modern data warehouse with SQL Server, including ETL processes, data modeling and data flow.

Hello everyone! My name is Yan Hein Aung and this project is one of my portfolio projects for a data analyst position. This project demonstrates my ability to design and implement a complete data warehouse with fully automated ETL pipeline with Microsoft SQL Server. The goal of this project is to showcase practical skills in data engineering, advanced SQL, data modeling, and analytics, following industry best practices used in modern data platforms.

# Data warehouse plan
![image alt](https://github.com/yanheinaung23-eng/Data-Warehousing-Portfolio-Project/blob/bb01120268535831a457112dcf325a885e8040d1/documents/Data%20warehouse%20plan.png)
# Problem Scenario 🏢

The company operates across multiple separate data sources like ERP and CRM platforms without ETL pipeline. As a result, the company faces data challenges:

- Fragmented and inconsistent data all across departments
- Extra workload for data analyst team cleaning data from multiple different data sources resulting in poor data quality. High   risk for human errors and time consuming workflow.
- Difficult to use data for stakeholders and business users in order to make important decisions.

# Solution 💡

To address these challenges, I designed and implemented a SQL-based modern data warehouse following Medallion Architecture - structured the data pipeline into Bronze, Silver and Gold layers.

This data pipeline allows the company:
- Data reliability with structured data architecture and pipeline.
- Data quality improvements as a result of validation and transformation logic in Silver layer
- Reduced extra workflow, reduced risk of human errors for the team in order to make effective data analysis report in short time with   structured star schema model.
- Improved data accessibility for stakeholders and business users with consistent datasets
- Fully automated ETL pipeline enables the company faster decision making with enhanced data quality.

# Data workflow
![image alt](https://github.com/yanheinaung23-eng/Data-Warehousing-Portfolio-Project/blob/827a282dac40518bbfd902fa2a5037c068a44412/documents/Final%20Data%20flow%20chart.png)

## 1. Data Ingestion (Bronze Layer) 🥉

The workflow begins with ingesting raw data from multiple source systems into the data warehouse.
Process:
- Extract data from ERP and CRM systems (CSV format)
- Load data into SQL Server using TRUNCATE and BULK INSERT operations
- Store data in the Bronze layer without transformation and created stored procedure using CREATE OR ALTER, BEGIN TRY to handle errors.
  [sql script](https://github.com/yanheinaung23-eng/Data-Warehousing-Portfolio-Project/tree/d1831f0abc7b577655bca9f692dab8c42d4d2113/scripts/Bronze%20layer)

## 2. Data Processing & Standardization (Silver Layer) 🥈

After ingestion, data is transformed in the Silver layer to improve quality and consistency.
Process:
- Data cleansing (handling nulls, removing duplicates)
- Standardization (date formats, text normalization, phone column formatting, email column formatting, gender column             formatting)
- Transforming inconsistent data, discuss with team and correct them. (transforming category column into consistent data)
- Data type conversions (e.g., string to numeric/date)
- Load cleaned data in the Silver layer using TRUNCATE and INSERT INTO.
  [sql script](https://github.com/yanheinaung23-eng/Data-Warehousing-Portfolio-Project/tree/a798913611d4fdab79af8b5ebb012daa87d6ab14/scripts/Silver%20layer)

## 3. Data Integration (Gold Layer) 🥇

At this stage, datasets from different systems are unified into a single model.
Process:
- Join ERP and CRM datasets using common keys
- Discuss with team and added discount column and markup column since the sales amount and product prices are not aligned.
- Resolve data inconsistencies between systems
- Align schemas and naming conventions
  [sql script](https://github.com/yanheinaung23-eng/Data-Warehousing-Portfolio-Project/tree/a798913611d4fdab79af8b5ebb012daa87d6ab14/scripts/Gold%20layer)

## 4. Data Modeling (Gold Layer) 🥇

The integrated data is transformed into an analytics-optimized structure.
Schema and model design using draw.io

Model Design
Fact Tables: Store measurable metrics (e.g., sales, transactions)

Dimension Tables: Store descriptive attributes (e.g., customers, products)
Schema: Star Schema

# Conclusion 📊

By building this system, I demonstrated how to convert disconnected data sources into a centralized, reliable, and analytics-ready platform that supports business decision-making. The final output enables stakeholders to easily analyze customer behavior, product performance, and sales trends.

# Skills 🛠️

## Data Engineering
ETL Pipeline Design and Development

Data Ingestion and Transformation

Data Cleaning and Standardization

Data Integration from Multiple Sources

Data Quality Validation and Testing

## Data Warehousing
Medallion Architecture (Bronze, Silver, Gold)

Dimensional Data Modeling (Star Schema)

Fact and Dimension Table Design

Data Layering and Pipeline Structuring

## SQL Development
Advanced SQL Queries

Joins, Aggregations, Window Functions

Data Transformation and Optimization

Stored Procedures and Script Automation

-----------------------------------------------------------------------------------------------
Datasets from Kaggle - [daasets](https://github.com/yanheinaung23-eng/Data-Warehousing-Portfolio-Project/tree/a798913611d4fdab79af8b5ebb012daa87d6ab14/datasets)

Data Type Dictionary for gold layer - [Data Catalog](https://github.com/yanheinaung23-eng/Data-Warehousing-Portfolio-Project/blob/bb01120268535831a457112dcf325a885e8040d1/documents/Data%20Type%20Dictionary%20for%20Gold%20layer.docx)

-----------------------------------------------------------------------------------------------
🛡️ License This project is licensed under the MIT License. You are free to use, modify, and share this project with proper attribution.
