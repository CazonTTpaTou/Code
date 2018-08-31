## 2. Authenticating with the API ##

headers = {"Authorization": "bearer 13426216-4U1ckno9J5AiK72VRbpEeBaMSKk",
           "User-Agent": "Dataquest/1.0"}

URL = "https://oauth.reddit.com/r/python/top"

params = {"t" : "day"}

response = requests.get(URL,
                        headers=headers,
                        params=params)

python_top = response.json()





## 3. Getting the Most Upvoted Post ##

"""
for k in python_top['data']['children']:
    number_vote = k['data']['ups']
    message = k['data']['selftext']
                    
    print(number_vote)
    print(message)
    
print(python_top_articles[1]['data'].keys())    
"""    
number_vote = 0

python_top_articles = python_top['data']['children']

for article in python_top_articles:
    
    if number_vote < int(article['data']['ups']):
        number_vote = int(article['data']['ups'])
        most_upvoted = article['data']['id']
                           
print(most_upvoted)
                           
                           

## 4. Getting Post Comments ##

URL = "https://oauth.reddit.com/"
URL+= "r/python/comments/4b7w9u"

response = requests.get(URL,
                        headers=headers)

comments = response.json()

print(type(comments))


## 5. Getting the Most Upvoted Comment ##

most_upvoted = 0
comments_list = []

for index,comment in enumerate(comments):
    if index>0:
        comments_list.append(comment['data'])
      
for comment in comments_list[0]['children']:  
    if int(comment['data']['ups']) > most_upvoted :
            most_upvoted = int(comment['data']['ups'])
            most_upvoted_comment = comment['data']['id']    


## 6. Upvoting a Comment ##

payload = {
    "id": "d16y4ry",
    "dir": 1
}

URL = "https://oauth.reddit.com/api/vote"

response = requests.post(URL,
                         json=payload,
                         headers=headers)

status = response.status_code


