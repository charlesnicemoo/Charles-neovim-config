" This is my old vim config that I cannot be bothered to convert to lua. 
" It also has the benefit of being more portable to normal vim.
let mapleader = " "
syntax off " Syntax off for LSP syntax highlights
set guicursor=
set nowrap
set scrolloff=5
" set spell
inoremap <CR> <CR><C-o>zH<C-o>zH
set number
set completeopt-=preview
" set wrap " line wrap is on when uncommented to undo you can use set nowrap
" set linebreak " when line wrap is set use this to prevent words from being split up
" set spell " sets spellcheck when uncommented
augroup numbertoggle 
    autocmd! 
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif 
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif 
augroup END
augroup TerminalLineNumbers
    autocmd!
    autocmd TermOpen * setlocal nonumber norelativenumber
augroup END
set laststatus=2
set statusline+=%F
set statusline+=%{&modified?'[+]':''}
set statusline+=%=%-14.(%l,%c%V%)
set colorcolumn=120
set tabstop=4
set shiftwidth=4
set expandtab
set splitright
let g:netrw_liststyle=3
autocmd FileType netrw setlocal relativenumber
" These is to start javacomplete2 use <C-x><C-o> to start the complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
" Set grep default options case insensitive, ignore binary and node_modules files
set grepprg=grep\ -nriI\ --exclude-dir={\"node_modules\",\"build\",\"target\"}
nnoremap <leader>n :cnext<CR>zz
nnoremap <leader>b :cprev<CR>zz
nnoremap <leader>c :copen<CR>
nnoremap <leader>x :cclose<CR>
nnoremap n nzz
