# zellij-nav.nvim

This is a Neovim plugin that integrates window navigation with
[zellij](https://github.com/zellij-org/zellij).

It creates four new commands that will move between windows inside Neovim (like
`^w h` et al.), but once it reaches the edge of your editor, it will attempt to
switch to the next zellij pane.

Commands:

- `ZellijNavigateLeft`
- `ZellijNavigateDown`
- `ZellijNavigateUp`
- `ZellijNavigateRight`

It also exports the `lua` versions, which you can call like this:

- `require("zellij-nav").left()`
- `require("zellij-nav").down()`
- `require("zellij-nav").up()`
- `require("zellij-nav").right()`

This is written in the spirit of
[vim-tmux-navigator](https://github.com/alexghergh/nvim-tmux-navigation/), but
for zellij instead, while also aiming to be as simple and lightweight as
possible.

## Installing

### [lazy](https://github.com/folke/lazy.nvim) (recommended)

```lua
{
  "https://git.sr.ht/~swaits/zellij-nav.nvim",
  lazy = true,
  event = "VeryLazy",
  keys = {
    { "<c-h>", "<cmd>ZellijNavigateLeft<cr>",  { silent = true, desc = "navigate left"  } },
    { "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down"  } },
    { "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up"    } },
    { "<c-l>", "<cmd>ZellijNavigateRight<cr>", { silent = true, desc = "navigate right" } },
  },
  opts = {},
}
```

### [pckr](https://github.com/lewis6991/pckr.nvim)

```lua
{
  "https://git.sr.ht/~swaits/zellij-nav.nvim",
  config = function()
    require("zellij-nav").setup()

    local map = vim.keymap.set
    map("n", "<c-h>", "<cmd>ZellijNavigateLeft<cr>",  { desc = "navigate left"  })
    map("n", "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { desc = "navigate down"  })
    map("n", "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { desc = "navigate up"    })
    map("n", "<c-l>", "<cmd>ZellijNavigateRight<cr>", { desc = "navigate right" })

  end
}
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'https://git.sr.ht/~swaits/zellij-nav.nvim'
lua require("zellij-nav").setup()

nnoremap <c-h> <cmd>ZellijNavigateLeft<cr>
nnoremap <c-j> <cmd>ZellijNavigateDown<cr>
nnoremap <c-k> <cmd>ZellijNavigateUp<cr>
nnoremap <c-l> <cmd>ZellijNavigateRight<cr>
```

## Configuring Zellij

This plugin only covers the Neovim side of things. To achieve a fully seamless
workflow, we also need zellij to perform a few tasks.

In an ideal scenario, we would be able to map `C-hjkl` to function identically
in both zellij and Neovim, but unfortunately, that is not possible. Currently,
zellij has a few issues that prevent us from reaching that point.

Firstly, zellij does not allow us to bind `C-j` to any function. This is a
[known bug](https://github.com/zellij-org/zellij/issues/2679).

Secondly, and more importantly, when any of the `C-hjkl` keystrokes are used in
zellij, we need to be able to:

1. Determine if the focused pane is running `nvim`.
2. If it is, forward the keystrokes to the application, for example, by using
   the zellij `Write` action.
3. If it is not, directly perform the keystroke action in zellij by using the
   `MoveFocus <direction>` action.

Currently, I have not found a way to accomplish this, even through the zellij
[plugin system](https://zellij.dev/documentation/plugins).

Therefore, my configuration uses `A-hjkl` in zellij. As a result, I use
`C-hjkl` to navigate within Neovim and to switch from Neovim to another zellij
pane. However, if I'm in a non-`nvim` pane, I use `A-hjkl` to change focus.

## MIT License

Copyright © 2023 Stephen Waits <steve@waits.net>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
