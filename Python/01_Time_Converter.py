 #01_Time_Converter.py

def convert_minutes(minutes):
    hours = minutes // 60
    remaining = minutes % 60

    # Formatting output
    if hours > 0 and remaining > 0:
        if hours == 1:
            return f"{hours} hr {remaining} minutes"
        else:
            return f"{hours} hrs {remaining} minutes"
    elif hours > 0:
        if hours == 1:
            return f"{hours} hr"
        else:
            return f"{hours} hrs"
    else:
        return f"{remaining} minutes"

print(convert_minutes(130))  
print(convert_minutes(110))  
print(convert_minutes(45))   