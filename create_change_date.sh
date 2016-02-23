if date --version >/dev/null 2>&1 ; then
    LANG=DE_de date -d@"$(git log -1 --pretty=format:%ct)" "+%e. %B %Y %H:%M"

else
    LANG=DE_de date -r "$(git log -1 --pretty=format:%ct)" "+%e. %B %Y %H:%M"
fi

