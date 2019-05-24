"
"                _
"        __   __(_)_ __ ____
"        \ \ / /| | '_ ` _  \
"         \ V / | | | | | | | --- Great and Cute
"          \_/  |_|_| |_| |_|
"
"  My Vimrc - for freedom
"
"  indexxuan@gmail.com
"
"  https://github.com/IndexXuan
"
" ====================================================================
"
"  including 4 parts:
"
"  1. Settings
"
"  2. KeyMap
"
"  3. Temp
"
"  4. ChangeLog
"
"  Copyright 2015 - 2019, test for Mac OS
"
" ====================================================================

" Path Alias
let g:dotfiles = $HOME.'/wow-my-dotfiles'

" Hello World !
execute('set runtimepath+='.g:dotfiles)
set nocompatible

" leader key setting
let g:mapleader = ";"
let mapleader = ";"
" basic mode for vimruntime without plugin
let g:basicmode = $BASIC_MODE == 1
" load plugin
let g:plugconfigpath = g:dotfiles.'/.plug.vim'
if filereadable(expand(g:plugconfigpath))
  if basicmode == 0
    " Init
    " Disable default plugins
    let g:loaded_gzip              = 1
    let g:loaded_man               = 1
    let g:loaded_matchit           = 1
    let g:loaded_matchparen        = 1
    let g:loaded_netrwPlugin       = 1
    let g:loaded_shada_plugin      = 1
    let g:loaded_spellfile_plugin  = 1
    let g:loaded_tarPlugin         = 1
    let g:loaded_2html_plugin      = 1
    let g:loaded_tutor_mode_plugin = 1
    let g:loaded_zipPlugin         = 1
    execute('source '.g:plugconfigpath)
  endif
endif

" --------------------------------------------------------------------
" -------------------------    Settings    ---------------------------
" --------------------------------------------------------------------

" UI Layout {{
  " Better gui colors
  set termguicolors
  " Show cursor line
  set cursorline
  " Better display for messages
  set cmdheight=2
  " Avoid the pop up menu occupying the whole screen
  set pumheight=15
  " Show list instead of just completing
  set wildmenu
  " Faster redrawing
  set ttyfast
  " Viminfo include !
  set viminfo+=!
  " Show sign column
  set signcolumn=yes
  " Show as much as possible of the last line
  set display+=lastline
  " Show current cmd
  set showcmd
  " Show line number
  set nonu
  function! NumberToggle()
    if(&number == 0)
      set relativenumber number
    else
      set nonumber norelativenumber
    endif
  endfunc
  nnoremap <leader>n :call NumberToggle()<cr>
  " Show Tabline always
  set showtabline=2
  " Hide default --insert--, use statusline plugin
  set noshowmode
  " Always display statusline( like airline / lightline )
  set laststatus=2
  " Smaller updatetime for CursorHold, CursorHoldI
  set updatetime=100
  " By default timeoutlen is 1000 ms
  set timeoutlen=500
  " set synmaxcol=300
  set shortmess+=c
  " Default background & color theme
  set background=dark
  " dark theme
  let g:vim_theme_dark = 'gruvbox9'
  " let g:vim_dark_theme = 'molokai'
  " light theme
  let g:vim_theme_light = 'solarized8_light'
  " default colorscheme
  let g:vim_theme = g:vim_theme_dark
  execute('colorscheme '.g:vim_theme)
  " Fast change background
  " cnoremap clight :colorscheme solarized8_light
  " cnoremap cdark  :colorscheme molokai
  " Colors
  hi CursorLine term=bold cterm=bold
  " Make ternimal beautiful and statusline( like airline / lightline ) show well
  set t_Co=256
  " key to make ternimal transparent, 256 is not ok
  hi Normal ctermbg=none ctermfg=255
  " NOTE: works ? - Neovim :terminal colors.
  let g:terminal_color_0  = '#282828'
  let g:terminal_color_1  = '#cc241d'
  let g:terminal_color_2  = '#98971a'
  let g:terminal_color_3  = '#d79921'
  let g:terminal_color_4  = '#458588'
  let g:terminal_color_5  = '#b16286'
  let g:terminal_color_6  = '#689d6a'
  let g:terminal_color_7  = '#a89984'
  let g:terminal_color_8  = '#928374'
  let g:terminal_color_9  = '#fb4934'
  let g:terminal_color_10 = '#b8bb26'
  let g:terminal_color_11 = '#fabd2f'
  let g:terminal_color_12 = '#83a598'
  let g:terminal_color_13 = '#d3869b'
  let g:terminal_color_14 = '#8ec07c'
  let g:terminal_color_15 = '#ebdbb2'
" }}

" File format {{
  set fileencodings=utf-8,gk2312,gbk,gb18030
  set termencoding=utf-8
  set fileformats=unix
  set encoding=UTF-8
" }}

" Misc {{
  " if hidden is not set, TextEdit might fail.
  set hidden
  set history=2000
  set wildmode=list:longest,full
  " Backspace and cursor keys wrap too
  set whichwrap=b,s,h,l,<,>,[,]
  set backspace=indent,eol,start
  set autowrite
  set autoread
  " set autochdir
  " NOTE: useful - https://eduncan911.com/software/fix-slow-scrolling-in-vim-and-neovim.html
  set lazyredraw
  " https://serverfault.com/questions/146093/how-do-i-keep-10-lines-visible-when-scrolling-up-to-eof-with-crtl-f/146095
  set scrolloff=5
  " can use mouse
  set mouse=a
  if has('gui_running')
    set guioptions-=r        " Hide the right scrollbar
    set guioptions-=L        " Hide the left scrollbar
    set guioptions-=T
    set guioptions-=e
    set shortmess+=c
    " No annoying sound on errors
    set noerrorbells
    set novisualbell
    set visualbell t_vb=
  endif
  " No annoying sound on errors
  " autocomplete
  set completeopt=longest,menu
  " 退出 Vim 后在终端留下文件内容，可以理解为残影
  " set t_ti= t_te=
" }}

" Undo / Backup {{
  set undofile
  set undodir=$HOME/.vim/undo
  set nobackup
  set nowritebackup
  set noswapfile
  set nowrap
" }}

" Clipboard {{
  " @see - http://www.cnblogs.com/jianyungsun/archive/2012/07/31/2616671.html
  if has('unnamedplus')
    set clipboard=unnamedplus,unnamed
  else
    set clipboard+=unnamed
  endif
  let g:clipboard = {
    \ 'name': 'pbcopy',
    \ 'copy': {
    \    '+': 'pbcopy',
    \    '*': 'pbcopy',
    \  },
    \ 'paste': {
    \    '+': 'pbpaste',
    \    '*': 'pbpaste',
    \ },
    \ 'cache_enabled': 0,
    \ }
" }}

" Search {{
  " Turn magic on for regexp
  set magic
  " Highlight search results
  set hlsearch
  " Increase search
  set incsearch
  " Cancel highlight of search results
  nmap <silent> <CR> :nohlsearch<CR>
  " Search ignore case
  set ignorecase
  " Search case-sensitive
  set smartcase
  " Keep search pattern at the center of the screen.
  nnoremap <silent> n nzz
  nnoremap <silent> N Nzz
  nnoremap <silent> * *zz
  nnoremap <silent> # #zz
  nnoremap <silent> g* g*zz
" }}

" Spaces & Tabs {{
  " Will override by editorconfig plugin
  set tabstop=2
  set shiftwidth=2
  set softtabstop=2
  set expandtab
  set smarttab
" }}

" Indent {{
  set smartindent
  set autoindent
  set shiftround
" }}

" Folder {{
  " 代码折叠
  set foldenable
  " 折叠方法
  " manual    手工折叠
  " indent    使用缩进表示折叠
  " expr      使用表达式定义折叠
  " syntax    使用语法定义折叠
  " diff      对没有更改的文本进行折叠
  " marker    使用标记进行折叠, 默认标记是 {{{ 和 }}}
  " set foldlevel=99
  " set foldmethod=manual
  " zf 手动折叠
  " zc 关闭当前打开的折叠
  " zo 打开当前的折叠
  " zm 关闭所有折叠
  " zM 关闭所有折叠及其嵌套的折叠
  " zr 打开所有折叠
  " zR 打开所有折叠及其嵌套的折叠
  " zd 删除当前折叠
  " zE 删除所有折叠
  " zj 移动至下一个折叠
  " zk 移动至上一个折叠
  " zn 禁用折叠
  " zN 启用折叠
  set foldmethod=indent
  set foldlevel=99
  " 代码折叠自定义快捷键 <leader>zz
  let g:foldmethod = 0
  " 使用类似原生命令的前缀 z
  map <leader>z :call ToggleFold()<cr>
  function! ToggleFold()
    if g:foldmethod == 0
      exec "normal! zc"
      let g:foldmethod = 1
    else
      exec "normal! zo"
      let g:foldmethod = 0
    endif
  endfunction
" }}

" --------------------------------------------------------------------
" -------------------------     KeyMaps    ---------------------------
" --------------------------------------------------------------------

" Run Code {{
  map <leader>rr :call Run()<CR>
  function! Run()
    exec "w"
    if &filetype == 'c'
      exec "!gcc % -o %<"
      exec "! ./%<"
      exec "!time ./%<:"
    elseif &filetype == 'cpp'
      exec "!g++ % -o %<"
      exec "!time ./%<"
    elseif &filetype == 'sh'
      exec "!bash %<.sh"
    elseif &filetype == 'typescript'
      exec "!ts-node %<"
    elseif &filetype == 'javascript'
      exec "!node %<"
    elseif &filetype == 'html'
      exec "!open % &"
    endif
  endfunction
" }}

" Misc {{
  " Global replace
  nnoremap <C-s> ggVG:s//g<left><left>
  " Global replace with regexp
  " nnoremap <C-s> :%s/\<\>//g<left><left><left><left><left>
  nnoremap <silent> <Space>[ :vertical resize -5<CR>
  nnoremap <silent> <Space>] :vertical resize +5<CR>
" }}


" Shell-like move {{
  inoremap <C-b> <left>
  inoremap <C-f> <Right>
  inoremap <C-p> <Up>
  inoremap <C-n> <Down>
  inoremap <C-o> <Esc>o
  imap <C-a> <Esc>fi
  imap <C-e> <End>
  imap <C-d> <Del>
  imap <C-h> <BS>
  inoremap <C-u> <Esc>d0cl
  inoremap <C-w> <Esc>dbcl
  " better command line editing
  cnoremap <C-b> <Left>
  cnoremap <C-f> <Right>
  cnoremap <C-p> <Up>
  cnoremap <C-n> <Down>
  cnoremap <C-a> <Home>
  cnoremap <C-e> <End>
  cnoremap <C-d> <Del>
  cnoremap <C-h> <BS>
  cnoremap <C-t> <C-R>=expand("%:p:h") . "/" <CR>
" }}

" Smart way to move between windows {{
  noremap <C-j> <C-W>j
  noremap <C-k> <C-W>k
  noremap <C-h> <C-W>h
  noremap <C-l> <C-W>l
" }}

" Remap {{
  " jj as Esc, very useful setting, great, great, great!!!
  inoremap jj <Esc>
  cnoremap jj <C-c>
  " Leader {{
  nnoremap <leader>q :x<CR>
  nnoremap <C-x> :bd<CR>
  nnoremap <silent> <leader>w :update<CR>
  " force write to file
  cnoremap w!! w !sudo tee % >/dev/null
  nnoremap <leader>W :<C-u>w !sudo tee % >/dev/null<CR>
  " force quit
  nnoremap QQ :q!<CR>
  " add some feature for fast and easy motion，like <C-a> & <C-e>
  nmap f ^
  nmap e $
  " toggle paste mode in vim, very useful. 20150709
  set pastetoggle=<F5>
  " indent global
  nnoremap = gg=G
  " retab!
  nnoremap -- :retab!<CR>
  " Y need remap for useful
  nnoremap Y y$
  " delete to the line begin
  nnoremap D d$
  " terminal in Vim
  if has('nvim') || has('terminal')
    map <leader>' :terminal<CR>
  else
    map <leader>' :shell<CR>
  endif
  " remove trailing whitespaces
  nnoremap <silent> <leader>x :%s/\s\+$//e<CR>
" }}

" Remap improved {{
  " backspace in Visual mode deletes selection
  vnoremap <BS> d
  " Treat long lines as break lines, useful when moving around in them
  nnoremap j gj
  nnoremap k gk
  " Vmap for maintain Visual Mode after shifting > and <
  vnoremap < <gv
  vnoremap > >gv
  " great, paste and auto in the bottom of the paste content, very useful!
  vnoremap <silent> y y`]
  nnoremap <silent> p p`]
  " split layouts
  nnoremap <leader>/ :vsplit<CR>
  nnoremap <leader>- :split<CR>
" }}

" Fast jump {{
  " 20150611, fast the jump, shift key is hard to press
  nnoremap [ {
  nnoremap ] }
  nnoremap 9 (
  nnoremap 0 )
  nnoremap 5 %
  " goto older / newer position in change list, very powerful
  nnoremap <silent> ) g;
  nnoremap <silent> ( g,
" }}

" Tabs {{
  nnoremap <tab>   :tabnext<CR>
  nnoremap <s-tab> :tabprevious<CR>
  nnoremap <C-t>   :tabnew<CR>
  inoremap <C-t>   <Esc>:tabnew<CR>i
  " <leader>[1-9] move to tab [1-9]
  for s:i in range(1, 9)
    execute('nnoremap <leader>' . s:i . ' ' . s:i . 'gt')
  endfor
" }}

" Patches {{
  " treat tpl, tmpl as html, add in 20160314
  autocmd BufNewFile,BufRead *tpl set filetype=html
  autocmd BufNewFile,BufRead *tmpl set filetype=html
  " To get correct comment highlight
  autocmd FileType json syntax match Comment +\/\/.\+$+
  " 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写，用于代替 vim-stay 插件
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
" }}

" --------------------------------------------------------------------
" -------------------------       Temp     ---------------------------
" --------------------------------------------------------------------

" ------------ notes and easy to forget area, create in 20150611 ---------------

" something maybe not use often but powerful when you need it
" :retab! change global tab to your set, faster and powful, 20150722
" <leader>d jsdoc
" qf to open quickfix panel
" gf go to an exist file and ctrl + o can back,  very magic and useful

" 20150616, fuck the GTW...
" as the reason we all know, google is always block and some google's
" ip can make us to use google painless, though failure with time goes on
" so, link the openbrowser.vim to dir ~/.vim and make change easily.

" 20150811, replace with eslint in 201512202100
"nnoremap <leader>ht :JSHint<CR>

" 20150723, 通过修改源码的方式将左对齐批量注释快捷键映射为 <leader>cc,
" 并将源码链接到.vim/目录下，便于修改！！！

" since syntastic plugin in js files was too slow, make vim not vim
" so always we need to disabled the checker in js files
" the plugin itself and checkers(jshint & eslint) was great for coding,
" woops,  wish a better experience, 201509251750
" cmap vv :SyntasticToggleMode

" --------------------------------------------------------------------
" -------------------------    Changelog   ---------------------------
" --------------------------------------------------------------------

" 20150611 !!
" 增加备忘录区

" 20150722 !
" 全局缩进变更为2个空格,　顺应新形式

" 20150723
" 通过修改源码的方式将左对齐批量注释快捷键映射为 <leader>cc,
" 并将源码链接到.vim/目录下，便于修改！！！

" 20150811 !
" 加入jshint, 用的vim-jshint2插件，很好，性能正好满足，几乎不卡

" 20150912 !
" add react & jsx

" 20151220 !
" replace jshint with eslint

" 20151230 !!
" nerdcomment, 为注释添加空格，改了源文件，按后缀名搜索修改即可

" 20160119 !!!
" 重装vim，重新编译、审视、整理插件
" 去除vim-easytags，貌似不需要它的自动生成并更新能力...
" jsctags是个很好的插件，生成的tags好的感人，而且无需配置，无奈性能堪忧
" vim-javascript是个不错的插件，但是并没有比vim自带的高亮好，甚至还差，留作观察
" 实验并清理无效插件，了解每个插件用途和配合
" 启用ycm配合ternjs(.tern-project)，有了很好的js补全和代码理解与重构能力
" UtilSnip配合ycm，vim-snippets有了很方便的代码生成能力
" 调研插件

" 20160120 !!
" 调研插件，学习ruanyl(vim-eslint作者)的bigvim(https://github.com/ruanyl/bigvim)
" 整理插件及配置代码
" 将vimrc拆分，模块化，格式化代码，去除无用代码，清理注释
" 学会vim启动过程分析，配置好用的zsh的vim快捷键，以不同模式启动vim
" 大幅改善vim启动速度，关闭了syntastic插件的文件启动自检查
" 配置快捷键来打开错误面板，定位eslint检查的错误，并能快速跳转

" 20160121 !!
" 加入了插件开关,以后不需要vim_basic了
" 确定了vim-javascript的无用，vim-jsx不依赖它也可用
" 调研scss-syntax.vim, vim-css3-syntax的冲突，提了issue,发现scss插件几乎没用
" 分拆的vimrc也加入git管理
" 彻底整理好配置文件，暂存,tag v1.0-beta

" 20160122 共40个插件 !!
" 修复vim-airline不显示git分支的问题，不小心删除了依赖
" CtrlP插件添加应该忽略的文件夹和文件,大幅减少查找时间，提高性能
" 增加了全局精准批量替换的keymap <leader>r, 增加了模糊匹配插件vim-fuzzysearch
" 基本完成v1.0的整理配置，准备尝试新的支持lazyLoad插件的包管理器：vim Plug-in


" 20160124 !!
" 尝试新的包管理器，vim-Plug，更好用，支持懒加载，解决我vim启动时间过慢问题
" 去除重复以及无用插件, 整理，整合优化

" 20160125 !!!
" 研究打开光标所在文件插件，还是解决不好无后缀匹配和存在"./"的话识别错误问题
" 懒加载几乎全部插件，启动时间减少一半，大约500ms左右，共40个插件,优化具体文件类型
" 恢复vim内部常用文件操作插件vim-eunuch，替换了标签匹配插件
" 增加了react等snip插件，去除其分号...深入了解了Ultisnips相关模板格式,格式有坑!(每行开头不是普通空格)
" changelist的游走映射为 "(" 和 ")" 一对儿，非常有用的快捷键
" 优化整理,包管理器随意切换，纳入git控制

" 20160130 !
" 替换vue插件,让vue文件有更好的编程体验，找到了处理更多情况的替换插件，但是需要修改源码，避免报错

" 20160203
" 暂时去除vim内eslint,有外部工具实时lint并提示
" 增加了vue文件的自动生成骨架

" 20160205
" 调研vim-orgmode,vimwiki,vimoutline，都放弃了，vim只作为代码编辑器

" 20160213 解决一个疑惑同时也是忘记了的操作,vim中真正tab缩进,而且能产生normal模式下不可到达的空格
" snippets的制作需要用到真正的tab缩进(makefile文件也是)，使用ctrl-v-i组合来打出

" 20160327
" change vue file tpl, add less-plugin

" 20160417
" 加入es.next.syntax插件，获取更多es6/7高亮支持,更新README,加入更多注意点

" 20160523
" 貌似vue-cli的配置改变，sass变为严格模式(sass)，因此语法和高亮都需要做相应改变
" vim-vue的sass语法匹配改为scss, 且模板里也同样修改为<style lang="scss"></style>, 其实更符合sass,scss区别!
"
" 20161101
" 增加了 `typescript`　支持，包含静态语法高亮和语言服务（补全和语法检查）
" 为了性能考虑，不再加载syntastic插件（本身是很好的插件，原本是设置了静默并置空相应检查引擎）
" 同样为了性能考虑，暂不开启typescript语法服务插件（关闭了syntastic插件依旧会检查...　性能暂时不可接受）
" 最后仅保留了typescript.vim这一个简单的语法高亮插件，其他都有问题

" 20170303
" 对vim-jsdoc改造，支持无 `function` 关键字函数（函数声明和函数表达式）

" 20170306 - 20170307
" 对 `vimrc` 进行了重构，精简插件，优化启动速度
" 启用fuzzy search, ag 版 ctrlsf

" 20170309
" 使用 `es2015 & react snips`，删除 `vim-es6` 里的snips

" 20190321
" 备份，本周末准备试试 coc.nvim 新系统代替 YCM

" 20190326 - v3.0
" 全新的 coc.nvim 补全体系，LSP 支持；整理代码；尽量使用 coc 生态工具；
" 因为 vim-node-rpc 导致启动速度在 500ms 左右

" 20190328
" use lightline, remove airline，启动速度在 450ms+

" 20190329
" use yarn global add vim-node-rpc, 启动速度正常了，外加精简插件，目前 ~200ms

" 20190330
" TODO: .vimrc 中很多不懂的配置
" TODO: 尽量使用 coc 生态，去除 vim plugins，学习 coc-list

" 20190331
" 添加 nerdfont 安装文档，以支持 devicon 插件
" 设置终端 font-size 14，让 emoji 显示正常
" 复原 vim 设置：1. 具备基础工具; 2. vimrc; 3. 终端颜色等设置;

" 20190412 - 27 plugins
" lightline 美化，已经与 vim-airline 一致，之前没设置好 branch icon 等
" 重新启用 CtrlP + CtrlSF
" 启动速度 150ms+ & lightline 添加 NOTE，以供复原

" 20190413 - 入职 mt 两周年
" 美化 lightline + vista.vim
" 整理代码

" 20190418 - 全异步延时加载 ~100ms
" 功能完备，UI 完美

" 20190430 - 代码整理 & UI 美化，增加更多图标 & 更多了解 lightline.vim
" 30 plugins
" .vimrc ~600 lines & .plug.vim ~1200 lines, with startuptime about 70ms

" 20190508 - 32 插件，优化 tabnum icons
" 不加载内部插件，仅 source，优化启动速度至 71ms 左右

