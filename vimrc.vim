" This is my old vim config that I cannot be bothered to convert to lua
syntax off " Syntax off for LSP syntax highlights
set nowrap                                                                                                              
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
set colorcolumn=120
set tabstop=4
set shiftwidth=4
set expandtab
set splitright
" These is to start javacomplete2 use <C-x><C-o> to start the complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
