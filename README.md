# VimBits

Suite of lightweight Vim plugins.

1. [**HighlightOnYank**](#plugin-highlightonyank) - Confirm yank operation by temporarily highlighting the region.

2. [**EasyJump**](#plugin-easyjump) - Jump to any location on screen by typing two characters.

3. [**fFtT**](#plugin-fFtT) - Highlight characters reachable in one jump using `f`, `t`, `F`, and `T` commands. 

4. [**Vim9Cmdline**](#plugin-vim9cmdline) - Use *vim9script* in command-line seamlessley.

5. **vimtips** from [zzapper](https://web.archive.org/web/20121104092340/http://zzapper.co.uk/vimtips.html) - `:h vimtips.txt`


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

## Configuration

By default, all plugins are enabled except for Vim9Cmdline. To disable a specific plugin, set its corresponding global variable to `false`. To enable a plugin, set its corresponding global variable to `true`.

```
vim9script
g:vimbits_highlightonyank = true
g:vimbits_easyjump = true
g:vimbits_fFtT = true
g:vimbits_vim9cmdline = false
```

More configurable options pertaining to individual plugins are described below.

# Plugin: HighlightOnYank

Ensure the text you intended to yank is correctly selected. This feature helps avoid surprises when pasting, especially if you accidentally hit the wrong keys.

The yanked region is temporarily highlighted (using `:h hl-IncSearch`) for 300 milliseconds by default. The duration and highlight group are configurable, and there's an option to disable highlighting in visual mode.

To customize the default settings, add the following to your `.vimrc` file:

```vim
vim9script
g:vimbits_highlightonyank = false  # Disables the default autocmd
import autoload 'vimbits/highlightonyank.vim' as hy
augroup HighlightOnYank
    autocmd!
    autocmd TextYankPost * hy.HighlightOnYank('IncSearch', 300, true)
augroup END
```

`HighlightOnYank()` accepts three arguments:

- `hlgroup`: The highlight group for the yanked region.
- `duration`: The duration of the highlight in milliseconds.
- `in_visual`: Whether to highlight the region when yanked in visual mode.

This mini plugin is inspired by [this issue](https://github.com/vim/vim/issues/14848).

# Plugin: EasyJump

Jump to any location on screen by typing two characters.

## TL;DR

- `s` + _\<character>_ + _\<tag_character>_ to jump
- `ds` + _\<character>_ + _\<tag_character>_ to delete (similarly, `vs` for visual selection, `cs` for change, etc.)
- `<Tab>` and `<S-Tab>` (or `;` and `,`) after _\<character>_ to view additional tag characters
- `2s` + _\<character_1>_ + _\<character_2>_ + _\<tag_character>_ to jump

## Features

- Initially bound to `s`, but it can be reassigned to any desired trigger (e.g., `,`).
- Supports essential Vim idioms such as `ds` for deletion, `cs` for change, `vs` for visual selection, and more. Here `s` is the trigger character.
- Updates the jump list (`:jumps`) for easy back-navigation using `<c-o>`.
- Optional two-character mode, for users accustomed to targeting with two characters instead of one.
- Non-disruptive: Does not modify the buffer. Crafted in vim9 script.


🚀 **Jump (`s`)**: Type `s` followed by a character (say `c`). Witness
new tag characters replacing the character `c`. Typing next
character initiates the jump. For instance, typing `e`
navigates the cursor to the `c` under `e`.

<img src='https://gist.githubusercontent.com/girishji/40e35cd669626212a9691140de4bd6e7/raw/6041405e45072a7fbc4e352cbd461e450a7af90e/easyjump-img1.jpeg' width='700'>

🚀 **Jump back**: Type `<c-o>` (control-O) to jump back. Type `<tab>` or `<c-i>` to jump forward.

🚀 **Visual Select (`vs`)**: For visually selecting a block of text from the
cursor position up to an instance of `c`, enter `vsc`, then the highlighted
character (e.g., `e`).

<img src='https://gist.githubusercontent.com/girishji/40e35cd669626212a9691140de4bd6e7/raw/6041405e45072a7fbc4e352cbd461e450a7af90e/easyjump-img2.jpeg' width='700'>

Likewise, use `ds` for deletion or `cs` for text alteration.

Press `<esc>` to cancel the ongoing jump.

Pictures above are based on `:colorscheme quiet`.

🔎 **What if the intended jump location is not showing a tag letter?**

This scenario occurs when there aren't enough unique letters available for
tagging. Simply press `<Tab>` (or `;`), and new tag labels will fill the
remaining spots. To cycle backwards, press `<S-Tab>` (or `,`).

🚀 **Two-Character Mode (New)**: Activated with `2s` or simply `s` if `g:easyjump_two_chars` is configured as `true`.

- Use `2s` + _\<character>_ + _\<tag_character>_ to leap to your destination (when a tag character marks the spot).
- If no tag label is present, type the adjacent character as well, forming `2s` + _\<character_1>_ + _\<character_2>_ + _\<tag_character>_ to execute the jump.

> [!TIP]
> A lazy way to navigate is by leveraging the space character as a guide. Experiment with typing `s` followed by `<space>`. The algorithm strives to allocate one label per line. Once you're near your desired location within a line, you can [effectively employ](https://github.com/girishji/fFtT.vim) Vim's built-in `f/F, t/T` commands to reach it precisely. This is an alternative to using relative line numbers to jump.

## Trigger Key

By default, `s` serves as the trigger key. To unmap `s` and restore it to the default (:h s),
include the following line in your .vimrc file:

```
g:easyjump_default_keymap = false
```

To assign `,` as the trigger for jumping, add the following lines to your `.vimrc`
file. You can choose any other key beside `,`.

```
nmap , <Plug>EasyjumpJump;
omap , <Plug>EasyjumpJump;
vmap , <Plug>EasyjumpJump;
```

## Case Sensitivity

Options include 'case' (case sensitive), 'icase' (ignore case), or 'smart'
(smart case). Add the following line to your .vimrc:

```
g:easyjump_case = 'smart' # Can be 'case', 'icase', or 'smart' (default).
```

## Highlight Group

The tag letters displayed alongside destination locations utilize the
highlighted group `EasyJump`. By default, this group is linked to `IncSearch`. Modify its
appearance using the `:highlight` command to change colors.

## Tag Letters

Jump locations prioritize placement based on distance from cursor and
preference for having at least one placement per line.
Letters are picked in the following sequence. Modify the sequence (say, for
Dvorak) as needed. Set the following global variable:

```
g:easyjump_letters = 'asdfgwercvhjkluiopynmbtqxzASDFGWERCVHJKLUIOPYNMBTQXZ0123456789'
```

# Plugin: fFtT

Characters that are reachable with a single jump are highlighted, while others are dimmed. This enhancement enhances the accuracy of navigation using `f`, `F`, `t`, and `T` commands. Moreover, you can prefix the command with a numerical `[count]` (e.g., `3f`), which will exclusively highlight the `[count]`'th occurrence (third in this instance) of a character to the right of the cursor, while dimming the others.

This plugin does not alter Vim operators or commands. It solely focuses on highlighting relevant characters without making any changes to the default key mappings. The code consists of less than 100 lines, with explanatory comments.

![](https://gist.githubusercontent.com/girishji/40e35cd669626212a9691140de4bd6e7/raw/6041405e45072a7fbc4e352cbd461e450a7af90e/fFtT-img.jpeg)

The appearance of characters that are unreachable within one jump is determined by the highlight group `FfTtSubtle`, which is linked to the `Comment` group by default.

# Plugin: Vim9Cmdline

*vim9script* offers significant improvements over the legacy script. Although there isn't a direct way to switch the command line to parse *vim9script*, you can execute *vim9script* commands by prepending each command with `vim9`. This plugin automates that process for you.

<img src='https://gist.githubusercontent.com/girishji/40e35cd669626212a9691140de4bd6e7/raw/74e521e25364bdc01a94ce8668e8d8ef92308a59/vim9cmdline.jpeg' width='700'>

Some things to keep in mind:

- Remember that execution occurs in the global context, not the script-local context. This means you need to declare variables with the `g:` prefix, like `g:foo = 'bar'`.

- Common commands, such as visual range (`'<,'>`), other types of ranges, shell commands (`!`), substitution (`s//`), and global (`g//`), work as expected even when `vim9` is prepended.

- Ranges to Ex commands should be prefixed with a colon. For example, `:vim9 :%s/foo/bar` (notice the `:` before `%s`).
  From `:h [range]`:

  > In Vim9 script a range needs to be prefixed with a colon to avoid ambiguity
  > with continuation lines.

- Related to the above, if your keymap's right-hand side (rhs) starts with a range, it may throw an error. To avoid this, use `:h <Cmd>` or ensure the {rhs} of your keymap begins with `silent` or `:`. For example, `nnoremap your_key :% !your_cmd<cr>` throws an error, while `nnoremap your_key <cmd>% !your_cmd<cr>`, `nnoremap your_key :silent % !your_cmd<cr>` and `nnoremap your_key ::% !your_cmd<cr>` are OK.

- Colorschemes may not load if they are written in legacy script. `:vim9 colorscheme foo` will not work unless `foo` is written in vim9script.

- If you have defined a custom command with a completion function (`command -complete=custom,Foo() ...`), be aware that this function may not work as expected if it is designed to complete the n-th word. This is because there are now n+1 words, including the word `vim9`. You many need to adapt this function.

- If you work with multi-byte UTF-8 characters, you'll appreciate the *vim9* command line. When slicing a UTF-8 string using the `[from : to]` operator, *vim9* is more predictable because it uses character-based addressing, unlike the byte-based addressing of the legacy script.

- Legacy mode of addressing autoloaded functions and variables still work, even without legacy keywords like `call` and `let`. For instance, both `:vim9 g:foo#bar#baz()` and `:vim9 call g:foo#bar#baz()` work.

You can keep the command line in *vim9script* mode by default and switch back to the legacy script at any time using the `:ToggleVim9Cmdline` command.

## Other Plugins to Enhance Your Workflow

1. [**vimcomplete**](https://github.com/girishji/vimcomplete) - enhances autocompletion in Vim.

2. [**devdocs.vim**](https://github.com/girishji/devdocs.vim) - browse documentation from [devdocs.io](https://devdocs.io).

3. [**scope.vim**](https://github.com/girishji/scope.vim) - fuzzy find anything.

4. [**VimSuggest**](https://github.com/girishji/vimsuggest) - autocompletion for Vim's command-line.
