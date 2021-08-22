-- 1. ¿Qué consulta ejecutaría para obtener los ingresos totales para marzo de 2012?
SELECT MONTHNAME(charged_datetime) as month, SUM(billing.amount) AS renevue FROM billing WHERE charged_datetime >= '2012/03/01' AND charged_datetime < '2012/04/01';
-- 2. ¿Qué consulta ejecutaría para obtener los ingresos totales recaudados del cliente con una identificación de 2?
SELECT client_id, SUM(amount) as total_renevue FROM billing WHERE client_id = 2;
-- 3. ¿Qué consulta ejecutaría para obtener todos los sitios que posee client = 10?
SELECT domain_name AS website, client_id 
FROM sites 
WHERE client_id=10;
-- 4. ¿Qué consulta ejecutaría para obtener el número total de sitios creados por mes por año para el cliente con una identificación de 1? ¿Qué pasa con el cliente = 20?
SELECT clients.client_id, COUNT(domain_name) AS numer_of_websites, MONTHNAME(sites.created_datetime) AS 'month_created', YEAR(sites.created_datetime) AS 'year_created' 
FROM clients 
JOIN sites ON clients.client_id = sites.client_id 
WHERE clients.client_id=1
GROUP BY month(sites.created_datetime), year(sites.created_datetime);
SELECT clients.client_id, COUNT(domain_name) AS numer_of_websites, MONTHNAME(sites.created_datetime) AS 'month_created', YEAR(sites.created_datetime) AS 'year_created' 
FROM clients 
INNER JOIN sites ON clients.client_id = sites.client_id 
WHERE clients.client_id=20
GROUP BY month(sites.created_datetime), year(sites.created_datetime);
-- 5. ¿Qué consulta ejecutaría para obtener el número total de clientes potenciales generados para cada uno de los sitios entre el 1 de enero de 2011 y el 15 de febrero de 2011?
SELECT domain_name AS website, COUNT(leads.leads_id) AS number_of_leads, DATE_FORMAT(leads.registered_datetime ,"%M %d, %Y") AS date_generate 
FROM sites 
INNER JOIN leads ON sites.site_id = leads.site_id
WHERE leads.registered_datetime >= '2011/01/01' AND leads.registered_datetime <= '2011/02/15'
GROUP BY sites.domain_name;
-- 6. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales que hemos generado para cada uno de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011?
SELECT CONCAT(clients.first_name, " ",clients.last_name) AS client_name, COUNT(leads_id) as number_of_leads
FROM clients
JOIN sites ON sites.client_id = clients.client_id
JOIN leads ON leads.site_id= sites.site_id
WHERE leads.registered_datetime >= '2011/01/01' AND leads.registered_datetime <= '2011/12/31'
GROUP BY clients.first_name;
-- 7. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales que hemos generado para cada cliente cada mes entre los meses 1 y 6 del año 2011?
SELECT CONCAT(clients.first_name, " ",clients.last_name) AS client_name, COUNT(leads_id) as number_of_leads, DATE_FORMAT(leads.registered_datetime ,"%M") AS month_generate 
FROM clients
JOIN sites ON sites.client_id = clients.client_id
JOIN leads ON leads.site_id= sites.site_id
WHERE leads.registered_datetime >= '2011/01/01' AND leads.registered_datetime < '2011/07/01'
GROUP BY leads_id;
-- 8. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y el número total de clientes potenciales que hemos generado para cada uno de los sitios de nuestros clientes entre el 1 de enero de 2011 y el 31 de diciembre de 2011? Solicite esta consulta por ID de cliente. Presente una segunda consulta que muestre todos los clientes, los nombres del sitio y el número total de clientes potenciales generados en cada sitio en todo momento.
SELECT CONCAT(clients.first_name, " ",clients.last_name) AS client_name, domain_name AS website, COUNT(leads.leads_id) as number_of_leads, DATE_FORMAT(leads.registered_datetime ,"%M %d, %Y" ) AS date_generate
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
LEFT JOIN leads ON sites.site_id = leads.site_id
WHERE leads.registered_datetime >= '2011/01/01' AND leads.registered_datetime < '2011/12/31'
GROUP BY sites.domain_name;
SELECT CONCAT(clients.first_name, " ",clients.last_name) AS client_name, domain_name AS website, COUNT(leads.leads_id) as number_of_leads
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
LEFT JOIN leads ON sites.site_id = leads.site_id
GROUP BY sites.domain_name;
-- 9. Escriba una sola consulta que recupere los ingresos totales recaudados de cada cliente para cada mes del año. Pídalo por ID de cliente.
SELECT CONCAT(clients.first_name, " ",clients.last_name) AS client_name, SUM(billing.amount) AS total_renevue, DATE_FORMAT(billing.charged_datetime ,"%M" ) AS month_charge, DATE_FORMAT(billing.charged_datetime ,"%Y" ) AS year_charge
FROM clients
INNER JOIN billing ON clients.client_id = billing.client_id
GROUP BY month(billing.charged_datetime), clients.client_id
ORDER BY clients.client_id ASC;
-- 10. Escriba una sola consulta que recupere todos los sitios que posee cada cliente. Agrupe los resultados para que cada fila muestre un nuevo cliente. Se volverá más claro cuando agregue un nuevo campo llamado 'sitios' que tiene todos los sitios que posee el cliente. (SUGERENCIA: use GROUP_CONCAT)
SELECT CONCAT(clients.first_name, " ",clients.last_name) AS client_name, GROUP_CONCAT(sites.domain_name SEPARATOR " / ") AS sites 
FROM clients
LEFT JOIN sites ON clients.client_id = sites.client_id
GROUP BY clients.client_id;

