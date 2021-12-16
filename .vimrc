set t_Co=256
set mouse=a
set number
set spell 
set spelllang=en
set relativenumber
set hlsearch
set encoding=UTF-8
set backspace=indent,eol,start
" make a line at 80 charicters to show pep8 wralp size
set colorcolumn=80
" clear the last hlsearch with the spacebar 
map <Space> :noh<cr>
" makes sure the tab line is at top of page with filename
set showtabline=2
" spelling limited so doesnt take up whole screen - call using z= 
set spellsuggest+=10
command Bang :call append(0, "#!/usr/bin/env bash")
command PyBang :call append(0, "#!/usr/bin/env python")
command Main :call append(line('$'), "if __name__ == \"__main__\":")
command Marker :call append(line('.')-1, "### >>>>>>>>>>> ERROR HERE <<<<<<<<<<<< ###")

command Latex :%s/{ /{/ge | %s/ }/}/ge | %s/&/\\&/ge | %s/%/\\%/ge | %s/\$/\\$/ge | %s/κ/$\\kappa$/ge | %s/β/$\\upbeta$/ge | %s/α/$\\alpha$/ge | %s/μ/$\\upmu$/ge | %s/^Chapter \d\t/\\chapter{/ge | %s/^\d\+\.\d\+\.\d\+\.\d\+\.\d\+\t/\\paragraph{/ge | %s/^\d\+\.\d\+\.\d\+\.\d\+\t/\\subsubsection{/ge | %s/^\d\+\.\d\+\.\d\+\t/\\subsection{/ge | %s/^\d\+\.\d\+\t/\\section{/ge | :execute 'g/^\\chapter{/:exe "norm A}"' | :execute 'g/ection{/:exe "norm A}"' | :execute 'g/agraph{/:exe "norm A}"' | :execute'g/^\\label/:-1j' | %s/\%u2003/ /ge | %s/\. \\citep/\. \\citet/ge | %s/\, \\citep/\, \\citet/ge | %s/\ and \\citep/\ and \\citet/ge | %s/\ by \\citep/\ by \\citet/ge | %s/\ in \\citep/\ in \\citet/ge | %s/^\\citep/\\citet/ge | %s/\\texorpdfstring{\\$\\upbeta\\\$/\\texorpdfstring{\$\\upbeta$

" can add a search for \. \\citep to replace it with citet
command Bibtex :%s/\%u03B2/$\\upbeta$/ge | %s/\%u03B1/$\\alpha$/ge | %s/&/\\&/ge

nnoremap <leader>r :!%:p<Enter>
" This just gueses the spelling of the word under cursor
autocmd filetype python nnoremap <leader>r :w <Enter> :!python %:p<Enter>
nmap <Leader>z 1z=

" Plugins will be downloaded under the specified directory.
call plug#begin('~/.vim/plugged')
" for auto making documentation strings for python functions
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
" this works by hitting leader \ then d when hovering over a function name

" Declare the list of plugins.
Plug 'morhetz/gruvbox'

Plug 'bryanmylee/vim-colorscheme-icons'

" for autocompletion 
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" List ends here. Plugins become visible to Vim after this call.
" to install plugs then run :PlugInstall
" to install coc plugins rin :CocInstall 
" install python for coc :CocInstall coc-pyright
" install bash for coc :CocInstall coc-sh
" coc might also need node.js . install with curl -sL install-node.now.sh/lts | bash
" vim +"CocInstall coc-pyright" +"CocInstall coc-sh"
" for the file system
Plug 'preservim/nerdtree'
" for the git nerdtree plugin
Plug 'preservim/nerdtree' |
            \ Plug 'Xuyuanp/nerdtree-git-plugin'
" for the icons next to file types
Plug 'ryanoasis/vim-devicons'

Plug 'christoomey/vim-tmux-navigator'

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

" ------------ coc presets ------------
" TextEdit might fail if hidden is not set.
set hidden
" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
" Don't pass messages to |ins-completion-menu|.
set shortmess+=c
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
			      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)
" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif
" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')
" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ------------ nerdtree settings -------------------
nnoremap <leader>n :NERDTreeFocus<CR>
" nnoremap <C-n> :NERDTree<CR>
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

let NERDTreeShowHidden=1

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror

" ------------ nerdtree git plugin settings --------

let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
                \ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }

let g:NERDTreeGitStatusConcealBrackets = 1 " default: 0

