from dateutil.parser import parse
import read

def parse_date(value):
    date_df=parse(value)
    return date_df.hour

df=read.load_data()

df['hours']=df['submission_time'].apply(parse_date)
most_times = df['hours'].value_counts().sort_values(ascending=False)

print(most_times)



