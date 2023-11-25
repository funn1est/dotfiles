return {
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "prettierd")
    end,
  },
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.list_extend(opts.formatters_by_ft or {}, {
        javascript = { { "prettierd", "prettier" } },
        typescriptreact = { { "prettierd", "prettier" } },
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = {
        "css-lsp",
        "html-lsp",
        "json-lsp",
        "lua-language-server",
        "rust-analyzer",
        "shfmt",
        "stylua",
        "taplo",
        "typescript-language-server",
      }
    end,
  },
}
