import pandas as pd

def load_data():
    stories=pd.read_csv('hn_stories.csv',header=None)
    stories.columns=['submission_time','upvotes','url','headline']
    print(stories.head(2))
    return stories

if __name__=="__main__":
    load_data()
    