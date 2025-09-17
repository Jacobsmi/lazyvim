vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.jsonc" },
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})
