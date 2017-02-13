let mapleader = ","

set history=50
set incsearch           " do incremental searching
set laststatus=2        " Always display the status line
set nobackup
set nocompatible        " Use Vim settings, rather then Vi settings
set nomodeline          " Do not parse vim modelines
set modelines=0
set noswapfile
set nowritebackup
set nowrap
set nomore
set ruler               " show the cursor position all the time
set showcmd             " display incomplete commands
set clipboard+=unnamed  " pasting
set ttimeoutlen=25
set noesckeys
set backspace=2
set undodir=$HOME/.vim/undo
set undolevels=1000
set undoreload=10000
set winwidth=80
set relativenumber      " Use relative line numbers
set number              " Use absolute numbers for current line
set tabstop=2           " Softtabs, 2 spaces
set shiftwidth=2
set shiftround          " Indent to the next shiftwidth column
set expandtab
set foldmethod=indent
set foldlevelstart=20

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" Load up vim bundles
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" Display extra whitespace
set list listchars=tab:»·,trail:·

" Setup The Silver Searcher
if executable("ag")
  set grepprg=ag\ --nogroup\ --nocolor
  let g:fuzzy_ignore = "*.png;*.PNG;*.JPG;*.jpg;*.GIF;*.gif;log/*;vendor/**;coverage/**;tmp/**;rdoc/**"
endif

" Color scheme
syntax enable
set background=dark
let base16colorspace=256
try
  colorscheme base16-default
catch
endtry
hi NonText      guibg=#060606
hi Folded       guibg=#0A0A0A guifg=#9090D0
hi LineNr       term=bold ctermfg=DarkGrey guifg=DarkGrey
hi CursorLineNr term=bold ctermfg=White guifg=White

" Indent guides
let g:indent_guides_auto_colors = 0
let g:indent_guides_color_change_percent = 90
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  ctermbg=0
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=234
autocmd VimEnter * :call indent_guides#enable()

" Prettier formatting
autocmd FileType javascript set formatprg=prettier\ --single-quote\ --stdin
autocmd BufWritePre *.js exe "normal! gggqG\<C-o>\<C-o>"
autocmd BufWritePre *.jsx exe "normal! gggqG\<C-o>\<C-o>"

" Numbers
set number
set numberwidth=5

" Buffers
map <Leader>b :buffers<CR>:buffer<space>
map <Leader>gs :Gstatus<CR>
map <Leader>gac :Gcommit -m -a ""<LEFT>
map <Leader>gc :Gcommit -m ""<LEFT>
map <Leader>m :Rmodel
map <Leader>sm :RSmodel
map <Leader>su :RSunittest
map <Leader>sv :RSview
map <Leader>vc :RVcontroller<cr>
map <Leader>vf :RVfunctional<cr>
map <Leader>vm :RVmodel<cr>
map <Leader>vu :RVunittest<CR>
map <Leader>vv :RVview<cr>
map <Leader>vi :vsp ~/.vimrc<CR>
map <Leader>vb :vsp ~/.vimrc.bundles<CR>

" Helpers to line up chunks of code
map <C-\> :Tab /=<cr>
map <Leader>\ :Tab /=<cr>
map <Leader>; :Tab /:/l1r0<cr>

" File Operations
map <C-s> <esc>:w<CR>
imap <C-s> <esc>:w<CR>

" Tab completion options
set wildmode=list:longest,list:full
set complete=.,w,t

" Tags
let g:Tlist_Ctags_Cmd="ctags --exclude='*.js'"
nmap <Leader>g :exec("tag ".expand("<cword>"))<CR>
nmap <Leader>G :vs <CR>:exec("tag ".expand("<cword>"))<CR>

" Tagbar toggling
nmap <F9> :TagbarToggle<CR>

" Remove trailing whitespace
autocmd BufWritePre * :DeleteTrailingWhitespace

" Cucumber navigation commands
autocmd User Rails Rnavcommand step features/step_definitions -glob=**/* -suffix=_steps.rb
autocmd User Rails Rnavcommand config config -glob=**/* -suffix=.rb -default=routes

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e

" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Get off my lawn
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> :echoe "Use k"<CR>
nnoremap <Down> :echoe "Use j"<CR>

" turbux settings
let g:turbux_command_rspec = 'bin/rspec'

" configure custom vimux commands for javascript tests
ruby << EOF
class Jest
  def test_command
    "jest"
  end

  def current_file
    VIM::Buffer.current.name
  end

  def current_line_number
    VIM::Buffer.current.line_number
  end

  def send_to_vimux(test_command)
    Vim.command("call VimuxRunCommand(\"#{test_command}\")")
  end

  def run_spec
    send_to_vimux("#{test_command} #{current_file}")
  end
end
EOF

function! RunJestTests()
  ruby Jest.new.run_spec
endfunction

" j for javascript, r for react
autocmd filetype javascript map <Leader>j :call RunJestTests()<CR>
autocmd filetype javascript map <Leader>r :call RunJestTests()<CR>

" Treat <li> and <p> tags like the block tags they are
let g:html_indent_tags = 'li\|p'

" Improve syntax highlighting
au BufRead,BufNewFile Gemfile set filetype=ruby
au BufRead,BufNewFile *.md set filetype=markdown
au BufRead,BufNewFile *.md setlocal spell
au BufRead,BufNewFile *.md setlocal textwidth=80
au BufRead,BufNewFile *.e[ex] set filetype=elixir

highlight OverLength ctermbg=235 ctermfg=250 guibg=#592929
au BufRead,BufNewFile *.md match OverLength /\%81v.\+/

" Open new split panes to right and bottom
set splitbelow
set splitright

" Folding
nnoremap <Space> za

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Easier window rezising
nnoremap <silent> <Leader>= :exe ":vertical resize " . (winwidth(0) * 4/3)<CR>
nnoremap <silent> <Leader>+ :exe "resize " . (winheight(0) * 6/5)<CR>
nnoremap <silent> <Leader>- :exe ":vertical resize " . (winwidth(0) * 3/4)<CR>
nnoremap <silent> <Leader>_ :exe "resize " . (winheight(0) * 5/6)<CR>

" Mappings for easier window swapping
noremap <silent> <leader>h :call SwapWindowLeft()<CR>
noremap <silent> <leader>l :call SwapWindowRight()<CR>

" ,cf - copy to clipboard the current
" file path relative to the project
nnoremap <leader>cf :let @*=expand("%")<CR>

" configure lightline.vim
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \  'right': [ [ 'lineinfo' ], [ 'percent' ], [ 'filetype' ] ]
      \ },
      \ 'component': {
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ }
    \ }

" configure syntastic syntax checking to check on open and save
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_ruby_exec='ruby'
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" configure nerdtree
map <F2> :NERDTreeToggle<CR>
autocmd FileType nerdtree cnoreabbrev <buffer> bd :NERDTreeToggle

" configure ctrlp
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = "_site/*"
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
set wildignore+=*/tmp/*,*/log/*,*/bin/*,.DS_Store,*/node_modules/*

" configure snipmate
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=javascript-jquery

" Tell vim about key mappings while using tmux
if &term =~ '^screen' && exists('$TMUX')
  " tmux will send xterm-style keys when xterm-keys is on
  execute "set <xUp>=\e[1;*A"
  execute "set <xDown>=\e[1;*B"
  execute "set <xRight>=\e[1;*C"
  execute "set <xLeft>=\e[1;*D"
endif

" Local config
if filereadable("~/.vimrc.local")
  source ~/.vimrc.local
endif

" Load quicklist files into the args list
command! -nargs=0 -bar Qargs execute 'args' QuickfixFilenames()
function! QuickfixFilenames()
  " Building a hash ensures we get each buffer only once
  let buffer_numbers = {}
  for quickfix_item in getqflist()
    let buffer_numbers[quickfix_item['bufnr']] = bufname(quickfix_item['bufnr'])
  endfor
  return join(map(values(buffer_numbers), 'fnameescape(v:val)'))
endfunction
