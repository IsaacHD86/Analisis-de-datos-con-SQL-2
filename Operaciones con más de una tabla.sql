/* 1) Utiliza las tablas  y 
Person.Person para crear una consulta que obtenga los nombres de los empleados (FirstName y LastName) 
y el título de su puesto (JobTitle) usando un INNER JOIN.
jobtitle --> HumanResources.Employee 
FirstName y LastName Person.Person */

SELECT p.FirstName,
	   p.LastName,
	   hre.JobTitle
FROM HumanResources.Employee hre
	INNER JOIN Person.Person p
		ON hre.BusinessEntityID = p.BusinessEntityID;

/* 2) Utiliza las tablas Sales.Customer y Person.Person 
para crear una consulta que obtenga los nombres de los clientes (FirstName y LastName).
Asegúrate de incluir todos los clientes, incluso aquellos que no tienen un registro en la tabla Person.Person
usando un LEFT JOIN. */

SELECT sc.CustomerID,
       p.FirstName,
	   p.LastName
FROM  Sales.Customer sc
	  LEFT OUTER JOIN Person.Person p
	     ON p.BusinessEntityID = sc.PersonID

/* 3) Utiliza las tablas Sales.SalesOrderHeader y Sales.Customer 
para crear una consulta que muestre el ID de la orden (SalesOrderID) y el ID del cliente (CustomerID). 
Asegúrate de incluir todas las órdenes, incluso si no hay un cliente asociado usando un RIGHT JOIN. */

SELECT sso.SalesOrderID,
       sc.CustomerID
FROM Sales.SalesOrderHeader sso
	 RIGHT OUTER JOIN Sales.Customer sc
	 ON sc.CustomerID = sso.CustomerID

/* 4) Utiliza las tablas Production.Product y Production.ProductReview para crear una consulta que muestre 
el nombre del producto (Name) y el comentario de la reseña (Comments). 
Incluye todos los productos y todas las reseñas, incluso si no coinciden usando un FULL OUTER JOIN.*/

SELECT p.Name,
       pr.Comments
FROM Production.Product p
	 FULL OUTER JOIN Production.ProductReview pr
	 ON p.ProductID = pr.ProductID

/* 5) Utiliza las tablas Production.Product y Production.ProductCategory para crear una consulta que devuelva una 
combinación de todos los productos con todas las categorías usando un CROSS JOIN.*/

SELECT 
       p.Name AS ProductName,
       pc.Name AS CategoryName
FROM Production.Product p
     CROSS JOIN Production.ProductCategory pc

/* 6) Crea dos consultas: una que utilice UNION y otra que utilice UNION ALL para combinar los nombres de productos
de las tablas Production.Product y Production.ProductModel.*/

SELECT ProductModelID,
       Name
FROM Production.Product
UNION 
SELECT ProductModelID,
       Name
FROM Production.ProductModel;

SELECT Name
FROM Production.Product
UNION ALL 
SELECT Name
FROM Production.ProductModel;

/* 7) Utiliza la tabla HumanResources.Employee para crear una consulta que muestre el BusinessEntityID, 
el JobTitle, y una columna adicional que indique si el título del puesto contiene la palabra 'Manager' usando la expresión CASE. 
Si el título del puesto es nulo, usa COALESCE para mostrar 'No Title'.*/

SELECT 
    e.BusinessEntityID,
    COALESCE(e.JobTitle, 'No Title')  AS JobTitle,
    CASE 
        WHEN e.JobTitle LIKE '%Manager%' THEN 'Manager'
        ELSE 'Not Manager'
    END AS JobCategory
FROM 
    HumanResources.Employee e;

/* 8) Utiliza la tabla Sales.SalesPerson para crear una consulta que muestre el BusinessEntityID, la SalesQuota,
y una columna que indique 'No Quota' si SalesQuota es nulo usando la función ISNULL.*/

SELECT sp.BusinessEntityID,
       sp.SalesQuota,
	   ISNULL(CAST(sp.SalesQuota AS VARCHAR(50)), 'No Quota') AS QuotaStatus
	   -- Se usa CAST(sp.SalesQuota AS VARCHAR(50)) para convertir SalesQuota a texto, 
	   -- ya que la función ISNULL requiere que ambos valores (el original y el alternativo) sean del mismo tipo de datos.
FROM Sales.SalesPerson sp;
