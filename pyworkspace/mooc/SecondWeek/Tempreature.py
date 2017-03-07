#Tt was designed to conversion between degrees and fahrenheit
#use raw_input() instead of input()
for i in range(3):
    tem =raw_input("Please enter your tempreature (For example:32C):")
    if(tem[-1] in ['c','C']):
        f= 1.8*float(tem[0:-1])+32
        print ("After conversion the tempreture is :%0.2fF"%f)
    elif(tem[-1] in ['F','f']):
        c = (float(tem[0:-1]) - 32)/1.8
        print ("After conversion the tempreture is :%0.2fC" % c)
    else:
        print("Wrong Input")