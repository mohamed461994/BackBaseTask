# BackBase Mobile assignment RnD
# Mohamed Shaban

I have preprocessed the list of cities into a dictionary where the key is the city first character in lowercase, 
while the value is array of cities that start with the same character.
### var dataSource: [ String: [ City ] ] = [:] 
I've alphabetically sorted all arrays in dictionary values.
Then I've written a binary search algorithm to search but instead of searching in all cities I'll search based on the first character.
So if the user Typed "Ne" in the search bar I'll search only on the array of cities that start with "N" time for accessing the array of n cities is constant.


## Every function had a documentation please read it.
