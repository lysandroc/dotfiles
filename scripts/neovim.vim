lua require("core")
lua require("config")

"Telescope settings
nnoremap <leader>sf <cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files,--glob=!**/.git/*,--glob=!**/node_modules/*<cr> 
nnoremap <C-p> :lua require('config.telescope').find_files()<CR>
nnoremap <leader>sd :lua require('config.telescope').search_dotfiles()<CR>
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
