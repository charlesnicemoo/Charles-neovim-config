# Charles-neovim-config
This is my vim/neovim(>=0.11.0) configuration.

External grep set as rg (ripgrep). If rg is not installed, I highly recommend it. If not possible internal vimgrep is likely sufficient for small-mid size codebases, as wildignore is set up quite nicely to ignore a bunch of useless stuff. For larger codebases vimgrep is perhaps a little slow, so I again recommend trying to install rg.

I have a find files command :FF which is more performant than the internal :find command. This is primarily for larger codebases. Unfortunately, this is not fully portable, as it is only for POSIX like systems, as it leverages the POSIX find command. I may implement some logic for DOS/NT systems later. I believe findstr works on NT, and on DOS there is another find tool, albeit not POSIX compliant.

I have made the lsp configuration in init.lua custom without any plugins leveraging lua-language-server, Clangd language server, JDTLS language server, and also typescript-language-server. These should all be executable from $PATH.

If using regular vim just copying vimrc.vim as ~/.vimrc is likely sufficient.

Base vim lsp is configured with vim-lsp plugin, found at:
https://github.com/prabirshrestha/vim-lsp

Create the directory structure (the 'vendor' name can be anything you like):
mkdir -p ~/.vim/pack/vendor/start

Move into that folder:
cd ~/.vim/pack/vendor/start

Clone vim-lsp:
git clone https://github.com/prabirshrestha/vim-lsp.git
