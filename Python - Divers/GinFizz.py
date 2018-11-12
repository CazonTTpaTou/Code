def gin_fizz(numberIterations):
    if numberIterations==0:
        return

    if numberIterations % 15==0 :
        print('{} - Gin-Fizz-Buzz'.format(numberIterations))
    else:
        if numberIterations % 5 ==0:
            print('{} - Fizz'.format(numberIterations))
        else:
            if numberIterations % 3 ==0:
                print('{} - Buzz'.format(numberIterations))
            else:
                print('{} - Gin'.format(numberIterations))
    gin_fizz(numberIterations-1)

gin_fizz(100)    


