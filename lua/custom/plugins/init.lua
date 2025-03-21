-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {

  -- Custom Keymaps
  vim.keymap.set('i', 'jk', '<ESC>'),

  -- Moving lines
  vim.keymap.set('n', '<A-j>', ':m .+1<CR>=='),
  vim.keymap.set('n', '<A-k>', ':m .-2<CR>=='),
  vim.keymap.set('i', '<A-j>', '<Esc>:m .+1<CR>=='),
  vim.keymap.set('i', '<A-k>', '<Esc>:m .-2<CR>=='),
  vim.keymap.set('v', '<A-j>', ":m '>+1<CR>gv=gv"),
  vim.keymap.set('v', '<A-k>', ":m '<-2<CR>gv=gv"),

  -- Tab visual text
  vim.keymap.set('v', '<Tab>', '>gv'),
  vim.keymap.set('v', '<S-Tab>', '<gv'),
}
