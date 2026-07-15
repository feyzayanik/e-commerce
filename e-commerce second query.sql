----------------------------------------------------------------------
-- QUERY 2.1 : Müşteri Sınıflandırma ---------------------------------
----------------------------------------------------------------------
SELECT
    o.CostomerId AS [Müşteri No],
    SUM(p.ProductPrice * o.OrderQuantity) AS [Toplam Harcama],

    CASE
        WHEN SUM(p.ProductPrice * o.OrderQuantity) >= 5000
            THEN 'Altın Müşteri (VIP)'

        WHEN SUM(p.ProductPrice * o.OrderQuantity) >= 1500
            THEN 'Gümüş Müşteri (Standart)'

        ELSE 'Bronz Müşteri (Düşük Harcamalı)'
    END AS [Müşteri Segmenti]

FROM Orders o
INNER JOIN Products p
ON o.ProductID = p.ProductId

GROUP BY
    o.CostomerId;

----------------------------------------------------------------------
-- QUERY 2.2 : Ödeme Yöntemi Tercihi ---------------------------------
----------------------------------------------------------------------
SELECT PaymentMethode ,
    COUNT(*)  AS [Kullanim Sayisi]
FROM 
    Orders
GROUP BY 
    PaymentMethode
ORDER BY [Kullanim Sayisi] desc;
    
-------------------------------------------------------------------------
-- QUERY 2.3 : En Değerli Müşteriler ------------------------------------
-------------------------------------------------------------------------

SELECT TOP 10
    o.CostomerId AS [Müşteri No],
    COUNT(o.OrderID) AS [Sipariş Sayısı],
    SUM(o.OrderQuantity * p.ProductPrice) AS [Toplam Harcama]
FROM Orders o
INNER JOIN Products p
    ON o.ProductID = p.ProductId
GROUP BY o.CostomerId
ORDER BY [Toplam Harcama] DESC;

