return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- Ensure indent is enabled
    opts.indent = opts.indent or {}
    opts.indent.enable = true

    -- Make sure JSX/TSX files use TreeSitter indentation
    return opts
  end,
}
