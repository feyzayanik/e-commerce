----------------------------------------------------------------------------
-- QUERY 1.1: Kategori Bazlı Sipariş, Satış Adedi ve Toplam Ciro Raporu
----------------------------------------------------------------------------
SELECT 
    c.CategoryName AS [Kategori Adı],
    COUNT(o.OrderID) AS [Toplam Sipariş Sayısı],
    SUM(o.OrderQuantity) AS [Satılan Toplam Ürün Adedi],
    SUM(o.OrderQuantity * p.ProductPrice) AS [Toplam Ciro (TL)],
    AVG(p.ProductPrice) AS [Ortalama Ürün Fiyatı]
FROM dbo.Categories c
INNER JOIN dbo.Products p ON c.CategoryId = p.CategoryId
INNER JOIN dbo.Orders o ON p.ProductId = o.ProductID
GROUP BY c.CategoryName
ORDER BY [Toplam Ciro (TL)] DESC;
----------------------------------------------------------------------------
-- QUERY 1.2: Mağazaya En Yüksek Ciro Kazandıran İlk 10 Ürün
----------------------------------------------------------------------------
SELECT TOP 10
    p.ProductName AS [Ürün Adı],
    c.CategoryName AS [Kategori],
    SUM(o.OrderQuantity) AS [Satılan Adet],
    p.ProductPrice AS [Birim Fiyat (TL)],
    SUM(o.OrderQuantity * p.ProductPrice) AS [Elde Edilen Toplam Ciro (TL)],
    p.ProductStock AS [Kalan Stok]
FROM dbo.Products p
INNER JOIN dbo.Categories c ON p.CategoryId = c.CategoryId
INNER JOIN dbo.Orders o ON p.ProductId = o.ProductID
GROUP BY p.ProductId, p.ProductName, c.CategoryName, p.ProductPrice, p.ProductStock
ORDER BY [Elde Edilen Toplam Ciro (TL)] DESC;
----------------------------------------------------------------------------
-- QUERY 1.3: Sipariş Durumlarına Göre Dağılım ve Finansal Karşılığı
----------------------------------------------------------------------------
SELECT 
    o.OrderStatus AS [Sipariş Durumu],
    COUNT(o.OrderID) AS [İşlem Sayısı],
    SUM(o.OrderQuantity) AS [İlgili Siparişlerdeki Toplam Ürün],
    SUM(o.OrderQuantity * p.ProductPrice) AS [Toplam Mali Değer (TL)]
FROM dbo.Orders o
INNER JOIN dbo.Products p ON o.ProductID = p.ProductId
GROUP BY o.OrderStatus
ORDER BY [Toplam Mali Değer (TL)] DESC;


