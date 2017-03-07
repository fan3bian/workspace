import turtle
def drwaSnake(rad, angle, len, neckrad):
   for i in range(len):
       turtle.circle(rad,angle)
       turtle.circle(-rad,angle)
   turtle.circle(-rad, angle/2)
   turtle.fd(rad)
   turtle.circle(neckrad+1,180)
   turtle.fd(rad*2/3)

def main():
    turtle.setup(1300,800,0,0)
    pythonSize =30
    turtle.pensize(pythonSize)
    turtle.pencolor("bule")
    turtle.seth(-40)
    drwaSnake(40,80,5,pythonSize/2)
main()