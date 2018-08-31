def make_change(amount,coins=[1,5,10,25],hand=None):
    hand = [] if hand is None else hand
    
    if amount == 0:
        yield hand
    
    for coin in coins:
        # ensures we don't give too much change and combinations are unique
        if coin > amount or (len(hand) > 0 and hand[-1] < coin):
            continue
    
        for result in make_change(amount - coin, coins=coins,hand=hand + [coin]):
            yield result            

##################################
for way in make_change(100,coins=[10,25,50]):
    print(way)
