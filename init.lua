vim.cmd([[set mouse=]])
vim.cmd([[set noswapfile]])
vim.opt.winborder = "rounded"
vim.opt.tabstop = 2
vim.opt.wrap = false
vim.opt.cursorcolumn = false
vim.opt.ignorecase = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.signcolumn = "yes"

vim.pack.add({
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/echasnovski/mini.nvim" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/chomosuke/typst-preview.nvim" },
	{ src = 'https://github.com/neovim/nvim-lspconfig' },
	{ src = "https://github.com/mason-org/mason.nvim" },
	{ src = "https://github.com/L3MON4D3/LuaSnip" },
})

require "mason".setup()
require "mini.pick".setup()
require "mini.diff".setup()
require "mini.bufremove".setup()
require "oil".setup()

vim.api.nvim_create_autocmd('LspAttach', {
	group = vim.api.nvim_create_augroup('my.lsp', {}),
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

-- LSP
vim.lsp.enable(
	{
		"lua_ls",
	}
)
vim.cmd [[set completeopt+=menuone,noselect,popup]]

-- snippets
require("luasnip").setup({ enable_autosnippets = true })
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/snippets/" })
local ls = require("luasnip")

-- mappings
local map = vim.keymap.set
vim.g.mapleader = " "

-- system clipboard
map({ 'n', 'v' }, '<leader>y', '"+y')
map({ 'n', 'v' }, '<leader>d', '"+d')
map({ 'n', 'v' }, '<leader>c', ':')

-- Keybindings
map('n', '<leader>o', ':update<CR> :source <CR>')
map('i', 'jk', '<ESC>')

map('n', '<leader>lf', vim.lsp.buf.format)

map('n', '<leader>f', "<Cmd>Pick files<CR>")
map('n', '<leader>b', "<Cmd>Pick buffers<CR>")
map('n', '<leader>h', "<Cmd>Pick help<CR>")
map('n', '<leader>g', "<Cmd>Pick grep_live<CR>")

map('n', '<leader>e', "<Cmd>Oil<CR>")
map('i', '<c-e>', function() vim.lsp.completion.get() end)

map("n", "<M-n>", "<cmd>resize +2<CR>")          -- Increase height
map("n", "<M-e>", "<cmd>resize -2<CR>")          -- Decrease height
map("n", "<M-i>", "<cmd>vertical resize +5<CR>") -- Increase width
map("n", "<M-m>", "<cmd>vertical resize -5<CR>") -- Decrease width

map('n', '<leader>n', ':cnext<CR>', { noremap = true, silent = true })
map('n', '<leader>p', ':cprev<CR>', { noremap = true, silent = true })
