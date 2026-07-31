return {
    "neovim-treesitter/nvim-treesitter",

    -- TODO: Hope they will add tags for consistent versioning of my plugins :)
    -- tag  = "v0.10.0",
    branch = "main",
    dependencies = { 'neovim-treesitter/treesitter-parser-registry' },

    lazy = false,
    build = ":TSUpdate",

    config = function()
        local treesitter = require("nvim-treesitter")
        local parsers = {
            -- 5 default ones
            "c", "lua", "vim", "vimdoc", "query",
            -- my additions
            "bash", "fish",
            "css",
            "csv",
            "dockerfile",
            "go",
            "hcl",
            "helm",
            "http",
            "javascript",
            "jsdoc",
            "json",
            "json5",
            "kotlin",
            "rust",
            "zig",
            "sql",
            "toml",
            "tsx",
            "typescript",
            "yaml",
        }

        -- Installing all the parsers
        treesitter.install(parsers)

        -- Enable treesitter features for all filetypes with parsers
        vim.api.nvim_create_autocmd("FileType", {
            pattern = "*",
            callback = function()
                local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
                if not lang then return end

                if pcall(vim.treesitter.start) then
                    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end
            end,
        })
    end
}
