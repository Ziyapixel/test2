-- Retrieve All Smartphone Data
SELECT * FROM Smartphones
 
 -- Average Selling Price by Brand 
SELECT Brands, AVG([Selling Price]) AS AvgSellingPrice
FROM Smartphones
GROUP BY Brands
ORDER BY AvgSellingPrice DESC;
 
 -- Average Prices and Discounts by Brand and Model
 SELECT Brands, Models,
       AVG([Original Price]) AS AvgOriginalPrice, 
       AVG([Selling Price]) AS AvgSellingPrice,
       AVG(Discount) AS AvgDiscount
FROM Smartphones
GROUP BY Brands,Models
ORDER BY AvgDiscount DESC;

-- Smartphones with the Highest Discount
SELECT Brands, Models, [Original Price], [Selling Price], Discount, [discount percentage]
FROM Smartphones
ORDER BY Discount DESC;

-- Average Rating by Brand and Model 
SELECT Brands, Models, AVG(Rating) AS AvgRating
FROM Smartphones
GROUP BY Brands, Models
ORDER BY AvgRating DESC;

-- Number of Models Available per Brand
SELECT Brands, COUNT(*) AS ModelCount
FROM Smartphones
GROUP BY Brands
ORDER BY ModelCount DESC;

-- Number of Units per Model
SELECT Brands, Models, COUNT(Models) AS ModelCount
FROM Smartphones
GROUP BY Brands, Models
ORDER BY ModelCount DESC;

-- Number of Color Variations per Model 
SELECT Models, Colors, COUNT(*) AS ColorCount
FROM Smartphones
GROUP BY Models, Colors
ORDER BY ColorCount DESC;

-- Rating Category Classification 
SELECT Brands, Models, Rating,
       CASE 
           WHEN Rating < 3.5 THEN 'Low-rated'
           WHEN Rating BETWEEN 3.5 AND 4.2 THEN 'Average-rated'
           ELSE 'High-rated'
       END AS Rating_Category
FROM Smartphones
ORDER BY Rating DESC;

-- Most Expensive and Cheapest Models for Each Brand 
WITH ModelPrices AS (
    SELECT Models, Brands, AVG([Original Price]) AS AvgOriginalPrice
    FROM Smartphones
    GROUP BY Models, Brands
)
SELECT MP.Brands,
       (SELECT TOP 1 Models FROM ModelPrices WHERE Brands = MP.Brands ORDER BY AvgOriginalPrice DESC) AS MostExpensiveModel,
       (SELECT TOP 1 AvgOriginalPrice FROM ModelPrices WHERE Brands = MP.Brands ORDER BY AvgOriginalPrice DESC) AS MostExpensivePrice,
       (SELECT TOP 1 Models FROM ModelPrices WHERE Brands = MP.Brands ORDER BY AvgOriginalPrice ASC) AS CheapestModel,
       (SELECT TOP 1 AvgOriginalPrice FROM ModelPrices WHERE Brands = MP.Brands ORDER BY AvgOriginalPrice ASC) AS CheapestPrice
FROM ModelPrices MP
GROUP BY MP.Brands;

--Creating View 
CREATE VIEW BrandPriceExtremes AS  
WITH ModelPrices AS (  
    SELECT Models, Brands, AVG([Original Price]) AS AvgOriginalPrice  
    FROM Smartphones  
    GROUP BY Models, Brands  
)  
SELECT MP.Brands,  
       (SELECT TOP 1 Models FROM ModelPrices WHERE Brands = MP.Brands ORDER BY AvgOriginalPrice DESC) AS MostExpensiveModel,  
       (SELECT TOP 1 AvgOriginalPrice FROM ModelPrices WHERE Brands = MP.Brands ORDER BY AvgOriginalPrice DESC) AS MostExpensivePrice,  
       (SELECT TOP 1 Models FROM ModelPrices WHERE Brands = MP.Brands ORDER BY AvgOriginalPrice ASC) AS CheapestModel,  
       (SELECT TOP 1 AvgOriginalPrice FROM ModelPrices WHERE Brands = MP.Brands ORDER BY AvgOriginalPrice ASC) AS CheapestPrice  
FROM ModelPrices MP  
GROUP BY MP.Brands;

SELECT * FROM BrandPriceExtremes;

