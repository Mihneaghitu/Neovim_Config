vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = true, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  }
})

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the four listed parsers should always be installed)
  ensure_installed = { "c", "cpp", "python", "lua", "vim" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { },
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

vim.opt.laststatus = 2
vim.opt.showtabline = 2
vim.opt.termguicolors = true

--require'staline'.setup {
--
--	sections = {
--		left = {
--			' ', 'right_sep', '-mode', 'left_sep', ' ',
--			'right_sep', '-cwd', 'left_sep', ' ',
--			'right_sep', '-branch', 'left_sep', ' ',
--		},
--		mid  = {'right_sep', 'lsp', 'left_sep', ' ', 'right_sep', '-file_name', 'left_sep', ' '},
--		right= {
--			'right_sep', '-cool_symbol', 'left_sep', ' ',
--			'right_sep', '- ', '-lsp_name', '- ', 'left_sep',
--			'right_sep', '-line_column', 'left_sep', ' ',
--		}
--	},
--
--	defaults={
--		fg = "#986fec",
--		cool_symbol = " ",
--		left_separator = "",
--		right_separator = "",
--		-- line_column = "%l:%c [%L]",
--		true_colors = true,
--		line_column = "[%l:%c] 並%p%% "
--		-- font_active = "bold"
--	},
--	mode_colors = {
--		n  = "#181a23",
--		i  = "#181a23",
--		ic = "#181a23",
--		c  = "#181a23",
--		v  = "#181a23"       -- etc
--	}
--}
-- local extensions = require('el.extensions')
-- local subscribe = require('el.subscribe')
-- local generator = function(_window, buffer)
--     local el_segments = {}
-- 
--     -- Statusline options can be of several different types.
--     -- Option 1, just a string.
-- 
--     table.insert(el_segments, '[creste pateul]')
--     table.insert(el_segments, '                                             ')
--     table.insert(el_segments, extensions.mode);
--     table.insert(el_segments, '                                             ')
--     table.insert(el_segments,
--       subscribe.buf_autocmd(
--         "el_file_icon",
--         "BufRead",
--         function(_, buffer)
--           return extensions.file_icon(_, buffer)
--         end
--       )
--     )
--     table.insert(el_segments, '                                             ')
--     table.insert(el_segments,
--       subscribe.buf_autocmd(
--         "el_git_branch",
--         "BufEnter",
--         function(window, buffer)
--           local branch = extensions.git_branch(window, buffer)
--           if branch then
--             return branch
--           end
--         end
--       )
--     )
-- 
--     return el_segments
-- end

-- And then when you're all done, just call
-- require('el').setup({generator=generator})
local function pate()
  return [[creste pateul]]
end

-- require('lualine').setup{
--   options = { theme = 'powerline' }, 
--   sections = { lualine_c = { 'filename', "[creste_pateul]" } }
-- }
require "lualine_config"

-- file manager
require("nvim-tree").setup()


local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<Tab>'] = cmp.mapping(cmp.mapping.select_next_item()),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'vsnip' }, -- For vsnip users.
  }, {
    { name = 'buffer' },
  })
})

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()
  -- if clang does not work, look into "update-alternatives"
  require('lspconfig')['clangd'].setup {
    capabilities = capabilities
  }
  require('lspconfig')['pyright'].setup {
    capabilities = capabilities
  }
  
  -- Dependency for fuzzy finder
  local async = require "plenary.async"

  -- Fuzzy finder
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

  -- Markdown preview 
  -- local md_preview = require "markdown-preview.nvim"

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager
  use 'neovim/nvim-lspconfig' -- Configurations for Nvim LSP
  use 'anott03/nvim-lspinstall' -- Language Server Easy Install
  use {
      'nvim-treesitter/nvim-treesitter',
      run = function()
          local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
          ts_update()
      end,
  }
  use 'tjdevries/colorbuddy.vim'
  use 'bkegley/gloombuddy'
  use 'folke/tokyonight.nvim'
  use 'Mofiqul/dracula.nvim'
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'tamton-aquib/staline.nvim'
  use 'nvim-tree/nvim-web-devicons'

  -- Completion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  -- For vsnip users.
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'

  -- File Manager
  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }
  use 'nikvdp/neomux'
  use "nvim-lua/plenary.nvim"

  use 'tjdevries/express_line.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.2',
  -- or                            , branch = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use({
    "iamcco/markdown-preview.nvim", run = "cd app && npm install",
    setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = { "markdown" }, 
  })

end)
