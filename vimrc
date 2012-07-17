" ******************** PATHOGEN ********************

" It is essential for pathogen to be called before enabling filetype
" detection, so we place its configuration at the top of the file.

" Load pathogen (http://github.com/tpope/vim-pathogen)
" call pathogen#runtime_append_all_bundles()
call pathogen#infect()

" Load help tags
call pathogen#helptags()



" ******************** GENERAL SETTINGS ********************

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Keep 50 lines of command line history
set history=50

" Show the cursor position all the time
set ruler

" Display incomplete commands
set showcmd

" Enable incremental searching
set incsearch

" Don't use Ex mode, use Q for formatting
map Q gq

" In many terminal emulators the mouse works just fine, thus enable it.
set mouse=a

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" ******************** AUTOCOMMANDS ********************

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " For all text files set 'textwidth' to 78 characters.
  au FileType text  setlocal textwidth=78

  " Ruby source code: set 2-space indentation
  au FileType ruby  setlocal ts=8 sw=2 sts=2 expandtab
  au FileType eruby setlocal ts=8 sw=2 sts=2 expandtab

  " Ruby source code: automatically add shabang to new files
  " au BufNewFile *.rb 0put ='#!/usr/bin/env ruby' | norm G

  " R source code: set 2-space indentation
  " au FileType r     setlocal ts=8 sw=2 sts=2 expandtab

  " HTML source code: set 2-space indentation
  au FileType html  setlocal ts=8 sw=2 sts=2 expandtab
  au FileType xhtml setlocal ts=8 sw=2 sts=2 expandtab

  " Bourne shell source code: set 4-space indentation
  au FileType sh    setlocal ts=8 sw=4 sts=4 expandtab
  au FileType sh    setlocal makeprg=bash\ '%'

  " Bourne shell source code: automatically add shabang to new files
  au BufNewFile *.sh 0put ='#!/bin/bash' | norm G

  " Syntax of these languages is fussy over tabs Vs spaces
  au FileType make  setlocal ts=8 sts=8 sw=8 noexpandtab
  au FileType yaml  setlocal ts=2 sts=2 sw=2 expandtab

  " Enable cursor line highlighting only in the current window
  au WinLeave * set nocursorline
  au WinEnter * set cursorline

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

else

  set autoindent	" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
  		\ | wincmd p | diffthis
endif

" ******************** EDITING ********************

" TODO: check whether we should disable this for old versions of Vim
" Highlight line where cursor is placed
set cursorline

" Use line numbers
set number

" Set minimum width of number field
set numberwidth=5

" Be more liberal with hidden buffers
set hidden

" Toggle paste mode with F9
set pastetoggle=<F9>

" Allow to override the following settings via modelines
let g:secure_modelines_allowed_items = [
            \ "syntax",      "syn",
            \ "textwidth",   "tw",
            \ "softtabstop", "sts",
            \ "tabstop",     "ts",
            \ "shiftwidth",  "sw",
            \ "expandtab",   "et",   "noexpandtab", "noet",
            \ "filetype",    "ft",
            \ "foldmethod",  "fdm",
            \ "readonly",    "ro",   "noreadonly", "noro",
            \ "rightleft",   "rl",   "norightleft", "norl"
            \ ]



" ******************** INVISIBLE CHARACTERS ********************

" This configuration was taken from vimcasts.org (episode 1)

" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Show invisible characters by default
set list


" ******************** WHITESPACE AND INDENTATION ********************

" This configuration is taken (in part) from vimcasts.org (episodes 4 and 5)

function! Preserve(command)
  " Preparation: save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Strip trailing spaces
" nmap _$ :call Preserve("%s/\\s\\+$//e")<CR>

" Re-indent the whole file
" nmap _= :call Preserve("normal gg=G")<CR>

" Remove blank lines
" nmap __ :%g/^$/d<CR>

" Smarter indentation functions
" map <A-Left>  <<
" nmap <A-Right> >>
" vmap <A-Left>  <gv
" vmap <A-Right> >gv

" Tab navigation shortcuts

map <F2> gt
map <F1> gT 
imap <F2> <ESC>gt<CR>
imap <F1> <ESC>gT<CR>

" ******************** Command-T fast file navigation*******
nnoremap <silent> <LocalLeader>t :CommandT<CR>
" Open a selected file in current tab by pressing Ctrl-t
let g:CommandTAcceptSelectionMap = '<C-t>'
" Open a selected file in a new tab by pressing Enter
let g:CommandTAcceptSelectionTabMap = '<CR>'
let g:CSApprox_verbose_level=0

" ******************** MATCHIT ********************

" This configuration was taken from vimcasts.org
" (http://vimcasts.org/blog/2010/12/a-text-object-for-ruby-blocks/)

runtime macros/matchit.vim


" ******************** COLORS ********************

" Set colors for dark blackground
set background=dark

" Set color scheme (requires csapprox)
colorscheme ir_black
" For presentations:
" colorscheme ironman

" Tell CSApprox to use the Konsole palette
let g:CSApprox_konsole=1

" Show syntax highlighting groups for word under cursor
nmap <C-S-P> :call <SID>SynStack()<CR>
function! <SID>SynStack()
	if !exists("*synstack")
		return
	endif
	echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

set gfn=Monaco:h14

