return {
  "folke/tokyonight.nvim",
  lazy = true,
  opts = {
    style = "night", -- The theme comes in three styles, "storm", "moon", a darker variant "night" and "day"
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = "transparent", -- style for sidebars, see below
      floats = "transparent", -- style for floating windows
    },
  },
  config = function(_, opts)
    require("tokyonight").setup(opts)

    -- Additional manual transparency settings
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
  end,
}
