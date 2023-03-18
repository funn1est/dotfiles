return {
  {
    "folke/which-key.nvim",
    opts = function(_, opts)
      opts.triggers_blacklist = {
        n = { "c", "y", "v", "d" },
      }
    end,
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      {
        "<C-x>",
        function()
          require("mini.bufremove").delete(0, false)
        end,
        desc = "Delete Buffer",
      },
    },
  },
  {
    "mbbill/undotree",
    event = "VeryLazy",
    keys = {
      { "<leader>fu", "<cmd>UndotreeToggle<cr>", desc = "Toggle Undotree" },
    },
  },
}
