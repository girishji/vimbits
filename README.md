# vimbits

Curated Suite of Lightweight Vim Plugins.

1. [**HighlightOnYank**]() - Confirm yank operation by temporarily highlighting the region.
    
2. [**Easyjump**]() - Jump to any location on screen by typing two characters.

3. [**fFtT**]() - Highlight characters reachable in one jump using `f`, `t`, `F`, and `T` commands. 
 
4. [**Vim9cmdline**]() - Use *vim9script* in command-line seamlessley.


## Requirements

- Vim 9.0 or higher

## Installation

Install it via [vim-plug](https://github.com/junegunn/vim-plug).

<details><summary><b>Show instructions</b></summary>
<br>
  
Using vim9 script:

```vim
vim9script
plug#begin()
Plug 'girishji/vimbits'
plug#end()
```

Using legacy script:

```vim
call plug#begin()
Plug 'girishji/vimbits'
call plug#end()
```

</details>

Install using Vim's built-in package manager.

<details><summary><b>Show instructions</b></summary>
<br>
  
```bash
$ mkdir -p $HOME/.vim/pack/downloads/opt
$ cd $HOME/.vim/pack/downloads/opt
$ git clone https://github.com/girishji/vimbits.git
```

Add the following to your $HOME/.vimrc file.

```vim
packadd vimbits
```

</details>

## Highlight on Yank

Confirm that the text you intended to yank is actually yanked. This can help prevent surprises when you paste, especially if you accidentally hit the wrong keys.

### Configuration

To disable this feature 
