return {
  -- tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "bash-language-server",
        "astro-language-server",
        "stylua",
        "selene",
        "luacheck",
        "shellcheck",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "dockerfile-language-server",
        "docker-compose-language-service",
        "emmet-language-server",
        "eslint-lsp",
        "html-lsp",
        "htmx-lsp",
        "json-lsp",
        "intelephense",
        "sqlls",
        "yaml-language-server",
      },
      ui = {
        border = "rounded",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = function()
      -- force border on ui lsp
      require("lspconfig.ui.windows").default_options.border = "rounded"
    end,
  },
}
