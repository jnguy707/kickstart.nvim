vim.api.nvim_set_hl(0, 'QuickScopePrimary', { fg = '#ff5f5f', bold = true, underline = true })
vim.api.nvim_set_hl(0, 'QuickScopeSecondary', { fg = '#5f87ff', underline = true })
return {
  {
    'unblevable/quick-scope',
    init = function()
      -- Highlight on f/F/t/T
      vim.g.qs_highlight_on_keys = { 'f', 'F', 't', 'T' }
    end,
  },
}
