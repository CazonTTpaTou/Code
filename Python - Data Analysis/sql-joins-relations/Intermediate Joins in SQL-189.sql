## 2. Joining Three Tables ##

SELECT
    TR.track_id,
    TR.name as track_name,
    MT.name as track_type,
    IL.unit_price,
    IL.quantity
    
FROM
        invoice_line as IL
    INNER JOIN
        track as TR
        ON IL.track_id = TR.track_id
    INNER JOIN
        media_type as MT
        ON TR.media_type_id = MT.media_type_id 
        
WHERE
    IL.invoice_id = 4
    
        

## 3. Joining More Than Three Tables ##

SELECT
    TR.track_id,
    TR.name as track_name,
    AR.name as artist_name,
    MT.name as track_type,
    IL.unit_price,
    IL.quantity
    
FROM
        invoice_line as IL
    INNER JOIN
        track as TR
        ON IL.track_id = TR.track_id
    INNER JOIN
        media_type as MT
        ON TR.media_type_id = MT.media_type_id 
    INNER JOIN
        album as AL
        ON AL.album_id = TR.album_id
    INNER JOIN 
        artist as AR
        ON AR.artist_id = AL.artist_id        
        
WHERE
    IL.invoice_id = 4
    

## 4. Combining Multiple Joins with Subqueries ##

SELECT
    AL.title as album,
    AR.name as artist,
    SUM(IL.quantity) AS tracks_purchased
    
FROM
        invoice_line as IL
    INNER JOIN
        track as TR
        ON IL.track_id = TR.track_id
    INNER JOIN
        album as AL
        ON AL.album_id = TR.album_id
    INNER JOIN 
        artist as AR
        ON AR.artist_id = AL.artist_id  
        
GROUP BY 
    AL.title,
    AR.name
    
ORDER BY
    tracks_purchased DESC

LIMIT 5    
     




## 5. Recursive Joins ##

SELECT
    EM.first_name || ' ' || EM.last_name AS employee_name,
    EM.title AS employee_title,
    SP.first_name || ' ' || SP.last_name AS supervisor_name,
    SP.title AS supervisor_title
    
FROM 
        employee AS EM
    LEFT OUTER JOIN
        employee AS SP
        ON EM.reports_to = SP.employee_id

ORDER BY
    employee_name ASC
    

## 6. Pattern Matching Using Like ##

SELECT 
    CU.first_name,
    CU.last_name,
    CU.phone
    
FROM
    customer AS CU

WHERE
    CU.first_name like '%belle%'
    

## 7. Generating Columns With The Case Statement ##

SELECT
    CU.first_name || ' ' || CU.last_name AS customer_name,
    PU.number AS number_of_purchases,
    PU.total_ AS total_spent,
    CASE 
        WHEN PU.total_ < 40 THEN 'small spender'
        WHEN PU.total_ BETWEEN 40 AND 100 THEN 'regular'
        ELSE 'big spender'
            END AS customer_category

    FROM 
            customer AS CU
        INNER JOIN 
            (SELECT customer_id,
                    COUNT(customer_id) AS number,
                    SUM(total) AS total_
             FROM
                invoice
             GROUP BY
                    customer_id)
                                                        AS PU
        ON CU.customer_id = PU.customer_id   

ORDER BY
        customer_name ASC
        
        
        