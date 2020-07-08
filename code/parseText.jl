fname = "AliceInWonderland.txt"
fstring = read(fname,String)
farr = split(fstring)

# How many words are there in Alice in Wonderland?

length(farr)

# What is the last word?

fstring[end]
#or
last(farr)

# What is the last word before "THE END"?

length(farr)
#then take the number of words, take three and input where number is length minus 3
farr[#number:#number]


# This is an example of how you might count the number of times the word "alice" appears:

count(i->(lowercase(i)=="alice"),farr)

# Write a function that will count the number of times any word appears

x=#word
function wordcount(x,farr)
    return count(i->(lowercase(i)==x),farr)
end

# Make the function work even if I passed it an argument with capital letters (e.g. "Alice")?

function wordcount(x,farr)
    return count(i->((i)==x),farr)
end

# Make a collection which tells me how many times the following words appear:
interesting_words = ["alice","mushroom", "caterpillar", "head", "cheshire"]

#using the first wordcount function

Wonderland=Dict()
Wonderland["alice"]=wordcount("alice",farr)
Wonderland["mushroom"]=wordcount("mushroom",farr)
Wonderland["caterpillar"]=wordcount("caterpillar",farr)
Wonderland["head"]=wordcount("head",farr)
Wonderland["cheshire"]=wordcount("cheshire",farr)
