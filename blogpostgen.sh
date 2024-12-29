#!/usr/bin/bash
# This script generates a blog post in Jekyll so that you no longer have to manually input and/or copy information for a couple of minutes. Includes most of the official Chirpy "Text and Typography" page—shortened to the elements I use most often.

# The fun and interactive part of the script.
echo "Please enter the name of the learning platform:"
read -r platform_name
echo "Please enter the name of the specific challenge/room/box:"
read -r challenge_name
echo "Please enter one or more tags in lowercase to associate with your post (separate by spaces if needed):"
read -r post_header_tags

# Somewhat redundant variables defined so that I didn't have to excessively double-quote in the below sed statements.
blog_path="$HOME/github/orionilloc.github.io"
post_filename_date=$(date "+%Y-%m-%d")
post_filename_full="${post_filename_date}-${challenge_name}.md"

# Creates a new post with the specified post title, as needed for static site generation.
if [[ -f "$blog_path/_posts/$post_filename_full" ]]; then
    echo "Post file already exists with the current date. Exiting to avoid data loss." && exit 1
else
    cp "$blog_path/_posts/Post-Template.md" "$blog_path/_posts/$post_filename_full"
fi

if [[ -d "$blog_path/assets/img/$challenge_name" ]]; then
    echo "Image directory already exists. Exiting to avoid data loss." && exit 2
else
    mkdir "$blog_path/assets/img/$challenge_name"
fi

# Sed statements to replace all of the placeholder text in the newly created post.
sed -i "s/PostDatePlaceholder/$post_filename_date/g" "$blog_path/_posts/$post_filename_full"
sed -i "s/PlatformNamePlaceholder/$platform_name/g" "$blog_path/_posts/$post_filename_full"
sed -i "s/ChallengeNamePlaceholder/$challenge_name/g" "$blog_path/_posts/$post_filename_full"
sed -i "s/TagsPlaceholder/$post_header_tags/g" "$blog_path/_posts/$post_filename_full"
