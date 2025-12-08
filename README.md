Flipkart E-Commerce Pricing & Value Analysis – End-to-End BI System
An analytical system to evaluate pricing, discounts, and customer value across smartphone brands.

Project Overview
This end-to-end BI project analyzes pricing patterns, discount strategies, and customer value across smartphones listed on Flipkart.
It combines Python, SQL, and Power BI to deliver a complete price-intelligence system that helps businesses answer key commerce questions:
	• Which brands price their products at a premium?
	• Which models offer true value for money based on RAM/Storage cost efficiency?
	• How do discounts vary across brands and price segments?
	• Which models appear overpriced or underpriced based on rating vs price?
📌 Author: Nagasudha S
📌 Tools: Python, Pandas, SQL Server, Power BI
📌 Dataset: Flipkart Mobiles(https://www.kaggle.com/code/devsubhash/flipkart-mobiles-eda/input)

Project Architecture

📂 data/
   ├── raw/                 → original scraped dataset
   └── cleaned/             → final processed dataset
  
📂 scripts/
   ├── data cleaning & feature engineering (Python)
   └── web scraping demo

📂 sql/
   └── analysis queries (pricing, discount, segmentation)

📂 powerbi/
   ├── Flipkart Mobile Price Intelligence.pbix  
   └── screenshots/ (all dashboard pages)

📂 docs/
   └── cheatsheet/ (optional reference materials)

README.md (this file)

Key Steps & Methodology
1️⃣ Python – Data Cleaning & Feature Engineering
	• Normalized RAM/Storage values (GB, MB, TB unified)
	• Created discount %
	• Computed value metrics:
		○ Price per GB RAM
		○ Price per GB Storage
	• Labeled premium vs budget categories
	• Exported cleaned dataset for SQL + Power BI
📄 Notebook: scripts/01_data_cleaning_and_preparation.ipynb

2️⃣ SQL – Business Analysis
SQL Server queries were used to compute:
	• Average price per brand
	• Premium vs budget distribution
	• Brand-wise discount intensity
	• Overpriced / underpriced flags
	• Value-for-money comparisons
📄 File: sql/FLIPKART_E_COMMERCE.sql

3️⃣ Power BI – Interactive Dashboard System
A 5-page dashboard provides actionable business insights:
1. Executive Summary
	• Avg Selling Price
	• Premium Count
	• Budget Count
	• Avg Discount %
	• Brand-level pricing & discount overview

2. Brand Insights
	• Premium model count
	• Brand-wise discount %
	• Brand pricing positions
	• Price vs Rating (Brand comparison)

3. Value-for-Money
	• Best RAM value (lowest ₹/GB RAM)
	• Best Storage value (lowest ₹/GB Storage)
	• Value-for-money model comparison

4. Discounts & Deals
	• Highest discount models
	• Discount by price segment
	• Heatmap of brand discount intensity

5. Overpriced vs Underpriced Analysis
Based on rating vs price, RAM/storage cost efficiency, and discount patterns:
	• Overpriced models (high price, low rating)
	• Underpriced models (low price, high rating)
	• Scatter plots of customer value positioning

 Business Insights Summary
	• Apple & Google Pixel dominate premium pricing with consistently high ASPs.
	• POCO & Motorola lead discount-driven strategies with aggressive promotions.
	• Nokia & Samsung feature phones offer the strongest RAM/storage value.
	• Many mid-range phones deliver high value, balancing pricing with strong customer ratings.
	• Overpriced models tend to cluster in older premium segments.
	• Underpriced models generally belong to mid-range phones with high ratings.

 How to Run the Project
Python

open scripts/01_data_cleaning_and_preparation.ipynb  
run all cells to generate cleaned dataset
SQL

open sql/FLIPKART_E_COMMERCE.sql in SQL Server  
run queries in order
Power BI

Open PBIX → Refresh data → Interact with dashboards


Nagasudha S
Aspiring Data Analyst | SQL • Python • Power BI
Driven by strong analytical thinking and end-to-end project execution.
<img width="879" height="2892" alt="image" src="https://github.com/user-attachments/assets/524be56f-b988-4f41-951b-78b41eea5d69" />
