return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local configs = require 'nvim-treesitter.configs'

      configs.setup {
        ensure_installed = {
          'bend',
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

      local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
      parser_config.bend = {
        install_info = {
          url = 'https://github.com/HigherOrderCO/tree-sitter-bend',
          files = { 'src/parser.c', 'src/scanner.c' },
          branch = 'main',
        },
      }

      vim.filetype.add {
        extension = {
          bend = 'bend',
        },
      }

      vim.treesitter.language.register('bend', { 'bend' })
    end,
  },
}
