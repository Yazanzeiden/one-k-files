# Function to check if any .txt files exist in the main directory
check_txt_files() {
    if ls *.txt &> /dev/null; then
        return 0
    else
        return 1
    fi
}

# Function to create sub-folders for each language
create_subfolders() {
    for lang in "${languages[@]}"; do
        mkdir -p "$lang"
    done
}

# Function to move files to their respective sub-folders
move_files() {
    for file in *.txt; do
        lang=$(echo "$file" | awk -F'-' '{print $1}')
        mv "$file" "$lang/"
    done
}

# Main script
languages=("Arabic" "English" "Bengali" "chinese" "french" "hindi" "indonesian" "portuguese" "russian" "spanish")

if [ -d "files" ]; then
    cd files || exit 1

    # Check if any .txt files exist in the main directory
    if ! check_txt_files; then
        echo "No more .txt files to organize."
        exit 0
    fi

    create_subfolders
    move_files
    echo "Files have been organized into sub-folders based on language."
else
    echo "Directory 'files' not found. Please make sure to place the files folder in the same directory as this script."
    exit 1
fi