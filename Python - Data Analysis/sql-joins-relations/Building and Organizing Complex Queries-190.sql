## 3. The With Clause ##

WITH Playlists AS
    (SELECT 
            PL.playlist_id AS playlist_id,
            PL.name AS playlist_name,
            TR.name AS track_name,
            TR.milliseconds/1000 AS length_second
     FROM 
            Playlist AS PL
     LEFT OUTER JOIN
            playlist_track AS PT
            ON PL.playlist_id = PT.playlist_id
     LEFT OUTER JOIN
            track AS TR
            ON PT.track_id = TR.track_id)
    
SELECT
            PLTS.playlist_id, 
            PLTS.playlist_name, 
            COUNT(PLTS.track_name) AS number_of_tracks, 
            SUM(PLTS.length_second) AS length_seconds 
            
FROM       
            Playlists AS PLTS          
GROUP BY
            PLTS.playlist_id,
            PLTS.playlist_name
ORDER BY
            PLTS.playlist_id ASC
            
            
            

## 4. Creating Views ##

CREATE VIEW chinook.customer_gt_90_dollars
AS
    WITH total_purchase
    AS
        (SELECT
                customer_id,
                SUM(total) AS total_p
         FROM
                invoice
         GROUP BY
                customer_id
         HAVING
                (total_p > 90))
    SELECT
        CU.*
        
    FROM
        customer AS CU
    INNER JOIN
        total_purchase AS TP
        ON CU.customer_id = TP.customer_id;

SELECT * FROM chinook.customer_gt_90_dollars

        

## 5. Combining Rows With Union ##

SELECT * FROM customer_usa 
UNION
SELECT * FROM customer_gt_90_dollars 



## 6. Combining Rows Using Intersect and Except ##

WITH customer_usa_90
AS
    (
        SELECT * FROM customer_usa 
        INTERSECT
        SELECT * FROM customer_gt_90_dollars)
        
SELECT
            EP.first_name || ' ' || EP.last_name AS employee_name,
            COUNT(DISTINCT CU.customer_id) AS customers_usa_gt_90 
        
FROM
            employee AS EP
        LEFT OUTER JOIN
            customer_usa_90 AS CU
            ON EP.employee_id = CU.support_rep_id

WHERE 
            EP.title = 'Sales Support Agent'

GROUP BY
            EP.employee_id

ORDER BY
            employee_name ASC
            
    

## 7. Multiple Named Subqueries ##

WITH 

India AS
    (SELECT 
            *
    FROM 
            customer
    WHERE
            country = 'India'),
            
total_purchases_customer AS
    (SELECT 
            customer_id,
            SUM(total) AS total_purchase
     FROM
            invoice
     GROUP BY
            customer_id)
            
SELECT
            ID.first_name || ' ' || ID.last_name AS customer_name,
            TP.total_purchase AS total_purchases 
FROM                    
            India AS ID
     INNER JOIN 
            total_purchases_customer AS TP
            ON ID.customer_id = TP.customer_id

ORDER BY
            customer_name ASC        
            
    

## 8. Challenge: Each Country's Best Customer ##

WITH
    customer_country_purchases AS
        (
         SELECT
             i.customer_id,
             c.country,
             SUM(i.total) total_purchases
         FROM invoice i
         INNER JOIN customer c ON i.customer_id = c.customer_id
         GROUP BY 1, 2
        ),
    country_max_purchase AS
        (
         SELECT
             country,
             MAX(total_purchases) max_purchase
         FROM customer_country_purchases
         GROUP BY 1
        ),
    country_best_customer AS
        (
         SELECT
            cmp.country,
            cmp.max_purchase,
            (
             SELECT ccp.customer_id
             FROM customer_country_purchases ccp
             WHERE ccp.country = cmp.country AND cmp.max_purchase = ccp.total_purchases
            ) customer_id
         FROM country_max_purchase cmp
        )
SELECT
    cbc.country country,
    c.first_name || " " || c.last_name customer_name,
    cbc.max_purchase total_purchased
FROM customer c
INNER JOIN country_best_customer cbc ON cbc.customer_id = c.customer_id
ORDER BY 1 ASC