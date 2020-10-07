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
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'morhetz/gruvbox'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'tpope/vim-surround'
Plug 'sainnhe/gruvbox-material'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"
"Plug 'leafgarland/typescript-vim'
"Plug 'peitalin/vim-jsx-typescript'
call plug#end()

set number                         " Line numbers
" set spell                        " disable by default
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
set wildignore+=**/node_modules/** " Excluding folder for :find and :tabfind commands
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

colorscheme gruvbox
if has('termguicolors')
  set termguicolors
endif

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='base16_gruvbox_dark_hard'

let g:gruvbox_contrast_dark='hard'
let g:gruvbox_material_background = 'hard'

let g:fzf_layout = {'window': {'width':0.8,'height':0.8}}
let $FZF_DEFAULT_OPTS='--reverse'
"let $FZF_DEFAULT_COMMAND = 'rg --files' "using fd
" FZF + ripgrep will not consider filename as a match in Vim.
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
command! -bang -nargs=* Rg call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

"
" use alt+hjkl to move between split/vsplit panels
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

nnoremap <up> 10<C-W>+
nnoremap <down> 10<C-W>-
nnoremap <left> 3<C-W>>
nnoremap <right> 3<C-W><

nnoremap <c-g> :Rg<cr>
nnoremap <space>g :Rg <C-R>=expand("<cword>")<CR><CR>
nnoremap <c-p> :FZF<cr>

let mapleader = ' '

nnoremap <leader>gs :G<CR> 
nnoremap <leader>gd :Gvdiffsplit<CR> 
nnoremap <leader>gr :diffget //3<CR>
nnoremap <leader>gl :diffget //2<CR>

nnoremap <leader>n :NERDTreeToggle<cr>
nnoremap <leader>N :NERDTreeFind<cr>
nnoremap <leader>edit :vsplit $MYVIMRC<cr>
nnoremap <leader>src :x<cr>:source $MYVIMRC<cr>
nnoremap <leader>hl :GitGutterLineNrHighlightsToggle<cr>
nnoremap <leader>h :History<cr>
nnoremap <leader>b :buffers<CR>:buffer<Space>
"split horizontal/vertical
nnoremap <leader>sv :ls<cr>:vsp<space>\|<space>b<space>
nnoremap <leader>sh :ls<cr>:sp<space>\|<space>b<space>
"enable/disable spell checking
nnoremap <silent> <leader>sp :set spell!<cr>
inoremap <silent> <leader>sp <C-O>:set spell!<cr>
 
"coc section
let g:coc_global_extensions = [
      \ 'coc-tsserver',
      \ 'coc-eslint',
      \ 'coc-go',
      \ 'coc-json',
      \ 'coc-css',
      \ 'coc-emmet',
      \ 'coc-prettier',
      \ ]
let g:go_def_mapping_enable=0

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
nmap <leader>ac  <Plug>(coc-codeaction)
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
