let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:vim_bootstrap_langs = "go,html,javascript,typescript"
let g:vim_bootstrap_editor = "nvim"				" nvim or vim

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin(expand('~/.config/nvim/plugged'))
Plug 'sheerun/vim-polyglot'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } "golang
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'sainnhe/gruvbox-material'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mattn/emmet-vim'

"telescope stuffs
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} 
Plug 'p00f/nvim-ts-rainbow', {'do': ':TSUpdate'} 
"dap client 
Plug 'mfussenegger/nvim-dap'
Plug 'nvim-telescope/telescope-dap.nvim'
Plug 'theHamsta/nvim-dap-virtual-text'
"end telescope stuffs

Plug 'github/copilot.vim'

call plug#end()

set number                         " Line numbers
set spelllang=en_us                " dictionary
set linebreak                      " Break line without break word
set smartcase                      " If have any uppercase, active case sensitive
set gdefault                       " Always substitute all letters, dont just first
set smartindent                    " Auto-indent
set cursorline                     " Active line with other color
set incsearch                      " Find when you typing
set tags=tags;                     " Use ctags file in current directory or parent
set backspace=2                    " Default backspace behaviour
set wildmode=full                  " Command complete display all list
set wildchar=<Tab> wildmenu        " Autocomplete commands on command mode
set mouse=a                        " Mouse will use vim behavior
set hidden                         " To edit multiple buffers without save
set expandtab                      " Indent with white spaces
set tabstop=2                      " Indent spaces
set shiftwidth=2                   " Auto-indent spaces
set display+=lastline              " Show last line much as possible
set guioptions-=T                  " GUI without toolbar
set path+=**                       " Find recursive when use command :find or :tabfind
set wildignore+=**/node_modules/**,**/vendor/** " Excluding folder for :find and :tabfind commands
set directory=~/tmp,/var/tmp,/tmp  " Save .swp file in temporary directory
set exrc                           " Load current folder .vimrc config file
set secure                         " Prevent :autocmd files in current folder config file
set encoding=utf-8
set splitbelow                     " Always create splits below or to the right
set splitright                     " Always create splits below or to the right
set background=dark
set undofile                       " Vim undo persists after file is closed
set undodir=$HOME/.vimdid/         " Directory where state will be saved
set inccommand=nosplit             " Updates in realtime like :s/old/new
set ignorecase                     " Ignore word case on search
set scrolloff=3                    " M
set number relativenumber         " turn hybrid line numbers on
"set colorcolumn=80
set signcolumn=yes

"theme
colorscheme gruvbox
if has('termguicolors')
  set termguicolors
endif
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='base16_gruvbox_dark_hard'
let g:gruvbox_contrast_dark='hard'
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_diagnostic_line_highlight = 1
let g:gruvbox_material_better_performance = 1

"NERDTree Settings
let NERDTreeShowHidden=1

"FZF.vim settings
nnoremap <c-g> :Rg
nnoremap <space>rg :Rg <C-R>=expand("<cword>")<CR><CR>
" nnoremap <c-p> :Files<cr>

let g:fzf_layout = {'window': {'width':0.9,'height':0.8}}
let $FZF_DEFAULT_OPTS='--layout=reverse'
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!{.git/*,node_modules,vendor}"'
command! -bang -nargs=? -complete=dir Files 
  \ call fzf#vim#files(
  \   <q-args>, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)

function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case -- %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  letec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)
" REMOVE FZF.VIM

"use ctrl+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" increase decrease size of buffer panels using arrow keys
nnoremap <up> 10<C-W>+
nnoremap <down> 10<C-W>-
nnoremap <left> 3<C-W>>
nnoremap <right> 3<C-W><

let mapleader = ' '

"clipboard
nnoremap <leader>y "+y<CR> 
vnoremap <leader>y "+y<CR> 
nnoremap <leader>P "+P<CR> 
vnoremap <leader>P "+P<CR> 

"git-fugitive
nnoremap <silent> <leader>gs :G<CR> 
nnoremap <silent> <leader>gp <ESC>:G push<CR> 
nnoremap <silent> <leader>gB <ESC>:GBrowse<CR> 
nnoremap <silent> <leader>gb <ESC>:GBranches<CR> 
nnoremap <leader>gd :Gvdiffsplit<CR> 
nnoremap <leader>gl :diffget //3<CR>
nnoremap <leader>gh :diffget //2<CR>

"common 
nnoremap <silent> <esc> :noh<return><esc>
nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>N :NERDTreeFind<cr>
nnoremap <leader>hl :GitGutterLineNrHighlightsToggle<cr>
nnoremap <leader><tab> :buffers<CR>:buffer<Space>

"common edit/source nvim without exit to load
nnoremap <leader>edit :vsplit $MYVIMRC<cr>
nnoremap <leader>src :x<cr>:source $MYVIMRC<cr>

"common split horizontal/vertical
nnoremap <leader>sv :ls<cr>:vsp<space>\|<space>b<space>
nnoremap <leader>sh :ls<cr>:sp<space>\|<space>b<space>

"common to exit
nnoremap <silent> <A-q> :q<CR>
nnoremap <silent> <A-x> :x<CR>
nnoremap <silent> <A-w> :w<CR>
inoremap <silent> <A-q> <ESC>:q<CR>
inoremap <silent> <A-x> <ESC>:x<CR>
inoremap <silent> <A-w> <ESC>:w<CR>a

"enable/disable spell checking
nnoremap <silent> <leader>sp :set spell!<cr>

"coc section
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-json',
      \ 'coc-css',
      \ 'coc-emmet',
      \ 'coc-prettier',
      \ ]
let g:go_def_mapping_enable=0
nmap <leader>es :CocCommand eslint.executeAutofix<cr>
nmap <leader>pr :CocCommand prettier.formatFile<cr>
nmap <leader>cr :CocRestart<cr>

inoremap <silent><expr> <c-space> coc#refresh()
" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ca  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"poup mapping
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Show all diagnostics.
nnoremap <silent><nowait> <space>cd  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>ce  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>cc  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>co  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>cs  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>cn  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>cp  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>cl  :<C-u>CocListResume<CR>
"END COC SECTION

"Telescope settings - it uses dotfiles/scripts/lua/custom/telescope.lua
  lua require("custom")

  nnoremap <leader>sf <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr> 
  nnoremap <leader>sh :lua require('telescope.builtin').help_tags()<CR>
  nnoremap <leader>sc :lua require('telescope.builtin').colorscheme()<CR>
  nnoremap <leader>sb :lua require('telescope.builtin').builtin()<CR>
  nnoremap <leader>sd :lua require('custom.telescope').search_dotfiles()<CR>
  nnoremap <leader>sw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>")  }<CR>
  nnoremap <leader>sg :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")})<CR>
  nnoremap <C-p> :lua require('custom.telescope-find').find_files()<CR>
  nnoremap <space><Tab> :lua require('telescope.builtin').buffers()<CR>
"Telescope settings

"DAP settings
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <S-F11> :lua require'dap'.step_out()<CR>
nnoremap <silent> <leader>b :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <leader>B :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
"TELESCOPE DAP SETTINGS 
nnoremap <silent> <leader>tf :lua require'telescope'.extensions.dap.frames{}<CR>
nnoremap <silent> <leader>tc :lua require'telescope'.extensions.dap.commands{}<CR>
nnoremap <silent> <leader>tC :lua require'telescope'.extensions.dap.configurations{}<CR>
nnoremap <silent> <leader>tv :lua require'telescope'.extensions.dap.variables{}<CR>
nnoremap <silent> <leader>tb :lua require'telescope'.extensions.dap.list_breakpoints{}<CR>

"Copilot settings
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")


