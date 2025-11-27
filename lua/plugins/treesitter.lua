return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require 'nvim-treesitter.configs'

      configs.setup {
        ensure_installed = {
          'lua',
          'python',
          'javascript',
          'typescript',
          'vimdoc',
          'vim',
          'regex',
          'sql',
          'dockerfile',
          'toml',
          'json',
          'java',
          'go',
          'gitignore',
          'yaml',
          'make',
          'cmake',
          'markdown',
          'markdown_inline',
          'bash',
          'tsx',
          'css',
          'html',
          'php',
          'rust',
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
}
