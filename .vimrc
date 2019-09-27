" vim: set foldmethod=marker foldlevel=0 nomodeline:
" ************************
" * Ricardo's vim config *
" ************************

" press za in normal mode to fold and unfolds
"
" -----------------------------------------------------------------------------
" Disabled mappings{{{


" }}}

" Definitions - autodownloads and installers {{{
" -----------------------------------------------------------------------------

" Vim makes this easy:
    " Press Ctrl + w (cmd + w in a Mac).
    " Press v (for vertical) or h (for horizontal).

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" Comment out the current line or text selected in visual mode.
" leader >cc
" uncomment in visual mode leader >c space


" -----------------------------------------------------------------------------
" }}}

" -----------------------------------------------------------------------------
" Autocmd configs {{{
" -----------------------------------------------------------------------------

" Tabs to Spaces auto
if has("autocmd")
    au BufReadPost * if &modifiable | retab | endif
endif

" " Automatic rename of tmux window
" if exists('$TMUX') && !exists('$NORENAME')
"     au BufEnter * if empty(&buftype) | call system('tmux rename-window '.expand('%:t:S')) | endif
"     au VimLeave * call system('tmux set-window automatic-rename on')
" endif" group vim not use if fedora group is used


" Staritfy with nerdtree startup
" :h startify-faq-06
" autocmd VimEnter * if !argc() | Startify | NERDTree | wincmd w | endif


" }}}

" -----------------------------------------------------------------------------
" Key Mappings and remappings {{{
" -----------------------------------------------------------------------------

" for help with current mapping keys
" :map :nmap :vmap :imap
" to look for info about the map :map (key), ejemplo: :map c, :map y
" set <leader> mapping key
" let mapleader = '\'
" let mapleader      = ' '
" let maplocalleader = ' '

" man lookup is annoying sometimes
" map K <nop>

" map - n, v, o
" map! - c, i
" lmap - c, i, l

" git diff
" nnoremap <<F10> :!git diff --patch-with-stat -M90 --no-ext-diff --color=always HEAD<cr>
" nnoremap <leader>g

" dont use non-vi keys!

" REPL config / repl-vim
nnoremap <leader>1 :REPLToggle<Cr>
let g:sendtorepl_invoke_key = "<leader>2"
let g:repl_program = {
            \   "python": "ipython3",
            \   "default": "bash"
            \   }

" Open new line below and above current line
" nnoremap <leader>o o<esc>
"
" nnoremap <leader>O O<esc>

" Jump list (to newer position)
" nnoremap <C-p> <C-i>

" jk | Escaping!
" inoremap jk <Esc>
" xnoremap jk <Esc>
" cnoremap jk <C-c>

" Save / save
inoremap <C-s> <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>s :update<cr>
nnoremap <leader>w :update<cr>
" file save
" noremap <Leader>fs :w<CR>

" Quit / quit
inoremap <C-Q>     <esc>:q<cr>
nnoremap <C-Q>     :q<cr>
vnoremap <C-Q>     <esc>
nnoremap <Leader>q :q<cr>
nnoremap <Leader>qq :qa!<cr>

" Disable CTRL-A on tmux or on screen
if $TERM =~ 'screen'
  nnoremap <C-a> <nop>
  nnoremap <Leader><C-a> <C-a>
endif

" Tabs not buffers
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

" nnoremap <F5> :tabprevious<CR>
" nnoremap <F6> :tabnext<CR>
" nnoremap <F7> :tabnew<CR>
" inoremap <F5> <Esc>:tabprevious<CR>i
" inoremap <F6> <Esc>:tabnext<CR>i
" inoremap <F7> <Esc>:tabnew<CR>

" change buffer vim defined in (FZF module)
map <F5> :bprev<cr>
map <F6> :bnex<cr>
map <F7> :new<cr>
noremap <Leader><F5> :bd<CR>
" map <F8> :enew<CR> "Edit a new, unnamed buffer.
" leader + b, list all buffer and select the one

" Split, vsiplit and view are created as a buffer not as a tab
" is define in :help split

" Background color switch
" noremap <Leader>b1 :set background=light<cr>
" noremap <Leader>b2 :set background=dark<cr>

" toggle rnlative line numbers
" noremap <Leader>rn :set nu!<cr>

" Syntastic results open, close, next, previous (actually the location list)
" noremap <Leader>so :Errors<CR>
" noremap <Leader>sc :lclose<CR>
" noremap <Leader>sn :lnext<CR>
" noremap <Leader>sN :lNext<CR>
" close quickfix, error, and preview windows
" noremap <Leader>c :cclose<CR>:pc<CR>:lclose<CR>

" error next and close
nnoremap ]q :cnext<cr>zz
nnoremap [q :cprev<cr>zz
nnoremap ]l :lnext<cr>zz
nnoremap [l :lprev<cr>zz

" Fix indentation - Map to ( backslash + F7 )
" map <leader>F7 mzgg=G`z

" Remap 'K'; it's fucking annoying
" nnoremap K <Nop>
" vnoremap K <Nop>

" -----------------------------------------------------------------------------
" copy / paste mappings
" -----------------------------------------------------------------------------

" Lazier versions of 'copy all' and 'delete all'
nmap <leader>5y :%y<cr>
nmap <leader>5d :%d<cr>

" copy / paste OS clipboard and backwards (compiled vim no +clipboard suport)
" vmap <leader><F3> :!xclip -f -sel clip<CR>
" map <leader><F4> :-1r !xclip -o -sel clip<CR>

" copy and paste to the register * (compiled vim no +clipboard suport)
" noremap <Leader>y "*y
" noremap <Leader>p "*p
" noremap <Leader>Y "+y
" noremap <Leader>P "+p

" -----------------------------------------------------------------------------
" Mouse togle mouse
" -----------------------------------------------------------------------------
map <leader>m <ESC>:exec &mouse!=""? "set mouse=" : "set mouse=a"<CR>
" Toggles folds with mouse triple click to avoid conflicting with text selectin
noremap <3-LeftMouse> za

" -----------------------------------------------------------------------------
" Timestamp mappings
" -----------------------------------------------------------------------------

nnoremap <leader>tt "=strftime("%c")<CR>P
inoremap <leader>tt <C-R>=strftime("%c")<CR>

" -----------------------------------------------------------------------------
" Tabs
" -----------------------------------------------------------------------------
" nnoremap ]t :tabn<cr>
" nnoremap [t :tabp<cr>


" }}}

" -----------------------------------------------------------------------------
" Vim-plug plugin installers {{{
" -----------------------------------------------------------------------------

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'

call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

" -----------------------------------------------------------------------------
" junegunn plugin installers
" -----------------------------------------------------------------------------

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plug 'junegunn/vim-easy-align'
" Any valid git URL is allowed
Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" Multiple Plug commands can be written in a single line using | separators
" emoji
Plug 'junegunn/vim-emoji'
" Plugin outside ~/.vim/plugged with post-update hook
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" Unmanaged plugin (manually installed and updated)
Plug '~/my-prototype-plugin'
" Multiple commands for git
Plug 'junegunn/vim-github-dashboard', { 'on': ['GHDashboard', 'GHActivity'] }
Plug 'junegunn/vader.vim',  { 'on': 'Vader', 'for': 'vader' }
" Code to execute when the plugin is lazily loaded on demand
Plug 'junegunn/goyo.vim', { 'for': 'markdown' }
" autocmd! User goyo.vim echom 'Goyo is now loaded!'
" To run Goyo just put :Goyo


" -----------------------------------------------------------------------------
" git plugin installers
" -----------------------------------------------------------------------------

" Custom git status in vim
Plug 'airblade/vim-gitgutter'
" Git Stuff
Plug 'Xuyuanp/nerdtree-git-plugin'


" -----------------------------------------------------------------------------
" snippets and engine plugins
" -----------------------------------------------------------------------------

" Track the engine.
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'


" -----------------------------------------------------------------------------
" other pluging installers
" -----------------------------------------------------------------------------

" I can mix in one line the plug installers
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Using a non-master branch
Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
Plug 'fatih/vim-go', { 'tag': '*' }
" Plugin options
Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" A small sensible Vim configuration and pair programming .vimrc file
Plug 'tpope/vim-sensible'
" Loaded when clojure file is opened
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" Multiple file types
Plug 'kovisoft/paredit', { 'for': ['clojure', 'scheme'] }
" On-demand loading on both conditions

" Post-update hooks
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --cs-completer --go-completer --js-completer  --rust-completer' }
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" IDE-like Vim tabline
" Plug 'bagrat/vim-buffet'

" Tags
" Plug 'universal-ctags/ctags'
" Plug 'ludovicchabant/vim-gutentags'

" Asynchronous Lint Engine
Plug 'w0rp/ale'

" Prettier plug
" Plug 'prettier/vim-prettier', { 'do': 'yarn install' }

" Code formater from google
" Plug 'google/yapf'

" Code formater for python
" Plug 'ambv/black'

" View any blob, tree, commit, or tag in the repository with :Gedit (and :Gsplit, :Gvsplit, :Gtabedit,)
Plug 'tpope/vim-fugitive'

" The plugin provides mappings to easily delete, change and add such surroundings in pairs.
Plug 'tpope/vim-surround'


" -----------------------------------------------------------------------------
" Colours, Colorschemes and themes for vim
" -----------------------------------------------------------------------------

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


" -----------------------------------------------------------------------------
" Writing pluging installers block
" -----------------------------------------------------------------------------

" Uncover usage problems in your writing
Plug 'reedes/vim-wordy'
" Tabular
Plug 'godlygeek/tabular'
" Syntax for languages Themes
Plug 'sheerun/vim-polyglot'
"Plug 'junegunn/vim-online-thesaurus'
" Writing plugins
"Plug 'davidbeckingsale/writegood.vim'
"Plug 'dbmrq/vim-ditto'



" Perform all your vim insert mode completions with Tab
" Plug 'ervandew/supertab'

" jedi-vim - awesome Python autocompletion with VIM
" Plug 'davidhalter/jedi-vim'


" -----------------------------------------------------------------------------
" Enhancements block
" -----------------------------------------------------------------------------

" Clean Code
Plug 'ntpeters/vim-better-whitespace'
Plug 'djoshea/vim-autoread'
" Vim enable an auto-close chars feature for you
" Plug 'Townk/vim-autoclose'
" Auto close parentheses and repeat by dot dot dot... *** The bes
" Plug  'cohama/lexima.vim'
" Auto close (X)HTML tags
Plug 'alvan/vim-closetag'
" PathPicker
Plug 'facebook/PathPicker'
" Read–Eval–Print Loop (REPL) vim 8.0 >
Plug 'sillybun/vim-repl', {'do': './install.sh'}
" Rainbow Parentheses
Plug 'junegunn/rainbow_parentheses.vim'
" Comment functions so powerful—no comment necessary.
Plug 'scrooloose/nerdcommenter'
Plug 'thaerkh/vim-workspace'

" quickr-preview.vim (not working - to do 20190621 02:38 pm)
" Plug 'ronakg/quickr-preview.vim'


" -----------------------------------------------------------------------------
" Nerdtree Highlighting and icons block
" -----------------------------------------------------------------------------

" Syntax highlighting for Dockerfiles
Plug 'docker/docker' , {'rtp': '/contrib/syntax/vim/'}
" Syntastic is a syntax checking plugin similar to YCM
"Plug 'scrooloose/syntastic'
"Plug 'vim-syntastic/syntastic'
" Adds file type glyphs/icons to popular Vim plugins
 Plug 'ryanoasis/vim-devicons'
" Dev icons and ultra mega awesome fonts
 "Plug 'ryanoasis/nerd-fonts', { 'do': './install.py' }
" The fancy start screen for vim
Plug 'mhinz/vim-startify'
" NERD tree will be loaded on the first invocation of NERDTreeToggle command
Plug 'scrooloose/nerdtree', " { 'on': 'NERDTreeToggle' }
" vim-nerdtree-syntax-highlight
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'


" -----------------------------------------------------------------------------
" powerline and airline pluging installer
" -----------------------------------------------------------------------------

" Vim-airline Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" restore buffers vim
" Plug 'tpope/vim-obsession'
" Plug 'dhruvasagar/vim-prosession'

" You’ve got to love multiple selections.
"Plug 'terryma/vim-multiple-cursors'

" -----------------------------------------------------------------------------
" the grep search variances
" -----------------------------------------------------------------------------

" ripgrep recursively searches directories for a regex pattern
" rg search result (ALT-A to select all, ALT-D to deselect all)
" Plug 'BurntSushi/ripgrep'

" A code-searching tool similar to ack, but faster
" ag search result (ALT-A to select all, ALT-D to deselect all)
" Plug 'ggreer/the_silver_searcher'

" -----------------------------------------------------------------------------
" Autosave plugin installer
" -----------------------------------------------------------------------------

Plug '907th/vim-auto-save'

" Plug 'pangloss/vim-javascript'


" -----------------------------------------------------------------------------
" preview window for vim
" -----------------------------------------------------------------------------

Plug 'skywind3000/vim-preview'

" -----------------------------------------------------------------------------
" Vim Autocompletion and linter for Terraform, a HashiCorp tool
" -----------------------------------------------------------------------------

Plug 'hashivim/vim-terraform'
" Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/terraform-lsp'
Plug 'juliosueiras/vim-terraform-completion'

" -----------------------------------------------------------------------------
" Conquer of Completion (coc)
" -----------------------------------------------------------------------------

" Use release branch
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Or latest tag
Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
" Or build from source code by use yarn: https://yarnpkg.com
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}



" -----------------------------------------------------------------------------
" Initialize plugin system
call plug#end()

" }}}

" -----------------------------------------------------------------------------
" Colours, coloschemes, background  {{{
" -----------------------------------------------------------------------------

" Set background
set background=dark     " Setting dark mode
" set background=light   " Setting light mode

" Schemes Colours - the italics has to be enabled before Theme/Scheme

" colorscheme solarized
" let g:solarized_termcolors=256
" let g:materialmonokai_italic=1
" colorscheme material-monokai
" colorscheme gruvbox
" let g:gruvbox_italic=1
colorscheme dracula
let g:dracula_italic = 1
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
" set termguicolors
" set lighline theme inside lightline config
" colorscheme tender
" let g:lightline = { 'colorscheme': 'tender' }
" colorscheme termina

" Activate italics no matter what colortheme the 1st the other are pa'diversion
" highlight Comment cterm=italic
" highlight Keyword cterm=italic gui=italic
" highlight type cterm=italic gui=italic

" highlight Comment cterm=italic
" highlight htmlArg cterm=italic

" set wildmenu
" set wildmode=longest:full,full

" -----------------------------------------------------------------------------
" <F9> | Color scheme selector
" -----------------------------------------------------------------------------
" function! s:rotate_colors()
"   if !exists('s:colors')
"     let s:colors = s:colors()
"   endif
"   let name = remove(s:colors, 0)
"   call add(s:colors, name)
"   execute 'colorscheme' name
"   redraw
"   echo name
" endfunction
" nnoremap <silent> <F9> :call <SID>rotate_colors()<cr>
"
"
" function! s:colors(...)
"   return filter(map(filter(split(globpath(&rtp, 'colors/*.vim'), "\n"),
"         \                  'v:val !~ "^/usr/"'),
"         \           'fnamemodify(v:val, ":t:r")'),
"         \       '!a:0 || stridx(v:val, a:1) >= 0')
" endfunction

" }}}

" -----------------------------------------------------------------------------
" Config section for modules and Plugins {{{
" -----------------------------------------------------------------------------

" -----------------------------------------------------------------------------
" vim-better-whitespace plugin config
" -----------------------------------------------------------------------------

let g:better_whitespace_ctermcolor='yellow'
let g:better_whitespace_guicolor='yellow'
let g:better_whitespace_enabled = 1
let g:strip_whitespace_on_save = 1
let g:better_whitespace_operator='_s'
let g:strip_whitespace_confirm=0
let g:better_whitespace_filetypes_blacklist=['<filetype1>', '<filetype2>',
    \  '<etc>', 'diff', 'gitcommit', 'unite', 'qf', 'help']


" highlight whitespace in markdown files, though stripping remains disabled by the blacklist
autocmd FileType markdown EnableWhitespace
" Do not modify kernel files, even though their type is not blacklisted and highlighting is enabled
autocmd BufRead /usr/src/linux* DisableStripWhitespaceOnSave

" -----------------------------------------------------------------------------
" Customization for Rainbow Parentheses
" -----------------------------------------------------------------------------

" let g:rainbow#max_level = 16
" let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

" List of colors that you do not want. ANSI code or #RRGGBB for Rainbow
" let g:rainbow#blacklist = [233, 234]


" -----------------------------------------------------------------------------
" yapf config for python
" -----------------------------------------------------------------------------

" autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf<CR>
" autocmd FileType python nnoremap <LocalLeader>i :!isort %<CR><CR>

" -----------------------------------------------------------------------------
" Airline configs
" -----------------------------------------------------------------------------

" let g:airline_powerline_fonts = 1
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
" let g:airline#extensions#tabline#formatter = 'default'
" let g:airline_statusline_ontop=1

let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" let g:airline_extensions = []
" Theme for airline
"let g:airline_theme='hybridline'

" if !exists('g:airline_symbols')
"     let g:airline_symbols = {}
" endif
"
" unicode symbols
" let g:airline_left_sep = '»'
" let g:airline_left_sep = '▶'
" let g:airline_right_sep = '«'
" let g:airline_right_sep = '◀'
" let g:airline_symbols.linenr = '␊'
" let g:airline_symbols.linenr = '␤'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" let g:airline_symbols.paste = 'Þ'
" let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'

" airline symbols
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = ''


" -----------------------------------------------------------------------------
" vim-github-dashboard
" -----------------------------------------------------------------------------


let g:github_dashboard = { 'username': 'ricardo-rod', 'password': $GITHUB_TOKEN }
" let g:github_dashboard = {}

" Dashboard window position
" - Options: tab, top, bottom, above, below, left, right
" - Default: tab
let g:github_dashboard['position'] = 'top'

" Disable Emoji output
" - Default: only enable on terminal Vim on Mac
let g:github_dashboard['emoji'] = 0

" Customize emoji (see http://www.emoji-cheat-sheet.com/)
let g:github_dashboard['emoji_map'] = {
\   'user_dashboard': 'blush',
\   'user_activity':  'smile',
\   'repo_activity':  'laughing',
\   'ForkEvent':      'fork_and_knife'
\ }

" Command to open link URLs
" - Default: auto-detect
let g:github_dashboard['open_command'] = 'open'

" API timeout in seconds
" - Default: 10, 20
let g:github_dashboard['api_open_timeout'] = 10
let g:github_dashboard['api_read_timeout'] = 20

" Do not set statusline
" - Then you can customize your own statusline with github_dashboard#status()
let g:github_dashboard['statusline'] = 0

" let g:github_dashboard['api_endpoint'] = 'http://github.mycorp.com/api/v3'


" -----------------------------------------------------------------------------
" Setup gitgutter
" -----------------------------------------------------------------------------

" a git diff in the gutter (sign column) and stages/undoes hunks.
" make a function or button
" :GitGutterToggle

" let g:gitgutter_sign_added = '+'
" let g:gitgutter_sign_modified = '+✚'
let g:gitgutter_sign_removed = '–'
" let g:gitgutter_sign_removed_first_line = '=-'
" let g:gitgutter_sign_modified_removed = '=+'
" let g:gitgutter_override_sign_column_highlight = 0

set updatetime=100
let g:gitgutter_max_signs = 500     " default value
let g:gitgutter_enabled = 1
let g:gitgutter_signs = 0
" let g:gitgutter_highlight_lines = 1

"If you don't want vim-gitgutter to set up any mappings at all, use this:
let g:gitgutter_map_keys = 0

" Manual Mappings for gitgutter
nmap <leader>r1 :GitGutterSignsToggle<cr>
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" If you really want to update the signs when you save a file
" autocmd BufWritePost * GitGutter

" If you don't want vim-gitgutter to set up any mappings at all
" let g:gitgutter_map_keys = 0
" let g:gitgitter_suppress_warnings

" Emoji in Vim vim-emoji config
" let g:gitgutter_sign_added = emoji#for('small_blue_diamond')
" let g:gitgutter_sign_modified = emoji#for('small_orange_diamond')
" let g:gitgutter_sign_removed = emoji#for('small_red_triangle')
" let g:gitgutter_sign_removed_first_line = emoji#for('x')
" let g:gitgutter_sign_modified_removed = emoji#for('collision')
" set completefunc=emoji#complete


" ----------------------------------------------------------------------------

" Advanced customization using autoload functions
"inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})


" -----------------------------------------------------------------------------
" fzf plugin config and fzf mappings
" -----------------------------------------------------------------------------

" nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
" Search and switch buffers
nmap <leader>b :Buffers<cr>
" Find files by name under the current directory
nmap <leader>f :Files<cr>
" Find files by name under home user
nmap <leader>h :Files ~/<cr>
" Search content in the current file
nmap <leader>l :BLines<cr>
" Search content in the current file and in files under the current directory
nmap <leader>ag :Ag<cr>

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Tags] Command to generate tags file
" let g:fzf_tags_command = 'ctags -R'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" -----------------------------------------------------------------------------
" fzf plugin config - a command-line fuzzy finder
" -----------------------------------------------------------------------------

" This is the default extra key bindings
let g:fzf_action = {
 \ 'ctrl-t': 'tab split',
 \ 'ctrl-x': 'split',
 \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" " Customize fzf colors to match your color scheme
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

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'

nnoremap <leader>p :History<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>t :Files<CR>

" Mapping selecting mappings
nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" Insert mode completion
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)


" -----------------------------------------------------------------------------
" Asynchronous Lint Engine - ALE plugin config
" -----------------------------------------------------------------------------

" ALE Enable completion where available.
" let g:ale_completion_enabled = 1
" Ale sings, si quieres cambiarlos mierda
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '--'
" fix ale error for python 2, parenthesis
" let g:ale_python_flake8_executable = 'python3'
" Write this in your vimrc file
" Check Python files with flake8 and pylint.
let b:ale_linters = ['flake8', 'pylint']
" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']
" Disable warnings about trailing whitespace for Python files.
" let b:ale_warn_about_trailing_whitespace = 0
" Show 5 lines of errors (default: 10)
let g:ale_list_window_size = 5
let g:ale_python_flake8_executable = 'python3'   " or 'python' for Python 2
let g:ale_python_flake8_options = '-m flake8'


" -----------------------------------------------------------------------------
" dictionary plugin config
" -----------------------------------------------------------------------------

" vim online Thesaurus
" By default the :OnlineThesaurusCurrentWord command is mapped to <LocalLeader>K.
" If you haven't remapped <LocalLeader>, it defaults to \. To close the split, just press q.
"let g:online_thesaurus_map_keys = 0
"nnoremap <your key binding> :OnlineThesaurusCurrentWord<CR>


" -----------------------------------------------------------------------------
" vim surround config
" -----------------------------------------------------------------------------

" Surround.vim
"It's easiest to explain with examples. Press cs"' inside of 'Hola mundo'
" To remove the delimiters entirely, press ds".
"Hola mundo"


" -----------------------------------------------------------------------------
" vim tag plugin config
" -----------------------------------------------------------------------------

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
" This will make the list of non-closing tags case-sensitive
" (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'


" -----------------------------------------------------------------------------
" startify plugin config
" -----------------------------------------------------------------------------



" -----------------------------------------------------------------------------
" NerdCommenter Usages
" -----------------------------------------------------------------------------

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


" -----------------------------------------------------------------------------
" Nerdtree plugin config, map, and NERDTree File highlighting
" -----------------------------------------------------------------------------

" open a NERDTree automatically when vim starts up
" autocmd vimenter * NERDTree | wincmd p

" open a NERDTree automatically when vim starts up if no files were specified
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

map <C-n> :NERDTreeToggle<CR>

"it closes nerdtree when it is the last file
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


let NERDTreeQuitOnOpen = 1
" nerdtree Show hidden files
" let NERDTreeShowHidden = 1

" Prevent brackets around icons when sourcing vimrc
" if exists('g:loaded_webdevicons')
  " call webdevicons#refresh()
" endif

" Disable Highlighting
" let g:NERDTreeDisableFileExtensionHighlight = 1
" let g:NERDTreeDisableExactMatchHighlight = 1
" let g:NERDTreeDisablePatternMatchHighlight = 1
"
" Highlight full name (not only icons). You need to add this if you don't have
" vim-devicons and want highlight.
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

" " Highlight folders using exact match
" let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
" let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name

" remove lag from NERDTreeHighlightCursorline
" let g:NERDTreeHighlightCursorline = 0

" let NERDTreeMinimalUI = 1
" let NERDTreeDirArrows = 1


" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

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
" call NERDTreeHighlightFile('bash', 'Gray', 'none', '#fff7f7', 'NONE')
" call NERDTreeHighlightFile('bashrc', 'Gray', 'none', '#686868', '#151515')
" call NERDTreeHighlightFile('bashprofile', 'Gray', 'none', '#686868', '#151515')
call NERDTreeHighlightFile('sh', 'gray', 'none', '#b999c6', 'NONE')
call NERDTreeHighlightFile('bash', 'gray', 'none', '#b999c6', 'NONE')


" option 1 is having lag at this momment 2018/July
" let g:NERDTreeLimitedSyntax = 1

" Fix lag bit not highlight files :(
" let g:NERDTreeSyntaxDisableDefaultExtensions = 1
" let g:NERDTreeDisableExactMatchHighlight = 1
" let g:NERDTreeDisablePatternMatchHighlight = 1
" let g:NERDTreeSyntaxEnabledExtensions = ['c', 'h', 'c++', 'php', 'json', 'js', 'css,', 'py', 'bash'] " example
" let g:NERDTreeHighlightCursorline = 0


" -----------------------------------------------------------------------------
" nerdtreegit config
" -----------------------------------------------------------------------------

"git nerdtree config
" let g:NERDTreeIndicatorMapCustom = {
"     \ "Modified"  : "✹",
"     \ "Staged"    : "✚",
"     \ "Untracked" : "✭",
"     \ "Renamed"   : "➜",
"     \ "Unmerged"  : "═",
"     \ "Deleted"   : "✖",
"     \ "Dirty"     : "✗",
"     \ "Clean"     : "✔︎",
"     \ "Ignored"   : "☒",
"     \ "Unknown"   : "?"
"     \ }
"
let g:NERDTreeShowIgnoredStatus = 1


" -----------------------------------------------------------------------------
" vim-workspace config
" -----------------------------------------------------------------------------
" nnoremap <leader>\ :ToggleWorkspace<CR>
" " config workspace
" let g:workspace_powerline_separators = 1
" let g:workspace_tab_icon = "\uf00a"
" let g:workspace_left_trunc_icon = "\uf0a8"
" let g:workspace_right_trunc_icon = "\uf0a9"
"

" -----------------------------------------------------------------------------
" VimDevIcons adds Icons to Your Plugins
" -----------------------------------------------------------------------------

" loading the plugin
let g:webdevicons_enable = 1

" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1

" adding the custom source to unite
let g:webdevicons_enable_unite = 1

" adding the column to vimfiler
let g:webdevicons_enable_vimfiler = 1

" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1

" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1

" ctrlp glyphs
let g:webdevicons_enable_ctrlp = 1

" adding to vim-startify screen
let g:webdevicons_enable_startify = 1

" adding to flagship's statusline
let g:webdevicons_enable_flagship_statusline = 1

" turn on/off file node glyph decorations (not particularly useful)
let g:WebDevIconsUnicodeDecorateFileNodes = 1

" use double-width(1) or single-width(0) glyphs
" only manipulates padding, has no effect on terminal or set(guifont) font
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

" whether or not to show the nerdtree brackets around flags
let g:webdevicons_conceal_nerdtree_brackets = 1

" the amount of space to use after the glyph character (default ' ')
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '

" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1

" enable folder/directory glyph flag (disabled by default with 0)
let g:WebDevIconsUnicodeDecorateFolderNodes = 1

" Adding the custom source to denite
let g:webdevicons_enable_denite = 1

" change the default character when no match found
" let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol = 'ƛ'



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
let g:webdevicons_conceal_nerdtree_brackets = 1


" -----------------------------------------------------------------------------
" syntastic plugin config
" -----------------------------------------------------------------------------

" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0


" -----------------------------------------------------------------------------
" ALE config at the end of vimrc file
" -----------------------------------------------------------------------------

" Put these lines at the very end of your vimrc file. ALE/ale

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
" packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
" silent! helptags ALL


" -----------------------------------------------------------------------------
" ronakg/quickr-preview config
" -----------------------------------------------------------------------------

" If you want to use your own key mappings, disable the default key mappings
" let g:quickr_preview_keymaps = 0
" Define custom key mappings
" nmap <leader>p <plug>(quickr_preview)
" nmap <leader>q <plug>(quickr_preview_qf_close)
" Valid values are above, below, left, or right
" let g:quickr_preview_position = 'above'

" -----------------------------------------------------------------------------
" snippets and engine plugins config
" -----------------------------------------------------------------------------
" pending to configure Sat 25 May 2019 04:46:27 PM AST
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<c-b>"
" let g:UltiSnipsJumpBackwardTrigger="<c-z>"
"
" " If you want :UltiSnipsEdit to split your window.
" let g:UltiSnipsEditSplit="vertical"


" -----------------------------------------------------------------------------
" ymc plugins config
" -----------------------------------------------------------------------------

" Default auto-completion for C family
" let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"

" let g:ycm_key_list_select_completion=[]
" let g:ycm_key_list_previous_completion=[]

let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'


" -----------------------------------------------------------------------------
" auto-save config
" -----------------------------------------------------------------------------
" let g:auto_save = 1
" let g:auto_save_events = ["InsertLeave", "TextChanged" ]




" -----------------------------------------------------------------------------
" Vim Terraform Completion with Linter
" -----------------------------------------------------------------------------
" https://github.com/juliosueiras/vim-terraform-completion

" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" (Optional) Enable terraform plan to be include in filter
" let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0

" https://github.com/hashivim/vim-terraform
" Allow vim-terraform to align settings automatically with Tabularize.
let g:terraform_align=1

" Allow vim-terraform to automatically fold (hide until unfolded) sections of
" terraform code. Defaults to 0 which is off.
" let g:terraform_fold_sections=1

" Allow vim-terraform to automatically format *.tf and *.tfvars files with
" terraform fmt. You can also do this manually with the :TerraformFmt command.
let g:terraform_fmt_on_save=1

" -----------------------------------------------------------------------------
" Conquer of compl (coc config)
" -----------------------------------------------------------------------------

" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Better display for messages
set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
" set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
" inoremap <silent><expr> <TAB>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>ff  <Plug>(coc-format-selected)
nmap <leader>ff  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  " autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of
" languageserver.

xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>


" Snippet for VSCode
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


" Opening the configuration file
function! SetupCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunction

" Use C to open coc config
call SetupCommandAbbrs('C', 'CocConfig')


autocmd FileType json syntax match Comment +\/\/.\+$+


hi CocCursorRange guibg=#b16286 guifg=#ebdbb2

" nmap <silent> <C-d> <Plug>(coc-cursors-word)*
" xmap <silent> <C-d> y/\V<C-r>=escape(@",'/\')<CR><CR>gN<Plug>(coc-cursors-range)gn

nmap <expr> <silent> <C-d> <SID>select_current_word()
function! s:select_current_word()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  return "*\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc

"coc.preferences.colorSupport": false,
" coc-pairs
let g:coc_pairs_expand = [['（', '）'], ['“', '”'], ['‘', '’'], ['《', '》']]
inoremap <silent> <M-]> <C-R>=util#keymapfunc#moveOutPairs(']')<CR>
inoremap <silent> <M-}> <C-R>=util#keymapfunc#moveOutPairs('}')<CR>
inoremap <silent> <M-)> <C-R>=util#keymapfunc#moveOutPairs(')')<CR>
" coc-smartf
" nmap f <Plug>(coc-smartf-forward)
" nmap F <Plug>(coc-smartf-backward)
" autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
" autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
" coc-bookmark
nmap <silent> ,b <Plug>(coc-bookmark-toggle)
nmap <silent> ,a <Plug>(coc-bookmark-annotate)
nmap <silent> gh <Plug>(coc-bookmark-prev)
nmap <silent> gl <Plug>(coc-bookmark-next)
" coc extensions
let g:coc_global_extensions = [
  \ 'coc-bookmark',
  \ 'coc-browser',
  \ 'coc-clock',
  \ 'coc-css',
  \ 'coc-diagnostic',
  \ 'coc-dictionary',
  \ 'coc-emoji',
  \ 'coc-emmet',
  \ 'coc-eslint',
  \ 'coc-explorer',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-lists',
  \ 'coc-json',
  \ 'coc-marketplace',
  \ 'coc-pairs',
  \ 'coc-post',
  \ 'coc-prettier',
  \ 'coc-python',
  \ 'coc-rls',
  \ 'coc-snippets',
  \ 'coc-syntax',
  \ 'coc-tag',
  \ 'coc-template',
  \ 'coc-todolist',
  \ 'coc-translator',
  \ 'coc-tslint-plugin',
  \ 'coc-tsserver',
  \ 'coc-vimtex',
  \ 'coc-vimlsp',
  \ 'coc-yank',
  \ 'coc-word'
\ ]


" }}}

" -----------------------------------------------------------------------------
" Defaults paratemers from vimrc, terminal type, colours {{{
" ----------------------------------------------------------------------------
" set encoding=UTF-8
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
set ruler               " show the cursor position all the time
""set number            " Show line numbers in vim
set showcmd           " show leader and others commands when pressed
set hidden              " Keep undo history when switching between a buffers

" --- history / file handling ---
set history=999             " Increase history (default = 20)
set undolevels=999          " More undo (default=100)
set autoread                " reload files if changed externally

"folding settings
" set foldmethod=indent   "fold based on indent
" set foldnestmax=3       "deepest fold is 3 levels
" set nofoldenable        "dont fold by default
" set foldtext=MyFoldText()
" set fillchars=vert:\|


" ViM Terminal colours
if has('termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" xterm and screen parameter for 256 colours
" if &term == "xterm-256color"
"   set t_Co=256
" endif

" if &term == "screen"
"   set t_Co=256
" endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
" Syntax hightlight mode, get you freak ON!!!
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Set truecolor 24-bit true color: "888" colors (aka 16 milion)
" set termguicolors
" Support for 256 Colours
" set t_Co=256

" Annoying temporary files
set backupdir=/tmp//,.
set directory=/tmp//,.
if v:version >= 703
  set undodir=/tmp//,.
endif

" display a warning if fileformat isnt unix
" set statusline+=%#warningmsg#
" set statusline+=%{&ff!='unix'?'['.&ff.']':''}
" set statusline+=%*

" display a warning if file encoding isnt utf-8
" set statusline+=%#warningmsg#
" set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
" set statusline+=%*

" read only flag
" set statusline+=%#identifier#
" set statusline+=%r
" set statusline+=%*


" }}}

" -----------------------------------------------------------------------------
" User Interface - UI {{{
" -----------------------------------------------------------------------------

filetype plugin on
filetype plugin indent on " tab is equal to 4 and autoindent is mark with >

autocmd FileType javascript setlocal shiftwidth=2 tabstop=2
autocmd FileType html       setlocal shiftwidth=2 tabstop=2
autocmd FileType python     setlocal shiftwidth=4 softtabstop=4 expandtab


" for all files
set tabstop=4           " show existing tab with 4 spaces width
set shiftwidth=4        " when indenting with '>', use 4 spaces width
set pastetoggle=<F2>    " set paste disable autoindent in vim
set expandtab           " On pressing tab, insert 4 spaces
set smarttab            " At start of line, <Tab> inserts shift width



" set autoindent " auto indent
" set wrap " wrap lines
" set linebreak " break lines on words
" let &showbreak = '| ' " wrap character
" set hlsearch " highlight search results without conditional
" set ignorecase " ignore case when searching
" set smartcase " use case if there are capitals

" Line at 80 Charaters for help: :help guibg and :help ctermbg for console
if (exists('+colorcolumn'))
    set colorcolumn=80
    highlight ColorColumn guibg=#3c3836
    " highlight ColorColumn ctermbg=7
endif

" make funtion to toggle mouse use
set mouse=a

" yy will go to the system's clipboard, instead of Vim's unnamed register,
" and p will paste the system's clipboard. using vimx or vim-X11 for plus
if has('clipboard')
   if has('unnamedplus')  " When possible use + register for copy-paste
       set clipboard=unnamed,unnamedplus
   else         " On mac and Windows, use * register for copy-paste
       set clipboard=unnamed
   endif
endif
" Prevent Vim from clearing the clipboard on exit
autocmd VimLeave * call system("xsel -ib", getreg('+'))

" powerline-status vim statusline
" python3 from powerline.vim import setup as powerline_setup
" python3 powerline_setup()
" python3 del powerline_setup
" set laststatus=2 " Always display the statusline in all windows
" set showtabline=2 " Always display the tabline, even if there is only one tab
" set noshowmode " Hide the default mode text (e.g. -- INSERT -- below the statusline)
" "set rtp+=~/.local/lib/python3.7/site-packages/powerline/bindings/vim/
" "set rtp+=/usr/lib/python3.4/site-packages/powerline/bindings/vim/

" disable vim powerline
" let g:powerline_loaded = 1

" }}}

" VIMRC {{{

nnoremap <leader>ev :vsplit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

" }}}


nnoremap <silent> <C-P> :Files<CR>

" -----------------------------------------------------------------------------
"  My .vimrc plugin and funtions that need to be at the bottom,
"  each time you mod listen to started from the bottorm now we're here
" -----------------------------------------------------------------------------

" How do I solve issues after re-sourcing my vimrc
" Try adding this to the bottom of your vimrc
if exists("g:loaded_webdevicons")
  call webdevicons#refresh()
endif

" added | AirlineRefresh to fix the squares loss of airline colors
autocmd! bufwritepost .vimrc source % | AirlineRefresh
" autocmd bufwritepost .vimrc source $MYVIMRC
