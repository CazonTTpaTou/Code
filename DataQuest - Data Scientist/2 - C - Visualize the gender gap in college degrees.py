
# coding: utf-8

# In[1]:


get_ipython().magic('matplotlib inline')
import pandas as pd
import matplotlib.pyplot as plt

women_degrees = pd.read_csv('percent-bachelors-degrees-women-usa.csv')
cb_dark_blue = (0/255,107/255,164/255)
cb_orange = (255/255, 128/255, 14/255)
stem_cats = ['Engineering', 'Computer Science', 'Psychology', 'Biology', 'Physical Sciences', 'Math and Statistics']

fig = plt.figure(figsize=(18, 3))

for sp in range(0,6):
    ax = fig.add_subplot(1,6,sp+1)
    ax.plot(women_degrees['Year'], women_degrees[stem_cats[sp]], c=cb_dark_blue, label='Women', linewidth=3)
    ax.plot(women_degrees['Year'], 100-women_degrees[stem_cats[sp]], c=cb_orange, label='Men', linewidth=3)
    ax.spines["right"].set_visible(False)    
    ax.spines["left"].set_visible(False)
    ax.spines["top"].set_visible(False)    
    ax.spines["bottom"].set_visible(False)
    ax.set_xlim(1968, 2011)
    ax.set_ylim(0,100)
    ax.set_title(stem_cats[sp])
    ax.tick_params(bottom="off", top="off", left="off", right="off")
    
    if sp == 0:
        ax.text(2005, 87, 'Men')
        ax.text(2002, 8, 'Women')
    elif sp == 5:
        ax.text(2005, 62, 'Men')
        ax.text(2001, 35, 'Women')

plt.show()


# In[13]:


stem_cats = ['Psychology', 'Biology', 'Math and Statistics', 'Physical Sciences', 'Computer Science', 'Engineering']
lib_arts_cats = ['Foreign Languages', 'English', 'Communications and Journalism', 'Art and Performance', 'Social Sciences and History']
other_cats = ['Health Professions', 'Public Administration', 'Education', 'Agriculture','Business', 'Architecture']

cats = [stem_cats,lib_arts_cats,other_cats]

fig = plt.figure(figsize=(18, 18))

for number,sp in enumerate(cats):
    for index,cat in enumerate(sp):
        num = (number*6)+index+1
        print('--- {}--{}---'.format(num,cat))
        ax = fig.add_subplot(3,6,num)
        ax.plot(women_degrees['Year'], women_degrees[cat], c=cb_dark_blue, label='Women', linewidth=3)
        ax.plot(women_degrees['Year'], 100-women_degrees[cat], c=cb_orange, label='Men', linewidth=3)
        ax.spines["right"].set_visible(False)    
        ax.spines["left"].set_visible(False)
        ax.spines["top"].set_visible(False)    
        ax.spines["bottom"].set_visible(False)
        ax.set_xlim(1968, 2011)
        ax.set_ylim(0,100)
        ax.set_title(cat)
        ax.tick_params(bottom="off", top="off", left="off", right="off")

        if index == 0:
            ax.text(2005, 87, 'Men')
            ax.text(2002, 8, 'Women')
        elif index == 5:
            ax.text(2005, 62, 'Men')
            ax.text(2001, 35, 'Women')

plt.show()
    


# In[14]:


stem_cats = ['Psychology', 'Biology', 'Math and Statistics', 'Physical Sciences', 'Computer Science', 'Engineering']
lib_arts_cats = ['Foreign Languages', 'English', 'Communications and Journalism', 'Art and Performance', 'Social Sciences and History']
other_cats = ['Health Professions', 'Public Administration', 'Education', 'Agriculture','Business', 'Architecture']

cats = [stem_cats,lib_arts_cats,other_cats]

fig = plt.figure(figsize=(18, 18))

for number,sp in enumerate(cats):
    for index,cat in enumerate(sp):
        num = (number*6)+index+1
        print('--- {}--{}---'.format(num,cat))
        ax = fig.add_subplot(3,6,num)
        ax.plot(women_degrees['Year'], women_degrees[cat], c=cb_dark_blue, label='Women', linewidth=3)
        ax.plot(women_degrees['Year'], 100-women_degrees[cat], c=cb_orange, label='Men', linewidth=3)
        ax.spines["right"].set_visible(False)    
        ax.spines["left"].set_visible(False)
        ax.spines["top"].set_visible(False)    
        ax.spines["bottom"].set_visible(False)
        ax.set_xlim(1968, 2011)
        ax.set_ylim(0,100)
        ax.set_title(cat)
        ax.tick_params(bottom="off", top="off", left="off", right="off")

        if index == 0:
            ax.text(2005, 87, 'Men')
            ax.text(2002, 8, 'Women')
        elif index == 5:
            ax.text(2005, 62, 'Men')
            ax.text(2001, 35, 'Women')

        if number==2:
            ax.tick_params(labelbottom='on')
        else:
            ax.tick_params(labelbottom='off')
                        
plt.show()



# In[15]:


stem_cats = ['Psychology', 'Biology', 'Math and Statistics', 'Physical Sciences', 'Computer Science', 'Engineering']
lib_arts_cats = ['Foreign Languages', 'English', 'Communications and Journalism', 'Art and Performance', 'Social Sciences and History']
other_cats = ['Health Professions', 'Public Administration', 'Education', 'Agriculture','Business', 'Architecture']

cats = [stem_cats,lib_arts_cats,other_cats]

fig = plt.figure(figsize=(18, 18))

for number,sp in enumerate(cats):
    for index,cat in enumerate(sp):
        num = (number*6)+index+1
        print('--- {}--{}---'.format(num,cat))
        ax = fig.add_subplot(3,6,num)
        ax.plot(women_degrees['Year'], women_degrees[cat], c=cb_dark_blue, label='Women', linewidth=3)
        ax.plot(women_degrees['Year'], 100-women_degrees[cat], c=cb_orange, label='Men', linewidth=3)
        ax.spines["right"].set_visible(False)    
        ax.spines["left"].set_visible(False)
        ax.spines["top"].set_visible(False)    
        ax.spines["bottom"].set_visible(False)
        ax.set_xlim(1968, 2011)
        ax.set_ylim(0,100)
        ax.set_title(cat)
        ax.tick_params(bottom="off", top="off", left="off", right="off")

        if index == 0:
            ax.text(2005, 87, 'Men')
            ax.text(2002, 8, 'Women')
        elif index == 5:
            ax.text(2005, 62, 'Men')
            ax.text(2001, 35, 'Women')

        if number==2:
            ax.tick_params(labelbottom='on')
        else:
            ax.tick_params(labelbottom='off')
         
        ax.set_yticks([0,100])
        
plt.show()



# In[18]:


stem_cats = ['Psychology', 'Biology', 'Math and Statistics', 'Physical Sciences', 'Computer Science', 'Engineering']
lib_arts_cats = ['Foreign Languages', 'English', 'Communications and Journalism', 'Art and Performance', 'Social Sciences and History']
other_cats = ['Health Professions', 'Public Administration', 'Education', 'Agriculture','Business', 'Architecture']

cats = [stem_cats,lib_arts_cats,other_cats]

fig = plt.figure(figsize=(18, 18))

for number,sp in enumerate(cats):
    for index,cat in enumerate(sp):
        num = (number*6)+index+1
        print('--- {}--{}---'.format(num,cat))
        ax = fig.add_subplot(3,6,num)
        ax.plot(women_degrees['Year'], women_degrees[cat], c=cb_dark_blue, label='Women', linewidth=3)
        ax.plot(women_degrees['Year'], 100-women_degrees[cat], c=cb_orange, label='Men', linewidth=3)
        ax.spines["right"].set_visible(False)    
        ax.spines["left"].set_visible(False)
        ax.spines["top"].set_visible(False)    
        ax.spines["bottom"].set_visible(False)
        ax.set_xlim(1968, 2011)
        ax.set_ylim(0,100)
        ax.set_title(cat)
        ax.tick_params(bottom="off", top="off", left="off", right="off")

        if index == 0:
            ax.text(2005, 87, 'Men')
            ax.text(2002, 8, 'Women')
        elif index == 5:
            ax.text(2005, 62, 'Men')
            ax.text(2001, 35, 'Women')

        if number==2:
            ax.tick_params(labelbottom='on')
        else:
            ax.tick_params(labelbottom='off')
         
        ax.set_yticks([0,100])
        
        ax.axhline(50, c=(171/255, 171/255, 171/255), alpha=0.3)
        
plt.show()


# In[19]:


stem_cats = ['Psychology', 'Biology', 'Math and Statistics', 'Physical Sciences', 'Computer Science', 'Engineering']
lib_arts_cats = ['Foreign Languages', 'English', 'Communications and Journalism', 'Art and Performance', 'Social Sciences and History']
other_cats = ['Health Professions', 'Public Administration', 'Education', 'Agriculture','Business', 'Architecture']

cats = [stem_cats,lib_arts_cats,other_cats]

fig = plt.figure(figsize=(18, 18))

for number,sp in enumerate(cats):
    for index,cat in enumerate(sp):
        num = (number*6)+index+1
        print('--- {}--{}---'.format(num,cat))
        ax = fig.add_subplot(3,6,num)
        ax.plot(women_degrees['Year'], women_degrees[cat], c=cb_dark_blue, label='Women', linewidth=3)
        ax.plot(women_degrees['Year'], 100-women_degrees[cat], c=cb_orange, label='Men', linewidth=3)
        ax.spines["right"].set_visible(False)    
        ax.spines["left"].set_visible(False)
        ax.spines["top"].set_visible(False)    
        ax.spines["bottom"].set_visible(False)
        ax.set_xlim(1968, 2011)
        ax.set_ylim(0,100)
        ax.set_title(cat)
        ax.tick_params(bottom="off", top="off", left="off", right="off")

        if index == 0:
            ax.text(2005, 87, 'Men')
            ax.text(2002, 8, 'Women')
        elif index == 5:
            ax.text(2005, 62, 'Men')
            ax.text(2001, 35, 'Women')

        if number==2:
            ax.tick_params(labelbottom='on')
        else:
            ax.tick_params(labelbottom='off')
         
        ax.set_yticks([0,100])
        
        ax.axhline(50, c=(171/255, 171/255, 171/255), alpha=0.9)
        
plt.show()


# In[20]:


stem_cats = ['Psychology', 'Biology', 'Math and Statistics', 'Physical Sciences', 'Computer Science', 'Engineering']
lib_arts_cats = ['Foreign Languages', 'English', 'Communications and Journalism', 'Art and Performance', 'Social Sciences and History']
other_cats = ['Health Professions', 'Public Administration', 'Education', 'Agriculture','Business', 'Architecture']

cats = [stem_cats,lib_arts_cats,other_cats]

fig = plt.figure(figsize=(18, 18))

for number,sp in enumerate(cats):
    for index,cat in enumerate(sp):
        num = (number*6)+index+1
        print('--- {}--{}---'.format(num,cat))
        ax = fig.add_subplot(3,6,num)
        ax.plot(women_degrees['Year'], women_degrees[cat], c=cb_dark_blue, label='Women', linewidth=3)
        ax.plot(women_degrees['Year'], 100-women_degrees[cat], c=cb_orange, label='Men', linewidth=3)
        ax.spines["right"].set_visible(False)    
        ax.spines["left"].set_visible(False)
        ax.spines["top"].set_visible(False)    
        ax.spines["bottom"].set_visible(False)
        ax.set_xlim(1968, 2011)
        ax.set_ylim(0,100)
        ax.set_title(cat)
        ax.tick_params(bottom="off", top="off", left="off", right="off")

        if index == 0:
            ax.text(2005, 87, 'Men')
            ax.text(2002, 8, 'Women')
        elif index == 5:
            ax.text(2005, 62, 'Men')
            ax.text(2001, 35, 'Women')

        if number==2:
            ax.tick_params(labelbottom='on')
        else:
            ax.tick_params(labelbottom='off')
         
        ax.set_yticks([0,100])
        
        ax.axhline(50, c=(171/255, 171/255, 171/255), alpha=0.9)

plt.savefig('gender_degrees.png')        

plt.show()


