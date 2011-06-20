syntax on
filetype plugin indent on
colorscheme vividchalk
au BufNewFile,BufRead *.clj set ft=clojure

" use indents of 2 spaces, and have them copied down lines:
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent

runtime! autoload/pathogen.vim
if exists("g:loaded_pathogen")
  call pathogen#runtime_append_all_bundles()
end

autocmd FileType ruby runtime ruby_mappings.vim

" don't make it look like there are line breaks where there are none
set nowrap

let mapleader = "\\"

" * Window splits

" Open new horizontal split windows below current
set splitbelow

" Open new vertical split windows to the right
set splitright

" Use neocomplcache. 
let g:NeoComplCache_EnableAtStartup = 0 

" Use smartcase. 
let g:NeoComplCache_SmartCase = 1 

" Use camel case completion. 
let g:NeoComplCache_EnableCamelCaseCompletion = 1 

" Use underbar completion. 
let g:NeoComplCache_EnableUnderbarCompletion = 1 

" Set minimum syntax keyword length. 
let g:NeoComplCache_MinSyntaxLength = 3 

" Quick, jump out of insert mode while no one is looking
imap ii <Esc>

" <leader>f to startup an ack search
map <leader>f :LAck<Space>

" Add RebuildTagsFile function/command
function! s:RebuildTagsFile()
  !ctags --recurse=yes --exclude=coverage --exclude=files --exclude=public --exclude=log --exclude=tmp --exclude=vendor *
endfunction
command! -nargs=0 RebuildTagsFile call s:RebuildTagsFile()

map <silent> <LocalLeader>nt :NERDTreeToggle<CR>
map <silent> <LocalLeader>nr :NERDTree<CR>
map <silent> <LocalLeader>nh :nohls<CR>

function! Find(name)
  let l:_name = substitute(a:name, "\\s", "*", "g")
  let l:list=system("find . -iname '*".l:_name."*' -not -name \"*.class\" -and -not -name \"*.swp\" | perl -ne 'print \"$.\\t$_\"'")
  let l:num=strlen(substitute(l:list, "[^\n]", "", "g"))
  if l:num < 1
    echo "'".a:name."' not found"
    return
  endif
  if l:num != 1
    echo l:list
    let l:input=input("Which ? (<enter>=nothing)\n")
    if strlen(l:input)==0
      return
    endif
    if strlen(substitute(l:input, "[0-9]", "", "g"))>0
      echo "Not a number"
      return
    endif
    if l:input<1 || l:input>l:num
      echo "Out of range"
      return
    endif
    let l:line=matchstr("\n".l:list, "\n".l:input."\t[^\n]*")
  else
    let l:line=l:list
  endif
  let l:line=substitute(l:line, "^[^\t]*\t./", "", "")
  execute ":e ".l:line
endfunction
command! -nargs=1 Find :call Find("<args>")

map <Leader>f :Fi 

let g:syntastic_enable_signs=1


