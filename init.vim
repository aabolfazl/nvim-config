
let mapleader=" "
set tabstop=4
set shiftwidth=4
set expandtab
set hidden

"set clipboard=unnamedplus
"set cursorline
set number
set relativenumber
set ignorecase
set smartcase

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

luafile ~/.config/nvim/lua/init.lua


set rtp+=/bin/
noremap <leader>fz :FZF<cr>

"autocmd BufWritePre * %s/\s\+$//e
"autocmd BufWritePre * %s/\n\+\%$//e


map <A-h> <C-w>h
map <A-j> <C-w>j
map <A-k> <C-w>k
map <A-l> <C-w>l

map <leader>s :setlocal spell! spelllang=en_us<CR>

map <leader>i :setlocal autoindent<CR>
map <leader>I :setlocal noautoindent<CR>



autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <C-Tab> <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

autocmd FileType c,h,cpp,hpp nnoremap <buffer> <silent> <leader>gh :ClangdSwitchSourceHeader<CR>
"nnoremap <C-n> :NvimTreeToggle<CR>

let g:indentLine_char = '│'


let g:airline_theme = 'dark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail'

colorscheme dracula-soft
set noshowmode


map <leader>m :w! \| !gcc "<c-r>%"
autocmd filetype python nnoremap <F4> :w <bar> exec '!python '.shellescape('%')<CR>
autocmd filetype c nnoremap <F4> :w <bar> exec '!gcc '.shellescape('%').' -o '.shellescape('%:r').' && '.shellescape(expand('%:p:r'))<CR>
autocmd filetype cpp nnoremap <F4> :w <bar> exec '!g++ '.shellescape('%').' -o '.shellescape('%:r').' && '.shellescape(expand('%:p:r'))<CR>
autocmd filetype c nnoremap <c-F4> :w <bar> exec '!gcc -g '.shellescape('%').' -o '.shellescape('%:r').' && '.shellescape(expand('%:p:r'))<CR>
autocmd filetype cpp nnoremap <c-F4> :w <bar> exec '!g++ -g '.shellescape('%').' -o '.shellescape('%:r').' && '.shellescape(expand('%:p:r'))<CR>
nnoremap <leader>bb <cmd>BufferLinePick<cr>

nnoremap <silent> gb :BufferLinePick<CR>

nmap <leader>l :bn<CR>
nmap <leader>h :bp<CR>
nmap <C-q> :bp <BAR> bd #<CR>
nmap <leader>bl :buffers<cr>:b<space>


set guifont=Hack\ 12
set encoding=UTF-8
let g:airline_powerline_fonts = 1


" MarkdownPreview
let g:mkdp_auto_start = 1
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']
let g:mkdp_theme = 'dark'
nnoremap <C-s> <Plug>MarkdownPreview
nnoremap <M-s> <Plug>MarkdownPreviewStop
nnoremap <C-p> <Plug>MarkdownPreviewToggle


nnoremap <leader>ct :TagbarToggle<CR>
nnoremap <leader>a :AerialToggle!<CR>

let $PYTHONPATH="/usr/lib/llvm-14/lib/python3.10/dist-packages" . $PYTHONPATH

hi BlackOnLightYellow guifg=#000000 guibg=#f2de91
