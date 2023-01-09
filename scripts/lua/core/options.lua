local opt = vim.opt

opt.termguicolors=true                  -- Enable 24-bit RGB colors
opt.encoding="utf-8"                    -- The encoding displayed
opt.number=true                         -- Line numbers
opt.relativenumber=true                 -- turn hybrid line numbers on
opt.spelllang="en_us"                   -- dictionary
opt.linebreak=true                      -- Break line without break word
opt.smartcase=true                      -- If have any uppercase, active case sensitive
opt.ignorecase=true                     -- Ignore word case on search
opt.gdefault=true                       -- Always substitute all letters, dont just first
opt.smartindent=true                    -- Auto-indent
opt.cursorline=true                     -- Active line with other color
opt.incsearch=true                      -- Find when you typing
opt.tags:append(".tags", ".git/tags")   -- Use ctags file in current directory or parent
opt.backspace="2"        -- Default backspace behaviour
--opt.backspace="indent,eol,start"        -- Default backspace behaviour
opt.wildmode="full"                     -- Command complete display all list
opt.mouse="a"                           -- Mouse will use vim behavior
opt.hidden=true                         -- To edit multiple buffers without save
opt.expandtab=true                      -- Indent with white spaces
opt.tabstop=2                           -- Indent spaces
opt.shiftwidth=2                        -- Auto-indent spaces
opt.display:append("lastline")          -- Show last line much as possible
opt.path:append("**")                   -- Find recursive when use command :find or :tabfind
opt.wildignore:append("**/node_modules/**","**/vendor/**")  -- Excluding folder for :find and :tabfind commands
opt.directory:append("~/tmp","/var/tmp","/tmp")             -- Save .swp file in temporary directory
opt.exrc=true                           -- Load current folder .vimrc config file
opt.secure=true                         -- Prevent :autocmd files in current folder config file
opt.splitbelow=true                     -- Always create splits below or to the right
opt.splitright=true                     -- Always create splits below or to the right
opt.background="dark"                   -- Dark background
opt.undofile=true                       -- Vim undo persists after file is closed
opt.undodir=os.getenv("HOME")..'/.vimdid/'  -- Directory where state will be saved
opt.inccommand="nosplit"                -- Updates in realtime like :s/old/new
opt.scrolloff=3                         -- Lines of context         
opt.signcolumn="yes"                     -- Always show the signcolumn, otherwise it would shift the text each time
-- opt.iskeyword:append("-")               -- Treat separated words as a word text object
--opt.colorcolumn=80
--opt.clipboard:append('unnamedplus')     -- Copy and paste to system clipboard

-- retrocompatibility with my previous vimconf file
vim.cmd('set wildchar=<Tab> wildmenu')  -- Autocomplete commands on command mode
vim.cmd("set guioptions-=T")            -- GUI without toolbar