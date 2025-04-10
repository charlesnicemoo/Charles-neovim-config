local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
vim.cmd [[colorscheme vim]]
vim.api.nvim_del_user_command("EditQuery")
require('charles')

local function collect_diagnostics_in_dir()
  -- Get the current working directory
  local cwd = vim.fn.getcwd()
  -- Get all files in the current directory recursively
  local files = vim.fn.split(vim.fn.globpath(cwd, "**/*", true, true), "\n")
  -- Table to store diagnostics for the quickfix list
  local qflist = {}
  for _, file in ipairs(files) do
    -- Skip node_modules directories
    if not file:find("node_modules") then
      -- Only process regular files and skip binary files
      if vim.fn.filereadable(file) == 1 and vim.fn.getfsize(file) > 0 then
        local file_type = vim.fn.systemlist('file --mime-type -b ' .. vim.fn.shellescape(file))[1]
        -- Skip binary files based on mime type
        if not file_type:find("application/") then
          -- Open the file in a buffer silently
          vim.cmd('edit ' .. file)
          -- Get diagnostics for the buffer
          local bufnr = vim.fn.bufnr(file)
          local diagnostics = vim.diagnostic.get(bufnr)
          for _, diag in ipairs(diagnostics) do
            -- Format diagnostics for quickfix list
            table.insert(qflist, {
              bufnr = bufnr,
              lnum = diag.lnum + 1,  -- Quickfix list is 1-indexed
              col = diag.col + 1,
              text = diag.message,
              type = vim.diagnostic.severity[diag.severity],
            })
          end
        end
      end
    end
  end
  -- Set the quickfix list
  vim.fn.setqflist(qflist)
  -- Open the quickfix list window
  vim.cmd('copen')
end

vim.api.nvim_create_user_command('Diagnostics', collect_diagnostics_in_dir, {})
