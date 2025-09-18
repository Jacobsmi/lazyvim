vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.js", "*.jsx", "*.ts", "*.tsx", "*.json", "*.jsonc" },
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascriptreact", "typescriptreact" },
  callback = function()
    -- Use TreeSitter for indentation
    vim.bo.indentexpr = "nvim_treesitter#indent()"

    -- Indentation settings
    vim.bo.shiftwidth = 2
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.expandtab = true
    vim.bo.autoindent = true
    vim.bo.smartindent = false -- Disable to prevent conflicts
    vim.bo.cindent = false
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascriptreact", "typescriptreact" },
  callback = function()
    -- Set TreeSitter as the indentexpr
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

    -- Override == to actually apply the calculated indentation
    vim.keymap.set("n", "==", function()
      local line_num = vim.api.nvim_win_get_cursor(0)[1]
      local calculated_indent = require("nvim-treesitter.indent").get_indent(line_num)

      if calculated_indent and calculated_indent >= 0 then
        local current_line = vim.api.nvim_get_current_line()
        local content = current_line:match("^%s*(.*)") or "" -- Remove existing indentation
        local indent_str = string.rep(" ", calculated_indent)
        vim.api.nvim_set_current_line(indent_str .. content)
      end
    end, { buffer = true })

    -- Also fix the arrow key issue by applying indentation when landing on blank lines
    vim.keymap.set("i", "<Up>", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, false, true), "n", false)

      vim.defer_fn(function()
        local line_num = vim.api.nvim_win_get_cursor(0)[1]
        local current_line = vim.api.nvim_get_current_line()

        if current_line:match("^%s*$") then -- If line is blank
          local calculated_indent = require("nvim-treesitter.indent").get_indent(line_num)
          if calculated_indent and calculated_indent > 0 then
            local indent_str = string.rep(" ", calculated_indent)
            vim.api.nvim_set_current_line(indent_str)
            vim.api.nvim_win_set_cursor(0, { line_num, calculated_indent })
          end
        end
      end, 0)

      return ""
    end, { expr = true, buffer = true })
  end,
})
