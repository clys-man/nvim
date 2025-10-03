-- ===================================================================
-- LEADER KEY CONFIGURATION
-- ===================================================================
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Disable spacebar's default behavior in Normal and Visual modes
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Default options for keymaps
local opts = { noremap = true, silent = true }

-- ===================================================================
-- BASIC EDITING & NAVIGATION
-- ===================================================================

-- File operations
vim.keymap.set('n', '<leader>w', '<cmd>w<CR>', opts)            -- save file
vim.keymap.set('n', '<leader>sn', '<cmd>noautocmd w<CR>', opts) -- save without auto-formatting
vim.keymap.set('n', '<C-q>', '<cmd>q<CR>', opts)                -- quit file

-- Better deletion (don't copy to register)
vim.keymap.set('n', 'x', '"_x', opts)
vim.keymap.set('v', 'p', '"_dP', opts) -- keep yanked when pasting

-- Enhanced scrolling and centering
vim.keymap.set('n', '<C-d>', '<C-d>zz', opts) -- scroll down and center
vim.keymap.set('n', '<C-u>', '<C-u>zz', opts) -- scroll up and center
vim.keymap.set('n', 'n', 'nzzzv', opts)       -- find next and center
vim.keymap.set('n', 'N', 'Nzzzv', opts)       -- find previous and center

-- Improved indentation (stay in indent mode)
vim.keymap.set('v', '<', '<gv', opts)
vim.keymap.set('v', '>', '>gv', opts)

-- Toggle line wrapping
vim.keymap.set('n', '<leader>lw', '<cmd>set wrap!<CR>', opts)

-- ===================================================================
-- BUFFER MANAGEMENT
-- ===================================================================

vim.keymap.set('n', '<S-l>', ':bnext<CR>', opts)         -- next buffer
vim.keymap.set('n', '<S-h>', ':bprevious<CR>', opts)     -- previous buffer
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', opts)   -- delete buffer
vim.keymap.set('n', '<leader>bD', ':bdelete!<CR>', opts)  -- force delete buffer
vim.keymap.set('n', '<leader>bn', '<cmd>enew<CR>', opts)  -- new buffer

-- ===================================================================
-- WINDOW & SPLIT MANAGEMENT
-- ===================================================================

-- Create splits
vim.keymap.set('n', '<leader>sv', '<C-w>v', opts)     -- split vertically
vim.keymap.set('n', '<leader>sh', '<C-w>s', opts)     -- split horizontally
vim.keymap.set('n', '<leader>se', '<C-w>=', opts)     -- equalize splits
vim.keymap.set('n', '<leader>sx', ':close<CR>', opts) -- close current split

-- Navigate between splits
vim.keymap.set('n', '<C-h>', ':wincmd h<CR>', opts) -- move to left split
vim.keymap.set('n', '<C-j>', ':wincmd j<CR>', opts) -- move to bottom split
vim.keymap.set('n', '<C-k>', ':wincmd k<CR>', opts) -- move to top split
vim.keymap.set('n', '<C-l>', ':wincmd l<CR>', opts) -- move to right split

-- Resize splits with arrow keys
vim.keymap.set('n', '<Up>', ':resize -2<CR>', opts)           -- decrease height
vim.keymap.set('n', '<Down>', ':resize +2<CR>', opts)         -- increase height
vim.keymap.set('n', '<Left>', ':vertical resize -2<CR>', opts) -- decrease width
vim.keymap.set('n', '<Right>', ':vertical resize +2<CR>', opts) -- increase width

-- ===================================================================
-- TAB MANAGEMENT
-- ===================================================================

vim.keymap.set('n', '<leader>to', ':tabnew<CR>', opts)   -- open new tab
vim.keymap.set('n', '<leader>tx', ':tabclose<CR>', opts) -- close current tab
vim.keymap.set('n', '<leader>tn', ':tabn<CR>', opts)     -- go to next tab
vim.keymap.set('n', '<leader>tp', ':tabp<CR>', opts)     -- go to previous tab

-- ===================================================================
-- DIAGNOSTICS & LSP
-- ===================================================================

vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic error messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic quickfix list' })

-- ===================================================================
-- AI ASSISTANCE (COPILOT)
-- ===================================================================

vim.keymap.set('n', '<leader>cp', ':Copilot panel<CR>', opts) -- open copilot panel

-- ===================================================================
-- SPECIALIZED TOOLS
-- ===================================================================

-- Manim rendering functions
local function get_class_name()
  local node = vim.treesitter.get_node()
  while node do
    if node:type() == 'class_definition' then
      local name_node = node:field('name')[1]
      if name_node then
        local class_name = vim.treesitter.get_node_text(name_node, 0)
        return class_name
      end
    end
    node = node:parent()
  end
  return nil
end

local function render_scene()
  local class_name = get_class_name()
  if not class_name then
    print 'No class name found at cursor!'
    return
  end

  local file_path = vim.fn.expand '%:p'
  local cmd = string.format('manim -pqh "%s" "%s"', file_path, class_name)
  vim.cmd('!' .. cmd)
end

-- Manim keymaps
vim.keymap.set('n', '<leader>mm', render_scene, { desc = 'Render Manim Scene' })