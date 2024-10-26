# supcd

`supcd` is a simple shell function that allows you to set, list, remove, and navigate to directory aliases quickly. It helps to improve your workflow by letting you create easy-to-remember shortcuts for directories, which you can use across terminal sessions.

## Features

- **Add an Alias**: Create a shortcut for the current or any specified directory.
- **List Aliases**: View all saved aliases and their associated paths.
- **Remove Alias**: Delete a specific alias.
- **Navigate Using Aliases**: Use an alias to quickly change directories.

## Installation

1. **Download the Script**: Save the `supcd` function to a file (e.g., `supcd.sh`) in your home directory.

2. **Add the Script to Your Shell Configuration**: Add a command to your `.bashrc` or `.zshrc` file to load `supcd.sh` automatically in new terminal sessions.

   Run the following command to add the source command to the end of your shell configuration file:

   - For Zsh (`.zshrc`):
     ```bash
     sed -i -e '$a\' ~/.zshrc
     echo "source \"$(pwd)/supcd.sh\"" >> ~/.zshrc
     ```
   - For Bash (`.bashrc`):
     ```bash
     sed -i -e '$a\' ~/.bashrc
     echo "source \"$(pwd)/supcd.sh\"" >> ~/.bashrc
     ```
   - (Alternatively) Add manually the line :
     ```bash
     source '(download path)/supcd.sh'
     ```
     to your default shell config file

3. **Verify**: Open a new terminal or source your config file with `source ~/.zshrc` or `source ~/.bashrc` to start using `supcd`.

## Usage

- **Add Current Directory as Alias**:
  ```bash
  supcd add <alias_name>
  ```

This saves the current directory under `<alias_name>`.

- **Add Specific Directory as Alias**:

  ```bash
  supcd add <alias_name> <directory_path>
  ```

  This saves `<directory_path>` under `<alias_name>`.

- **List All Aliases**:

  ```bash
  supcd -l
  ```

- **Remove an Alias**:

  ```bash
  supcd remove <alias_name>
  ```

- **Change to Alias Directory**:

  ```bash
  supcd <alias_name>
  ```

  This navigates to the directory saved under `<alias_name>`.

### Example

```bash
# Add an alias for the current directory
supcd add project

# Add an alias for a specified directory
supcd add docs /path/to/documentation

# List all aliases
supcd -l

# Remove an alias
supcd remove project

# Navigate to an alias
supcd docs
```

## Notes

- The alias mappings are stored in a file at `~/.supcd_aliases`. You can modify this location by changing the `alias_file` variable in the `supcd` function if needed.

Enjoy efficient directory navigation with `supcd`!
