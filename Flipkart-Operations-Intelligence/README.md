<img width="1376" height="768" alt="image" src="https://github.com/user-attachments/assets/7a4f1fe6-8169-49e9-bae9-42804f75746b" />


# Flipkart Operations Intelligence & SLA Performance Analytics

### Turning order, delivery and customer data into actionable operational intelligence.

An end-to-end business intelligence project focused on understanding order performance, delivery efficiency, service-level compliance, cancellations and customer behaviour through data engineering, analytical modelling and interactive reporting.

---

## 1. Business Problem

In a large e-commerce operation, processing orders is only one part of the challenge. Maintaining delivery commitments, controlling cancellations and identifying operational bottlenecks are equally important.

Business teams need clear answers to questions such as:

- Where are delivery delays occurring?
- Which cities and product categories experience higher SLA breaches?
- How does cancellation behaviour vary across delivery types?
- Which customer segments contribute most to revenue and order volume?
- How is sales and order performance changing over time?

The objective of this project is to transform raw operational data into a structured analytical solution that helps management monitor performance, identify inefficiencies and make evidence-based decisions.

## 2. Project Objectives

- Build a structured data pipeline for operational reporting.
- Prepare and validate order-level data for analytical use.
- Develop a relational analytical model using SQL Server and SSAS Tabular.
- Define business measures for sales, orders, delivery performance and cancellations.
- Develop an interactive Power BI dashboard for operational monitoring.
- Translate analytical findings into meaningful business insights.

## 3. Technology Stack

| Technology | Purpose |
|---|---|
| SQL Server | Relational data storage and SQL-based data preparation |
| SSIS | ETL and data integration workflow |
| SSAS Tabular | Semantic modelling and centralized analytical measures |
| Power BI | Interactive dashboards and business reporting |
| DAX | KPI calculations and analytical measures |
| Excel / CSV | Source dataset |

## 4. End-to-End Data Architecture

The project follows an end-to-end analytical workflow:

**Source Data → ETL → SQL Server → SSAS Tabular → Power BI**

1. **Data Ingestion:** Operational order data is used as the source for analysis.
2. **ETL & Preparation:** Data integration, cleaning and transformation are organized through the SSIS workflow.
3. **Relational Storage:** SQL Server provides the structured data layer.
4. **Analytical Modelling:** SSAS Tabular provides the semantic model and centralized business calculations.
5. **Visualization:** Power BI connects to the analytical model to deliver interactive reports.

## 5. Dataset Overview

The project uses a 1,500-record Flipkart-style operational order dataset created for portfolio analysis.

Key attributes include:

- Order ID and Order Date
- City and Warehouse
- Product Category
- Order Value
- Order Status
- Delivery Type
- Customer Segment
- Promised Delivery Days
- Actual Delivery Days
- SLA Breach Indicator

**Note:** This is a portfolio dataset and is not official or confidential Flipkart business data.

## 6. Analytical Data Model

The analytical model follows a fact-and-dimension structure.

**Fact Table**
- Fact_Flipkart_Orders

**Dimension Tables**
- Dim_Date
- Dim_Category
- Dim_City
- Dim_Status

This structure supports consistent reporting across time, geography, product categories and order status.

## 7. Business KPIs

The dashboard tracks the following performance indicators:

| KPI | Business Purpose |
|---|---|
| Total Orders | Measures order volume |
| Total Sales | Tracks overall sales value |
| Average Order Value | Measures average transaction value |
| Delivered Orders | Tracks successful deliveries |
| SLA Breach % | Measures delivery commitment failures |
| Within SLA % | Measures on-time delivery performance |
| Cancellation Rate | Tracks cancelled orders |
| Average Delivery Days | Measures actual delivery duration |

Additional analysis includes month-over-month performance, category contribution, city-level trends and customer segmentation.

## 8. Dashboard Pages

The Power BI solution contains six analytical pages.

**01. Executive Overview**

<img width="1412" height="799" alt="01  Executive Overview" src="https://github.com/user-attachments/assets/40c9458c-4367-424e-b213-757a0037a611" />


- Overall business performance
- Sales and order KPIs
- Delivery and SLA overview
- Category and city performance

**02. Sales & Orders Analysis**

<img width="1412" height="799" alt="02  Sales   Orders" src="https://github.com/user-attachments/assets/499307a1-d56d-4490-8ba9-4566253399e1" />


- Monthly sales and order trends
- Category-wise sales contribution
- City-level sales performance
- Delivery type distribution
- Customer segment analysis

**03. Delivery & SLA Analysis**

<img width="1412" height="799" alt="03  Delivery   SLA" src="https://github.com/user-attachments/assets/3d79ea13-abcc-4d93-8d97-22b8acae2f62" />


- Actual versus promised delivery time
- SLA breach performance
- City and category comparisons
- Delivery efficiency monitoring

**04. Cancellation Analysis**

<img width="1412" height="799" alt="04  Cancellation Analysis" src="https://github.com/user-attachments/assets/24766c2f-2c46-4cf3-992d-38efb082ab58" />


- Cancellation volume and rate
- City-level cancellation patterns
- Category-wise cancellation analysis
- Delivery type comparisons

**05. Customer Insights**

<img width="1412" height="799" alt="05  Customer Insights" src="https://github.com/user-attachments/assets/84d38223-f5f0-4135-b74e-5620b132e1f2" />


- Customer segment contribution
- Order volume by segment
- Revenue and average order value analysis
- Customer behaviour patterns

**06. Management View**

<img width="1412" height="799" alt="06  Management View" src="https://github.com/user-attachments/assets/d29e4177-e9a0-4f6d-a94e-2b2d1e1289d5" />


- Consolidated operational performance
- Management-level KPIs
- Key business observations
- Decision-support reporting

## 9. Key Business Findings

Based on the portfolio dataset:

- **1,500 orders** were analysed, generating approximately **₹3.31 million** in sales.
- **1,137 orders (75.80%)** were delivered within the defined SLA.
- **363 orders (24.20%)** breached the delivery SLA.
- The overall cancellation rate was **11.33%**, representing 170 orders.
- Electronics generated the highest category sales at approximately **₹709.5K**.
- Regular customers contributed approximately **57.4%** of total orders.
- Mumbai recorded the highest order volume among the analysed cities.

These findings highlight opportunities to investigate delivery delays, improve service-level compliance and monitor cancellation patterns.

## 10. Business Value

This solution demonstrates how operational data can be converted into a structured decision-support system.

It enables business teams to:

- Monitor operational performance through centralized KPIs.
- Identify cities and categories requiring delivery improvement.
- Track SLA compliance and cancellation trends.
- Understand customer contribution and purchasing behaviour.
- Support management decisions through consistent analytical reporting.

## 11. Repository Structure

```text
Flipkart-Operations-Intelligence/
│
├── SQL Server/
│   ├── README.md
│   └── SQL scripts
│
├── SSIS/
│   ├── README.md
│   └── SSIS project files
│
├── SSAS/
│   ├── README.md
│   └── SSAS model files
│
├── Screenshots/
│   ├── README.md
│   └── Dashboard images
│
├── Flipkart.pbix
├── Flipkart_Raw_Orders.csv
└── README.md
```

## 12. Project Scope & Disclaimer

This is an independent portfolio project developed to demonstrate practical skills in data integration, relational data modelling, analytical modelling, SQL, DAX and business intelligence reporting.

The dataset is synthetic and created for demonstration purposes. The project is not affiliated with or endorsed by Flipkart.

---

**Project:** Flipkart Operations Intelligence & SLA Performance Analytics  
**Domain:** E-commerce Operations & Business Intelligence  
**Focus:** Data Engineering | SQL Analytics | Semantic Modelling | Business Intelligence
