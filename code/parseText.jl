fname = "AliceInWonderland.txt"
fstring = read(fname,String)
farr = split(fstring)

# How many words are there in Alice in Wonderland?

# What is the last word?

# What is the last word before "THE END"?

# This is an example of how you might count the number of times the word "alice" appears:
count(i->(lowercase(i)=="alice"),farr)

# Write a function that will count the number of times any word appears

# Make the function work even if I passed it an argument with capital letters (e.g. "Alice")?

# Make a collection which tells me how many times the following words appear:
interesting_words = ["alice","mushroom", "caterpillar", "head", "cheshire"]
