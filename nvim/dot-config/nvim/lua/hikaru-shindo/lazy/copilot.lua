return {
    "zbirenbaum/copilot.lua",
    branch = "master",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
        require("copilot").setup({
            suggestion = {
                auto_trigger = true
            }
        })
    end,
}
