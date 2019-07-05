if type git >/dev/null 2>/dev/null; then
  init_github(){
    if  [ -z $1 ]; then
      printf "Error: Pass repo name to function\n"
      return 1
    fi
    git init
    git add *
    git commit -m "Initial commit."
    git remote add origin git@github.com:Nyarmith/${1}.git
    git push -u origin master
  }
fi
