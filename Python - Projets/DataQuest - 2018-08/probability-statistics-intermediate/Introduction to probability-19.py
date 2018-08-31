## 1. Probability basics ##

# Print the first two rows of the data.
print(flags[:2])

max_bars = flags['bars'].max()
most_bars_country = flags['name'][flags['bars']==max_bars]

max_population = flags['population'].max()
highest_population_country = flags['name'][flags['population']==max_population]








## 2. Calculating probability ##

total_countries = flags.shape[0]

orange_probability = flags['orange'].sum()/total_countries

stripe_probability = flags['stripes'][flags['stripes']>1].count()/total_countries




## 3. Conjunctive probabilities ##

five_heads = .5 ** 5

ten_heads = 0.5 ** 10

hundred_heads = 0.5**100

## 4. Dependent probabilities ##

# Remember that whether a flag has red in it or not is in the `red` column.

def arrangement(red,total,number):
    if number==1 :
        return red/total
    else :        
        return ((red-number+1)/(total-number+1))*arrangement(red,
                                                         total,
                                                         number-1)

three_red = arrangement(flags['red'].sum(),
                        flags['red'].shape[0],
                        3)



## 5. Disjunctive probability ##

start = 1
end = 18000

def multiple(number):
    multi = 0
    for num in range(start,end+1):
        multi+=(num%number==0)
    return multi

hundred_prob = multiple(100)/(end-start+1)

seventy_prob = multiple(70)/(end-start+1)




## 6. Disjunctive dependent probabilities ##

def proba(cond1,cond2):

    cond_1 = flags[cond1]>=1
    cond_2 = flags[cond2]>=1
    inter_cond1_cond2 = (flags[cond1]>=1) & (flags[cond2]>=1)

    return          ((sum(cond_1)
                     +sum(cond_2)
                     -sum(inter_cond1_cond2)) 
                                            /flags.shape[0])

red_or_orange = proba('red','orange')

stripes_or_bars = proba('stripes','bars')

## 7. Disjunctive probabilities with multiple conditions ##

heads_or = None

heads_or = 1 - (0.5**3)

