## 1. Introduction to Remote Repositories ##

/home/dq$ git clone /dataquest/user/git/chatbot

## 2. Making Changes to Cloned Repositories ##

/home/dq/chatbot$ git commit -m "Updated README.md"

## 3. Overview of the Master Branch ##

/home/dq/chatbot$ git branch

## 4. Pushing Changes to the Remote ##

/home/dq/chatbot$ git push origin master

## 5. Viewing Individual Commits ##

/home/dq/chatbot$ git show 1ff1bab5afd8fbc739b2ac4f38414d17bdef509a

## 6. Commits and the Working Directory ##

/home/dq/chatbot$ git diff 1ffbab5 63af140

## 7. Switching to a Specific Commit ##

/home/dq/chatbot$ git reset --hard 63af140f556ccfcf49641ff55877a9db6fa82f42

## 8. Pulling From a Remote Repo ##

/home/dq/chatbot$ git pull origin

## 9. Referring to the Most Recent Commit ##

/home/dq/chatbot$ git reset HEAD~1