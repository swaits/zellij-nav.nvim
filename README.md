# zellij-nav.nvim

This is a Neovim plugin which integrates window navigation with
[zellij](https://github.com/zellij-org/zellij).

It creates four new commands which will move between windows inside Neovim
(like `^w h` et. al.), but once it hits the edge of your editor it will attempt
to switch to the next zellij pane.

Commands:

- `ZellijNavigateLeft`
- `ZellijNavigateDown`
- `ZellijNavigateUp`
- `ZellijNavigateRight`

It also exports the lua versions, which you can call like this:

- `require("zellij-nav").left()`
- `require("zellij-nav").down()`
- `require("zellij-nav").up()`
- `require("zellij-nav").right()`

This is written in the spirit of
[vim-tmux-navigator](https://github.com/alexghergh/nvim-tmux-navigation/), but
for zellij instead, while also staying as simple and lightweight as possible.

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
