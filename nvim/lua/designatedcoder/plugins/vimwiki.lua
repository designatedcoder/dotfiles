return {
    "vimwiki/vimwiki",
    -- The event that triggers the plugin
    event = "BufEnter *.md",
    -- The keys that trigger the plugin
    keys = { "<leader>ww", "<leader>wt" },
    -- The configuration for the plugin
    init = function()
        vim.g.vimwiki_list = {
            {
                path = 'path_to_your_vim_wikis',
                syntax = "markdown",
                ext = ".md",
            },
        }
        vim.g.vimwiki_ext2syntax = {['.md'] = 'markdown', ['.markdown'] = 'markdown', ['.mdown'] = 'markdown'}
    end
}
