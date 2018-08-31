## 2. Array Comparisons ##

countries_canada = (world_alcohol[:,2] == "Canada")
years_1984 = (world_alcohol[:,0] == "1984")


## 3. Selecting Elements ##

country_is_algeria = (world_alcohol[:,2] == 'Algeria')
country_algeria = world_alcohol[country_is_algeria,:]
                      

## 4. Comparisons with Multiple Conditions ##

is_algeria_and_1986 = (world_alcohol[:,0]=='1986') & (world_alcohol[:,2]=='Algeria')

rows_with_algeria_and_1986 = world_alcohol[is_algeria_and_1986,:]


## 5. Replacing Values ##

is_1986 = world_alcohol[:,0]=='1986'
world_alcohol[is_1986,0] = '2014'

is_wine = world_alcohol[:,3]=='Wine'
world_alcohol[is_wine,3]='Grog'


## 6. Replacing Empty Strings ##

is_value_empty=world_alcohol[:,4]==''
world_alcohol[is_value_empty,4]=0


## 7. Converting Data Types ##

alcohol_consumption=world_alcohol[:,4]
alcohol_consumption.astype(float)


## 8. Computing with NumPy ##

total_alcohol=alcohol_consumption.sum(0)
average_alcohol = alcohol_consumption.mean(0)



## 9. Total Annual Alcohol Consumption ##

canada_1986=world_alcohol[(world_alcohol[:,0]=='1986')&(world_alcohol[:,2]=='Canada'),:]
canada_1986[canada_1986[:,4]=='',4]=0
canada_alcohol=canada_1986[:,4].astype(float)
total_canadian_drinking=canada_alcohol.sum(0)


## 10. Calculating Consumption for Each Country ##

totals = {}

def compute_country(country,year):
    temporary=world_alcohol[(world_alcohol[:,0]==year)&(world_alcohol[:,2]==country),:]
    temporary[temporary[:,4]=='',4]=0
    result=temporary[:,4].astype(float)
    return result.sum(0)

for country in countries:
    totals[country] = compute_country(country,'1989')

    

## 11. Finding the Country that Drinks the Most ##

highest_value = 0
highest_key = None

for key,value in totals.items():
    if value >= highest_value:
        highest_value = value
        highest_key = key

        