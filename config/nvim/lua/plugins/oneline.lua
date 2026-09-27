return {
    'tpope/vim-fugitive',
    {
	'brenoprata10/nvim-highlight-colors',
	config = function()
	    vim.opt.termguicolors = true
	    require('nvim-highlight-colors').setup({})
	end,
    },
    {
	'windwp/nvim-autopairs',
	event = "InsertEnter",
	config = function()
	    require('nvim-autopairs').setup({})
	end,
    },
    {
	"iamcco/markdown-preview.nvim",
	cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	ft = { "markdown" },
	build = function() vim.fn["mkdp#util#install"]() end,
    }
}
