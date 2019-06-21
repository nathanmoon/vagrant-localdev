" BEGIN VUNDLE STUFF
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" status line
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" directory tree
Plugin 'scrooloose/nerdtree'
Plugin 'ctrlpvim/ctrlp.vim'

" git integration
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" linter
Plugin 'w0rp/ale'

" Python
Plugin 'hdima/python-syntax'

" shows whitespace
Plugin 'ntpeters/vim-better-whitespace'

" Javascript
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
" Plugin 'posva/vim-vue'
Plugin 'mitermayer/vim-prettier'

" LESS syntax highlighting
Plugin 'groenewege/vim-less'

" JSON
Plugin 'elzr/vim-json'

" Typescript
Plugin 'leafgarland/typescript-vim'
" Plugin 'Shougo/vimproc.vim' " only needed for neovim (??)
Plugin 'Quramy/tsuquyomi'


" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" END VUNDLE STUFF

" w0rp/ale config
" This would be if you wanted global eslint config for some reason
" let g:ale_javascript_eslint_options = "--no-eslintrc --config ~/.eslintrc"
" let g:ale_javascript_eslint_use_global = 1

" configure so :ALEFix will try and fix your JS code with ESLint.
let g:ale_fixers = {
\   'javascript': ['prettier'],
\   'typescript': ['tsserver'],
\}
" fix files automatically on save.
let g:ale_fix_on_save = 1

" nerdtree config
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeWinSize = 50
let NERDTreeShowHidden = 1

" testing: remove trailing whitespace
" autocmd FileType javascript autocmd BufWritePre <buffer> %s/\s\+$//e

" prettier config
let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat = 0
let g:prettier#quickfix_enabled = 0
let g:prettier#config#single_quote = 'true'
let g:prettier#config#trailing_comma = 'es5'
let g:prettier#config#bracket_spacing = 'true'

" prettier is off by default but can be turned on by running
" :call TogglePrettier()
" when turned on, it will reformat on save
let g:PrettierToggle = 0
" augroup PrettierStuff
"     autocmd!
"     autocmd BufWritePre *.js,*.css,*.scss,*.less PrettierAsync
" augroup END

function! TogglePrettier()
    " Switch the toggle variable
    let g:PrettierToggle = !get(g:, 'PrettierToggle', 1)

    " Reset group
    augroup PrettierStuff
        autocmd!
    augroup END

    " Enable if toggled on
    if g:PrettierToggle
        augroup PrettierStuff
            autocmd! BufWritePre *.js,*.css,*.scss,*.less PrettierAsync
        augroup END
    endif
endfunction

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|\.local|([^\/]+\/)*dist|([^\/]+\/)*node_modules)$',
  \ 'file': '\v\.(exe|so|dll|un~|swp)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }

" airline
" show buffers
let g:airline#extensions#tabline#enabled = 1
" show just filename
let g:airline#extensions#tabline#fnamemod = ':t'
" linter
let g:airline#extensions#ale#enabled = 1
" NOTE: install powerline fonts on the host, and use one in settings in iterm
let g:airline_powerline_fonts = 1
let g:airline_theme='mydark'
" something to get airline theme to show up at the first:
set laststatus=2


" json config
let g:vim_json_syntax_conceal = 0

set background=dark
colorscheme koehler

set hlsearch

syntax on

" fiddle with colors
highlight SpellBad ctermbg=52

" heavy-handed writes, so that file watchers work better
set backupcopy=yes

" Auto indent and doing 2 spaces for tabs
set expandtab
set ts=2
set sw=2
set smarttab
set autoindent
set autoread
set nowrap

" allow backspace to work like expected
set backspace=indent,eol,start

" incremental search
set incsearch
" Show line numbers
set number
" Undo across runs
set undofile
" all lower searches are case insensitive, mixed case is case sensitive
set ignorecase
set smartcase
set cursorline
" Toggle paste mode (auto-indent)
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

" custom key mappings

" nnoremap <C-J> m`o<Esc>``
" nnoremap <C-K> m`O<Esc>``

" Move between splits
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" Move between buffers
nnoremap <C-M> :bnext<CR>
nnoremap <C-N> :bprevious<CR>

" Alternate Escape
inoremap ;l <Esc>
vnoremap ;l <Esc>
cnoremap ;l <Esc>

" file type specific

au BufNewFile,BufRead *.es6 set filetype=javascript

autocmd FileType python setlocal shiftwidth=4 tabstop=4
autocmd FileType html setlocal shiftwidth=2 tabstop=2
autocmd FileType htmldjango setlocal shiftwidth=2 tabstop=2
autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType coffeescript setlocal shiftwidth=2 tabstop=2
autocmd FileType css setlocal shiftwidth=2 tabstop=2
autocmd FileType scss setlocal shiftwidth=2 tabstop=2
autocmd FileType typescript setlocal shiftwidth=2 tabstop=2
" autocmd FileType vue setlocal shiftwidth=2 tabstop=2

" WatchForChanges function
"
" This is used by the WatchForChanges* commands, but it can also be
" useful to call this from scripts. For example, if your script executes a
" long-running process, you can have your script run that long-running process
" in the background so that you can continue editing other files, redirects its
" output to a file, and open the file in another buffer that keeps reloading itself
" as more output from the long-running command becomes available.
"
" Arguments:
" * bufname: The name of the buffer/file to watch for changes.
"     Use '*' to watch all files.
" * options (optional): A Dict object with any of the following keys:
"   * autoread: If set to 1, causes autoread option to be turned on for the buffer in
"     addition to setting up the autocommands.
"   * toggle: If set to 1, causes this behavior to toggle between on and off.
"     Mostly useful for mappings and commands. In scripts, you probably want to
"     explicitly enable or disable it.
"   * disable: If set to 1, turns off this behavior (removes the autocommand group).
"   * while_in_this_buffer_only: If set to 0 (default), the events will be triggered no matter which
"     buffer you are editing. (Only the specified buffer will be checked for changes,
"     though, still.) If set to 1, the events will only be triggered while
"     editing the specified buffer.
"   * more_events: If set to 1 (the default), creates autocommands for the events
"     listed above. Set to 0 to not create autocommands for CursorMoved, CursorMovedI,
"     (Presumably, having too much going on for those events could slow things down,
"     since they are triggered so frequently...)
function! WatchForChanges(bufname, ...)
  " Figure out which options are in effect
  if a:bufname == '*'
    let id = 'WatchForChanges'.'AnyBuffer'
    " If you try to do checktime *, you'll get E93: More than one match for * is given
    let bufspec = ''
  else
    if bufnr(a:bufname) == -1
      echoerr "Buffer " . a:bufname . " doesn't exist"
      return
    end
    let id = 'WatchForChanges'.bufnr(a:bufname)
    let bufspec = a:bufname
  end

  if len(a:000) == 0
    let options = {}
  else
    if type(a:1) == type({})
      let options = a:1
    else
      echoerr "Argument must be a Dict"
    end
  end
  let autoread    = has_key(options, 'autoread')    ? options['autoread']    : 0
  let toggle      = has_key(options, 'toggle')      ? options['toggle']      : 0
  let disable     = has_key(options, 'disable')     ? options['disable']     : 0
  let more_events = has_key(options, 'more_events') ? options['more_events'] : 1
  let while_in_this_buffer_only = has_key(options, 'while_in_this_buffer_only') ? options['while_in_this_buffer_only'] : 0

  if while_in_this_buffer_only
    let event_bufspec = a:bufname
  else
    let event_bufspec = '*'
  end

  let reg_saved = @"
  "let autoread_saved = &autoread
  let msg = "\n"

  " Check to see if the autocommand already exists
  redir @"
    silent! exec 'au '.id
  redir END
  let l:defined = (@" !~ 'E216: No such group or event:')

  " If not yet defined...
  if !l:defined
    if l:autoread
      let msg = msg . 'Autoread enabled - '
      if a:bufname == '*'
        set autoread
      else
        setlocal autoread
      end
    end
    silent! exec 'augroup '.id
      if a:bufname != '*'
        "exec "au BufDelete    ".a:bufname . " :silent! au! ".id . " | silent! augroup! ".id
        "exec "au BufDelete    ".a:bufname . " :echomsg 'Removing autocommands for ".id."' | au! ".id . " | augroup! ".id
        exec "au BufDelete    ".a:bufname . " execute 'au! ".id."' | execute 'augroup! ".id."'"
      end
        exec "au BufEnter     ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHold   ".event_bufspec . " :checktime ".bufspec
        exec "au CursorHoldI  ".event_bufspec . " :checktime ".bufspec

      " The following events might slow things down so we provide a way to disable them...
      " vim docs warn:
      "   Careful: Don't do anything that the user does
      "   not expect or that is slow.
      if more_events
        exec "au CursorMoved  ".event_bufspec . " :checktime ".bufspec
        exec "au CursorMovedI ".event_bufspec . " :checktime ".bufspec
      end
    augroup END
    let msg = msg . 'Now watching ' . bufspec . ' for external updates...'
  end

  " If they want to disable it, or it is defined and they want to toggle it,
  if l:disable || (l:toggle && l:defined)
    if l:autoread
      let msg = msg . 'Autoread disabled - '
      if a:bufname == '*'
        set noautoread
      else
        setlocal noautoread
      end
    end
    " Using an autogroup allows us to remove it easily with the following
    " command. If we do not use an autogroup, we cannot remove this
    " single :checktime command
    " augroup! checkforupdates
    silent! exec 'au! '.id
    silent! exec 'augroup! '.id
    let msg = msg . 'No longer watching ' . bufspec . ' for external updates.'
  elseif l:defined
    let msg = msg . 'Already watching ' . bufspec . ' for external updates'
  end

"  echo msg
  let @"=reg_saved
endfunction

let autoreadargs={'autoread':1}
execute WatchForChanges("*",autoreadargs)
