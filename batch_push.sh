#!/bin/bash
set -e
echo "Starting local incremental push..."

cd /Users/windwild/codebox/windwild-solo/apps/news-curator/articles
git reset --soft origin/main
git reset HEAD

echo "Finding files to push..."
files=$( (git ls-files -o --exclude-standard; git diff --name-only; git diff --name-only --cached) | sort | uniq | grep -v '^$' )
total=$(echo "$files" | wc -l | xargs)

echo "Total files to push: $total"
if [ "$total" -eq 0 ]; then
    echo "Nothing to push"
    exit 0
fi

count=0
batch_num=1

# Use a while read loop to process spaces in filenames correctly if any
echo "$files" | while IFS= read -r file; do
    if [ -z "$file" ]; then continue; fi
    git add "$file"
    count=$((count + 1))
    
    if [ $((count % 100)) -eq 0 ]; then
        echo "Pushing batch $batch_num ($count/$total files)..."
        git commit -m "chore(sync): batch push $batch_num ($count/$total files)"
        if ! git push origin main; then
            echo "Failed to push batch $batch_num."
            exit 1
        fi
        batch_num=$((batch_num + 1))
    fi
done

if [ $((count % 100)) -ne 0 ]; then
    echo "Pushing final batch..."
    git commit -m "chore(sync): final batch push ($count/$total files)"
    git push origin main
fi
echo "Done!"
