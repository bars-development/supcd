function supcd() {
    
    # Set the path to the file storing alias-location mappings
    local alias_file="$HOME/.supcd_aliases" #change this to the desired destination to keep redirection dictionary

    # Display the intstructions on how to use
    if [ "$#" -eq 0 ]; then 
        echo "Usage:
            supcd -l                    - Lists all aliases and their paths.
            supcd <alias>               - Changes to the directory of the specified alias.
            supcd add <alias>           - Adds the current directory as an alias.
            supcd add <alias> <path>    - Adds a specified directory under the alias.
            supcd remove <alias>        - Removes the specified alias."
        return 0
    fi

    # Check for -l flag, display all aliases and paths
    if [ "$#" -eq 1 ] && [ "$1" = "-l" ]; then
        echo "All aliases and paths:"
        awk -F':' '{ printf "%-15s %s\n", $1, $2 }' "$alias_file"
        return 0
    fi

    # Check if two arguments are provided and the first is "add", add the current directory under the provided alias
    if [ "$#" -eq 2 ] && [ "$1" = "add" ]; then
        if grep -q "^$2:" "$alias_file"; then 
            echo "Alias with this name already exists. Are you sure you want to rewrite the alias?(y/n)"
            read -r answer
            if [[ "$answer" != "y" && "$answer" != "Y" ]]; then
                return 1
            fi 
        fi
        echo "$2:$(pwd)" >> "$alias_file"
        echo "Alias added: $2 -> $(pwd)"
        return 0
    fi

    # Check if three arguments are provided and the first is "add", add the directory given in the third argument under the alias given in the second argument to the list
    if [ "$#" -eq 3 ] && [ "$1" = "add" ]; then
        if grep -q "^$2:" "$alias_file"; then 
            echo "Alias with this name already exists. Are you sure you want to rewrite the alias?(y/n)"
            #add yes no 
        fi
        echo "$2:$3" >> "$alias_file"
        echo "Alias added: $2 -> $3"
        return 0
    fi

    # Check if two arguments are provided and the first is "remove", remove the given alias from the list
    if [ "$#" -eq 2 ] && [ "$1" = "remove" ]; then
        # Check if the alias exists in the mapping file
        if grep -q "^$2:" "$alias_file"; then
            sed -i "/^$2:/d" "$alias_file"
            echo "Alias removed: $2"
            return 0
        else
            echo "Alias not found: $2"
            return 1
        fi
    fi

    local alias_name="$1"
    local target_dir

    # Change directory to the given alias if exists
    if grep -q "^$alias_name:" "$alias_file"; then
        target_dir=$(grep "^$alias_name:" "$alias_file" | cut -d ':' -f 2)
        cd "$target_dir" || return 1
        echo "Changed directory to: $target_dir"
    else
        echo "Alias not found: $alias_name"
        return 1
    fi
}
