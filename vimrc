" Specify the character encoding used in the script.
set fileencodings=utf-8,gbk
set encoding=utf-8
scriptencoding utf-8

" Uncomment the following to have Vim jump to the last position when
" reopening a file
if has('autocmd')
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Plugins will be downloaded under the specified directory
call plug#begin('~/.vim/plugged')

" Declare the list of plugins
" for example: Plug 'your plugins'

" Plug 'tpope/vim-sensible'
Plug 'yianwillis/vimcdoc'
Plug 'scrooloose/nerdtree',
Plug 'mbbill/undotree', {'on': 'UndotreeToggle'}
Plug 'tpope/vim-commentary',
Plug 'tpope/vim-surround',
Plug 'tpope/vim-speeddating'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/LeaderF', {'do': './install.sh'}
Plug 'Raimondi/delimitMate', {'for': ['python', 'c', 'cpp', 'go', 'rust', 'sh', 'zsh', 'vim', 'asm', 'make', 'cmake']}
Plug 'junegunn/vim-easy-align'
Plug 'vim-airline/vim-airline'
" Plug 'Yggdroot/indentLine'       " 缩进线，有bug，停用
" Plug 'terryma/vim-smooth-scroll' " 顺滑滚动，增加渲染时间，停用
Plug 'easymotion/vim-easymotion'
Plug 'mhinz/vim-signify'
Plug 'w0rp/ale'
Plug 'Valloric/YouCompleteMe'
" Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/asyncrun.vim'
Plug 'Shougo/echodoc.vim'
Plug 'Dimercel/todo-vim'
Plug 'zivyangll/git-blame.vim'
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt', {'for': ['python', 'c', 'cpp', 'go', 'rust', 'sh', 'zsh']}
Plug 'google/vim-glaive'
" Plug 'google/vim-searchindex'                  " 显示第几个搜索结果，airline中有类似功能，停用
" Plug 'junegunn/fzf', {'do': {->fzf#install()}} " fzf的vim插件，使用LeaderF做模糊搜索，停用
" Plug 'junegunn/fzf.vim'                        " 在vim中提供更多fzf相关的快捷操作，使用LeaderF做模糊搜索，停用
Plug 'PeterRincker/vim-searchlight'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'iamcco/markdown-preview.nvim', {'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'preservim/vim-markdown', {'for': 'markdown'}
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'MattesGroeger/vim-bookmarks'
Plug 'mhinz/vim-startify'

" Theme
" Plug 'sheerun/vim-polyglot' " 多语言高亮包，使用YCM语法高亮，停用
Plug 'sainnhe/sonokai'      " sonokai配色
Plug 'sainnhe/edge'         " edge配色
Plug 'ryanoasis/vim-devicons'

" List ends here. Plugins become visible to Vim after this call
call plug#end()

" -----basic configurations-----
" runtime
runtime ftplugin/man.vim "较好地显示手册页的系统自带的插件

" colorscheme
" important!!
if has('termguicolors')
    set termguicolors " 24位色
endif
set background=dark

let g:sonokai_style='atlantis' " default/atlantis/andromeda/shusia/maia/espresso
let g:sonokai_better_performance=1
colorscheme sonokai

" let g:edge_style='default' " default/aura/neon
" let g:edge_better_performance=1
" colorscheme edge

" indent
set backspace=2   " 使用delimitMate括号展开必须选项
set expandtab     " 插入时用空格替换tab字符
set smarttab      " 默认使用智能缩进
set noshowmode    " 不展示当前vim处于哪种模式，状态栏中已有这个信息
set tabstop=4     " 输入tab时表示的空格数
set shiftwidth=4  " 自动缩进时使用的空白数目，例如>>操作。设置为0时，使用tabstop的值
set softtabstop=4 " 用于文本展示，例如tabstop=8，如果设置softtabstop=4，展示的tab也是4个空格的宽度

" fold
set foldenable
set foldmethod=indent
set foldlevelstart=99

" spell check
" set spell
" set spelllang=en

" normal setting
if has('mouse')
    set mouse=a
endif
set number
set incsearch
set hlsearch
set wildmenu
" set cursorcolumn
set cursorline
set signcolumn=yes
set updatetime=1200 " YCM需要多少毫秒弹出popup
if v:version >= 900
    set wildoptions=fuzzy,pum
endif

" function
" TODO

" map
nnoremap <space><space> za
nnoremap <silent><esc><esc> <esc>:nohls<CR>
nnoremap <silent><C-H> :wincmd h<CR>
nnoremap <silent><C-J> :wincmd j<CR>
nnoremap <silent><C-k> :wincmd k<CR>
nnoremap <silent><C-L> :wincmd l<CR>

" presetting autocmd groups
augroup filetype_settings
    autocmd BufRead,BufNewFile *.asm,*.s,*.S set filetype=asm
    autocmd FileType * set formatoptions-=cro " 关闭自动注释
augroup end


" -----plug settings-----

" 1. nerdtree
nnoremap <silent><space>nl :NERDTreeFind<CR>
nnoremap <silent><space>nt :NERDTreeToggle<CR>
augroup nerdtree_settings
    " start NERDTree. If a file is specified, move the cursor to its window.
    " autocmd StdinReadPre * let s:std_in=1
    " autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

    " start NERDTree when Vim starts with a directory argument.
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
        \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

    " exit Vim if NERDTree is the only window remaining in the only tab.
    " autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
    " close the tab if NERDTree is the only window remaining in it.
    " autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    " if another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
    " autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    "     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

    " open the existing NERDTree on each new tab.
    " autocmd BufEnter * if exists('b:NERDTree') | silent NERDTreeMirror | endif

    " disable signcolumn
    autocmd FileType nerdtree setlocal signcolumn=no
augroup end
let g:NERDTreeWinPos='left'
" let g:NERDTreeMinimalMenu=1

" 2. undotree
nnoremap <silent><space>ud :UndotreeToggle<CR>
let g:undotree_WindowLayout=3
let g:undotree_SetFocusWhenToggle=1

" 3. vim-commentary
augroup commentary_settings
    autocmd FileType c,cpp set commentstring=//\ %s " 设置注释符号
    autocmd FileType asm set commentstring=;\ %s    " 设置注释符号
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
noremap <silent><leader>f :<C-U><C-R>=printf("Leaderf file %s", "")<CR><CR>
noremap <silent><leader>t :<C-U><C-R>=printf("Leaderf function %s", "")<CR><CR>
noremap <silent><leader>l :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <silent><leader>b :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <silent><leader>m :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <silent><leader>h :<C-U><C-R>=printf("Leaderf help %s", "")<CR><CR>
noremap <silent><leader>s :<C-U><C-R>=printf("Leaderf searchHistory %s", "")<CR><CR>
noremap <silent><leader>c :<C-U><C-R>=printf("Leaderf cmdHistory %s", "")<CR><CR>
noremap <silent><leader>w :<C-U><C-R>=printf("Leaderf rg -e %s ", expand("<cword>"))<CR><CR>
noremap <silent><leader>a :<C-U><C-R>=printf("Leaderf rg --case-insensitive %s", "")<CR><CR>
noremap <silent><leader>u :<C-U>Leaderf --recall<CR>
let g:Lf_WindowPosition='popup'
let g:Lf_PreviewInPopup=1
let g:Lf_ShowDevIcons=1
let g:Lf_ShowHidden=1
let g:Lf_WindowHeight=0.3
" let g:Lf_StlSeparator={'left': '►', 'right': '◄', 'font': ''}
" let g:Lf_StlSeparator={'left': '', 'right': ''}
" let g:Lf_StlSeparator = { 'left': '', 'right': '' }
let g:Lf_StlSeparator = { 'left': '', 'right': '' }
" let g:Lf_StlColorscheme='one'
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_CacheDirectory=expand('$HOME/.cache/LfCache')

" 9. delimitMate
augroup delimit_settings
    autocmd FileType vim let b:delimitMate_quotes = "' `"   " vim的注释是双引号
augroup end
let g:delimitMate_expand_cr=1

" 11. vim-easy-align
xnoremap ga <plug>(EasyAlign)
nnoremap ga <plug>(EasyAlign)

" 12. vim-airline
let g:airline_theme='sonokai'
" let g:airline_theme='edge'
let g:airline_left_sep=''
let g:airline_left_alt_sep = ''
let g:airline_right_sep=''
let g:airline_right_alt_sep = ''
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#show_buffers=1
let g:airline#extensions#tabline#tab_min_count=1
let g:airline#extensions#tabline#show_tab_nr=0

" 13. indentLine
" let g:indentLine_char='┆'
" let g:indentLine_first_char='┆'
" let g:indentLine_showFirstIndentLevel=1
" let g:indentLine_fileType=['python', 'cpp', 'c', 'go', 'rust', 'vim', 'sh', 'zsh',]

" 14. vim-smooth-scroll
" noremap <silent><C-U> :call smooth_scroll#up(&scroll, 20, 4)<CR>
" noremap <silent><C-D> :call smooth_scroll#down(&scroll, 20, 4)<CR>
" noremap <silent><C-B> :call smooth_scroll#up(&scroll*2, 20, 6)<CR>
" noremap <silent><C-F> :call smooth_scroll#down(&scroll*2, 20, 6)<CR>

" 15. vim-easymotion
" TODO

" 16. vim-signify
nnoremap <silent><space>gd :SignifyHunkDiff<CR>
nnoremap <silent><space>gu :SignifyHunkUndo<CR>
nnoremap <silent><space>gj <plug>(signify-next-hunk)
nnoremap <silent><space>gk <plug>(signify-prev-hunk)
let g:signify_sign_change='#'

" 17. ale
nnoremap <silent><space>wj <plug>(ale_next_wrap)
nnoremap <silent><space>wk <plug>(ale_previous_wrap)
let g:ale_set_highlights=0
let g:ale_lint_on_text_changed='never'
let g:ale_lint_on_save=1
let g:ale_lint_on_enter=1
let g:ale_lint_on_insert_leave=1
let g:ale_sign_error='->'
let g:ale_sign_warning='!'
let g:ale_linters_explicit=1 " 显示指定文件类型使用的linter，配合g:ale_linters使用
let g:ale_linters={'python': ['pylint'], 'c': ['clang'], 'cpp': ['clang'], 'go': ['staticcheck'], 'rust': ['cargo'], 'sh': ['shellcheck'], 'zsh': ['shellcheck'], 'vim': ['vint']}
" linter配置
let g:ale_c_clang_options='-Wall -O2 -std=gnu17'
let g:ale_cpp_clang_options='-Wall -O2 -std=gnu++17'

" 18. YouCompleteMe
nnoremap <silent><space>] :rightbelow vertical YcmCompleter GoTo<CR>
nnoremap <silent><space>[ :rightbelow vertical YcmCompleter GoToCallers<CR>
nnoremap <silent><space>; :rightbelow vertical YcmCompleter GoToDefinition<CR>
nnoremap <silent><space>: :rightbelow vertical YcmCompleter GoToDeclaration<CR>
nnoremap <silent><space>" :rightbelow vertical YcmCompleter GoToReferences<CR>
nnoremap <silent><space>? :rightbelow vertical YcmCompleter GoToDocumentOutline<CR>
nnoremap <silent><space>- :rightbelow vertical YcmCompleter GoToImplementation<CR>
nnoremap <silent><space>, <plug>(YCMHover)
" nnoremap <silent><space>yfw <Plug>(YCMFindSymbolInWorkspace)
" nnoremap <silent><space>yfd <Plug>(YCMFindSymbolInDocument)
set completeopt=menu,menuone
let g:ycm_enable_semantic_highlighting=1                            " 打开语法高亮
let g:ycm_enable_inlay_hints=0                                      " 关闭内嵌提示
let g:ycm_clear_inlay_hints_in_insert_mode=0                        " 插入模式关闭内嵌提示
let g:ycm_show_diagnostics_ui=0                                     " 不使用YCM的代码检测功能，使用ale实现代码检测
let g:ycm_complete_in_strings=1                                     " 输入字符串也进行补全
let g:ycm_min_num_of_chars_for_completion=1                         " 启动补全的最小输入字符
let g:ycm_min_num_identifier_candidate_chars=0                      " 候选标识符长度，不作限制
let g:ycm_collect_identifiers_from_comments_and_strings=1           " 从注释和字符串中提取标识符用于补全
let g:ycm_semantic_triggers={'c,cpp,python,go,rust': ['re!\w{1}'],} " 开启语法补全，输入两个字符时开启
let g:ycm_confirm_extra_conf=0                                      " 确认查找到的额外配置文件，不确认
let g:ycm_goto_buffer_command='same-buffer'                         " 设置跳转的新窗口
let g:ycm_use_ultisnips_completer=1                                 " 打开ultisnips补全
" 若当前文件夹下没有配置文件，则加载全局配置文件
" let g:ycm_conf_path = findfile('.ycm_extra_conf.py', '.;')
" let g:ycm_global_ycm_extra_conf=g:ycm_conf_path

" 19. vim-gutentags
" let g:gutentags_project_root=['.root', '.svn', '.git', '.hg', '.project'] " gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
" let g:gutentags_ctags_tagfile='.tags'                                     " 所生成的数据文件的名称
" let s:vim_tags=expand('$HOME/.cache/tags')                                " 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
" let g:gutentags_cache_dir=s:vim_tags
" let g:gutentags_ctags_extra_args=['--fields=+niazS', '--extra=+q']        " 配置 ctags 的参数
" let g:gutentags_ctags_extra_args+=['--c++-kinds=+px']
" let g:gutentags_ctags_extra_args+=['--c-kinds=+px']
" if !isdirectory(s:vim_tags)                                               " 检测 ~/.cache/tags 不存在就新建
"     silent! call mkdir(s:vim_tags, 'p')
" endif

" 20. asyncrun
let g:asyncrun_bell=0    " 提示音开
let g:quickfix_height=15 " quickfix窗口的高度
let g:asyncrun_open=g:quickfix_height
function! SetCompileOptions()
    nnoremap <silent><space>C :AsyncStop!<CR>
    nnoremap <silent><space>Q :call asyncrun#quickfix_toggle(g:quickfix_height)<CR>
    augroup compile_settings
        autocmd FileType c nnoremap <silent><space>b :AsyncRun -save=1 gcc -std=gnu17 -Wall -O2 $VIM_FILEPATH -o $VIM_FILEDIR/$VIM_FILENOEXT<CR>
        autocmd FileType c nnoremap <silent><space>r :AsyncRun -raw -save=1 gcc -std=gnu17 -Wall -O2 $VIM_FILEPATH -o $VIM_FILEDIR/$VIM_FILENOEXT && $VIM_FILEDIR/$VIM_FILENOEXT<CR>
        autocmd FileType cpp nnoremap <silent><space>b :AsyncRun -save=1 g++ -std=gnu++17 -Wall -O2 $VIM_FILEPATH -o $VIM_FILEDIR/$VIM_FILENOEXT<CR>
        autocmd FileType cpp nnoremap <silent><space>r :AsyncRun -raw -save=1 g++ -std=gnu++17 -Wall -O2 $VIM_FILEPATH -o $VIM_FILEDIR/$VIM_FILENOEXT && $VIM_FILEDIR/$VIM_FILENOEXT<CR>
        autocmd FileType python nnoremap <silent><space>r :AsyncRun -raw -save=1 python3 $VIM_FILEPATH<CR>
        autocmd FileType sh nnoremap <silent><space>r :AsyncRun -raw -save=1 sh $VIM_FILEPATH<CR>
        autocmd FileType go nnoremap <silent><space>r :AsyncRun -raw -save=1 go run .<CR>
        autocmd FileType go nnoremap <silent><space>b :AsyncRun -save=1 go build .<CR>
        autocmd FileType go nnoremap <silent><space>t :AsyncRun -save=1 go test $VIM_FILEDIR -v -cover -count=1<CR>
        autocmd FileType go nnoremap <silent><space>tt :AsyncRun -save=1 go test $VIM_FILEDIR -v -cover -count=1 -run $VIM_CWORD<CR>
        autocmd FileType rust nnoremap <silent><space>b :AsyncRun -save=1 cargo build<CR>
        autocmd FileType rust nnoremap <silent><space>c :AsyncRun -save=1 cargo check<CR>
        autocmd FileType rust nnoremap <silent><space>r :AsyncRun -raw -save=1 cargo run<CR>
    augroup end
endfunction
call SetCompileOptions()

" 21. echodoc
let g:echodoc_enable_at_startup=1

" 22. todo-vim
nnoremap <silent><space>td :TODOToggle<CR>

" 23. git-blamer
nnoremap gb :call gitblame#echo()<CR>

" 24. vim-codefmt
augroup autoformat_settings
    " autocmd FileType bzl AutoFormatBuffer buildifier
    autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
    autocmd FileType c,cpp,proto,javascript,arduino Glaive codefmt clang_format_style='{BasedOnStyle: LLVM, IndentWidth: 4, AllowShortFunctionsOnASingleLine: Inline, ColumnLimit: 128}'
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
    autocmd FileType sh,zsh AutoFormatBuffer shfmt
    autocmd FileType sh,zsh Glaive codefmt shfmt_options=`['-i', '4', '-sr', '-ci']`
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

" 30. nerdtree-git-plugin
" TODO a plugin of NERDTree showing git status flags

" 31. vim-devicons
" TODO support icons of file

" 32. markdown-preview
nnoremap <silent><space>mp <plug>MarkdownPreviewToggle

" 33. vim-markdown
set conceallevel=0
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_math=0
let g:vim_markdown_strikethrough=1

" 34. ultisnips
let g:UltiSnipsExpandTrigger='<C-E>'
let g:UltiSnipsJumpForwardTrigger='<C-J>'
let g:UltiSnipsJumpBackwardTrigger='<C-K>'

" 35. vim-snippets
" TODO a collection of snippets

" 36. vim-bookmarks
let g:bookmark_no_default_key_mappings=1
nnoremap <silent><space>mm <Plug>BookmarkToggle
nnoremap <silent><space>mi <Plug>BookmarkAnnotate
nnoremap <silent><space>ma <Plug>BookmarkShowAll
nnoremap <silent><space>mj <Plug>BookmarkNext
nnoremap <silent><space>mk <Plug>BookmarkPrev
nnoremap <silent><space>mc <Plug>BookmarkClear
nnoremap <silent><space>mx <Plug>BookmarkClearAll
nnoremap <silent><space>mg <Plug>BookmarkMoveToLine
nnoremap <silent><space>mkk <Plug>BookmarkMoveUp
nnoremap <silent><space>mjj <Plug>BookmarkMoveDown

" 37. vim-startify
let g:startify_bookmarks=systemlist("cut -sd' ' -f 2- ~/.NERDTreeBookmarks")


" " -----tips-----
" " Put these lines at the very end of your vimrc file.

" " Load all plugins now.
" " Plugins need to be added to runtimepath before helptags can be generated.
" packloadall
" " Load all of the helptags now, after plugins have been loaded.
" " All messages and errors will be ignored.

" silent! helptags ALL
