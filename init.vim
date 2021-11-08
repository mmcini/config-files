" ########################################
" #### Nvim plugins             ##########
" ########################################

call plug#begin(stdpath('config') . '/plugged')
" language related
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/nvim-cmp'
Plug 'lervag/vimtex'
Plug 'cohama/lexima.vim'
" file/search related
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'chrisbra/csv.vim'
" aesthetics
Plug 'arcticicestudio/nord-vim'
Plug 'Mofiqul/dracula.nvim'
Plug 'mhinz/vim-startify'
Plug 'norcalli/nvim-colorizer.lua'
call plug#end()

" ########################################
" #### Shell config         ##############
" ########################################

set shell=/usr/bin/zsh
set termguicolors
set shellcmdflag=-ic

" ########################################
" #### LSP server and cmp   ##############
" ########################################
 
set completeopt=menu,menuone,noselect

lua <<EOF
  -- Setup nvim-cmp.
  local cmp = require'cmp'
  cmp.setup({
    mapping = {
      ['<Tab>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<S-Tab>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'buffer' },
    }
  })

  -- Setup lspconfig.
  require'lspconfig'.texlab.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
  require'lspconfig'.r_language_server.setup {
    capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  }
EOF

" ######################################## 
" #### lines and indent         #########
" ########################################

filetype plugin indent on        " File-dependent indent options
set number                       " adds line numbers
set backspace=indent,eol,start   " To make backscape work in all conditions.
set encoding=utf-8
set expandtab                    " To enter spaces when tab is pressed.
set tabstop=4                    " show existing tab with 4 spaces width
set shiftwidth=4                 " when indenting with '>', use 4 spaces width
set expandtab                    " On pressing tab, insert 4 spaces
set smarttab                     " Insert “tabstop” number of spaces when the
                                 "  “tab” key is pressed.
set autoindent                   " To copy indentation from current line 
                                 "  when starting a new line.

" ######################################## 
" #### Nvim-R settings          ##########
" ########################################
 
autocmd TermOpen * setlocal nonumber "no number in console
autocmd TermOpen * setlocal winfixheight " prevent console resize
let R_rconsole_width = 0
let R_rconsole_height = 10
let R_assign = 1
let g:rout_follow_colorscheme = 1
let g:Rout_more_colors = 1

" ########################################
" #### csv.vim          ##################
" ########################################

filetype plugin on

" ########################################
" #### vimTeX           ##################
" ########################################

let g:vimtex_general_viewer='zathura'
let g:Tex_MultipleCompileFormats='pdf,bib,pdf'
map <F5> :setlocal spell! spelllang=en_us<CR>
map <F6> :setlocal spell! spelllang=pt<CR>

" ########################################
" #### nvim mappings     #################
" ########################################

" # sets current file dir as working dir
nnoremap <F11> :cd %:h<Cr>
" # deletes backwards in insert mode
inoremap <C-d> <Del>

" ########################################
" #### Nvimtree mappings    ##############
" ########################################

lua require'nvim-tree'.setup()

let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }

" Dictionary of buffer option names mapped to a list of option values that
" indicates to the window picker that the buffer's window should not be
" selectable.

" List of filenames that gets highlighted with NvimTreeSpecialFile
let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 } 
let g:nvim_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 1,
    \ 'files': 0,
    \ 'folder_arrows': 0,
    \ }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" ########################################
" #### Treesitter       ##################
" ########################################

lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,          -- false will disable the whole extension
  },
}
EOF

" ########################################
" #### Telescope        ##################
" ########################################

lua <<EOF
require('telescope').setup{
  pickers = {
    find_files = {
      follow = true,
    }
  }
}
EOF

" Find files using Telescope command-line sugar.
nnoremap <leader><space>f <cmd>Telescope find_files<cr>
nnoremap <leader><space>g <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" ########################################
" #### Startify         ##################
" ########################################

let s:startify_ascii_header = [
 \ '                                        ▟▙            ',
 \ '                                        ▝▘            ',
 \ '██▃▅▇█▆▖  ▗▟████▙▖   ▄████▄   ██▄  ▄██  ██  ▗▟█▆▄▄▆█▙▖',
 \ '██▛▔ ▝██  ██▄▄▄▄██  ██▛▔▔▜██  ▝██  ██▘  ██  ██▛▜██▛▜██',
 \ '██    ██  ██▀▀▀▀▀▘  ██▖  ▗██   ▜█▙▟█▛   ██  ██  ██  ██',
 \ '██    ██  ▜█▙▄▄▄▟▊  ▀██▙▟██▀   ▝████▘   ██  ██  ██  ██',
 \ '▀▀    ▀▀   ▝▀▀▀▀▀     ▀▀▀▀       ▀▀     ▀▀  ▀▀  ▀▀  ▀▀',
 \ '',
 \]

let g:startify_custom_header = startify#center(s:startify_ascii_header +
        \ startify#fortune#quote())

" ########################################
" #### Colorizer        ##################
" ########################################

lua require'colorizer'.setup()

" ########################################
" #### Color schemes    ##################
" ########################################

" colorscheme dracula
colorscheme nord

" highlight Normal guibg=none " allows the bg
" highlight NonText guibg=none " to be transparent

" line number color
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE 
       \ gui=NONE guifg=#8BE9FD guibg=#585858
