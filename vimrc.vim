" This is my old vim config that I cannot be bothered to convert to lua. 
" It also has the benefet of being more portable to normal vim.
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
function! GetGitBranch()
  if &buftype == 'terminal'
    return ''
  endif
  let l:current_dir = getcwd() " Store current working directory
  let l:buffer_path = expand('%:p') " Get full path of current buffer
  let l:file_dir = expand('%:p:h') " Get directory of current buffer
  if l:buffer_path == '' || l:buffer_path =~# 'help\%(.\{-}\)\?\.txt$' || l:file_dir == ''
    return ''
  endif
  exec 'cd ' . fnameescape(l:file_dir)
  let l:branch = system('git rev-parse --abbrev-ref HEAD 2>/dev/null')
  exec 'cd ' . fnameescape(l:current_dir)
  let l:branch = substitute(l:branch, '\n$', '', '')
  if v:shell_error == 0 && l:branch != 'HEAD' && l:branch != ''
    return '  ' . l:branch
  else
    return ''
  endif
endfunction
set laststatus=2
set statusline+=%F%{&modified?'[+]':''}%{GetGitBranch()}%=%-14.(%l,%c%V%)
set colorcolumn=120
set tabstop=2
set shiftwidth=2
set expandtab
set splitright
let g:netrw_liststyle=3
autocmd FileType netrw setlocal relativenumber
" These is to start javacomplete2 use <C-x><C-o> to start the complete
autocmd FileType java setlocal omnifunc=javacomplete#Complete
" Set grep default options case insensitive, ignore binary and node_modules files
set grepprg=grep\ -nriI\ --exclude-dir={\"node_modules\",\"build\",\"target\",\"coverage\",\".git\"}
nnoremap <leader>j :cnext<CR>zz
nnoremap <leader>k :cprev<CR>zz
nnoremap <leader>c :copen<CR>
nnoremap <leader>v :cnewer<CR>
nnoremap <leader>x :colder<CR>
nnoremap n nzz
nnoremap N nzz
nnoremap gd gdzz
