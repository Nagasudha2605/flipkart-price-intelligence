CREATE DATABASE FLIPKART_ECOMMERCE;
USE FLIPKART_ECOMMERCE;

-- 1. Creating the table schema
CREATE TABLE flipkart_mobiles_cleaned (
    Brand              VARCHAR(50),
    Model              VARCHAR(150),
    Color              VARCHAR(50),
    Rating             FLOAT,
    Selling_Price      INT,
    Original_Price     INT,
    Memory_GB          FLOAT,
    Storage_GB         FLOAT,
    discount_percentage FLOAT,
    price_gap          INT,
    price_per_GB_RAM   FLOAT,
    price_per_GB_storage FLOAT,
    premium_flag       INT,
    budget_flag        INT
);

-- 2. Importing the CSV file & then pushing into the schema
--- 2.1 Checking the schema of table created in sql server & schema of csv imported
SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'flipkart_mobiles_cleaned'; -- table schema created here

SELECT * 
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'flipkart_mobiles_final'; -- schema from csv imported


--- 2.2 Inserting the data from csv imported file into the table created here
INSERT INTO flipkart_mobiles_cleaned -- table created
SELECT
    Brand,
    Model,
    Color,
    Rating,
    Selling_Price,
    Original_Price,
    Memory_GB,
    Storage_GB,
    discount_percentage,
    price_gap,
    price_per_GB_RAM,
    price_per_GB_storage,
    premium_flag,
    budget_flag
FROM flipkart_mobiles_final;   -- CSV-imported table 

--- 2.3 Checking the number of rows in the table
SELECT COUNT(*) FROM flipkart_mobiles_cleaned;

--- 2.4 Verifying the imported data (sample)
SELECT TOP 10 * 
FROM flipkart_mobiles_final;

--- 2.5 Deleting the csv imported table (we don't need this)
DROP TABLE flipkart_mobiles_final;

SELECT * FROM flipkart_mobiles_cleaned;

-- 3. SQL Business Analysis Queries
--- 3.1 Brand-wise Average Selling Price
SELECT 
	Brand,
	AVG(Selling_Price) AS avg_selling_price
FROM flipkart_mobiles_cleaned
GROUP BY Brand
ORDER BY AVG(Selling_Price) DESC;

--- 3.2 Total Premium vs Budget Phones
SELECT
	SUM(CASE WHEN premium_flag = 1 THEN 1 END) AS premium_phones_count,
	SUM(CASE WHEN budget_flag = 1 THEN 1 END) AS budget_phones_count,
	COUNT(*) AS total_phones_count
FROM flipkart_mobiles_cleaned;

--- 3.3 Top 10 Highest Discount Phones
SELECT TOP 10
	Brand,
	Model,
	Color,
	Selling_Price,
    Original_Price,
	discount_percentage
FROM flipkart_mobiles_cleaned
ORDER BY discount_percentage DESC;

-- 3.4 Best Value-for-Money Phones
/*
price_per_GB_RAM
Lower = better value.
*/
SELECT TOP 10
    Brand,
    Model,
    Selling_Price,
    Memory_GB,
    price_per_GB_RAM
FROM flipkart_mobiles_cleaned
WHERE Memory_GB > 0
ORDER BY price_per_GB_RAM ASC;

-- 3.5 Brand-wise Average Discount
SELECT
	Brand,
	ROUND(AVG(discount_percentage),2) AS avg_discount_percent
FROM flipkart_mobiles_cleaned
GROUP BY Brand
ORDER BY AVG(discount_percentage) DESC;

--- 3.6 Brand-wise Premium Share
SELECT 
    Brand,
    SUM(CASE WHEN premium_flag = 1 THEN 1 END) AS Premium_Count,
    COUNT(*) AS Total,
    ROUND((SUM(CASE WHEN premium_flag = 1 THEN 1 END)*100.0) / COUNT(*), 2) AS Premium_Percentage
FROM flipkart_mobiles_cleaned
GROUP BY Brand
ORDER BY Premium_Percentage DESC;

--- 3.7 Most Overpriced Phones
/*
Overpriced = HIGH selling price +  LOW RAM + LOW Storage + LOW Rating
*/

WITH brand_stats AS (
    SELECT 
        Brand,
        AVG(Selling_Price) AS avg_brand_price,
        AVG(Memory_GB) AS avg_brand_ram
    FROM flipkart_mobiles_cleaned
    GROUP BY Brand
)

SELECT TOP 10
    f.Brand,
    f.Model,
	f.Color
    f.Selling_Price,
    f.Memory_GB,
    f.Storage_GB,
    f.Rating
FROM flipkart_mobiles_cleaned f
JOIN brand_stats b ON f.Brand = b.Brand
WHERE 
    f.Selling_Price > b.avg_brand_price
    AND f.Memory_GB < b.avg_brand_ram,
    AND f.Rating < 3.5
ORDER BY f.Selling_Price DESC;

--- 3.8 Most Underpriced Phones (Best Deals)
/*
Underpriced =LOW selling price +  HIGH RAM + HIGH Storage + HIGH Rating
*/
WITH brand_stats AS (
    SELECT 
        Brand,
        AVG(Selling_Price) AS avg_brand_price,
        AVG(Memory_GB) AS avg_brand_ram,
		AVG(Storage_GB) AS avg_brand_storage
    FROM flipkart_mobiles_cleaned
    GROUP BY Brand
)

SELECT TOP 10
    f.Brand,
    f.Model,
	f.Color,
    f.Selling_Price,
    f.Memory_GB,
    f.Storage_GB,
    f.Rating
FROM flipkart_mobiles_cleaned f
JOIN brand_stats b ON f.Brand = b.Brand
WHERE 
    f.Selling_Price < b.avg_brand_price
    AND f.Memory_GB >= b.avg_brand_ram
    AND f.Storage_GB >= b.avg_brand_storage
    AND f.Rating >= 4.2
ORDER BY f.Selling_Price ASC;

--- 3.9 Best Value-for-Money Storage Phones
/*
price_per_GB_storage
The lower this value ? better value.
*/
SELECT TOP 10
    Brand,
    Model,
	Color,
    Selling_Price,
    Storage_GB,
    price_per_GB_storage
FROM flipkart_mobiles_cleaned
WHERE Storage_GB > 0
ORDER BY price_per_GB_storage ASC;


--- 3.10 Full Phone Pricing Summary View
SELECT
    Brand,
    Model,
	Color,
    Selling_Price,
    Original_Price,
    discount_percentage,
    Memory_GB,
    Storage_GB,
    price_per_GB_RAM,
    price_per_GB_storage,
    premium_flag,
    budget_flag,
    Rating
FROM flipkart_mobiles_cleaned
ORDER BY Brand, Selling_Price DESC;


