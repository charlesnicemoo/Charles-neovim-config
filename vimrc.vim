" This is my old vim config that I cannot be bothered to convert to lua. 
" It also has the benefit of being more portable to normal vim.
function! GitDetectBranchAndSetBufferVar()
  let b:git_branch = ''
  if &buftype == 'terminal'
    return
  endif
  let l:current_dir = getcwd()
  let l:buffer_path = expand('%:p')
  let l:file_dir = expand('%:p:h')
  if l:buffer_path == '' || l:buffer_path =~# 'help\%(.\{-}\)\?\.txt$' || l:file_dir == ''
    return
  endif
  exec 'cd ' . fnameescape(l:file_dir)
  let l:branch = system('git rev-parse --abbrev-ref HEAD 2>/dev/null')
  exec 'cd ' . fnameescape(l:current_dir)
  let l:branch = substitute(l:branch, '\n$', '', '')
  if v:shell_error == 0 && l:branch != 'HEAD' && l:branch != ''
    let b:git_branch = ' ' . l:branch
  endif
endfunction
function! StatuslineGitBranch()
  return get(b:, 'git_branch', '')
endfunction
augroup GitBranchStatusline
  autocmd!
  autocmd BufReadPost,BufEnter,FocusGained,ShellCmdPost * call GitDetectBranchAndSetBufferVar()
augroup END
augroup numbertoggle 
  autocmd! 
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif 
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif 
  autocmd TermOpen * setlocal nonumber norelativenumber
augroup END
augroup MarkdownWrapAndBreak
  autocmd!
  autocmd FileType markdown,text,tex setlocal wrap linebreak spell
augroup END
" Below needs reworking but I now think it now works as intended
autocmd FileType netrw setlocal nospell | setlocal relativenumber 
let mapleader = " "
syntax off " Syntax off to prevent conflict with LSP syntax highlights
set guicursor=
set nowrap
set scrolloff=5
set number
set laststatus=2
set statusline+=%F%{&modified?'[+]':''}%{StatuslineGitBranch()}%=%-14.(%l,%c%V%)
set colorcolumn=120
set tabstop=2
set shiftwidth=2
set expandtab
let g:netrw_liststyle=3
" use Lexplore (Le/Lex) to toggle left explorer
set splitright
set completeopt-=preview
set path+=**
" Set grep default options case insensitive, ignore binary and node_modules files
set grepprg=grep\ -nriI\ --exclude-dir={\"node_modules\",\"build\",\"target\",\"coverage\",\".git\",\".turbo\",\".next\"}
cabbrev gr grep
cabbrev gp grep
cabbrev ge grep
cabbrev rg grep
cabbrev gep grep
cabbrev ger grep
cabbrev gre grep
cabbrev erp grep
cabbrev rep grep
cabbrev gerp grep
cabbrev gpre grep
cabbrev perg grep
cabbrev rpeg grep
cabbrev regp grep
cabbrev regr grep
" Note that since nvim 0.11 [q and and ]q move you though copen quickfix list
" Also [l ]l work similarly for lopen location list
" nnoremap <leader>j :cnext<CR>zz
" nnoremap <leader>k :cprev<CR>zz
nnoremap <leader>c :copen<CR>
nnoremap <leader>v :cnewer<CR>
nnoremap <leader>x :colder<CR>
nnoremap <leader>n :bnext<CR>
nnoremap <leader>b :bprevious<CR>
nnoremap n nzz
nnoremap N Nzz
nnoremap gd gdzz
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz
inoremap <CR> <CR><C-o>zH<C-o>zH
function! FF(search_term)
  let l:filelist = split(system('find . -type d \( -name "node_modules" -o -name ".git" -o -name ".turbo" -o -name ".next" \) -prune -o -type f -iname \*'.shellescape(a:search_term).'\* -print 2>/dev/null'), "\n")
  let l:qflist = []
  for l:file in l:filelist
    if !empty(l:file)
      call add(l:qflist, {'filename': fnamemodify(l:file, ':p')})
    endif
  endfor
  call setqflist([] , ' ', {'title': 'FF ' . a:search_term, 'items': l:qflist})
  copen
  cfirst
endfunction
command! -nargs=1 -complete=file FF call FF(<f-args>)
