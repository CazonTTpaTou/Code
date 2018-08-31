## 1. Introduction to Version Control Systems ##

/home/dq/random_numbers$ git init

## 2. The .git Folder ##

/home/dq/random_numbers$ ls -al

## 3. Creating Files in the Repository ##

/home/dq/random_numbers$ nano script.py

## 4. Checking File Status ##

/home/dq/random_numbers$ git add README.md

## 5. Configuring Identity in Git ##

/home/dq/random_numbers$ git config --global user.name "Fabien Monnery"

## 6. Committing Changes ##

/home/dq/random_numbers$ git commit -m "initial commit. Added script.py and READ

## 7. Viewing File Differences ##

/home/dq/random_numbers$ git status

## 8. Making a Second Commit ##

/home/dq/random_numbers$ git commit -m "Add randint instruction"

## 9. Reviewing the Commit History ##

/home/dq/random_numbers$ git log

## 10. Viewing Commit Differences ##

/home/dq/random_numbers$ git log --stat