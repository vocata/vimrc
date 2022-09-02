" Specify the character encoding used in the script.
set fileencodings=utf-8,gbk
set encoding=utf-8
scriptencoding utf-8

" Uncomment the following to have Vim jump to the last position when       
" reopening a file                                                         
if has('autocmd')
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Plugins will be downloaded under the specified directory
call plug#begin('~/.vim/plugged')

" Declare the list of plugins
" for example: Plug 'your plugins'

Plug 'tpope/vim-sensible'
Plug 'yianwillis/vimcdoc'
Plug 'scrooloose/nerdtree', {'on': 'NERDTreeToggle'}
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'tpope/vim-commentary',
Plug 'tpope/vim-surround',
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
Plug 'Raimondi/delimitMate', {'for': ['python', 'cpp', 'c', 'go', 'rust', 'vim', 'asm', 'sh', 'zsh', 'make', 'cmake',]}
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'      "不能加后续选项，否则有bug
Plug 'terryma/vim-smooth-scroll'
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-signify'
Plug 'w0rp/ale',
Plug 'Valloric/YouCompleteMe'
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/asyncrun.vim'
Plug 'Shougo/echodoc.vim'
Plug 'Dimercel/todo-vim'
Plug 'zivyangll/git-blame.vim'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
Plug 'google/vim-glaive'
Plug 'google/vim-searchindex'
Plug 'junegunn/fzf', {'do': {->fzf#install()}}
Plug 'junegunn/fzf.vim'
Plug 'PeterRincker/vim-searchlight'

" Theme
Plug 'flazz/vim-colorschemes'
Plug 'sheerun/vim-polyglot'
Plug 'vim-airline/vim-airline-themes'
Plug 'dracula/vim', {'as': 'dracula'}

" List ends here. Plugins become visible to Vim after this call
call plug#end()

" -----basic configurations-----
" runtime
runtime ftplugin/man.vim    "较好地显示手册页的系统自带的插件

" colorscheme
" colorscheme space-vim-dark
" colorscheme molokai
" colorscheme monokai-phoenix
colorscheme dracula

" indent
set expandtab
set smarttab
set noshowmode
set tabstop=4
set shiftwidth=4
set softtabstop=4

" fold
set foldenable
set foldmethod=indent
set foldlevelstart=99

" spell check
" set spell
" set spelllang=en

" normal setting
set number
set incsearch
set hlsearch
set wildmenu
" set cursorcolumn
" set cursorline
set signcolumn=yes
set wildoptions=pum

" function

" map
noremap <silent><Leader>m :Man <cword><CR>
noremap <space> z
noremap <esc><esc> <esc>:nohls<CR>

" presetting autocmd
augroup pre_autocmd
    autocmd!
    autocmd FileType * set formatoptions-=cro  " 关闭自动注释
    autocmd BufRead,BufNewFile *.asm,*.s,*.S set filetype=asm
augroup end


" -----plug settings-----

" 1. nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-N> :NERDTreeToggle<CR>
nnoremap <C-M> :NERDTreeMirror<CR>
nnoremap <C-L> :NERDTreeFind<CR>
augroup nerdtree_settings
    " start NERDTree. If a file is specified, move the cursor to its window.
    " autocmd StdinReadPre * let s:std_in=1
    " autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

    " start NERDTree when Vim starts with a directory argument.
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
        \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

    " exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    " close the tab if NERDTree is the only window remaining in it.
    autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
        \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

    " open the existing NERDTree on each new tab.
    " autocmd BufEnter * if exists('b:NERDTree') | silent NERDTreeMirror | endif
augroup end
let g:NERDTreeWinPos='left'

" 2. undotree
noremap <silent><F4> :UndotreeToggle<CR>
let g:undotree_WindowLayout=3
let g:undotree_SetFocusWhenToggle=1

" 3. vim-commentary
augroup commentary_settings
    autocmd FileType python set commentstring=#\ %s   " 设置注释符号
    autocmd FileType c,cpp set commentstring=//\ %s   " 设置注释符号
    autocmd FileType asm set commentstring=;\ %s   " 设置注释符号
augroup end

" 4. vim-surround
" TODO

" 5. vim-speeddating
" TODO

" 6. vim-repeat
" TODO

" 7. vim-fugitive
" TODO

" 8. LeaderF
noremap <silent><Leader>lf :LeaderfFile<CR>
noremap <silent><Leader>lb :LeaderfBuffer<CR>
noremap <silent><Leader>lt :LeaderfFunction<CR>
noremap <silent><Leader>ll :LeaderfLine<CR>
let g:Lf_WindowPosition='popup'
let g:Lf_PreviewInPopup=1
let g:Lf_ShowDevIcons=0
let g:Lf_ShowHidden=1
let g:Lf_WindowHeight=0.3
let g:Lf_CacheDirectory=expand('$HOME/.cache/LfCache')
let g:Lf_StlSeparator={'left': '►', 'right': '◄', 'font': ''}
" let g:Lf_StlSeparator={'left': '', 'right': ''}
let g:Lf_StlColorscheme='one'

" 9. delimitMate
augroup delimit_settings
    autocmd FileType vim let b:delimitMate_quotes = "' `"   " vim的注释是双引号
augroup end
let g:delimitMate_expand_cr=1

" 11. vim-easy-align
xnoremap ga <Plug>(EasyAlign)
nnoremap ga <Plug>(EasyAlign)

" 12. vim-airline
" let g:airline_theme='luna'
" let g:airline_theme='dark'
" let g:airline_theme='molokai'
let g:airline_theme='dracula'
let g:airline_powerline_fonts=0
let g:airline#extensions#tabline#enabled=1

" 13. indentLine
let g:indentLine_char='┆'
let g:indentLine_first_char='┆'
let g:indentLine_showFirstIndentLevel=1
let g:indentLine_fileType=['python', 'cpp', 'c', 'go', 'rust', 'vim', 'sh', 'zsh',]

" 14. vim-smooth-scroll
noremap <silent><C-U> :call smooth_scroll#up(&scroll, 20, 2)<CR>
noremap <silent><C-D> :call smooth_scroll#down(&scroll, 20, 2)<CR>
noremap <silent><C-B> :call smooth_scroll#up(&scroll*2, 20, 4)<CR>
noremap <silent><C-F> :call smooth_scroll#down(&scroll*2, 20, 4)<CR>

" 15. vim-easymotion
" TODO

" 16. vim-signify
noremap <silent><Leader>d :SignifyHunkDiff<CR>
noremap <silent><Leader>u :SignifyHunkUndo<CR>

" 17. ale
nnoremap <silent><C-K> <Plug>(ale_previous_wrap)
nnoremap <silent><C-J> <Plug>(ale_next_wrap)
let g:ale_set_highlights=0
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_insert_leave=1
let g:ale_lint_on_enter=1
let g:ale_sign_error='->'
let g:ale_sign_warning='!'
let g:ale_linters_explicit=1    " 显示指定文件类型使用的linter
let g:ale_linters={'python': ['pylint'], 'c': ['clang'], 'cpp': ['clang'], 'go': ['staticcheck'], 'rust': ['cargo'], 'vim': ['vint']}
" 配置linter的选项"
let g:ale_c_clang_options='-Wall -O2 -std=gnu17'
let g:ale_cpp_clang_options='-Wall -O2 -std=gnu++17'

" 18. YouCompleteMe
noremap <silent><Leader>] :rightbelow vertical YcmCompleter GoTo<CR>
noremap <silent><Leader>[ :rightbelow vertical YcmCompleter GoToCallers<CR>
set completeopt=menu,menuone
let g:ycm_enable_semantic_highlighting=1                            " 打开语法高亮
let g:ycm_enable_inlay_hints=0                                      " 关闭内嵌提示
let g:ycm_clear_inlay_hints_in_insert_mode=0                        " 插入模式关闭内嵌提示
let g:ycm_show_diagnostics_ui=0                                     " 不使用YCM的代码检测功能，使用ale实现代码检测
let g:ycm_complete_in_strings=1                                     " 输入字符串也进行补全
let g:ycm_min_num_of_chars_for_completion=2                         " 启动补全的最小输入字符
let g:ycm_min_num_identifier_candidate_chars=0                      " 候选标识符长度，不作限制
let g:ycm_collect_identifiers_from_comments_and_strings=1           " 从注释和字符串中提取标识符用于补全
let g:ycm_semantic_triggers={'c,cpp,python,go,rust': ['re!\w{2}'],} " 开启语法补全，输入两个字符时开启
let g:ycm_confirm_extra_conf=0                                      " 确认查找到的额外配置文件，不确认
let g:ycm_goto_buffer_command='same-buffer'                         " 设置跳转的新窗口
" 若当前文件夹下没有配置文件，则加载全局配置文件
" let g:ycm_conf_path = findfile('.ycm_extra_conf.py', '.;')
" let g:ycm_global_ycm_extra_conf=g:ycm_conf_path

" 19. vim-gutentags
" set tags=./.tags;,.tags
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root=['.root', '.svn', '.git', '.hg', '.project']
" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile='.tags'
" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags=expand('$HOME/.cache/tags')
let g:gutentags_cache_dir=s:vim_tags
" 配置 ctags 的参数
let g:gutentags_ctags_extra_args=['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args+=['--c++-kinds=+px']
let g:gutentags_ctags_extra_args+=['--c-kinds=+px']
" 检测 ~/.cache/tags 不存在就新建
if !isdirectory(s:vim_tags)
    silent! call mkdir(s:vim_tags, 'p')
endif

" 20. asyncrun
let g:quickfix_height=15    " quickfix窗口的高度
let g:asyncrun_open=g:quickfix_height
let g:asyncrun_bell=0   " 提示音开
function! SetCompileOptions()
    noremap <silent><Leader>c :AsyncStop!<CR>
    noremap <silent><Leader>q :call asyncrun#quickfix_toggle(g:quickfix_height)<CR>
    augroup compile_settings
        autocmd!
        autocmd FileType c,cpp noremap <silent><Leader>M :w<CR>:AsyncRun make<CR>
        autocmd FileType c noremap <silent><Leader>B :w<CR>:AsyncRun clang -std=gnu17 -Wall -O2 $VIM_FILEPATH -o $VIM_FILEDIR/$VIM_FILENOEXT<CR>
        autocmd FileType cpp noremap <silent><Leader>B :w<CR>:AsyncRun clang++ -std=gnu++17 -Wall -O2 $VIM_FILEPATH -o $VIM_FILEDIR/$VIM_FILENOEXT<CR>
        autocmd FileType c,cpp noremap <silent><Leader>r :AsyncRun -raw -cwd=$VIM_FILEDIR $VIM_FILEDIR/$VIM_FILENOEXT<CR>
        autocmd FileType python noremap <silent><Leader>r :w<CR>:AsyncRun -raw python3 $VIM_FILEPATH<CR>
        autocmd FileType sh noremap <silent><Leader>r :w<CR>:AsyncRun -raw zsh $VIM_FILEPATH<CR>
        autocmd FileType go noremap <silent><Leader>B :w<CR>:AsyncRun go build $VIM_FILEDIR<CR>
        autocmd FileType go noremap <silent><Leader>r :w<CR>:AsyncRun go run $VIM_FILEDIR<CR>
        autocmd FileType go noremap <silent><Leader>t :w<CR>:AsyncRun go test -v -cover -count=1 -run .<CR>
        autocmd FileType go noremap <silent><Leader>tf :w<CR>:AsyncRun go test -v -cover -count=1 -run $VIM_CWORD<CR>
    augroup end
endfunction
call SetCompileOptions()

" 21. echodoc
let g:echodoc_enable_at_startup=1

" 22. todo-vim
noremap <silent><F5> :TODOToggle<CR>

" 23. git-blamer
nnoremap gb :call gitblame#echo()<CR>

" 24. vim-codefmt
augroup autoformat_settings
    " autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
    " autocmd FileType dart AutoFormatBuffer dartfmt
    autocmd FileType go AutoFormatBuffer gofmt
    " autocmd FileType gn AutoFormatBuffer gn
    " autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
    " autocmd FileType java AutoFormatBuffer google-java-format
    autocmd FileType python AutoFormatBuffer black
    " Alternative: autocmd FileType python AutoFormatBuffer autopep8
    autocmd FileType rust AutoFormatBuffer rustfmt
    " autocmd FileType vue AutoFormatBuffer prettier
    " autocmd FileType swift AutoFormatBuffer swift-format
    autocmd FileType sh AutoFormatBuffer shfmt
augroup end

" 25. vim-glaive
" TODO required by codefmt

" 26. vim-searchindex
" TODO

" 27. fzf
" TODO official fzf plugin providing basic wrapper fucntions

" 28. fzf.vim
" TODO fzf wrapper, provide more wrapper fzf functions for vim

" 29. vim-searchlight
highlight link Searchlight Incsearch



" " -----tips-----
" " Put these lines at the very end of your vimrc file.

" " Load all plugins now.
" " Plugins need to be added to runtimepath before helptags can be generated.
" packloadall
" " Load all of the helptags now, after plugins have been loaded.
" " All messages and errors will be ignored.

" silent! helptags ALL
