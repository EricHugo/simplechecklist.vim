# simpleChecklist.vim
WIP

## Installation

#### [Vim-Plug](https://github.com/junegunn/vim-plug) (Recommended)

1. Add `Plug 'erichugo/simplechecklist.vim' to your vimrc (vim) or init.vim (neovim) file
2. Open a new instance of Vim/Neovim
3. Run `:PlugInstall`

Many other plugin managers are available. If you use a different one I am sure you know how.

## Usage
simplechecklist.vim is active only for filetype `.chk`, which includes highlighting. Thus a simple way to use is:

``` bash
vim TODO.chk
```

Ones in vim/neovim all newlines will create a new checklist entry. E.g.:
```
-> [ ] Add README
-> [ ] 
```

Entries can be toggled as complete or not in normal and visual mode with
``` vim
<leader>z
```

