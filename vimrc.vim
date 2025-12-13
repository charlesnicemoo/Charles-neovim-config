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
let g:netrw_banner = 0
set splitright
set path+=**
set wildmenu
set wildignore+=*/node_modules/*,*/.git/*,*/dist/*,*/.next/*,*/.turbo/*,*/target/*,*/coverage/*,*.DS_Store
set grepprg=rg\ -g\ \'!node_modules'\ -g\ \'!.git\'\ -g\ \'!dist/\'\ -g\ \'!.next\'\ -g\ \'!.turbo/\'\ -g\ \'!target\'\ -g\ \'!coverage\'\ --vimgrep\ -uuu\ --no-binary\ --ignore-case
" If need to really search all stuff (POSIX compliant all dirs) use something like: 
" find . -type f -print | xargs grep -n "your_search_pattern"
cabbrev vimgr vimgrep
cabbrev vmgrp vimgrep
cabbrev vgrp vimgrep
cabbrev vmgr vimgrep
cabbrev vgr vimgrep
cabbrev vgp vimgrep
cabbrev vg vimgrep
cabbrev rg grep
cabbrev lrg lgrep
" Note that since nvim 0.11.0 [q and and ]q move you though copen quickfix list
" Also [l ]l work similarly for lopen location list
" Also [b ]b works similarly but for buffer list
" Also [d ]d works similarly but for diagnistics
nnoremap <leader>c :copen<CR>
nnoremap <leader>C :close<CR>
nnoremap <leader>x :colder<CR>
nnoremap <leader>X :cnewer<CR>
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
