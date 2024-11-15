CREATE DATABASE IF NOT EXISTS Stocks;
USE Stocks;
SET SQL_SAFE_UPDATES = 0;
CREATE TABLE IF NOT EXISTS `BRK-A` (
    `Date` DATE,
    `Open` DECIMAL(10, 2),
    `High` DECIMAL(10, 2),
    `Low` DECIMAL(10, 2),
    `Close` DECIMAL(10, 2),
    `Adj_Close` DECIMAL(10, 2),
    `Volume` INT,
    `Month` INT NULL,
    `Quarter` INT NULL,
    `Company` VARCHAR(20) DEFAULT 'BRK-A'
);

CREATE TABLE IF NOT EXISTS `DNUT` (
    `Date` DATE,
    `Open` DECIMAL(10, 2),
    `High` DECIMAL(10, 2),
    `Low` DECIMAL(10, 2),
    `Close` DECIMAL(10, 2),
    `Adj_Close` DECIMAL(10, 2),
    `Volume` INT,
    `Month` INT NULL,
    `Quarter` INT NULL,
    `Company` VARCHAR(20) DEFAULT 'DNUT' 
);

CREATE TABLE IF NOT EXISTS `DPZ` (
    `Date` DATE,
    `Open` DECIMAL(10, 2),
    `High` DECIMAL(10, 2),
    `Low` DECIMAL(10, 2),
    `Close` DECIMAL(10, 2),
    `Adj_Close` DECIMAL(10, 2),
    `Volume` INT,
    `Month` INT NULL,
    `Quarter` INT NULL,
    `Company` VARCHAR(20) DEFAULT 'DPZ' 
);

CREATE TABLE IF NOT EXISTS `LKNCY` (
    `Date` DATE,
    `Open` DECIMAL(10, 2),
    `High` DECIMAL(10, 2),
    `Low` DECIMAL(10, 2),
    `Close` DECIMAL(10, 2),
    `Adj_Close` DECIMAL(10, 2),
    `Volume` INT,
    `Month` INT NULL,
    `Quarter` INT NULL,
    `Company` VARCHAR(20) DEFAULT 'LKNCY'
);

CREATE TABLE IF NOT EXISTS `MCD` (
    `Date` DATE,
    `Open` DECIMAL(10, 2),
    `High` DECIMAL(10, 2),
    `Low` DECIMAL(10, 2),
    `Close` DECIMAL(10, 2),
    `Adj_Close` DECIMAL(10, 2),
    `Volume` INT,
    `Month` INT NULL,
    `Quarter` INT NULL,
    `Company` VARCHAR(20) DEFAULT 'MCD'
);

CREATE TABLE IF NOT EXISTS `PZZA` (
    `Date` DATE,
    `Open` DECIMAL(10, 2),
    `High` DECIMAL(10, 2),
    `Low` DECIMAL(10, 2),
    `Close` DECIMAL(10, 2),
    `Adj_Close` DECIMAL(10, 2),
    `Volume` INT,
    `Month` INT NULL,
    `Quarter` INT NULL,
    `Company` VARCHAR(20) DEFAULT 'PZZA' 
);

CREATE TABLE IF NOT EXISTS `QSR` (
    `Date` DATE,
    `Open` DECIMAL(10, 2),
    `High` DECIMAL(10, 2),
    `Low` DECIMAL(10, 2),
    `Close` DECIMAL(10, 2),
    `Adj_Close` DECIMAL(10, 2),
    `Volume` INT,
    `Month` INT NULL,
    `Quarter` INT NULL,
    `Company` VARCHAR(20) DEFAULT 'QSR' 
);

CREATE TABLE IF NOT EXISTS `SBUX` (
    `Date` DATE,
    `Open` DECIMAL(10, 2),
    `High` DECIMAL(10, 2),
    `Low` DECIMAL(10, 2),
    `Close` DECIMAL(10, 2),
    `Adj_Close` DECIMAL(10, 2),
    `Volume` INT,
    `Month` INT NULL,
    `Quarter` INT NULL,
    `Company` VARCHAR(20) DEFAULT 'SBUX' 
);

CREATE TABLE IF NOT EXISTS `WEN` (
    `Date` DATE,
    `Open` DECIMAL(10, 2),
    `High` DECIMAL(10, 2),
    `Low` DECIMAL(10, 2),
    `Close` DECIMAL(10, 2),
    `Adj_Close` DECIMAL(10, 2),
    `Volume` INT,
    `Month` INT NULL,
    `Quarter` INT NULL,
    `Company` VARCHAR(20) DEFAULT 'WEN' 
);

CREATE TABLE IF NOT EXISTS `YUM` (
    `Date` DATE,
    `Open` DECIMAL(10, 2),
    `High` DECIMAL(10, 2),
    `Low` DECIMAL(10, 2),
    `Close` DECIMAL(10, 2),
    `Adj_Close` DECIMAL(10, 2),
    `Volume` INT,
    `Month` INT NULL,
    `Quarter` INT NULL,
    `Company` VARCHAR(20) DEFAULT 'YUM' 
);

CREATE TABLE IF NOT EXISTS stock_predictions (
    Company VARCHAR(10) NOT NULL,
    ds DATE NOT NULL,
    Predicted_Price FLOAT,
    Lower_Confidence_Interval FLOAT,
    Upper_Confidence_Interval FLOAT,
    PRIMARY KEY (Company, ds)
);

CREATE TABLE IF NOT EXISTS merged_stock_data (
    Date DATE,
    Open DECIMAL(10, 2),
    High DECIMAL(10, 2),
    Low DECIMAL(10, 2),
    Close DECIMAL(10, 2),
    Adj_Close DECIMAL(10, 2),
    Volume BIGINT,
    Company VARCHAR(20),
    Month INT,
    Quarter INT
);

CREATE TABLE company_details (
    Company_Name VARCHAR(255) NOT NULL,
    Company_Summary TEXT,
    Recent_Stock_News TEXT
);
INSERT INTO company_details (Company_Name, Company_Summary, Recent_Stock_News) VALUES
('BRK-A', 
 'Berkshire Hathaway Inc. is a multinational conglomerate led by Warren Buffett, owning a range of businesses. Known for its value investing approach, it holds significant investments in diverse sectors. It has subsidiaries in insurance, utilities, railroads, and consumer goods.', 
 'Recent news highlights Berkshire Hathaway’s increasing focus on AI through strategic investments, driving its stock upward.'),
 
('DNUT', 
 'Krispy Kreme, Inc. specializes in premium doughnuts and has a global presence in retail and wholesale markets. Known for its hot, fresh doughnuts, it maintains a loyal customer base. Krispy Kreme continues to expand into international markets and explore new product varieties.', 
 'Recent reports show Krispy Kreme’s interest in leveraging e-commerce for higher direct sales, with strong investor reactions.'),

('DPZ', 
 'Domino’s Pizza, Inc. is one of the largest pizza delivery chains in the world, with a strong presence in digital and online ordering. Known for efficient delivery and customer convenience, it’s constantly innovating to retain its market leadership. Franchise expansion is a core growth strategy.', 
 'Recent stock gains reflect Domino’s push towards drone delivery and enhanced digital solutions, improving customer experience.'),

('LKNCY', 
 'Luckin Coffee Inc. is a Chinese coffeehouse chain rapidly expanding in China. The company offers a tech-driven approach to customer engagement and loyalty. Known as a Starbucks competitor, it aims to be the top coffee chain in China.', 
 'Recent news highlights Luckin Coffee’s innovative product launches, increasing stock value as demand surges in China.'),

('MCD', 
 'McDonald’s Corporation is the world’s leading global foodservice retailer with millions of daily customers. Known for its iconic menu, McDonald’s operates in over 100 countries, focusing on quick service and quality. Digital innovation and menu updates drive its growth.', 
 'Recent headlines showcase McDonald’s global expansion plans, boosting investor confidence amid rising sales figures.'),

('PZZA', 
 'Papa John’s International, Inc. is a major pizza delivery and carryout chain known for using fresh ingredients. Its “Better Ingredients, Better Pizza” slogan highlights quality and customer appeal. The company is expanding in various markets, with franchise growth as a priority.', 
 'Recent stock increase follows news of Papa John’s new franchise agreements, enhancing growth in key regions.'),

('QSR', 
 'Restaurant Brands International Inc. owns Burger King, Tim Hortons, and Popeyes. This global fast-food giant is focused on market expansion and digital transformation. QSR continues to innovate in product offerings and convenience options across its brands.', 
 'Recent announcements of global expansion and digital upgrades have positively impacted QSR’s stock performance.'),

('SBUX', 
 'Starbucks Corporation is a premier roaster and retailer of specialty coffee globally, with a vast network of stores worldwide. Known for its customer-centric ambiance, Starbucks has loyal clientele and is constantly innovating in product and service offerings.', 
 'Stock uptick reflects Starbucks’ plans to open 10,000 new stores and prioritize sustainability in sourcing and operations.'),

('WEN', 
 'The Wendy’s Company operates as a quick-service restaurant chain focused on quality ingredients and unique offerings. With a commitment to freshness, Wendy’s is expanding its footprint through franchises and new menu items. Innovation and quality remain its core strategies.', 
 'Recent stock gains follow Wendy’s global expansion and menu innovation strategy to attract new customers.'),

('YUM', 
 'Yum! Brands, Inc. owns several renowned fast-food chains including KFC, Taco Bell, and Pizza Hut. Known for its global presence, Yum! Brands is focused on innovation and market adaptation. The company’s franchise-driven model supports consistent expansion.', 
 'Recent gains are attributed to Yum! Brands’ positive Q3 earnings, backed by strong international sales growth.');
 
INSERT INTO merged_stock_data (Date, Open, High, Low, Close, Adj_Close, Volume, Company)
SELECT Date, Open, High, Low, Close, Adj_Close, Volume, Company FROM `BRK-A`
UNION ALL
SELECT Date, Open, High, Low, Close, Adj_Close, Volume, Company FROM `DNUT`
UNION ALL
SELECT Date, Open, High, Low, Close, Adj_Close, Volume, Company FROM `DPZ`
UNION ALL
SELECT Date, Open, High, Low, Close, Adj_Close, Volume, Company FROM `LKNCY`
UNION ALL
SELECT Date, Open, High, Low, Close, Adj_Close, Volume, Company FROM `MCD`
UNION ALL
SELECT Date, Open, High, Low, Close, Adj_Close, Volume, Company FROM `PZZA`
UNION ALL
SELECT Date, Open, High, Low, Close, Adj_Close, Volume, Company FROM `QSR`
UNION ALL
SELECT Date, Open, High, Low, Close, Adj_Close, Volume, Company FROM `SBUX`
UNION ALL
SELECT Date, Open, High, Low, Close, Adj_Close, Volume, Company FROM `WEN`
UNION ALL
SELECT Date, Open, High, Low, Close, Adj_Close, Volume, Company FROM `YUM`;

select * from merged_stock_data;
