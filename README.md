# Charles-neovim-config
This is my neovim configuration (requires 0.11), I have made the configuration custom without any plugins. Requires lua-language-server, Clangd language server, JDTLS language server, and also typescript-language-server.

On Mac you may need run into some confusion with python versions. This can also be fixed using pyenv but I like this more
python3 -m pip install --user --upgrade pynvim
 - Note: I can't remember why I had this, it may be for an old plugin that I am no longer using. So It may not be required.

Please see 0.11 version notes for neovim since I am now using these default keys:

https://neovim.io/doc/user/news-0.11.html

It states some:
Mappings:
grn in Normal mode maps to vim.lsp.buf.rename()
grr in Normal mode maps to vim.lsp.buf.references()
gri in Normal mode maps to vim.lsp.buf.implementation()
gO in Normal mode maps to vim.lsp.buf.document_symbol()
gra in Normal and Visual mode maps to vim.lsp.buf.code_action()
CTRL-S in Insert and Select mode maps to vim.lsp.buf.signature_help()
Mouse popup-menu includes an "Open in web browser" item when you right-click on a URL.
Mouse popup-menu includes a "Go to definition" item when LSP is active in the buffer.
Mouse popup-menu includes "Show Diagnostics", "Show All Diagnostics" and "Configure Diagnostics" items when there are diagnostics in the buffer.
]d-default and [d-default accept a count.
[D-default and ]D-default jump to the first and last diagnostic in the current buffer, respectively.
Mappings inspired by Tim Pope's vim-unimpaired:
[q, ]q, [Q, ]Q, [CTRL-Q, ]CTRL-Q navigate through the quickfix list
[l, ]l, [L, ]L, [CTRL-L, ]CTRL-L navigate through the location-list
[t, ]t, [T, ]T, [CTRL-T, ]CTRL-T navigate through the tag-matchlist
[a, ]a, [A, ]A navigate through the argument-list
[b, ]b, [B, ]B navigate through the buffer-list
[<Space>, ]<Space> add an empty line above and below the cursor
[[ and ]] in Normal mode jump between shell prompts for shells which emit OSC 133 sequences ("shell integration" or "semantic prompts").
