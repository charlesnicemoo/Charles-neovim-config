local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
vim.cmd [[colorscheme vim]]
vim.api.nvim_del_user_command("EditQuery")
-- lua vim.cmd.edit(vim.lsp.get_log_path()) is a useful command to see your LSP debug log
vim.lsp.set_log_level("debug")
vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = {
    "lua"
  },
  on_init = function(client)
    if client.workspace_folders then
      local path = client.workspace_folders[1].name
      if
          path ~= vim.fn.stdpath("config")
          and (vim.uv.fs_stat(path .. "/.luarc.json") or vim.uv.fs_stat(path .. "/.luarc.jsonc"))
      then
        return
      end
    end
    client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua, {
      runtime = {
        version = "LuaJIT",
        path = {
          "lua/?.lua",
          "lua/?/init.lua",
        },
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME
        }
      }
    })
  end,
  settings = {
    Lua = {}
  }
})
vim.lsp.config("ts_ls", {
  cmd = { "typescript-language-server", "--stdio" },
  init_options = {
    plugins = {
      {
        name = "@vue/typescript-plugin",
        location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
        languages = { "javascript", "typescript", "vue" },
      },
    },
  },
  filetypes = {
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "vue",
  },
})
vim.lsp.config("clangd", {
  cmd = { "clangd", "--background-index", "--clang-tidy", "--log=verbose" },
  root_markers = { ".clangd", ".clang-tidy", ".clang-format", "compile_commands.json", "compile_flags.txt", "configure.ac", ".git" },
  filetypes = { "c", "cpp", "cuda" }
})
vim.lsp.config("jdtls", {
  cmd = { "jdtls", "-data", vim.fn.stdpath("cache") .. "/jdtls_workspaces/" .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") },
  root_markers = { ".git", "build.gradle", "build.gradle.kts", "build.xml", "pom.xml", "settings.gradle", "settings.gradle.kts" },
  filetypes = { "java"}
})
vim.lsp.enable("lua_ls")
vim.lsp.enable("ts_ls")
vim.lsp.enable("clangd")
vim.lsp.enable("jdtls")
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    -- remap gd here on the LSP attach, means default gd will be used when no lsp is attached
    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method("textDocument/completion") then
      client.server_capabilities.completionProvider.triggerCharacters = {
        ".",":"
      }
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})
vim.diagnostic.config({
  virtual_text = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = false,
    style = "minimal",
    border = "single",
    header = "",
    prefix = "",
  },
  signs = {
    enable = true,
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN]  = "W",
      [vim.diagnostic.severity.HINT]  = "H",
      [vim.diagnostic.severity.INFO]  = "I",
    },
  },
})
-- See https://neovim.io/doc/user/news-0.11.html for nice update on some new default keys 
vim.opt.signcolumn = "auto"
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
vim.keymap.set("n", "<leader>vl", vim.diagnostic.setloclist, { desc = "Set diagnostics to loclist" })
