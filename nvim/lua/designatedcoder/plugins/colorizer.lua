return {
    {
        "NvChad/nvim-colorizer.lua",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            user_default_options = {
                tailwind = true,
            }
        }
    },
}
