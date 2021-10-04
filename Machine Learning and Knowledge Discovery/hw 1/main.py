# open file and set to read with 'r'
file = open('num_to_add.txt', 'r')
# readlines() returns line from file
num = file.readlines()
# close input file
file.close()
# open output file to write in ** use 'w'
f = open("output.txt", 'w')
# add the number pairs and print output next to it
for line in num:
    nums = line.strip().split(" ")
    f.write(nums[0] + " " + nums[1] + " " + str(int(nums[0]) + int(nums[1])) + "\n")
# close output file
f.close()