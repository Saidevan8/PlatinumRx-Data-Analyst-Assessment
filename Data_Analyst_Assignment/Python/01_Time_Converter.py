def convert_minutes(total_minutes):
    hours = total_minutes // 60
    mins = total_minutes % 60

    if hours > 1:
        return f"{hours} hrs {mins} minutes"
    elif hours == 1:
        return f"{hours} hr {mins} minutes"
    else:
        return f"{mins} minutes"

print(convert_minutes(130))   # 2 hrs 10 minutes
print(convert_minutes(110))   # 1 hr 50 minutes
print(convert_minutes(59))    # 59 minutes
