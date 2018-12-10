" set confirm

"powerline-status vim statusline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup
set laststatus=2 " Always display the statusline in all windows
set showtabline=2 " Always display the tabline, even if there is only one tab
set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
set  rtp+=/usr/lib/python3.4/site-packages/powerline/bindings/vim/
set t_Co=256

" To avoid pasting commented on all lines when you have one commented line
" tab is equal to 4 and autoindent is mark with >
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" set  paste disable autoindent in vim
set pastetoggle=<F2>
" On pressing tab, insert 4 spaces
set expandtab

" set clipboard=unnamed
"if has('clipboard')
"    if has('unnamedplus')  " When possible use + register for copy-paste
"        set clipboard=unnamed,unnamedplus
"    else         " On mac and Windows, use * register for copy-paste
"        set clipboard=unnamed
"    endif
"endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" 001 Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'

" 002 Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" 002 Multiple Plug commands can be written in a single line using | separators
Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" 003 On-demand loading
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" 004 Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" 005 Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }

" 006 Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" 007 Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" 008 Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'

" 009 A small sensible Vim configuration and pair programming .vimrc file
Plug 'tpope/vim-sensible'

" 010 NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }

" 011 Multiple commands
Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }

" 012 Loaded when clojure file is opened
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" 013 Multiple file types
Plug 'kovisoft/paredit', { 'for': ['clojure', 'scheme'] }

" 014 On-demand loading on both conditions
Plug 'junegunn/vader.vim',  { 'on': 'Vader', 'for': 'vader' }

" 015 Code to execute when the plugin is lazily loaded on demand
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
autocmd! User goyo.vim echom 'Goyo is now loaded!'

" 016 Post-update hooks
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --cs-completer --go-completer --js-completer  --rust-completer' }

" 017 Custom git status in vim
"Plug 'airblade/vim-gitgutter'

" ID018 Comment functions so powerful—no comment necessary.
Plug 'scrooloose/nerdcommenter'

" ID019 Dev icons and ultra mega awesome fonts
Plug 'ryanoasis/vim-devicons'
"Plug 'ryanoasis/nerd-fonts', { 'do': './install.py' }

" ID020
Plug 'mhinz/vim-startify'

" ID021 vim-nerdtree-syntax-highlight
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" ID022 Git Stuff
Plug 'Xuyuanp/nerdtree-git-plugin'

" ID023 VimWorkspace tabs for everyone
" Plug 'bagrat/vim-workspace'

" ID024 Tags
"Plug 'universal-ctags/ctags'
"Plug 'ludovicchabant/vim-gutentags'

" The Silver Searcher

" ID025 Asynchronous Lint Engin
Plug 'w0rp/ale'

" ID+026 Code formater from google
Plug 'google/yapf'

" Code formater for python
"Plug 'ambv/black'

" View any blob, tree, commit, or tag in the repository with :Gedit (and :Gsplit, :Gvsplit, :Gtabedit,)
Plug 'tpope/vim-fugitive'

" Syntastic is a syntax checking plugin similar to YCM
"Plug 'scrooloose/syntastic'
Plug 'vim-syntastic/syntastic'

" The plugin provides mappings to easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-surround'

" Rainbow Parentheses
Plug 'junegunn/rainbow_parentheses.vim'
"Plug 'luochen1990/rainbow'
" Too old
"Plug 'kien/rainbow_parentheses.vim'

" Syntax for languages Themes
Plug 'sheerun/vim-polyglot'

" Schemes - themes for vim
Plug 'morhetz/gruvbox'
Plug 'nightsense/carbonized'
Plug 'nightsense/stellarized'
Plug 'HenryNewcomer/vim-theme-papaya'
Plug 'skielbasa/vim-material-monokai'
Plug 'aradunovic/perun.vim'
Plug 'joshdick/onedark.vim'
Plug 'yuttie/hydrangea-vim'
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'cocopon/iceberg.vim'
Plug 'dikiaap/minimalist'
Plug 'nightsense/snow'
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'dracula/vim'
Plug 'jacoborus/tender.vim'
Plug 'kcierzan/termina'
" Clean Code
Plug 'ntpeters/vim-better-whitespace'

Plug 'djoshea/vim-autoread'

" Vim Online Thesaurus - not working belog tried junun
"Plug 'beloglazov/vim-online-thesaurus'
"Plug 'junegunn/vim-online-thesaurus'

" Uncover usage problems in your writing
Plug 'reedes/vim-wordy'

" Syntax highlighting for Dockerfiles
Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}

" Vim enable an auto-close chars feature for you
" Plug 'Townk/vim-autoclose'

" Auto close parentheses and repeat by dot dot dot...
Plug  'cohama/lexima.vim'

" Auto close (X)HTML tags
Plug 'alvan/vim-closetag'

" Tabular
Plug 'godlygeek/tabular'

" You’ve got to love multiple selections.
"Plug 'terryma/vim-multiple-cursors'

" Emmet-vim
"Plug 'mattn/emmet-vim'

" Writing plugins
"Plug 'davidbeckingsale/writegood.vim'
"Plug 'dbmrq/vim-ditto'

" Initialize plugin system
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""
"   Config section for modules and Plugins  "
"   --------------------------------------  "
"""""""""""""""""""""""""""""""""""""""""""""

" Tmux config arrow fix and other scape character problems
" Put your terminal to match OS and tmux

" Show line numbers in vim
"set number

" Line at 80 Charaters
if (exists('+colorcolumn'))
    set colorcolumn=80
"    highlight ColorColumn ctermbg=111
endif

" Reload .vimrc config
autocmd! bufwritepost .vimrc source %

" Fix indentation - Map to ( backslash + F7 )
map <leader>F7 mzgg=G`z

" Tabs to Spaces auto
if has("autocmd")
au BufReadPost * retab
endif

" Customization for Rainbow Parentheses
" let g:rainbow#max_level = 16
" let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" List of colors that you do not want. ANSI code or #RRGGBB for Rainbow
" let g:rainbow#blacklist = [233, 234]

" Syntax hightlight mode, get you freak ON!!!
syntax on

" Set truecolor
set termguicolors
" Support for 256 Colours
set t_Co=256

" Set background
set background=dark    " Setting dark mode
"set background=light   " Setting light mode

" Schemes Colours - the italics has to be enabled febore Theme/Scheme

" let g:materialmonokai_italic=1
" colorscheme material-monokai
 let g:gruvbox_italic=1
 colorscheme gruvbox
" colorscheme carbonized-dark
" colorscheme papaya
" let g:papaya_gui_color='blue'
" colorscheme perun
" colorscheme onedark
" colorscheme hydrangea
" colorscheme deep-space             " it needs termguicolors
" let g:deepspace_italics=1
" colorscheme minimalist
" colorscheme snow
" Solarized cofig
" colorscheme solarized
" set background=dark
" colorscheme solarized
" Comment Unified color scheme (default: dark)
" colorscheme seoul256
" Light color scheme
" colo seoul256-light
" colorscheme onehalfdark
" let g:airline_theme='onehalfdark'
" let g:onehalfdark_italic=1
" color dracula
" Does not work let g:dracula_italic=1
" set lighline theme inside lightline config
" colorscheme tender
" let g:lightline = { 'colorscheme': 'tender' }
" Activate italics no matter what colortheme the 1st the other are para diversion
" highlight Comment cterm=italic
" highlight Keyword cterm=italic gui=italic
" highlight type cterm=italic gui=italic
" colorscheme termina

" Nerdtree
"autocmd vimenter * NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>

" yapf config for python
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>


" Setup gitgutter
"set updatetime=100
"let g:gitgutter_max_signs = 500     " default value
"let g:gitgutter_enabled = 1
"let g:gitgutter_signs = 1
"set g:gitgutter_highlight_lines = 1

" vim-better-whitespace config
let g:better_whitespace_ctermcolor='red'
let g:better_whitespace_operator='_s'
let g:strip_whitespace_on_save=1


" This is the default extra key bindings
"let g:fzf_action = {
"  \ 'ctrl-t': 'tab split',
"  \ 'ctrl-x': 'split',
"  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
if v:version >= 703
  set undodir=/tmp//,.
endif


" Open new line below and above current line
nnoremap <leader>o o<esc>
nnoremap <leader>O O<esc>

" Jump list (to newer position)
" nnoremap <C-p> <C-i>

" jk | Escaping!
inoremap jk <Esc>
xnoremap jk <Esc>
cnoremap jk <C-c>

" Save / save
inoremap <C-s> <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>

" Quit / quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>Q :qa!<cr>

" Disable CTRL-A on tmux or on screen
if $TERM =~ 'screen'
  nnoremap <C-a> <nop>
  nnoremap <Leader><C-a> <C-a>
endif

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <leader>p :History<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :Files<CR>

" Mapping selecting mappings
"nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

" ----------------------------------------------------------------------------
" Tabs
" ----------------------------------------------------------------------------
" nnoremap ]t :tabn<cr>
" nnoremap [t :tabp<cr>

" ----------------------------------------------------------------------------

" Advanced customization using autoload functions
"inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

" Search and switch buffers
nmap <leader>b :Buffers<cr>
" Find files by name under the current directory
nmap <leader>f :Files<cr>

nmap <leader>h :Files ~/<cr>
" Search content in the current file
nmap <leader>l :BLines<cr>
" Search content in the current file and in files under the current directory
nmap <leader>g :Ag<cr>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" ALE Enable completion where available.
let g:ale_completion_enabled = 1
" Ale sings, si quieres cambiarlos mierda
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'

" vim online Thesaurus
" By default the :OnlineThesaurusCurrentWord command is mapped to <LocalLeader>K.
" If you haven't remapped <LocalLeader>, it defaults to \. To close the split, just press q.
"let g:online_thesaurus_map_keys = 0
"nnoremap <your key binding> :OnlineThesaurusCurrentWord<CR>
"

" Surround.vim
"It's easiest to explain with examples. Press cs"' inside of 'Hola mundo'
" To remove the delimiters entirely, press ds".
"Hola mundo"


" closetag.vim
" filenames like *.xml, *.html, *.xhtml, ...
" These are the file extensions where this plugin is enabled.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'

" filenames like *.xml, *.xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" filetypes like xml, html, xhtml, ...
" These are the file types where this plugin is enabled.
let g:closetag_filetypes = 'html,xhtml,phtml'

" filetypes like xml, xhtml, ...
" This will make the list of non-closing tags self-closing in the specified files.
let g:closetag_xhtml_filetypes = 'xhtml,jsx'

" integer value [0|1]
" This will make the list of non-closing tags case-sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

" NerdCommenter Usages
" Comment out the current line or text selected in visual mode.
" leader >cc
" uncomment in visual mode  leader >c space


" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

"--------------------------------------------
" VimDevIcons adds Icons to Your Plugins    -
" -------------------------------------------
" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1
" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
" enable pattern matching glyphs on folder/directory (enabled by default with 1)
let g:DevIconsEnableFolderPatternMatching = 1
" enable file extension pattern matching glyphs on folder/directory (disabled by default with 0)
let g:DevIconsEnableFolderExtensionPatternMatching = 1
" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '


" " NERDTress File highlighting
" function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"  exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"  exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
" endfunction
"
" call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
" call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
" call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
" call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
" call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
" call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
" call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')
" call NERDTreeHighlightFile('ds_store', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('gitconfig', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')
"
" autocmd VimEnter * call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')

"option 1 is having lag at this momment 2018/July
"let g:NERDTreeLimitedSyntax = 1
"Fix lag bit not highlight files :(
"let g:NERDTreeHighlightCursorline = 0
 let g:NERDTreeSyntaxDisableDefaultExtensions = 1
 let g:NERDTreeDisableExactMatchHighlight = 1
 let g:NERDTreeDisablePatternMatchHighlight = 1
 let g:NERDTreeSyntaxEnabledExtensions = ['c', 'h', 'c++', 'php', 'json', 'js', 'css,', 'py', 'bash'] " example
"
" Tabs not bufferi
" help keycodes
" map <C-F8>> :tabnext<CR>
" map <C-F9> :tabp<CR>
" map <C-F10> :tabnew<CR>

" Tab navigation like Firefox, workingon on GVIM not in vim mapping conflict.
" nnoremap <C-S-tab> :tabprevious<CR>
" nnoremap <C-tab>   :tabnext<CR>
" nnoremap <C-t>     :tabnew<CR>
" inoremap <C-S-tab> <Esc>:tabprevious<CR>i
" inoremap <C-tab>   <Esc>:tabnext<CR>i
" inoremap <C-t>     <Esc>:tabnew<CR>

" Tab nvigation leader or funtion <F5>,<F6>,<F7>
" nnoremap <leader><F5> :tabprevious<CR>
" nnoremap <leader><F6> :tabnext<CR>
" nnoremap <leader><F7> :tabnew<CR>
" inoremap <leader><F5> <Esc>:tabprevious<CR>i
" inoremap <leader><F6> <Esc>:tabnext<CR>i
" inoremap <leader><F7> <Esc>:tabnew<CR>

nnoremap <F5> :tabprevious<CR>
nnoremap <F6> :tabnext<CR>
nnoremap <F7> :tabnew<CR>
inoremap <F5> <Esc>:tabprevious<CR>i
inoremap <F6> <Esc>:tabnext<CR>i
inoremap <F7> <Esc>:tabnew<CR>

" change buffer vim
" map <F6> :bnex<CR>
" map <F7> :bprev<CR>

" config workspace
let g:workspace_powerline_separators = 1
let g:workspace_tab_icon = "\uf00a"
let g:workspace_left_trunc_icon = "\uf0a8"
let g:workspace_right_trunc_icon = "\uf0a9"


"git nerdtree config
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }


" syntastic config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_always_populate_loc_list = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" How do I solve issues after re-sourcing my vimrc : Try adding this to the bottom of your vimrc
" if exists("g:loaded_webdevicons")
"   call webdevicons#refresh()
" endif

