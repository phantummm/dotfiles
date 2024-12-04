local config_path = vim.fn.stdpath('config') .. '/init.lua'

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
    use 'onsails/lspkind.nvim'

    -- copilot
    use 'zbirenbaum/copilot.lua'

    -- autocomplete/snippets
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'
    use 'zbirenbaum/copilot-cmp'
    use 'hrsh7th/nvim-cmp'
    use 'm4xshen/autoclose.nvim'

    -- git
    use 'lewis6991/gitsigns.nvim'
    use 'tpope/vim-fugitive'

    use 'nvim-treesitter/nvim-treesitter'
    use 'RRethy/nvim-treesitter-endwise'
    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons',
        },
    }
    use 'ThePrimeagen/harpoon'

    -- themes/UI
    use 'ellisonleao/gruvbox.nvim'
    use 'nvim-lualine/lualine.nvim'
    use {
        'akinsho/bufferline.nvim',
        tag = "*",
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
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "bashls",
        "intelephense",
        "tsserver",
        "tailwindcss",
        "eslint",
        "ruby_lsp",
        "rubocop",
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


lspconfig.lua_ls.setup({
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
lspconfig.bashls.setup({})
lspconfig.intelephense.setup({})
lspconfig.tsserver.setup({})
lspconfig.tailwindcss.setup({})
lspconfig.eslint.setup({})
lspconfig.ruby_lsp.setup({})
lspconfig.rubocop.setup({})

vim.api.nvim_create_autocmd("LspAttach", {
    callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        client.server_capabilities.semanticTokensProvider = nil
    end,
});

require('nvim-treesitter.configs').setup({
    indent = {
        enable = true,
    },
    endwise = {
        enable = true,
    },
    highlight = {
        enable = true,
    },
    ensure_installed = {
        'lua',
        'python',
        'bash',
        'rust',
        'php',
        'javascript',
        'typescript',
        'tsx',
        'ruby',
    },
})

require('nvim-tree').setup({
    view = {
        side = "right",
        width = 50,
    },
})

require('gitsigns').setup()

require('gruvbox').setup({
    contrast = 'hard',
    italic = {
        strings = false,
        operators = false,
        comments = false,
    },
})

require('autoclose').setup({})

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

require('copilot').setup({
    panel = { enabled = false },
    suggestion = { enabled = true },
})
require("copilot_cmp").setup({})

local function close_buffer_smart()
    vim.cmd('bdelete')

    local remaining_buffers = vim.fn.getbufinfo({buflisted = 1})
    local remaining_count = #remaining_buffers

    if remaining_count == 0 and vim.fn.winnr('$') == 1 and vim.fn.exists('*NvimTreeFindFile') == 1 then
        vim.cmd('enew')
        vim.cmd('NvimTreeFindFile')
    elseif remaining_count > 0 then
        vim.cmd('bp')
    end
end

local function close_other_buffers()
    local current_buf = vim.api.nvim_get_current_buf()
    local buffers = vim.api.nvim_list_bufs()

    for _, buf in ipairs(buffers) do
        if vim.api.nvim_buf_is_loaded(buf) and buf ~= current_buf then
            local is_nvim_tree = vim.fn.bufname(buf):match('NvimTree_') ~= nil
            if not is_nvim_tree then
                vim.api.nvim_buf_delete(buf, {force = true})
            end
        end
    end

    vim.cmd('redrawtabline')
end

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

-- Because ftplugins overwrite formatoptions :(
vim.cmd([[autocmd BufEnter * set formatoptions-=cro]])

-- Keymaps
vim.g.mapleader = ','
vim.keymap.set({'n', 'x'}, 'cp', '"+y')
vim.keymap.set({'n', 'x'}, 'cv', '"+p')

vim.keymap.set({'n'}, '<leader>r', '<cmd>e ' .. config_path .. '<cr>')
vim.keymap.set({'n'}, '<leader>R', '<cmd>source ' .. config_path .. '<cr>')

vim.keymap.set({'n'}, '<leader>b', '<cmd>cclose<cr>')
vim.keymap.set({'n'}, '<leader>v', '<cmd>vsplit<cr>')
vim.keymap.set({'n'}, '<Tab>', '<cmd>bn<cr>')
vim.keymap.set({'n'}, '<S-Tab>', '<cmd>bp<cr>')
vim.keymap.set({'n'}, '<leader>w', close_buffer_smart, {})
vim.keymap.set({'n'}, '<leader>W', close_other_buffers, {})
vim.keymap.set({'n'}, '<leader>q', '<cmd>q<cr>', {silent=true})

local telescope_builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>t', telescope_builtin.find_files, {})
vim.keymap.set('n', '<leader>F', telescope_builtin.live_grep, {})
vim.keymap.set('n', 'fb', telescope_builtin.buffers, {})
vim.keymap.set('n', 'fh', telescope_builtin.help_tags, {})

vim.keymap.set('n', '<leader>d', '<cmd>:NvimTreeToggle<cr>', {})
vim.keymap.set('n', '<leader>D', '<cmd>:NvimTreeFindFile<cr>', {})

vim.keymap.set('n', '<leader>B', '<cmd>Git blame<cr>', {silent=true})

local harpoon_mark = require('harpoon.mark')
local harpoon_ui = require('harpoon.ui')
vim.keymap.set('n', '<leader>M', harpoon_mark.add_file, {})
vim.keymap.set('n', '<leader>N', harpoon_mark.rm_file, {})
vim.keymap.set('n', '<leader>m', harpoon_ui.toggle_quick_menu, {})
vim.keymap.set('n', '<M>]>', harpoon_ui.nav_next, {})
vim.keymap.set('n', '<M>[>', harpoon_ui.nav_prev, {})

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
local lspkind = require('lspkind')
vim.api.nvim_set_hl(0, "CmpItemKindCopilot", {fg ="#6CC644"})

cmp.setup({
    window = {
        -- completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
    performance = {
        max_view_entries = 20,
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ["<C-h>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({
            i = cmp.mapping.abort(),
            c = cmp.mapping.close(),
        }),
        ['<CR>'] = cmp.mapping({
            i = function(fallback)
                if cmp.visible() and cmp.get_active_entry() then
                    cmp.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = false })
                else
                    fallback()
                end
            end,
            s = cmp.mapping.confirm({ select = true }),
            c = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
        }),
    }),
    sources = cmp.config.sources({
        { name = 'copilot', group_index = 1 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'path', group_index = 4 },
    }, {
            { name = 'buffer' },
        }),
    formatting = {
        format = lspkind.cmp_format({
            -- mode = 'symbol',
            maxwidth = 100,
            ellipsis_char = '...',
            show_labelDetails = true,
            before = function (_, vim_item)
                return vim_item
            end,
            symbol_map = { Copilot = "" },
        })
    }
})
