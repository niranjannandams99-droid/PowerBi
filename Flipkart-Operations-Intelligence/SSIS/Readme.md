<img width="384" height="131" alt="image" src="https://github.com/user-attachments/assets/538f232f-3f68-44f5-9300-0fb380101448" />


# SSIS – ETL & Data Integration

## Overview

The SSIS layer handles the data integration component of the Flipkart Operations Intelligence solution.

The objective is to establish an ETL workflow that prepares operational source data for structured storage and subsequent analysis.

## Key Activities

- Developed an SSIS project for data integration.
- Used an SSIS package to organise ETL processing.
- Structured the project to support source-to-destination data movement.
- Configured project-level parameters.
- Connected the ETL layer with the SQL Server database architecture.

## ETL Architecture

**Source Data → Extraction → Transformation → SQL Server**

## Technology Stack

- SQL Server Integration Services (SSIS)
- Visual Studio
- SQL Server

## Project Files

| File | Purpose |
|---|---|
| `Package.dtsx` | Main SSIS ETL package |
| `Project.params` | Project-level parameters |
| `SSIS_Test.database` | SSIS project database configuration |
| `SSIS_Test.dtproj` | SSIS project definition |

## Role in the Architecture

SSIS provides the integration layer, helping prepare operational data before it is consumed by the analytical model.

**Next Layer:** SSAS Tabular Model
