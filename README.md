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
- `ZellijNavigateLeftTab`
- `ZellijNavigateDownTab`
- `ZellijNavigateUpTab`
- `ZellijNavigateRightTab`

It also exports the `lua` versions, which you can call like this:

- `require("zellij-nav").left()`
- `require("zellij-nav").down()`
- `require("zellij-nav").up()`
- `require("zellij-nav").right()`
- `require("zellij-nav").left_tab()`
- `require("zellij-nav").down_tab()`
- `require("zellij-nav").up_tab()`
- `require("zellij-nav").right_tab()`

This is written in the spirit of
[vim-tmux-navigator](https://github.com/alexghergh/nvim-tmux-navigation/), but
for zellij instead, while also aiming to be as simple and lightweight as
possible.

## Installing

### [lazy](https://github.com/folke/lazy.nvim) (recommended)

```lua
{
  "swaits/zellij-nav.nvim",
  lazy = true,
  event = "VeryLazy",
  keys = {
    { "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>",  { silent = true, desc = "navigate left or tab"  } },
    { "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { silent = true, desc = "navigate down"  } },
    { "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { silent = true, desc = "navigate up"    } },
    { "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { silent = true, desc = "navigate right or tab" } },
  },
  opts = {},
}
```

### [pckr](https://github.com/lewis6991/pckr.nvim)

```lua
{
  "https://github.com/swaits/zellij-nav.nvim",
  config = function()
    require("zellij-nav").setup()

    local map = vim.keymap.set
    map("n", "<c-h>", "<cmd>ZellijNavigateLeftTab<cr>",  { desc = "navigate left or tab"  })
    map("n", "<c-j>", "<cmd>ZellijNavigateDown<cr>",  { desc = "navigate down"  })
    map("n", "<c-k>", "<cmd>ZellijNavigateUp<cr>",    { desc = "navigate up"    })
    map("n", "<c-l>", "<cmd>ZellijNavigateRightTab<cr>", { desc = "navigate right or tab" })

  end
}
```

### [vim-plug](https://github.com/junegunn/vim-plug)

```vim
Plug 'https://github.com/swaits/zellij-nav.nvim'
lua require("zellij-nav").setup()

nnoremap <c-h> <cmd>ZellijNavigateLeft<cr>
nnoremap <c-j> <cmd>ZellijNavigateDown<cr>
nnoremap <c-k> <cmd>ZellijNavigateUp<cr>
nnoremap <c-l> <cmd>ZellijNavigateRight<cr>
```

## Avoiding keymaps collision

Since the purpose of this plugin is to have the same keymaps for pane navigation in Zellij and window navigation in Neovim, we have to make sure Zellij doesn't intercept our keymaps while inside Neovim. This can be achieved by forcing Zellij into locked mode while Neovim is active.

```
vim.api.nvim_create_autocmd({ "FocusGained" }, {
  command = "silent !zellij action switch-mode locked",
})
vim.api.nvim_create_autocmd({ "VimEnter" }, {
  command = "silent !zellij action switch-mode locked",
})
vim.api.nvim_create_autocmd({ "FocusLost" }, {
  command = "silent !zellij action switch-mode normal",
})
vim.api.nvim_create_autocmd({ "VimLeave" }, {
  command = "silent !zellij action switch-mode normal",
})
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
