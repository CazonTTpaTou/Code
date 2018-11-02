# Finobacci Suite
def Finobacci(n):
    if n<=0 :
        return 0
    if n==1 :
        return 1
    return Finobacci(n-1) + Finobacci(n-2)

def SuiteFinobacci(number):
    return '-'.join(str(Finobacci(n)) for n in range(number))

print(SuiteFinobacci(10))  

