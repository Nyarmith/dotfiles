if type git >/dev/null 2>/dev/null; then
  initthisrepo(){
    printf "! are you sure you want to repofy this directory? [Y/n]\n"

    read ans
    [[ "$ans" != 'Y' ]] && {
        printf "aborting!\n"
        return 0
    }

    local repo="$(basename `pwd`)"
    printf "creating github repository : ${repo}"

    curl -u 'nyarmith' https://api.github.com/user/repos -d "{\"name\":\"$repo\"}" || {
        printf "error creating repo, aborting!\n"
        return 1
    }

    git init
    git add *
    git commit -m "Initial commit."
    git remote add origin "git@github.com:Nyarmith/${repo}.git"
    git push -u origin master
  }
fi
