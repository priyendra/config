git log --author="$1" --pretty=tformat: --numstat | grep -v third-party | gawk '{ add += $1 ; subs += $2 ; loc += $1 - $2 } END { printf "added lines: %s removed lines : %s total lines: %s\n",add,subs,loc }' -
echo -n "Number of changes: "
git log --author="$1" --format=oneline | wc -l
