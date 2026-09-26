return {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",

    config = function()
        require("nvim-treesitter").setup()

        require("nvim-treesitter").install({
            "lua",
            "nix",
            "css",
            "cpp",
            "rust",
            "json",
        })

        vim.api.nvim_create_autocmd("FileType", {
            pattern = {
                "lua",
                "nix",
                "css",
                "cpp",
                "rust",
                "json",
            },
            callback = function()
                vim.treesitter.start()
            end,
        })
    end,
}
