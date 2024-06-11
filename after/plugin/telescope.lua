local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
require("telescope").setup({
  defaults = {
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden", 
    },
    mapppings = {
        i = {
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            },
            n = {
                ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
            }
    }
    -- ^ Mappings allows sending grep output to copen qflist, so that you can edit buffers and keep grep output visible
  }
})
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', builtin.find_files, {})
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})
-- requires ripgrep
vim.keymap.set('n', '<leader>gr', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})
