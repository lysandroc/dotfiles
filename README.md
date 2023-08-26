# Dotfiles

### Installation

To integrate these dotfiles into your environment, simply run the following command:

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/lysandroc/dotfiles/main/install.sh)"
```

### Bash shortcuts

| Shortcut          | Description                                                |
| ----------------- | ---------------------------------------------------------- |
| `ctrl + space`    | autocomplete and runs the written command                  |
| `alt + space`     | runs the last executed command                             |
| `ctrl + e`        | just autocomplete the command                              |
| `ctrl + r`        | search a command in the history                            |
| `ctrl + P`        | search a folder in the current directory                   |
| `ctrl + o`        | search and open a file in the current directory (disabled) |
| `tmux prefix + O` | opens the dotfile project in a new tmux window             |

### Neovim shortcuts

#### Navigation and Layout

| Shortcut        | Description                                   |
| --------------- | --------------------------------------------- |
| \<A-h\>         | Jump to the right panel                       |
| \<A-j\>         | Jump to the left panel                        |
| \<A-k\>         | Jump to the top panel                         |
| \<A-l\>         | Jump to the bottom panel                      |
| \<up\>          | Resize upwards (10x)                          |
| \<down\>        | Resize downwards (10x)                        |
| \<left\>        | Resize leftwards (3x)                         |
| \<right\>       | Resize rightwards (3x)                        |
| tmux prefix + O | Open the dotfile project in a new tmux window |

#### Clipboard and Editing

| Shortcut    | Description                                     |
| ----------- | ----------------------------------------------- |
| \<leader\>y | Yank text to the OS clipboard in visual mode    |
| \<leader\>P | Paste text from the OS clipboard in normal mode |
| \<J\>       | Move highlighted lines downwards                |
| \<K\>       | Move highlighted lines upwards                  |

#### Native Commands

| Shortcut          | Description                              |
| ----------------- | ---------------------------------------- |
| \<esc\>           | Hide search highlighting                 |
| \<leader\>sp      | Enable/disable spell-checking            |
| \<leader\>\<tab\> | Switch between open buffers              |
| \<leader\>sv      | Duplicate the current panel vertically   |
| \<leader\>sh      | Duplicate the current panel horizontally |

#### File and Git Operations

| Shortcut     | Description                               |
| ------------ | ----------------------------------------- |
| \<A-Q\>      | Force quit                                |
| \<A-q\>      | Quit the current file                     |
| \<A-x\>      | Quit and save the current file            |
| \<A-w\>      | Save the current file                     |
| \<leader\>hl | Toggle Git line highlights                |
| \<leader\>gs | Show untracked/staged files in Git        |
| \<leader\>gp | Git push                                  |
| \<leader\>gB | Open GitHub page for the current file     |
| \<leader\>gb | Checkout to another Git branch            |
| \<leader\>gd | Show Git diff                             |
| \<leader\>gl | Add the current line from right side file |
| \<leader\>gh | Add the current line from left side file  |

#### Language-Specific and Debugging

| Shortcut      | Description                     |
| ------------- | ------------------------------- |
| \<leader\>jjr | Run Jest                        |
| \<leader\>jjf | Run Jest for the current file   |
| \<leader\>jjd | Debug Jest for the current file |
| \<F5\>        | Continue debugging              |
| \<F10\>       | Step over during debugging      |
| \<F11\>       | Step into during debugging      |
| \<S-F11\>     | Step out during debugging       |
| \<F9\>        | Toggle breakpoint               |
| \<S-F9\>      | Set breakpoint with condition   |

#### Debugging UI

| Shortcut       | Description              |
| -------------- | ------------------------ |
| \<leader\>dapo | Open DAP UI              |
| \<leader\>dapc | Close DAP UI             |
| \<leader\>dapt | Toggle DAP UI visibility |
