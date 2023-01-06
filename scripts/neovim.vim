let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

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
" Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' } "golang
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
" THEME
Plug 'morhetz/gruvbox'

" common
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'numToStr/Comment.nvim'

Plug 'nvim-lualine/lualine.nvim'
" Plug 'kyazdani42/nvim-web-devicons'
Plug 'SmiteshP/nvim-navic'

Plug 'mattn/emmet-vim'
Plug 'b0o/schemastore.nvim'
"telescope stuffs
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim' "It is also used in mason/js-debug-adapter
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'p00f/nvim-ts-rainbow', {'do': ':TSUpdate'} 

"cmp/lsp/mason/dap
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim'
Plug 'williamboman/mason-lspconfig.nvim'
Plug 'mfussenegger/nvim-dap'
Plug 'mxsdev/nvim-dap-vscode-js'
Plug 'mortepau/codicons.nvim'
Plug 'rcarriga/nvim-dap-ui' 
Plug 'jose-elias-alvarez/typescript.nvim' " extends tsserver lsp with more commands
Plug 'folke/neodev.nvim'
Plug 'theHamsta/nvim-dap-virtual-text'
Plug 'nvim-telescope/telescope-dap.nvim'

Plug 'jameshiew/nvim-magic'
Plug 'MunifTanjim/nui.nvim'

Plug  'github/copilot.vim'

call plug#end()

lua require("core.options")

"NERDTree Settings
let NERDTreeShowHidden=1

"FZF.vim settings
" nnoremap <c-g> :Rg
" nnoremap <c-p> :Files<cr>
nnoremap <space>/ :Rg<space>
nnoremap <space>rg :Rg <C-R>=expand("<cword>")<CR><CR>

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
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

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
nnoremap <silent><leader>n :NERDTreeToggle<cr>
nnoremap <silent><leader>N :NERDTreeFind<cr>
nnoremap <leader>hl :GitGutterLineNrHighlightsToggle<cr>
"change buffer, the native way
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

lua require("plugins")

" Copilot settings
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <space><Tab> copilot#Accept("\<CR>")

"Telescope settings
nnoremap <leader>sf <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<cr> 
nnoremap <C-p> :lua require('plugins.telescope').find_files()<CR>
nnoremap <leader>sd :lua require('plugins.telescope').search_dotfiles()<CR>
nnoremap <space><Tab> :lua require('telescope.builtin').buffers()<CR>
nnoremap <leader>sw :lua require('telescope.builtin').grep_string { search = vim.fn.expand("<cword>")  }<CR>
nnoremap <leader>sg :lua require('telescope.builtin').grep_string({ search = vim.fn.input("Grep for > ")})<CR>
nnoremap <leader>sh :lua require('telescope.builtin').help_tags()<CR>
nnoremap <leader>sc :lua require('telescope.builtin').colorscheme()<CR>
nnoremap <leader>sb :lua require('telescope.builtin').builtin()<CR>

"DAP settings
nnoremap <silent> <F5> :lua require'dap'.continue()<CR>
nnoremap <silent> <F10> :lua require'dap'.step_over()<CR>
nnoremap <silent> <F11> :lua require'dap'.step_into()<CR>
nnoremap <silent> <S-F11> :lua require'dap'.step_out()<CR>
nnoremap <silent> <F9> :lua require'dap'.toggle_breakpoint()<CR>
nnoremap <silent> <S-F9> :lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>
nnoremap <silent> <leader>lp :lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
nnoremap <silent> <leader>dr :lua require'dap'.repl.open()<CR>
nnoremap <silent> <leader>dl :lua require'dap'.run_last()<CR>
"NVIM-DAP-UI
nnoremap <silent> <leader>dapo :lua require("dapui").open()<CR>
nnoremap <silent> <leader>dapc :lua require("dapui").close()<CR>
nnoremap <silent> <leader>dapt :lua require("dapui").toogle()<CR>

"TELESCOPE WITH DAP SETTINGS 
nnoremap <silent> <leader>tf :lua require'telescope'.extensions.dap.frames{}<CR>
nnoremap <silent> <leader>tc :lua require'telescope'.extensions.dap.commands{}<CR>
nnoremap <silent> <leader>tC :lua require'telescope'.extensions.dap.configurations{}<CR>
nnoremap <silent> <leader>tv :lua require'telescope'.extensions.dap.variables{}<CR>
nnoremap <silent> <leader>tb :lua require'telescope'.extensions.dap.list_breakpoints{}<CR>

" test delete later
" noremap <leader>dh :lua require'dap'.toggle_breakpoint)<CR> 
" noremap <S-k> :lua require 'dap'.step_out ()<CR> 
" noremap <S-1> :lua require'dap'.step_into()<CR> 
" noremap <S-j> :lua require'dap'.step_over() <CR> 
" noremap <leader>dn :lua require'dap'.continue() <CR> 
" noremap <Leader>d_ :lua require'dap'.run_last() <CR> 
" noremap <leader>dr :lua require'dap'.repl.open({}, 'vsplit')<CR><C-w>l
" noremap <leader>di :lua require'dap.ui.variables'.hover.(function () return vim.fn.expand("<cexpr›") end)<CR> 
" vnoremap <Leader>di :lua require'dap.ui.variables'.visual_hover()<CR> 
" noremap <Leader>d? :lua require'dap.ui.variables'.scopes()<CR> 
" noremap <leader>de :lua require'dap'.set_exception_breakpoints({"all"}) <CR>
" " noremap <leader>da :lua require'debugHelper'.attach()<CR>
