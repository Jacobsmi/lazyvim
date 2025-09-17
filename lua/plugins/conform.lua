return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = opts.formatters_by_ft or {}

      -- Function to choose formatter based on config files
      local function get_js_formatter()
        if vim.fn.filereadable("biome.json") == 1 then
          return { "biome-check" }
        elseif vim.fn.filereadable(".prettierrc") == 1 or vim.fn.filereadable("prettier.config.js") == 1 then
          return { "prettier" }
        else
          return { "biome-check" } -- default
        end
      end

      opts.formatters_by_ft.javascript = get_js_formatter
      opts.formatters_by_ft.typescript = get_js_formatter
      opts.formatters_by_ft.javascriptreact = get_js_formatter
      opts.formatters_by_ft.typescriptreact = get_js_formatter

      -- Your existing formatter definitions...
    end,
  },
}
