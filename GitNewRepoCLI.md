# How-to make remote repo without web-browser
Little instruction how to make local repo *seminar2* then we make remote public repo *seminar2* on github and push local branches from Windows PC and Linux PC to remote. At last, through web browser we create third branch and merge others to it.
As result, we produce 4 branches:
+ win - managed with Windows PC 
+ linux - managed with Xubuntu Linux PC
+ main - managed through web interface  
+ forth - i mean fourth )) it needed for minimum

All procedure takes 5 main actions

## 1 GitHub api
With web browser on github.com we need to make Personal Access Token in Developer section of Settings in main Menu.

## 2 Linux bash
We could use linux shell or Git Bash for windows to create public repo *seminar2*, after password prompt insert PAT token from first action:
```
curl -u allseen https://api.github.com/user/repos -d '{"name":"seminar2","private":false}'
```
## 3 Windows
To create remote repo from Windows PC is needed to install **curl** utility!
```
git init
git add README.md
git add -m "first commit"
git branch -M win
git remote add origin https://github.com/allseenn/seminar2.git
git push -u origin win
```
## 4 Linux git
```
git clone https://github.com/allseenn/seminar2.git
cd seminar2
git branch linux
git checkout linux
vim README.md
git add README.md
git commit -m "linux part"
git push
```
## 5 GitHub Web
On GitHub with web browser made main branch from win.
And will try to merge others to it, if possible )).
Seccessfuly changed default branch from win to main
in Settings - Branches
