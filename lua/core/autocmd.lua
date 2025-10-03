vim.api.nvim_create_autocmd('BufWritePost', {
  pattern = { '*.tex', '*.sty' },
  callback = function()
    local makefile = vim.fn.findfile('Makefile', '.;')

    if makefile ~= '' then
      local output = vim.fn.system 'make build 2>&1'
      local exit_code = vim.v.shell_error

      if exit_code == 0 then
        vim.notify('✓ LaTeX build concluído', vim.log.levels.INFO)
      else
        vim.notify('✗ Erro no build:\n' .. output, vim.log.levels.ERROR)
      end
    end
  end,
})

local autosave_timer = nil

vim.api.nvim_create_autocmd({ 'TextChanged', 'TextChangedI' }, {
  pattern = '*.tex',
  callback = function()
    if autosave_timer then
      vim.fn.timer_stop(autosave_timer)
    end

    autosave_timer = vim.fn.timer_start(2000, function()
      if vim.bo.modified and not vim.bo.readonly then
        vim.cmd 'silent! write'
        vim.notify('File saved', vim.log.levels.INFO)
      end
    end)
  end,
})
