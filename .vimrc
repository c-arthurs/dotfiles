set t_Co=256
set mouse=a
set number
set spell 
set spelllang=en
set relativenumber
set hlsearch
" clear the last hlsearch with the spacebar 
map <Space> :noh<cr>
" makes sure the tab line is at top of page with filename
set showtabline=2

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')

" Declare the list of plugins.
Plug 'morhetz/gruvbox'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

colorscheme gruvbox
set background=dark
syntax on

if system('uname -s') == "Darwin\n"
  set clipboard=unnamed "OSX
else
  set clipboard=unnamedplus "Linux
endif

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


