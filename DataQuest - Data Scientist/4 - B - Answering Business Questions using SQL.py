
# coding: utf-8

# In[1]:


import pandas as pd
import sqlite3

get_ipython().magic('matplotlib inline')

def run_query(q):
    with sqlite3.connect('chinook.db') as conn:
        return pd.read_sql(q, conn)
    
def run_command(q):
    with sqlite3.connect('chinook.db') as conn:
        conn.isolation_level = None
        conn.execute(q)

def show_tables():
    query = "SELECT name,type FROM sqlite_master "
    query+= "WHERE type IN ('table','view');"
        
    return run_query(query)
        


# In[2]:


show_tables()


# In[3]:


query = "Select GR.name, SUM(INV.quantity) AS Vente, "
query+= "(Cast(SUM(INV.quantity) as float)) "
query+= "/ (cast((SELECT SUM(quantity) FROM Invoice_line) as float)) AS Ratio_vente "
query+= "FROM track as TR INNER JOIN Invoice_line AS INV "
query+= "ON TR.track_id = INV.track_id "
query+= "INNER JOIN Genre AS GR ON GR.genre_id = TR.genre_id "
query+= "GROUP BY GR.name"

data_genre = run_query(query)
data_genre


# In[4]:


data_genre_name = data_genre.set_index('name')


# In[5]:


data_genre_name['Ratio_vente'].plot.barh()


# In[6]:


query = "SELECT EMP.first_name || ' ' || EMP.last_name as employee_name,"
query+= "SUM(INV.total) AS total_vente "
query+=" FROM employee AS EMP INNER JOIN customer AS CUS "
query+=" ON EMP.employee_id = CUS.support_rep_id "
query+=" INNER JOIN Invoice AS INV ON INV.customer_id = CUS.customer_id "
query+=" GROUP BY EMP.employee_id"

data_employee = run_query(query)


# In[7]:


data_employee


# In[8]:


data_employee_name = data_employee.set_index('employee_name')
data_employee_name.plot.barh()


# In[9]:


query0="drop view IF EXISTS Customer_Country "
run_command(query0)

query ="CREATE VIEW Customer_Country AS "
query+="SELECT CUST.*,"
query+="CASE WHEN VEN.Nb_Customer <= 1 THEN 'Other' ELSE VEN.country END AS New_Country "
query+="FROM customer AS CUST INNER JOIN " 
query+="(SELECT CUS.country,"
query+="COUNT(Distinct CUS.customer_id) AS Nb_Customer "
query+="FROM customer AS CUS INNER JOIN Invoice AS INVO "
query+="ON CUS.customer_id = INVO.customer_id "
query+="GROUP BY CUS.country) AS VEN "
query+="ON CUST.country = VEN.country"

run_command(query)


# In[10]:


query1 = "SELECT * FROM Customer_Country"
run_query(query1)


# In[22]:


query="SELECT CUS.new_country,"
query+="count(CUS.customer_id) AS total_number_customers,"
query+="SUM(INVO.total) AS total_value_sales,"
query+="count(distinct CUS.customer_id) AS unique_consumers,"
query+="count(CUS.customer_id) / count(distinct CUS.customer_id) AS average_number_sales,"
query+="SUM(INVO.total)/count(distinct CUS.customer_id) AS average_purchase "
query+="FROM Customer_Country AS CUS INNER JOIN Invoice AS INVO "
query+="ON CUS.customer_id = INVO.customer_id "
query+="GROUP BY CUS.new_country "
query+="ORDER BY total_value_sales DESC"

run_query(query)


# In[23]:


sales = run_query(query)


# In[26]:


sales_index = sales.set_index('New_Country')


# In[43]:


import matplotlib.pyplot as plt
fig = plt.figure(figsize=(20,20))
get_ipython().magic('matplotlib inline')

kpi = ['total_number_customers','total_value_sales','unique_consumers','average_number_sales','average_purchase']
color=['blue','yellow','green','red','purple']

for k,c in zip(kpi,color):
        sales_index[k].plot.barh(title=k,color=c)
        plt.show()

        


# In[8]:


query= "WITH first_track AS ("
query+="SELECT invoice_id,"
query+="MIN(track_id) AS first_track_id "
query+="FROM invoice_line "
query+="GROUP BY invoice_id) "


# In[17]:


query_ = query
query_+="SELECT album_purchase,"
query_+="COUNT(invoice_id) AS number_invoices,"
query_+="cast(count(invoice_id) as float) / "
query_+="(cast((select count(*) from invoice) as float)) as Percent "
query_+="FROM ("
query_+="SELECT IFS.*,"
query_+="CASE WHEN ("
query_+="SELECT t.track_id FROM track as T "
query_+="WHERE t.album_id = ("
query_+="SELECT T2.album_id FROM track AS T2 "
query_+="WHERE T2.track_id = IFS.first_track_id) "
query_+="EXCEPT "
query_+="SELECT IL2.track_id FROM invoice_line as IL2 "
query_+="WHERE IL2.invoice_id = IFS.invoice_id) "
query_+="IS NULL"
query_+="AND "
query_+="(SELECT IL2.track_id FROM invoice_line as IL2 "
query_+="WHERE IL2.invoice_id = IFS.invoice_id "
query_+="EXCEPT "
query_+="SELECT t.track_id FROM track as T "
query_+="WHERE t.album_id = ("
query_+="SELECT T2.album_id FROM track AS T2 "
query_+="WHERE T2.track_id = IFS.first_track_id) "
query_+=") IS NULL THEN 'Yes' ELSE 'No' END AS Album_Purchase "
query_+="FROM first_track AS IFS) "
query_+="GROUP BY Album_Purchase"


# In[18]:


query_


# In[20]:


albums_vs_tracks = '''
WITH invoice_first_track AS
    (
     SELECT
         il.invoice_id invoice_id,
         MIN(il.track_id) first_track_id
     FROM invoice_line il
     GROUP BY 1
    )

SELECT
    album_purchase,
    COUNT(invoice_id) number_of_invoices,
    CAST(count(invoice_id) AS FLOAT) / (
                                         SELECT COUNT(*) FROM invoice
                                      ) percent
FROM
    (
    SELECT
        ifs.*,
        CASE
            WHEN
                 (
                  SELECT t.track_id FROM track t
                  WHERE t.album_id = (
                                      SELECT t2.album_id FROM track t2
                                      WHERE t2.track_id = ifs.first_track_id
                                     ) 

                  EXCEPT 

                  SELECT il2.track_id FROM invoice_line il2
                  WHERE il2.invoice_id = ifs.invoice_id
                 ) IS NULL
             AND
                 (
                  SELECT il2.track_id FROM invoice_line il2
                  WHERE il2.invoice_id = ifs.invoice_id

                  EXCEPT 

                  SELECT t.track_id FROM track t
                  WHERE t.album_id = (
                                      SELECT t2.album_id FROM track t2
                                      WHERE t2.track_id = ifs.first_track_id
                                     ) 
                 ) IS NULL
             THEN "yes"
             ELSE "no"
         END AS "album_purchase"
     FROM invoice_first_track ifs
    )
GROUP BY album_purchase;
'''


# In[21]:


run_query(albums_vs_tracks)

