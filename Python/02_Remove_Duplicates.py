#02_Remove_Duplicates.py

def remove_duplicates(input_string):
    result = ""

    for char in input_string:
        if char not in result:
            result += char

    return result

print(remove_duplicates("programming"))  
print(remove_duplicates("hello"))
print(remove_duplicates("aabbcc"))