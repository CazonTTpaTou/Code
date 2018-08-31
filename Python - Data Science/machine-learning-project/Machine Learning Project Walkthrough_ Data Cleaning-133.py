## 3. Reading in to Pandas ##

import pandas as pd

loans_2007 = pd.read_csv('loans_2007.csv')

print(loans_2007.head(1))

print(len(loans_2007.columns))




## 5. First group of columns ##

loans_2007 = loans_2007.drop(columns=    ['id',
                                        'member_id',
                                        'funded_amnt',
                                        'funded_amnt_inv',
                                        'grade',
                                        'sub_grade',
                                        'emp_title',
                                        'issue_d'])
                             
print(len(loans_2007.columns))





## 7. Second group of features ##

cols = ['zip_code',
    'out_prncp',
    'out_prncp_inv',
    'total_pymnt',
    'total_pymnt_inv',
    'total_rec_prncp']
    
loans_2007 = loans_2007.drop(columns=cols)


    

## 9. Third group of features ##

last_cols = ['total_rec_int',
    'total_rec_late_fee',
    'recoveries',
    'collection_recovery_fee',
    'last_pymnt_d',
    'last_pymnt_amnt']

loans_2007 = loans_2007.drop(columns=last_cols)

print(loans_2007.head(1))

print(len(loans_2007.columns))




## 10. Target column ##

status = loans_2007['loan_status'].value_counts().sort_values(ascending=False)

print(status)





## 12. Binary classification ##

conditions_removed = ((loans_2007['loan_status']=='Fully Paid') 
                      | (loans_2007['loan_status']=='Charged Off'))

loans_2007 = loans_2007[conditions_removed]

mapping_status = {'Charged Off':0,
                  'Fully Paid':1}

loans_2007['loan_status'] = loans_2007['loan_status'].replace(mapping_status)

print(loans_2007['loan_status'].value_counts())




## 13. Removing single value columns ##

drop_columns = list()

for col in loans_2007.columns:
    if len(loans_2007[col].dropna().unique())<=1:
        drop_columns.append(col)

loans_2007 = loans_2007.drop(columns=drop_columns)

print(drop_columns)


        