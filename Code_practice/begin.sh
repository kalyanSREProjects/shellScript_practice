#!/bin/bash

# name="John"                   # Variables are assigned using the ''='' sign without spaces.
# echo "Hello, $name!"          # To access the value of a variable, prefix it with a $ sign


echo "Enter your name:"
read name                       # read the input using the 'read' command 
echo "Hello, $name!"

# echo "Enter a number:"                            # if condition
# read number                           
# if [ $number -gt 10 ]; then                       # [ $number -gt 10 ] is a test condition where -gt stands for "greater than."
#     echo "Number is greater than 10"      
# else
#     echo "Number is less than or equal to 10"
# fi

# for i in 1 2 3 4 5; do
#     echo "Number: $i"                             # for loop
# done

# count=1
# while [ $count -le 5 ]; do                       # while loop
#     echo "Count: $count"  
#     count=$((count + 1))
# done