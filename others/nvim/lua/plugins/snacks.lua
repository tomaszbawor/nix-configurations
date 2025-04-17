return {
  "folke/snacks.nvim",
  opts = {
    explorer = { enabled = true }, -- keep the sidebar itself on
    picker = {
      -- defaults you want every picker to inherit (optional)
      -- hidden = true,
      -- ignored = true,
      sources = {
        explorer = {
          hidden = true, -- ‹dotfiles› like .env, .gitignore, …
          ignored = false, -- set to true if you also want .gitignored items
          include = { ".gitignore" },
          -- exclude  = { ".git", "node_modules" }, -- optional filters
          -- include  = { ".env" },                 -- whitelist patterns
        },
      },
    },
  },
}
