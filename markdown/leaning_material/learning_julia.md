# Scientific computing with Julia

## Calculator
Julia works as a calculator

```julia
2+2
(2+2)*5
((12+12)/6)^2 # the symbol ^ means "to the power of"
```

## Comments in code

We can add human readable comments to Julia code using "#"

```julia
# Julia understands scientific concepts like pi
print(pi)
pi
```

## Variables

Variables store values for later retrieval.
The equals sign in programming has a slightly unusual meaning.  It is an assignment, rather than just a statement.  So the equals sign means "store what is evaluated on the right using the name on the left".

```julia
a = 2+2
b = a*5
c = b^2
a,b,c
```

#### Types of variables

##### Integer type (e.g. for counting):

```julia
a = 7
```
##### String type (e.g. for counting):

```julia
a = "seven"
```
We can add strings together to make longer strings
```julia
bigstring = "seven"*" "*"hundred"*" and "*"twenty"
```
I often think of computers as dealing primarily with numbers, but they do a lot of work with text, so there are lots of nice tools/functions for working with strings

```julia
replace(bigstring,"e" => "ee")
replace(bigstring,"n" => uppercase)
```

##### Float type variable (e.g. for storing real numbers)
```julia
a = 10.0
a = 10
10/6
10.0/6.0
round(10.0/6.0)
```

We can manually change the type of some variables if we have to
```julia
a = 12
b = float(a)
a,b
```

## Conditions
Julia can answer whether questions are true or false.  Examples: Is three greater than four?  Is four greater than three?

```julia
3>4
4>3
```

The symbol for the question "is equal to?" is "==", not "=".  This is an important source of errors in a lot of code!  Beware!  What do you expect each of the following three lines of code is doing?

```julia
a = 3
a == 4
a == 3
```

## Collections
Julia has various methods of grouping variables together

##### Arrays
```julia
testlist=[99,98,97,96,95,94,93,92,91]
```
We can access array elements by their index, which is a kind of coordinate or location identifier.
```julia
testlist[3]
```

Note that Julia indices start from one and not from zero (as they do in many other programming languages)
```julia
testlist[1]
```

We can access the end of an array
```julia
last(testlist)
lastindex(testlist)
testlist[end]
```

We can access sections of arrays by index
```julia
testlist[2:5]
testlist[3:end]
```

And we can find the length of arrays
```julia
length(testlist)
testlist[length(testlist)]
```
We can easily add to an array
```julia
print(testlist)
append!(testlist,90)
length(testlist)
```

We can convert strings to arrays and manipulate them using the same tools

```julia
bigstring = "I am a fairly long string with lots of characters."
bigarray = split(bigstring,"")
filter!(e->e!="o",bigarray)
join(bigarray,"")
```
Arrays don't have to be filled with numbers or with single characters

```julia
fruits=["apples","pears","oranges","apples","bananas"]
```

#### Dictionaries

These are a way of collecting objects (e.g. word definitions) with labels (e.g. words)

```julia
zoo=Dict()
zoo["elephant"]=4
zoo["monkey"]=12
zoo["giraffe"]=2
zoo["squirrel"]=100

zoo
print(zoo["squirrel"])
```

Here is a small English dictionary

```julia
English=Dict()
English["elephant"]="Either  of  two  large,  five-toed  pachyderms  of  the  family  Elephantidae,  characterized  by  a  long,  prehensile  trunk  formed  of  the  nose  and  upper  lip."
English["monkey"]="Any mammal of the order Primates, including the guenons, macaques, langurs, and capuchins, but excluding humans, the anthropoid apes, and, usually, the tarsier and prosimians."
English["giraffe"]="A tall, long-necked, spotted ruminant, Giraffa camelopardalis, of Africa: the tallest living quadruped animal."
English["squirrel"]="Any of numerous arboreal, bushy-tailed rodents of the genus Sciurus, of the family Sciuridae."

English
English["squirrel"]
```

## Iterative loops
Computers specialise in performing repetitive tasks.  Programming loops is one way to command computers to perform such tasks.

```julia
for x in testlist
  v1=x^2
  v2=x^3
  v3=x^4
  # print out a report, including the value of x, x^2 etc.
  println(join([x,v1,v2,v3]," "))
end
```

The for statement executes the block of code (up until "end") with each of the elements of testlist assigned to x in turn.

#### Seven times tables
```julia
values = [1:12;]
for x in values
  newstring = join(["7 x",string(x),"=",string(7*x)]," ")
  println(newstring)
end
```

#### List comprehensions
Often, the reason you want to run an interative loop is to iteratively build up an array of results.  You can do that in one step as follows:

```julia
asq = [a^2 for a in 1:10]
```

## If-then-else

In order for computers to be able to automatically make decisions we need a way to give them instructions to follow if a certain set of conditions are true.  We do this with an if-statement.

```julia
z=33
# The test condition here is "z>10".  It can evaluate to "true" or "false"
# Only one of the two blocks of code below will be executed
if (z>10)
  # This block of code between if and else is executed if the condition is true
  print("z is big!")
  q=5;
else
  # This block of code between else and end is executed if the condition is false
  print("z is small!")
  q=1;
end
# q has been assigned a value, depending on the value of z (whether it's big or small)
q
```

## Functions

Often we want to repeat complicated set of instructions several times, but with different input.  In this case it can be useful to define a function.  These are analogous to mathematical functions, they take some arguments as input, carry out some tasks, and optionally provide some output.  Typically, the advantage of installing Python packages is that they contain many complicated, interesting functions, that we can re-use if we just know what input data to supply them, and what they do.

First let's look at some trigonometry functions from Julia itself:
```julia
x = 10
log(x)
sin(x)
cos(x)
tan(x)
```

We can define our own function of a and b which does something different
```julia
function patrick(a,b)
    c=a+b
    d=a^2
    c*d
end

myfunc(10,29)
myfunc(1,2)
myfunc(10.3,45.9)

function testbigger(;x=2,y=20)
  if y>x print("y is bigger") else print("y is smaller") end
end

testbigger(2,3)
```

## TODO:
1. Introduce packages
1. Install [Luxor](https://juliagraphics.github.io/Luxor.jl/v0.11/turtle.html) package
1. Load package
1. Use turtle
1. Follow turtle example from [Conor's Python tutorial](http://cnrlwlss.github.io/ScientificPython/Structure/)
1. Carry out exercise
