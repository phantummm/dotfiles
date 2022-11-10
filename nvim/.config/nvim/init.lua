local config_path = vim.fn.stdpath('config') .. '/init.lua'

-- vanilla settings
vim.opt.number = true
vim.opt.mouse = ''
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = false

vim.opt.swapfile = false

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.termguicolors = true
vim.opt.background = 'dark'

vim.g.mapleader = ','
vim.keymap.set({'n', 'x'}, 'cp', '"+y')
vim.keymap.set({'n', 'x'}, 'cv', '"+p')

vim.keymap.set({'n'}, '<leader>r', '<cmd>e ' .. config_path .. '<cr>')
vim.keymap.set({'n'}, '<leader>R', '<cmd>source ' .. config_path .. '<cr>')

vim.keymap.set({'n'}, '<leader>w', '<cmd>bd<cr>')
vim.keymap.set({'n'}, '<leader>W', '<cmd>%bd|e#|bd#<cr>')
vim.keymap.set({'n'}, '<Tab>', '<cmd>bn<cr>')
vim.keymap.set({'n'}, '<S-Tab>', '<cmd>bp<cr>')

-- plugins
-- packer bootstrap
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local install_plugins = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    local packer_url = 'https://github.com/wbthomason/packer.nvim'
    print('Installing packer...')
    vim.fn.system({'git', 'clone', '--depth', '1', packer_url, install_path})
    print('Done.')

    vim.cmd('packadd packer.nvim')
    install_plugins = true
end

if install_plugins then
    return
end

-- specify plugins
require('packer').startup(function(use)
    use 'wbthomason/packer.nvim'

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- autocomplete/snippets
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'hrsh7th/nvim-cmp'

    -- git
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive'

    use 'nvim-treesitter/nvim-treesitter'
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.0',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
        tag = 'nightly',
    }

    -- themes/UI
    use 'ellisonleao/gruvbox.nvim'
    use 'nvim-lualine/lualine.nvim'
    use {
        'akinsho/bufferline.nvim',
        tag = "v3.*",
        requires = 'nvim-tree/nvim-web-devicons'
    }


    if install_plugins then
        print('Syncing packer...')
        require('packer').sync()
    end
end)

-- plugin-dependent stuff
local lsp_defaults = {
    flags = {
        debounce_text_changes = 150,
    },
    capabilities = vim.lsp.protocol.make_client_capabilities(),
    on_attach = function(_, _)
        vim.api.nvim_exec_autocmds('User', {pattern = 'LspAttached'})
    end
}

require('mason').setup()
require('mason-lspconfig').setup({
    ensure_installed = {
        "sumneko_lua",
        "rust_analyzer",
        "pyright",
        "bashls",
    }
})

local cmp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lspconfig = require('lspconfig')
lspconfig.util.default_config = vim.tbl_deep_extend(
    'force',
    lspconfig.util.default_config,
    lsp_defaults,
    { capabilities = cmp_capabilities }
)


lspconfig.sumneko_lua.setup({
    settings = {
        Lua = {
            diagnostics = {
                globals = { 'vim' },
            },
        },
    },
})
lspconfig.pyright.setup({
    -- Don't love this, but it sucks when broken, and can be activated in project
    reportGeneralTypeIssues = false
})
lspconfig.rust_analyzer.setup({})

vim.api.nvim_create_autocmd('User', {
    pattern = 'LspAttached',
    desc = 'LSP actions',
    callback = function()
        local bufmap = function(mode, lhs, rhs)
            local opts = { buffer = true }
            vim.keymap.set(mode, lhs, rhs, opts)
        end

        bufmap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>')
        bufmap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>')
        bufmap('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>')
        bufmap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>')
        bufmap('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>')
        bufmap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>')
        bufmap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>')
        bufmap('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>')
        bufmap('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>')
        bufmap('x', '<F4>', '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
        bufmap('n', 'gl', '<cmd>lua vim.diagnostic.open_float()<cr>')
        bufmap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<cr>')
        bufmap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<cr>')
    end
})

local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn['vsnip#anonymous'](args.body)
        end,
    },
    mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
	}, {
		{ name = 'buffer' },
	}),
})

require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
    },
    ensure_installed = {
        'lua',
        'python',
        'bash',
        'rust',
    },
})

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', 'ff', telescope_builtin.find_files, {})
vim.keymap.set('n', 'fg', telescope_builtin.live_grep, {})
vim.keymap.set('n', 'fb', telescope_builtin.buffers, {})
vim.keymap.set('n', 'fh', telescope_builtin.help_tags, {})

require('nvim-tree').setup({
    view = {
        side = "right",
    },
})

vim.keymap.set('n', '<leader>d', '<cmd>:NvimTreeToggle<cr>', {})
vim.keymap.set('n', '<leader>D', '<cmd>:NvimTreeFindFile<cr>', {})

require('gitsigns').setup()

require('gruvbox').setup({
    contrast = 'hard',
    italic = false,
})

vim.cmd("colorscheme gruvbox")

require('bufferline').setup({})
require('lualine').setup({
    options = {
        theme = 'gruvbox-material',
        icons_enabled = false,
        section_separators = '',
        component_separators = '',
    },
    sections = {
        lualine_c = {
            {
                'filename',
                path = 3,
            }
        },
    },
})
