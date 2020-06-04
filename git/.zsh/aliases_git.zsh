gitexe()
{
    if [[ $(pwd -P) == *"/mnt/c/"* ]];
    then
        git.exe "$@"  
    else 
        git "$@" 
    fi
}

alias git=gitexe

alias git-log-since-rlz='git log --oneline --pretty=format:"%h%x09%an%x09%s" --no-merges `git describe --abbrev=0 --tags`..HEAD'
