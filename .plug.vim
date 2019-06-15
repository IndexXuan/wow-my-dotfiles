" ----------------------------------------------------------------------------
"
"                           Plugins and Settings v3.0.0
"                              Plug with 37 Plugins
"
" ----------------------------------------------------------------------------

" setup
" NOTE: @Install
" " enable python if $PATH has python3 >= 3.4
" " pip3 install --user --upgrade pynvim

if has('nvim')
  let g:python_host_skip_check = 1
  let g:python_host_prog = '/usr/local/bin/python3'
  let g:python3_host_skip_check = 1
  let g:python3_host_prog = '/usr/local/bin/python3'
endif

call plug#begin('$HOME/.vim/plugged')

" ----------------------------------------------------------------------------
"
"  Vim-Plug --- Minimalist Vim Plugin Manager
"
"  command:
"  :PlugInstall[name ...]
"    install plugins
"  :PlugUpdate[name ...]
"    install or update plugins
"  :PlugClean[!]
"    remove plugin not in list(bang version will clean without prompt)
"  :PlugStatus
"    check the status of plugins(e.g. load or not)
"  :PlugUpgrade
"    upgrade vim-plug itself
"  :PlugDiff
"    examine changes from the previous update and the pending changes
"  :PlugSnapshot[!] [output path]
"    generate script for restoring the current snapshot of the plugins
"
"  options:
"  branch / tag / commit => 插件 git 仓库选择
"  rtp                   => vim 插件包含在子文件夹
"  dir                   => 插件自定义文件夹
"  do                    => 定义插件安装钩子，传入字符串命令或者函数名
"  on                    => 满足条件懒加载
"  for                   => 文件类型懒加载
"  frozen                => 不随着更新除非具体表明
"
"  keybindings
"  in :PlugStatus state, press L to load plugin in cursor
"
"  More docs in github homepage
"  https://github.com/junegunn/vim-plug
"
" ----------------------------------------------------------------------------

" UI Bar Width
let g:bar_width = 30

augroup loadPlugin
  autocmd!
  autocmd vimEnter * call DeferLoadPlugins()
        \ | autocmd! loadPlugin
augroup END

function! Handler(_)
  " 0. before load
  " do nothing right now

  " 1. load plugins
  call plug#load('vim-startify', 'vim-nerdtree-syntax-highlight', 'ctrlp.vim', 'vim-devicons', 'nerdtree-git-plugin', 'nerdtree', 'lightline.vim', 'vim-snippets', 'vim-fugitive')

  " 2. handle vim [empty] - 顺序不能变，精心调试出来的
  if !argc()
    " Open Left & Right Bar
    call OpenBar()
    " focus on Startify
    wincmd w
    function! s:center_layout(lines) abort
      let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
      " NOTE: 修复居中问题，减去 bar_width * 2
      let cols = &columns - (2 * g:bar_width)
      let centered_lines = map(copy(a:lines),
            \ 'repeat(" ", (cols / 2) - (longest_line / 2)) . v:val')
      return centered_lines
    endfunction
    " let g:startify_custom_header = s:center_layout(startify#fortune#cowsay())
    let g:startify_custom_header = s:center_layout([
          \'+-------------------------------------------+',
          \'|              IndexVim ^_^                 |',
          \'|                                           |',
          \'|            Github: IndexXuan              |',
          \'+-------------------------------------------+',
          \])
    " Open Startify Screen
    execute("Startify")
  endif

  " 3. handle vim [dir], call NerdTree
  autocmd StdinReadPre * let s:std_in=1
  if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in")
    " Open Left-Side NERDTree
    exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0]
  endif

  " 4. patch for vim
  if !has("nvim")
    " Vim 需要提前加载这个，懒加载不起作用 ...
    call plug#load('quickmenu.vim')
  endif

  " 5. after load
  call plug#load(
    \ 'vim-wakatime', 'vim-editorconfig', 'vim-hardtime', 'comfortable-motion.vim', 'vim-surround', 'vim-repeat',
    \ 'nerdcommenter', 'vim-multiple-cursors', 'MatchTagAlways', 'vim-jsdoc', 'fzf', 'fzf.vim',
    \ )
endfunction

" Order is important
function! OpenBar()
  " 1. Open Right-Side Menu
  call OpenMenu()
  " 2. Open Left-Side NERDTree
  execute("NERDTree")
endfunction

" 函数名必须大写开头，加 ! 为了避免报重复定义，强行覆盖执行
function! DeferLoadPlugins()
  return timer_start(0, 'Handler', { 'repeat': 1 })
endfunction

" -------------------------- Base ---------------------------

" https://github.com/neoclide/coc-imselect
" Input method enhance for iTerm2 on mac.
 " Plug 'neoclide/coc-imselect'

" https://github.com/neoclide/coc.nvim - 0 - init - 异步加载会超级慢 - 基础生态插件
" Intellisense engine for vim8 & neovim, full language server protocol support as VSCode
Plug 'neoclide/coc.nvim', { 'branch': 'master', 'do': 'yarn install --frozen-lockfile' }

" https://github.com/wakatime/vim-wakatime - 0 - lazy - 基础功能插件
" Vim plugin for automatic time tracking and metrics generated from your programming activity
Plug 'wakatime/vim-wakatime', { 'on': [] }

" https://github.com/takac/vim-hardtime - lazy - 基础插件，Vim 特色
" Plugin to help you stop repeating the basic movement keys
Plug 'takac/vim-hardtime', { 'on': []}

" https://github.com/easymotion/vim-easymotion - 0 - on-demand - 基础插件，Vim 特色
" Vim motions on speed!
Plug 'easymotion/vim-easymotion', { 'on': [
      \ '<Plug>(easymotion-overwin-f2)',
      \ '<Plug>(easymotion-j)',
      \ '<Plug>(easymotion-k)',
      \ '<Plug>(easymotion-lineforward)',
      \ '<Plug>(easymotion-linebackward)',
      \ ]}

" https://github.com/yuttie/comfortable-motion.vim - 0 - lazy - 基础功能插件 - better than vim-smooth-scroll
" Brings physics-based smooth scrolling to the Vim world!
Plug 'yuttie/comfortable-motion.vim', { 'on': [] }

" https://github.com/sgur/vim-editorconfig - 0 - lazy - 基础插件
" Yet another EditorConfig (http://editorconfig.org) plugin for vim written in vimscript only
Plug 'sgur/vim-editorconfig', { 'on': [] }

" https://github.com/tpope/vim-surround - 1 - lazy - 基础插件，Vim 特色
" surround.vim: quoting/parenthesizing made simple
Plug 'tpope/vim-surround', { 'on': [] }

" https://github.com/tpope/vim-repeat - 1 - lazy - 基础插件，Vim 特色
" repeat.vim: enable repeating supported plugin maps with "."
Plug 'tpope/vim-repeat', { 'on': [] }

" https://github.com/vim-scripts/open-browser.vim - 2 - on-demand - 基础功能插件
" Open URI with your favorite browser from your favorite editor
Plug 'tyru/open-browser.vim', { 'on': ['<Plug>(openbrowser-smart-search)', 'OpenBrowser'] }

" https://github.com/terryma/vim-multiple-cursors - 2 - lazy - 编辑能力增强
Plug 'terryma/vim-multiple-cursors', { 'on': [] }

" https://github.com/terryma/vim-expand-region - 2 - on-demand - 选择能力增强，Vim 特色
Plug 'terryma/vim-expand-region', { 'on': ['<Plug>(expand_region_expand)', '<Plug>(expand_region_shrink)'] }

" https://github.com/simnalamburt/vim-mundo - 2 - on-demand - undotree
" 🎄 Vim undo tree visualizer
Plug 'simnalamburt/vim-mundo', { 'on': 'MundoToggle' }

" https://github.com/voldikss/vim-translate-me - 1 - on-demand - 基础功能增强
Plug 'voldikss/vim-translate-me', { 'on': ['<Plug>TranslateW', '<Plug>TranslateWV'] }

" -------------------------- UI Layout ---------------------------

" https://github.com/mhinz/vim-startify - 1 - lazy
" 🔗 The fancy start screen for Vim.
Plug 'mhinz/vim-startify', { 'on': [] }

" https://github.com/junegunn/goyo.vim - on-demand - UI
" 🌷 Distraction-free writing in Vim
Plug 'junegunn/goyo.vim', { 'on': 'Goyo' }

" https://github.com/junegunn/limelight.vim - on-demand - UI
" 🔦 All the world's indeed a stage and we are merely players
Plug 'junegunn/limelight.vim', { 'on': 'Limelight'}

" https://github.com/ryanoasis/vim-devicons - 2 - lazy - 但也要尽快加载，否则很多地方出不来
" Adds file type glyphs/icons to popular Vim plugins: NERDTree, vim-airline, Powerline, Unite, vim-startify and more
Plug 'ryanoasis/vim-devicons', { 'on': [] }

" https://github.com/itchyny/lightline.vim - 0 - lazy - 否则会拖慢
" A light and configurable statusline/tabline plugin for Vim
Plug 'itchyny/lightline.vim', { 'on': [] }

" https://github.com/scrooloose/nerdtree - 0 - lazy
" a tree explorer plugin for vim
Plug 'scrooloose/nerdtree', { 'on': [] }

" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight - 2 - lazy - 非常好看
" Extra syntax and highlight for nerdtree files
Plug 'tiagofumo/vim-nerdtree-syntax-highlight', { 'on': [] }

" https://github.com/Xuyuanp/nerdtree-git-plugin
" A plugin of NERDTree showing git status
" Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': [] }
" https://github.com/tsony-tsonev/nerdtree-git-plugin - 0 - lazy - fork 上面的，并做了 UI 颜色区分与增强
" A plugin of NERDTree showing git status
Plug 'tsony-tsonev/nerdtree-git-plugin', { 'on': [] }

" https://github.com/skywind3000/quickmenu.vim - 0 - lazy - UI 右侧栏
" A nice customizable popup menu for vim
Plug 'skywind3000/quickmenu.vim', { 'on': [] }

" https://github.com/Yggdroot/indentLine - 1 - on-demand - UI 增强
" A vim plugin to display the indention levels with thin vertical lines
Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesToggle' }

" https://github.com/liuchengxu/vim-which-key - 1 - on-demand - 快捷键提示与导航
" 🌷 Vim plugin that shows keybindings in popup
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" ----------------- As Programmer's Editor -----------------------

" https://github.com/scrooloose/nerdcommenter - 0 - lazy - 基础功能
" Vim plugin for intensely orgasmic commenting
Plug 'scrooloose/nerdcommenter', { 'on': [] }

" TODO:
" https://github.com/ctrlpvim/ctrlp.vim - 1 - lazy - must before devicon plugin
" Active fork of kien/ctrlp.vim—Fuzzy file, buffer, mru, tag, etc finder.
" Plug 'ctrlpvim/ctrlp.vim', { 'on': ['CtrlP', 'CtrlPMixed', 'CtrlPMRU'] }
Plug 'ctrlpvim/ctrlp.vim', { 'on': [] }

" https://github.com/dyng/ctrlsf.vim - 0 - on-demand
" An ack.vim alternative mimics Ctrl-Shift-F on Sublime Text 2
Plug 'dyng/ctrlsf.vim', { 'on': ['CtrlSF'] }

" https://github.com/junegunn/fzf#using-the-finder - 1 - lazy - 强大搜索功能
" 🌸 A command-line fuzzy finder
" NOTE: If installed using Homebrew
Plug '/usr/local/opt/fzf', { 'on': [] }
Plug 'junegunn/fzf.vim', { 'on': [] }

" -------------------------- Working with Git --------------------------------

" TODO: replace by coc-git
" https://github.com/tpope/vim-fugitive - 1 - lazy
" fugitive.vim: A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive', { 'on': [] }

" https://github.com/rhysd/git-messenger.vim - 1 - on-demand - Git 增强，UI 美观
" Vim and Neovim plugin to reveal the commit messages under the cursor
Plug 'rhysd/git-messenger.vim', { 'on': ['<Plug>(git-messenger)'] }

" --------------------------- Language Plugins ---------------------------------

" https://github.com/leafgarland/typescript-vim - 0 - filetype
" Typescript syntax files for Vim
Plug 'leafgarland/typescript-vim', { 'for': ['typescript'] }

" https://github.com/posva/vim-vue - 0 - filetype
" Syntax Highlight for Vue.js components
Plug 'posva/vim-vue', { 'for' : ['vue'] }

" https://github.com/neoclide/vim-jsx-improve - 3 - filetype
" Syntax and indent plugin for React jsx.
Plug 'neoclide/vim-jsx-improve', { 'for': [ 'javascript', 'javascript.jsx', 'typescript', 'typescript.tsx'] }

" https://github.com/iamcco/markdown-preview.nvim - filetype
" markdown preview plugin for (neo)vim
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install', 'for': [ 'markdown', 'md'] }

" https://github.com/Quramy/vim-js-pretty-template
" highlights JavaScript's Template Strings in other FileType syntax rule
" Plug 'Quramy/vim-js-pretty-template'

" https://github.com/maxmellon/vim-jsx-pretty
" 🔦 [Vim script] JSX syntax pretty highlighting for vim.
" Plug 'maxmellon/vim-jsx-pretty', { 'for': ['typescript.tsx', 'javascript.jsx'] }

" --------------------- Extras / Advanced ----------------------

" https://github.com/honza/vim-snippets - 1 - lazy
" vim-snipmate default snippets (Previously snipmate-snippets)
Plug 'honza/vim-snippets', { 'on': [] }

" https://github.com/Valloric/MatchTagAlways - 0 - lazy
" A Vim plugin that always highlights the enclosing html / xml tags
Plug 'Valloric/MatchTagAlways', { 'on': [] }

" https://github.com/heavenshell/vim-jsdoc - 2 - lazy - hack 支持了 vue 文件
" Generate JSDoc to your JavaScript code.
Plug 'heavenshell/vim-jsdoc', { 'on': [] }

" Add plugins to &runtimepath
call plug#end()

" -------------------------  Plugins-Specific Settings Start -------------------------


" https://github.com/neoclide/coc.nvim {{
  " NOTE: @Install - https://github.com/universal-ctags/ctags
  " brew install --HEAD universal-ctags/universal-ctags/universal-ctags
  " 1. global installed extensions
  let g:coc_global_extensions = [
        \ 'coc-lists', 'coc-git', 'coc-word', 'coc-dictionary', 'coc-emoji', 'coc-highlight', 'coc-pairs', 'coc-yank',
        \ 'coc-vimlsp', 'coc-prettier', 'coc-tsserver', 'coc-vetur', 'coc-html', 'coc-emmet', 'coc-css', 'coc-json', 'coc-yaml',
        \ 'coc-eslint', 'coc-stylelint', 'coc-tslint-plugin',
        \ 'coc-snippets',
        \ 'https://github.com/xabikos/vscode-javascript',
        \ 'https://github.com/sdras/vue-vscode-snippets',
        \ 'https://github.com/snowffer/Element-UI-Snippets-VSCode',
        \ 'https://github.com/xabikos/vscode-react',
        \]

  " 2. Misc
  " Use <c-space> for trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()
  "uto coc-pairs 自动加空格，需要配合 coc-settings.json 里的属性
  inoremap <silent><expr> <CR> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"
  " NOTE: coc-pairs
  autocmd FileType markdown let b:coc_pairs_disabled = ['`']
  " Highlight symbol under cursor on CursorHold
  autocmd CursorHold * silent call CocActionAsync('highlight')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  " autocmd CursorHold * silent call CocActionAsync('doHover')

  " 3. Using CocList
  " Show all Lists
  nnoremap <silent> <space>l  :<C-u>CocList --number-select lists<cr>
  " Show commands
  nnoremap <silent> <space>c  :<C-u>CocList --number-select commands<cr>
  " Show all diagnostics
  nnoremap <silent> <space>d  :<C-u>CocList --number-select --auto-preview diagnostics<cr>
  " Manage extensions
  nnoremap <silent> <space>e  :<C-u>CocList --number-select extensions<cr>
  " Git status
  " nnoremap <silent> <space>g  :<C-u>CocList --normal gstatus<CR>
  " Find symbol of current document
  nnoremap <silent> <space>o  :<C-u>CocList --number-select --auto-preview outline<cr>
  " Search workspace symbols
  " nnoremap <silent> <C-p>  :<C-u>CocList --interactive --auto-preview --number-select files<cr>
  nnoremap <silent> <leader>s  :<C-u>CocList --interactive --number-select symbols<cr>
  nnoremap <silent> <space>y  :<C-u>CocList -A --normal yank<cr>
  " Do default action for next item.
  " nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " Do default action for previous item.
  " nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " Resume latest coc list
  nnoremap <silent> <space>r  :<C-u>CocListResume<CR>

  " coc-git
  nmap <silent> <leader>go :CocCommand git.browserOpen<CR>
  " navigate chunks of current buffer
  nmap <leader>gp <Plug>(coc-git-prevchunk)
  nmap <leader>gn <Plug>(coc-git-nextchunk)
  " show chunk diff at current position
  " nmap <leader>gch <Plug>(coc-git-chunkinfo)
  " show commit at current position
  nmap <leader>gc <Plug>(coc-git-commit)

  " 4. Buffer 内操作
  " 文本搜索当前词，等同于 / 内置命令，但多了列表聚合展示
  " nnoremap <silent> <leader>f :exe 'CocList -I --normal --input='.expand('<cword>').' words'<CR>
  " 文本模糊搜索，等同于 fuzzy-search 插件

  " 5. 全局操作
  " 模糊搜索文件 - CocList files - 代替 CtrlP - 暂未发现优势
  " 模糊搜索文本 - 暂无 - 代替 CtrlSF - 暂未发现优势

  " 6. 补全配置
  " Use tab for trigger completion with characters ahead and navigate.
  " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
  inoremap <silent><expr> <TAB>
        \ pumvisible() ? coc#_select_confirm() :
        \ coc#expandableOrJumpable() ? coc#rpc#request('doKeymap', ['snippets-expand-jump','']) :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  let g:coc_snippet_next = '<tab>'

  " expand vue snippet - @see https://github.com/iamcco/dotfiles/blob/master/nvim/viml/plugins.config/coc.nvim.vim#L52
  function! s:vue_snippet() abort
      let l:start_line = line('.')
      let l:is_position = search('\v%x0')
      if l:is_position !=# 0
          silent! s/\v\t/    /g
          silent! s/\v%x0\n//g
          silent! s/\v%x0/\r/g
          let l:end_line = line('.')
          call cursor(l:start_line, 0)
          let l:pos = searchpos('\v\$\{\d+\}', 'n', l:end_line)
          if l:pos[0] !=# 0 && l:pos[1] !=# 0
              call cursor(l:pos[0], l:pos[1])
              normal! df}
          endif
      endif
  endfunction

  " vue
  autocmd CompleteDone *.vue call <SID>vue_snippet()
  " highlight text color, default #000000
  autocmd ColorScheme * highlight! CocHighlightText guibg=#909399 ctermbg=023

  " 7. 跳转配置
  " core typings keymap
  " nmap <silent> <leader>pp <Plug>(coc-diagnostic-prev)
  " nmap <silent> <leader>nn <Plug>(coc-diagnostic-next)
  nmap <silent> <leader>d  <Plug>(coc-definition)
  nmap <silent> <leader>a  :call <SID>show_documentation()<CR>
  nmap <silent> <leader>ca <Plug>(coc-codeaction)
  nmap <silent> <leader>cl <Plug>(coc-codelens-action)
  nmap <silent> <leader>rn <Plug>(coc-rename)
  nmap <silent> <leader>rf <Plug>(coc-references)
  nmap <silent> <leader>td <Plug>(coc-type-definition)
  nmap <silent> <leader>ip <Plug>(coc-implementation)

  function! s:show_documentation()
    if &filetype == 'vim'
      execute('h '.expand('<cword>'))
    else
      call CocAction('doHover')
    endif
  endfunction

  " 8. 自定义命令
  function! SetupCommandAbbrs(from, to)
    exec 'cnoreabbrev <expr> '.a:from
          \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
          \ .'? ("'.a:to.'") : ("'.a:from.'"))'
  endfunction

  " to open coc config
  call SetupCommandAbbrs('config', 'CocConfig')
  call SetupCommandAbbrs('gb', 'Gblame')
  call SetupCommandAbbrs('gs', 'Gstatus')
  call SetupCommandAbbrs('gl', '0Glog')

  " coc.nvim - prettier
  command! -nargs=0 Prettier :CocCommand prettier.formatFile
  nmap <leader>p :Prettier<CR>
  vmap <leader>p <Plug>(coc-format-selected)
" }}

" https://github.com/takac/vim-hardtime {{
  " If you want hardtime to run in every buffer, add this to .vimrc
  let g:hardtime_default_on = 1
  " default settings
  let g:list_of_normal_keys = ["h", "j", "k", "l", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
  let g:list_of_visual_keys = ["h", "l", "<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
  let g:list_of_insert_keys = ["<UP>", "<DOWN>", "<LEFT>", "<RIGHT>"]
  let g:list_of_disabled_keys = []
  " To enable the notification about HardTime being enabled set
  let g:hardtime_showmsg = 1
  " Setting this value to 2 will allow a user to press jj but not jjj.
  let g:hardtime_maxcount = 5
  " To enable hardtime to ignore certain buffer patterns set
  let g:hardtime_ignore_buffer_patterns = [ "quickmenu", "NERD.*", "ctrlsf" ]
" }}

" https://github.com/easymotion/vim-easymotion {{
  let g:EasyMotion_do_mapping = 0 " Disable default mappings
  " map <leader><leader> <Plug>(easymotion-prefix)
  " Default Mapping      | Details
  "   ---------------------|----------------------------------------------
  "   <Leader>f{char}      | Find {char} to the right. See |f|.
  "   <Leader>F{char}      | Find {char} to the left. See |F|.
  "   <Leader>t{char}      | Till before the {char} to the right. See |t|.
  "   <Leader>T{char}      | Till after the {char} to the left. See |T|.
  "   <Leader>w            | Beginning of word forward. See |w|.
  "   <Leader>W            | Beginning of WORD forward. See |W|.
  "   <Leader>b            | Beginning of word backward. See |b|.
  "   <Leader>B            | Beginning of WORD backward. See |B|.
  "   <Leader>e            | End of word forward. See |e|.
  "   <Leader>E            | End of WORD forward. See |E|.
  "   <Leader>ge           | End of word backward. See |ge|.
  "   <Leader>gE           | End of WORD backward. See |gE|.
  "   <Leader>j            | Line downward. See |j|.
  "   <Leader>k            | Line upward. See |k|.
  "   <Leader>n            | Jump to latest "/" or "?" forward. See |n|.
  "   <Leader>N            | Jump to latest "/" or "?" backward. See |N|.
  "   <Leader>s            | Find(Search) {char} forward and backward.
  "                        | See |f| and |F|.

  " Turn on case-insensitive feature
  let g:EasyMotion_smartcase = 1
  " keep cursor column when JK motion
  let g:EasyMotion_startofline = 0

  " `s{char}{char}{label}`
  " Need one more keystroke, but on average, it may be more comfortable.
  nmap s <Plug>(easymotion-overwin-f2)
  map <leader>j <Plug>(easymotion-j)
  map <leader>k <Plug>(easymotion-k)
  map <leader>l <Plug>(easymotion-lineforward)
  map <leader>h <Plug>(easymotion-linebackward)
" }}

" https://github.com/terryma/vim-smooth-scroll {{
  " Distance: This is the total number of lines you want to scroll
  " Duration: This is how long you want each frame of the scrolling animation to last in milliseconds. Each frame will take at least this amount of time. It could take more if Vim's scrolling itself is slow
  " Speed: This is how many lines to scroll during each frame of the scrolling animation
  " noremap <silent> <c-u> :call smooth_scroll#up(&scroll, 16, 2)<CR>
  " noremap <silent> <c-d> :call smooth_scroll#down(&scroll, 16, 2)<CR>
  " noremap <silent> <c-b> :call smooth_scroll#up(&scroll*2, 16, 4)<CR>
  " noremap <silent> <c-f> :call smooth_scroll#down(&scroll*2, 16, 4)<CR>
" }}

" https://github.com/yuttie/comfortable-motion.vim {{
  let g:comfortable_motion_no_default_key_mappings = 1
  let g:comfortable_motion_impulse_multiplier = 1  " Feel free to increase/decrease this value.
  nnoremap <silent> <C-d> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 2)<CR>
  nnoremap <silent> <C-u> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -2)<CR>
  nnoremap <silent> <C-f> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * 4)<CR>
  nnoremap <silent> <C-b> :call comfortable_motion#flick(g:comfortable_motion_impulse_multiplier * winheight(0) * -4)<CR>
" }}

" https://github.com/vim-scripts/open-browser.vim {{
  " if it looks like URI, Open URI under cursor.
  " Otherwise, Search word under cursor.
  nmap <leader>o <Plug>(openbrowser-smart-search)
" }}


" https://github.com/terryma/vim-multiple-cursors {{
  let g:multi_cursor_use_default_mapping=0

  " Default mapping
  let g:multi_cursor_start_word_key      = '<C-n>'
  let g:multi_cursor_select_all_word_key = '<A-n>'
  let g:multi_cursor_start_key           = 'g<C-n>'
  let g:multi_cursor_select_all_key      = 'g<A-n>'
  let g:multi_cursor_next_key            = '<C-n>'
  let g:multi_cursor_prev_key            = '<C-p>'
  let g:multi_cursor_skip_key            = '<C-x>'
  let g:multi_cursor_quit_key            = '<Esc>'
" }}


" https://github.com/terryma/vim-expand-region {{
  map K <Plug>(expand_region_expand)
  map J <Plug>(expand_region_shrink)
" }}

" https://github.com/simnalamburt/vim-mundo {{
  let g:mundo_right = 1
  nnoremap <silent> <leader>u :MundoToggle<CR>
" }}

" https://github.com/voldikss/vim-translate-me {{
  let g:vtm_default_mapping = 0
  " 翻译光标下的文本，在命令行回显翻译内容
  " nmap <silent> <leader>ttt <Plug>Translate
  " vmap <silent> <leader>ttt <Plug>TranslateV
  " 翻译光标下的文本，在窗口中显示翻译内容
  nmap <silent> <leader>tt <Plug>TranslateW
  vmap <silent> <leader>tt <Plug>TranslateWV
" }}


" https://github.com/mhinz/vim-startify {{
  let g:startify_files_number        = 10
  let g:startify_bookmarks = [
        \ { 'v': dotfiles.'/.vimrc' },
        \ { 'p': dotfiles.'/.plug.vim' },
        \ { 'c': dotfiles.'/coc-settings.json' },
        \ { 'p': dotfiles.'/.plug.vim' },
        \ { 'z': dotfiles.'/.zshrc' },
        \]
  let g:startify_change_to_dir       = 1
  let g:startify_update_oldfiles     = 1
  let g:startify_session_autoload    = 1
" }}

" https://github.com/junegunn/goyo.vim {{
  let g:goyo_width = 120
  let g:goyo_height = '80%'
  let g:goyo_linenr = 0
  noremap <leader>e :Goyo<CR>
  function! s:goyo_enter()
    set noshowcmd
    set scrolloff=999
    if g:hardtime_default_on == 1
      exec "HardTimeOff"
    endif
    Limelight
    " colorscheme solarized8_light
    echo "加油! Deadline 是第一生产力 ..."

    let b:quitting = 0
    let b:quitting_bang = 0
    autocmd QuitPre <buffer> let b:quitting = 1
    cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
  endfunction

  function! s:goyo_leave()
    set showcmd
    set scrolloff=5
    if g:hardtime_default_on == 1
      exec "HardTimeOn"
    endif
    Limelight!
    " colorscheme molokai

    " Quit Vim if this is the only remaining buffer
    if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
      if b:quitting_bang
        qa!
      else
        qa
      endif
    endif
  endfunction

  autocmd! User GoyoEnter nested call <SID>goyo_enter()
  autocmd! User GoyoLeave nested call <SID>goyo_leave()
" }}

" https://github.com/junegunn/limelight.vim {{
  " Default: 0.5
  let g:limelight_default_coefficient = 0.6
  nnoremap <leader>v :Limelight!! 0.6<CR>
" }}

" https://github.com/ryanoasis/vim-devicons {{
  " useful ?
  " if exists('g:loaded_webdevicons')
  "   call webdevicons#refresh()
  " endif
  " let g:webdevicons_conceal_nerdtree_brackets = 1
  let g:WebnevIconsOS = 'Darwin'

  let g:webdevicons_enable = 1
  let g:webdevicons_enable_nerdtree = 1
  let g:webdevicons_enable_startify = 1
  let g:webdevicons_enable_ctrlp = 1
  " Force extra padding in NERDTree so that the filetype icons line up vertically
  let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
  " let g:DevIconsDefaultFolderOpenSymbol = ''
  let g:DevIconsEnableFoldersOpenClose = 1

  " let g:WebDevIconsNerdTreeAfterGlyphPadding = ' '
  let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol='~'
  let g:DevIconsEnableFolderPatternMatching = 1
  let g:WebDevIconsUnicodeDecorateFolderNodes = 1
" }}


" https://github.com/itchyny/lightline.vim {{
  " Set statusline screen break point
  let s:screen_xs = 30
  let s:screen_sm = 60
  let s:screen_md = 80
  let s:screen_lg = 120
  let s:screen_xl = 150

  " NOTE: only work once right now ... not support toggle
  " change lightline colorscheme on the fly
  augroup LightLineColorscheme
    autocmd!
    autocmd ColorScheme * call s:lightline_update()
  augroup END
  function! s:lightline_update()
    if !exists('g:loaded_lightline')
      return
    endif
    try
      if &background == 'dark'
        let g:lightline.colorscheme = 'powerline'
      else
        let g:lightline.colorscheme = 'solarized'
      endif
      call lightline#init()
      call lightline#colorscheme()
      call lightline#update()
    catch
    endtry
  endfunction

  " NOTE: fonts @see - https://github.com/ryanoasis/nerd-fonts/issues/144
  " NOTE: @Install -  Fonts: 安装 https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts 然后终端设置成该字体，字号 14 号 ( 因为 emoji icon 太太，12 号不和谐，vertical 100% and horizontal < 100% )
  " brew tap caskroom/fonts
  " brew cask install font-hack-nerd-font
  let g:lightline = {
        \ 'colorscheme': 'powerline',
        \ 'enable': {
        \   'tabline': 1,
        \   'statusline': 1,
        \ },
        \ 'tab': {
        \   'active': [ 'name', 'closeicon' ],
        \   'inactive': [ 'name', 'close' ],
        \ },
        \ 'tabline': {
        \   'left': [ [ 'tabsicon', 'tabs' ] ],
		    \   'right': [ [ 'tabsicon' ] ],
        \ },
        \ 'tab_component_function': {
        \   'name': 'LightlineTabName',
        \ },
        \ 'tabline_separator': { 'left': "", 'right': "" },
        \ 'tabline_subseparator': { 'left': "", 'right': "" },
        \ 'active': {
        \   'left': [
        \     [ 'mode', 'paste' ],
        \     [ 'ctrlpmark', 'git', 'diagnostic', 'cocstatus', 'filename', 'method', 'blame' ]
        \   ],
        \   'right':[
        \     [ 'filetype', 'fileencoding', 'lineinfo', 'percent' ],
        \     [ 'coc' ]
        \   ],
        \ },
        \ 'inactive': {
        \   'left': [ ['mode', 'filename'] ],
        \   'right':[ ['lineinfo', 'percent'] ],
        \ },
        \ 'component': {
        \ },
        \ 'component_expand': {
        \   'diagnostic': 'LightlineCocDiagnostic',
        \   'cocstatus': 'LightlineCocStatus',
        \ },
        \ 'component_function': {
        \   'tabsicon': 'LightlineTabIcon',
        \   'mode': 'LightlineMode',
        \   'ctrlpmark': 'CtrlPMark',
        \   'git': 'LightLineGit',
        \   'filename': 'LightlineFilename',
        \   'method': 'LightlineMethod',
        \   'blame': 'LightlineGitBlame',
        \   'coc': 'LightlineCoc',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileEncoding',
        \   'lineinfo': 'LightLineLineInfo',
        \   'percent': 'LightlinePercent',
        \ },
        \ 'separator': { 'left': "\ue0b0", 'right': "\ue0b2" },
        \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
        \ }

  function! PatchTablineColor(bg)
    " change tabline color here
    " tabline color as inactive color
    let s:tablinecolor = '#d0d0d0'
    " tabline bgcolor
    let s:tablinebg = '#585858'
    if a:bg == 'dark'
      let s:palette = g:lightline#colorscheme#powerline#palette
    else
      let s:palette = g:lightline#colorscheme#solarized#palette
    endif

    " 定义 active tab color & bgcolor( same as Normal mode bgcolor )
    let s:palette.tabline.tabsel = [ [ '#606060', '#afdf00', 252, 66, 'bold' ] ]
    " 定义 tabline 背景与颜色，也就是 x 号颜色，x 号背景
    let s:palette.tabline.left = [ [ s:tablinecolor, s:tablinebg, 252, 66 ] ]
    let s:palette.tabline.middle = [ [ s:tablinecolor, s:tablinebg, 252, 66 ] ]
    let s:palette.tabline.right = [ [ s:tablinecolor, s:tablinebg, 252, 66 ] ]
  endfunction

  function! LightlineMode()
    call PatchTablineColor(&background)
    let fname = expand('%:t')
    return fname =~ 'NERD_tree' ? 'NERD' :
          \ fname == 'ControlP' ? 'CtrlP' :
          \ &filetype == 'ctrlsf' ? 'CtrlSF' :
          \ &filetype == 'quickmenu' ? 'Menu' :
          \ &filetype == 'startify' ? 'Startify' :
          \ winwidth(0) > s:screen_xs ? lightline#mode() : ''
  endfunction

  function! LightlineTabIcon(...)
    return '🔥'
  endfunction

  " https://github.com/itchyny/lightline.vim/issues/302
  function! LightlineTabNum(n)
    " instead of tabpagenr(), use code below to active and inactive tabnum
    let cur = a:n
    " http://xahlee.info/comp/unicode_circled_numbers.html
    let iconmap = [ '❶ ', '❷ ', '❸ ', '❹ ', '❺ ', '❻ ', '❼ ', '❽ ', '❾ ']
    " let iconmap = ['① ', '② ', '③ ', '④ ', '⑤ ', '⑥ ', '⑦ ', '⑧ ', '⑨ ']
    return cur >= 10 ? cur : iconmap[cur - 1]
  endfunction

  " https://github.com/itchyny/lightline.vim/issues/297
  function! LightlineTabName(n)
    let winnr = tabpagewinnr(a:n)
    let bufnr = tabpagebuflist(a:n)[winnr - 1]
    let modified = gettabwinvar(a:n, winnr, '&modified') ? '+' : gettabwinvar(a:n, winnr, '&modifiable') ? '' : '-'
    let fname = expand('#' . bufnr . ':t')
    let _ = fname =~ 'NERD_tree' ? 'NERDTree' :
           \ ('' != fname ? fname : '[No Name]')
    " use file.filename as file.${ext} to show active and inactive icons
    return LightlineTabNum(a:n) . _ . ' ' . WebDevIconsGetFileTypeSymbol('file'.fname) . ' ' . modified
  endfunction

  " like /etc/hosts readonly file
  function! LightlineReadonly()
    let ft = &filetype
    let fname = expand('%:t')
    let isBar = fname =~ 'NERD_tree' || ft == 'quickmenu'
    if isBar
      return ''
    endif
    if &filetype == "help"
      return ''
    elseif &readonly
      return ""
    else
      return ''
    endif
  endfunction

  function! LightLineGit()
    let branch = get(g:, 'coc_git_status', '')
    let s:threshold = 12
    " show just important info when branch name too long
    let parts = split(branch, '/')
    let branch = strlen(branch) > s:threshold ? parts[len(parts) - 1] : branch
    let gutter = trim(get(b:, 'coc_git_status', ''))
    let full = branch . (gutter != '' ? ' ¶ ' . gutter : '')
    return winwidth(0) > s:screen_md ? full : winwidth(0) > s:screen_sm ? branch : ''
  endfunction

  function! LightlineCocDiagnostic() abort
    let info = get(b:, 'coc_diagnostic_info', {})
    if empty(info) | return '' | endif
    let msgs = []
    if get(info, 'error', 0)
      " call add(msgs, 'E' . info['error'])
      " call add(msgs, '⨶ ' . info['error'])
      " call add(msgs, '❌ ' . info['error']) " 颜色很好，但符号太大了，不太协调
      call add(msgs, '❎ ' . info['error'])
    endif
    if get(info, 'warning', 0)
      " call add(msgs, 'W' . info['warning'])
      " call add(msgs, '⚠ ' . info['warning'])
      call add(msgs, '⚠️  ' . info['warning'])
    endif
    return join(msgs, ' ')
  endfunction

  " NOTE: 展示 ts version & prettier，没啥意义，暂时注释掉
  function! LightlineCocStatus() abort
    " let coc_status = get(g:, 'coc_status', '')
    return ''
  endfunction

  function! LightlineGitBlame() abort
    let blame = get(b:, 'coc_git_blame', '')
    " return blame
    return winwidth(0) > s:screen_md ? blame : ''
  endfunction

  autocmd User CocDiagnosticChange call lightline#update()


  function! LightlineModified()
    return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
  endfunction

  function s:shorten(_, val)
    let wind = winwidth(0)
    let s:shorter = wind > s:screen_xl ? 10 : wind > s:screen_lg ? 3 : wind > s:screen_sm ? 2 : 1
    return strpart(a:val, 0, s:shorter)
  endfunction

  " relative path to root with shorten
  function! LightlineRaPathName()
    let fname = expand('%:t')
    let fullfname = expand('%')
    let root = fnamemodify(get(b:, 'git_dir'), ':h')
    let path = expand('%:p')
    try
      if path[:len(root)-1] ==# root
        let rawpath = path[len(root)+1:]
        let splits = split(rawpath, '/')
        let parts = deepcopy(splits)
        call remove(parts, len(parts) - 1)
        let mapped = map(parts, function('s:shorten'))
        let joined = join(mapped, '/')
        return joined == '' ? fname : joined.'/'.fname
      else
        return fname
      endif
    catch
      return fname
    endtry
  endfunction

  function! LightlineFilename()
    let fname = expand('%:t')
    let fullfname = LightlineRaPathName()
	  let ret = ('' != LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
	        \ ('' != fname ? fname : '[No Name]') .
	        \ ('' != LightlineModified() ? ' ' . LightlineModified() : '')
    let isHidden = &filetype == '' || &filetype == 'nerdtree' || &filetype == 'startify' || &filetype == 'quickmenu' || fname == 'ControlP'
    let _  = isHidden ? '' : (winwidth(0) > s:screen_md ? fullfname : ret) . ' ' . WebDevIconsGetFileTypeSymbol()
    return winwidth(0) > s:screen_sm ? _ : ''
  endfunction

  function! LightlineMethod()
    " 必须双引号
    let f_icon = "\uf794"
    let name = get(b:, 'coc_current_function', '')
    let _ = name != '' ? f_icon . ' ' . name : ''
    return winwidth(0) > s:screen_md ? _ : ''
  endfunction

  function! LightlineCoc()
    return winwidth(0) > s:screen_xl ? '⚡Powered By  coc.nvim' : ''
  endfunction

  function! LightlineFiletype()
    let ft = &filetype !=# '' ? &filetype : 'no ft'
    let fname = expand('%:t')
    return fname =~ 'NERD_tree' ? '' :
          \ fname == 'ControlP' ? '' :
          \ &filetype == 'ctrlsf' ? '' :
          \ &filetype == 'quickmenu' ? '' :
          \ &filetype == 'startify' ? '' :
          \ winwidth(0) > s:screen_lg ? ft : ''
  endfunction

  function! LightlineFileEncoding()
    let fc = &fenc !=# '' ? &fenc : &enc
    let _ = fc != '' ? fc . ' ' . WebDevIconsGetFileFormatSymbol() : ''
    return winwidth(0) > s:screen_lg ? _ : ''
  endfunction

  function! LightLineLineInfo()
    " without Startify
    let li = printf('㏑%d:%d', line('.'), col('.'))
    let _ = &filetype != 'Startify' ? li : ''
    return winwidth(0) > s:screen_sm ? _ : ''
  endfunction

  function! LightlinePercent()
    let _ = 'Ξ ' . (100 * line('.') / line('$')) . '%'
    " always show percent with Startify
    return &filetype == 'startify' ? '' : _
  endfunction

  " NOTE: override lightline, mark CtrlP all modes and features
  function! CtrlPMark()
    if expand('%:t') =~ 'ControlP' && has_key(g:lightline, 'ctrlp_item')
      " NOTE: 这里映射合法的 lightline#mode() 值即可，regex 对应 0 | 1
      call lightline#link('RV'[g:lightline.ctrlp_regex])
      " g:ctrlp_working_path_mode => return 'ra' or 'r' based on your settings
      return lightline#concatenate([g:lightline.ctrlp_item, g:lightline.ctrlp_regexmode, g:lightline.ctrlp_cwd], 0)

    else
      return ''
    endif
  endfunction

  let g:ctrlp_status_func = {
        \ 'main': 'CtrlPStatusFunc_1',
        \ 'prog': 'CtrlPStatusFunc_2',
        \ }

  function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
    let g:lightline.ctrlp_regex = a:regex
    let g:lightline.ctrlp_regexmode = a:regex == 1 ? 'regexp' : 'normal'
    let g:lightline.ctrlp_prev = a:prev
    let g:lightline.ctrlp_item = a:item
    let g:lightline.ctrlp_next = a:next
    " NOTE: 这里只是 hardcode 了 getcwd，可以根据 path_mode 来动态设置真实搜索目录
    let g:lightline.ctrlp_cwd = getcwd()
    return lightline#statusline(0)
  endfunction

  function! CtrlPStatusFunc_2(str)
    return lightline#statusline(0)
  endfunction
" }}


" https://github.com/scrooloose/nerdtree {{
  " do not show ? help & up a dir
  " let NERDTreeMinimalUI = 1

  " file system menu
  " https://sookocheff.com/post/vim/creating-a-new-file-or-directoryin-vim-using-nerdtree/

  " Tree UI
  let g:NERDTreeWinSize = bar_width
  let g:NERDTreeDirArrowExpandable = '▸'
  let g:NERDTreeDirArrowCollapsible = '▾'
  " let NERDTreeNodeDelimiter="\x07"     "bell
  " let NERDTreeNodeDelimiter="\u00b7"   "middle dot
  " let NERDTreeNodeDelimiter="\u00a0"   "non-breaking space
  let NERDTreeNodeDelimiter="😀"

  " 在 Handler 里设置
  " How can I open NERDTree automatically when vim starts up on opening a directory?
  " autocmd StdinReadPre * let s:std_in=1
  " autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

  " map
  nmap <silent> <leader>t :NERDTreeToggle<CR>
  " 进入文件自动关闭 Tree
  let NERDTreeQuitOnOpen = 0
  " show hidden files, add in 20160125
  let g:NERDTreeShowHidden = 1
  let NERDTreeIgnore = [ '\.obj$', '\.o$', '\.so$', '\.egg$' ]
  "close vim if the only window left open is a NERDTree
  autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | end
" }}


" https://github.com/tiagofumo/vim-nerdtree-syntax-highlight {{
  " NOTE: https://github.com/tiagofumo/vim-nerdtree-syntax-highlight/issues/30
  let s:git_orange = 'F54D27'
  let g:NERDTreeExtensionHighlightColor = {}
  let g:NERDTreeExtensionHighlightColor['vue'] = '42b883'
  let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
  let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files
  let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
  let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
" }}


" https://github.com/tsony-tsonev/nerdtree-git-plugin {{
  " a heavy feature may cost much more time
  let g:NERDTreeShowIgnoredStatus = 1

  " use color for stutus
  let g:NERDTreeGitStatusWithFlags = 1
  let g:NERDTreeIndicatorMapCustom = {
      \ "Modified"  : "⋆",
      \ "Staged"    : "✚",
      \ "Untracked" : "✭",
      \ "Renamed"   : "➜",
      \ "Unmerged"  : "═",
      \ "Deleted"   : "✖",
      \ "Dirty"     : "⁖",
      \ "Clean"     : "✔︎",
      \ 'Ignored'   : "☒",
      \ "Unknown"   : "?",
      \ }
  let g:NERDTreeGitStatusNodeColorization = 1
  let g:NERDTreeColorMapCustom = {
    \ "Modified"  : ["#528AB3", "NONE", "NONE", "NONE"],
    \ "Staged"    : ["#538B54", "NONE", "NONE", "NONE"],
    \ "Untracked" : ["#BE5849", "NONE", "NONE", "NONE"],
    \ "Dirty"     : ["#299999", "NONE", "NONE", "NONE"],
    \ "Clean"     : ["#87939A", "white", "white", "white"],
    \ "Ignored"   : ["#808080", "black", "NONE", "NONE"]
    \ }
" }}


" https://github.com/skywind3000/quickmenu.vim {{
  let g:quickmenu_max_width = bar_width
  let g:quickmenu_ft_blacklist = ['netrw', 'nerdtree']
  let g:quickmenu_disable_nofile = 0
  " choose a favorite key to show / hide quickmenu
  noremap <silent><leader>b :call OpenMenu()<cr>
  " enable cursorline (L) and cmdline help (H)
  let g:quickmenu_options = "L"
  function! OpenMenu()
    call plug#load('quickmenu.vim')
    call quickmenu#current('menu')
    " Reset Old
    call quickmenu#reset()
    " Build Menu
    call quickmenu#header('Menu Bar')
    call quickmenu#append("# Git", '')
    " use fugitive to show diff
    call quickmenu#append("Git Diff", 'Gvdiff', "use fugitive's Gvdiff on current document")
    call quickmenu#append("Git Blame", 'Gblame', "use fugitive's Gblame on current document")
    call quickmenu#append("Git Status", 'Gstatus', "use coc-git's Gstatus on current document")
    call quickmenu#append("Git Log", '0Glog', "use fugitive's 0Glog on current document")

    " new section
    call quickmenu#append("# Misc", '')
    call quickmenu#append("Color Schema Light", "call ColorschemeChange('light')", "turn on light colorscheme")
    call quickmenu#append("Color Schema Dark" , "call ColorschemeChange('dark')", "turn on dark colorscheme")
    call quickmenu#append("Wakatime Dashboard", "OpenBrowser https://wakatime.com/dashboard", "go to wakatime")
    call quickmenu#append("Code Outline List" , "CocList --number-select --auto-preview outline", "show code outline")
    " Open it
    call quickmenu#toggle('menu')
  endfunction

  function! ColorschemeChange(type)
    if a:type == 'dark'
      set background=dark
      execute('colorscheme '.g:vim_theme_dark)
    else
      set background=light
      echo g:vim_theme_light
      execute('colorscheme '.g:vim_theme_light)
    endif
    " not works perfect
    " patch vim-vue syntax highlight - @see https://github.com/posva/vim-vue#my-syntax-highlighting-stops-working-randomly
    if &filetype == 'vue'
      syntax sync fromstart
    endif
  endfunction
  " quit when only quickmenu tab left
  autocmd bufenter * if (winnr("$") == 1 && (&filetype == 'quickmenu')) | q | end
" }}

" https://github.com/Yggdroot/indentLine {{
  let g:indentLine_enabled = 0
  let g:indentLine_char = '┆'
  let g:indentLine_fileTypeExclude = ['startify', 'json']
  let g:indentLine_concealcursor = 'niv'
  nnoremap <leader>i :IndentLinesToggle<CR>
" }}

" https://github.com/liuchengxu/vim-which-key {{
  let g:which_key_map_leader = {
      \ 'name' : '+leader'                   ,
      \ "'"    : ['', 'open-terminal']       ,
      \ '-'    : ['', 'split-window-below']  ,
      \ '/'    : ['', 'split-window-right']  ,
      \ '1'    : ['', 'tab1']                ,
      \ '2'    : ['', 'tab2']                ,
      \ '3'    : ['', 'tab3']                ,
      \ '4'    : ['', 'tab4']                ,
      \ '5'    : ['', 'tab5']                ,
      \ '6'    : ['', 'tab6']                ,
      \ '7'    : ['', 'tab7']                ,
      \ '8'    : ['', 'tab8']                ,
      \ '9'    : ['', 'tab9']                ,
      \ 'a'    : ['', 'show-documentation']  ,
      \ 'b'    : ['', 'toggle-menu']         ,
      \ 'c'    : ['', 'toggle-commenter']    ,
      \ 'ca'   : ['', 'codeaction']          ,
      \ 'd'    : ['', 'definition']          ,
      \ 'dd'   : ['', 'jsdoc']               ,
      \ 'e'    : ['', 'toggle-editmode']     ,
      \ 'f'    : {
      \ 'name' : '+fzf'                      ,
      \ 'c'    : ['', 'commits']             ,
      \ 'cb'   : ['', 'buffer-commits']      ,
      \ 'f'    : ['', 'files']               ,
      \ 'm'    : ['', 'maps']                ,
      \ 'r'    : ['', 'rg-search']           ,
      \ 'w'    : ['', 'rg-search-cword']     ,
      \ }                                    ,
      \ 'g'    : {
      \ 'name' : '+git'                      ,
      \ 'c'    : ['', 'git-commit']          ,
      \ 'm'    : ['', 'git-commit-msg']      ,
      \ 'n'    : ['', 'git-nextchunk']       ,
      \ 'o'    : ['', 'git-open-browser']    ,
      \ 'p'    : ['', 'git-prevchunk']       ,
      \ }                                    ,
      \ 'h'    : ['', 'motion-lineforward']  ,
      \ 'i'    : ['', 'toggle-indentline']   ,
      \ 'ip'   : ['', 'implementation']      ,
      \ 'j'    : ['', 'motion-down']         ,
      \ 'k'    : ['', 'motion-up']           ,
      \ 'l'    : ['', 'motion-linebackward'] ,
      \ 'm'    : ['', 'markdown-preview']    ,
      \ 'M'    : ['', 'markdown-stop']       ,
      \ 'n'    : ['', 'toggle-number']       ,
      \ 'o'    : ['', 'open-browser']        ,
      \ 'p'    : ['', 'prettier']            ,
      \ 'q'    : ['', 'save-and-quit']       ,
      \ 'r'    : ['', 'which_key_ignore']    ,
      \ 'rr'   : ['', 'async-run-buffer']    ,
      \ 'rf'   : ['', 'references']          ,
      \ 'rn'   : ['', 'rename']              ,
      \ 's'    : ['', 'find-symbol']         ,
      \ 'sf'   : ['', 'ctrlsf']              ,
      \ 't'    : ['', 'toggle-filetree']     ,
      \ 'tt'   : ['', 'translate-cword']     ,
      \ 'td'   : ['', 'type-definition']     ,
      \ 'u'    : ['', 'toggle-undotree']     ,
      \ 'v'    : ['', 'toggle-limelight']    ,
      \ 'w'    : ['', 'save']                ,
      \ 'W'    : ['', 'sudo-save']           ,
      \ 'x'    : ['', 'rm-trailing-space']   ,
      \ 'y'    : ['', '+empty']              ,
      \ 'z'    : ['', 'toggle-codefolder']   ,
      \ }
  " non-leader key
  let g:which_key_map_space = {
      \ 'name' : '+coc'                      ,
      \ '['    : ['', 'which_key_ignore']    ,
      \ ']'    : ['', 'which_key_ignore']    ,
      \ 'c'    : ['', 'coc-commands']        ,
      \ 'd'    : ['', 'coc-diagnostics']     ,
      \ 'e'    : ['', 'coc-extensions']      ,
      \ 'g'    : ['', 'coc-git-status']      ,
      \ 'l'    : ['', 'coc-lists']           ,
      \ 'o'    : ['', 'coc-outline']         ,
      \ 'r'    : ['', 'coc-list-resume']     ,
      \ 'y'    : ['', 'coc-yank-list']       ,
      \ }
  nnoremap <silent> <leader> :<c-u>WhichKey '<leader>'<CR>
  nnoremap <silent> <Space> :<c-u>WhichKey '<Space>'<CR>
  autocmd! User vim-which-key call WhichKey_Init()
  function! WhichKey_Init()
    call which_key#register(g:mapleader, 'g:which_key_map_leader')
    call which_key#register('<Space>', 'g:which_key_map_space')
  endfunction
" }}

" https://github.com/scrooloose/nerdcommenter {{
  let g:NERDCreateDefaultMappings = 0
  nnoremap <leader>c :call NERDComment(0, "toggle")<CR>
  vnoremap <leader>c :call NERDComment(0, "toggle")<CR>
  " Add spaces after comment delimiters by default
  let g:NERDSpaceDelims = 1
  " Use compact syntax for prettified multi-line comments
  let g:NERDCompactSexyComs = 1
  " Align line-wise comment delimiters flush left instead of following code indentation
  let g:NERDDefaultAlign = 'left'
  " Allow commenting and inverting empty lines (useful when commenting a region)
  let g:NERDCommentEmptyLines = 1
  " Enable trimming of trailing whitespace when uncommenting
  let g:NERDTrimTrailingWhitespace = 1
  " Enable NERDCommenterToggle to check all selected lines is commented or not
  let g:NERDToggleCheckAllLines = 1

  let g:ft = ''
  function! NERDCommenter_before()
    if &ft == 'vue'
      let g:ft = 'vue'
      let stack = synstack(line('.'), col('.'))
      if len(stack) > 0
        let syn = synIDattr((stack)[0], 'name')
        if len(syn) > 0
          exe 'setf ' . substitute(tolower(syn), '^vue_', '', '')
        endif
      endif
    endif
  endfunction

  function! NERDCommenter_after()
    if g:ft == 'vue'
      setf vue
      let g:ft = ''
    endif
  endfunction
" }}


" https://github.com/ctrlpvim/ctrlp.vim {{
  " Change the default mapping and the default command to invoke CtrlP:
  nnoremap <silent> <C-p> :CtrlP<CR>
  " search in Files, Buffers and MRU files at the same time.
  let g:ctrlp_cmd = 'CtrlPMixed'
  " the nearest ancestor of the current file that contains one of these directories or files: .git .hg .svn .bzr _darcs
  let g:ctrlp_working_path_mode = 'r'

  " MacOSX / Linux
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip
  let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
  let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn)$',
        \ 'file': '\v\.(exe|so|dll)$',
        \ 'link': 'some_bad_symbolic_links',
        \ }
  " Ignore files in .gitignore
  " let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
  " NOTE: @Install - Use RG for CtrlP - https://github.com/BurntSushi/ripgrep
  " brew install ripgrep
  if executable('rg')
    set grepprg=rg\ --color=never
    let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
    let g:ctrlp_use_caching = 0
  endif
  let g:ctrlp_follow_symlinks = 1
" }}


" https://github.com/dyng/ctrlsf.vim {{
  " NOTE: @Install - Use RG for CtrlSF - https://github.com/BurntSushi/ripgrep
  " brew install ripgrep
  let g:ctrlsf_ackprg = '/usr/local/bin/rg'
  nnoremap <leader>sf :CtrlSF<Space><Right>''<Right><Left>
  let g:ctrlsf_confirm_save = 1
  let g:ctrlsf_auto_close = {
        \ "normal" : 0,
        \ "compact": 0
        \}
  " cwd | project
  let g:ctrlsf_default_root = 'project'
  " normal | compact
  let g:ctrlsf_default_view_mode = 'normal'
  let g:ctrlsf_search_mode = 'async'
  let g:ctrlsf_position = 'left'
  let g:ctrlsf_winsize = '40%'
  " map for 一致性
  let g:ctrlsf_mapping = {
        \ "next": "n",
        \ "prev": "N",
        \ "tab" : "<C-t>",
        \ }
" }}


" https://github.com/junegunn/fzf.vim {{
  " nnoremap <silent> <leader>fb :Buffers<CR>
  " nnoremap <silent> <leader>fc :Colors<CR>
  " nnoremap <silent> <leader>fc :Commands<CR>
  nnoremap <silent> <leader>fc :Commits<CR>
  nnoremap <silent> <leader>fcb :BCommits<CR>
  nnoremap <silent> <leader>ff :call FzfFiles()<CR>
  nnoremap <silent> <leader>fm :Maps<CR>
  nnoremap <silent> <leader>fr :Rg<CR>
  nnoremap <silent> <leader>fw :Rg <C-R><C-W><CR>

  " Customize fzf colors to match your color scheme
  let g:fzf_colors =
  \ { 'fg':      ['fg', 'Normal'],
    \ 'bg':      ['bg', '#5f5f87'],
    \ 'hl':      ['fg', 'Comment'],
    \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
    \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
    \ 'hl+':     ['fg', 'Statement'],
    \ 'info':    ['fg', 'PreProc'],
    \ 'border':  ['fg', 'Ignore'],
    \ 'prompt':  ['fg', 'Conditional'],
    \ 'pointer': ['fg', 'Exception'],
    \ 'marker':  ['fg', 'Keyword'],
    \ 'spinner': ['fg', 'Label'],
    \ 'header':  ['fg', 'Comment'] }

  let g:fzf_commits_log_options = '--graph --color=always
    \ --format="%C(yellow)%h%C(red)%d%C(reset)
    \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'

  "let $FZF_DEFAULT_COMMAND = 'ag --hidden -l -g ""'
  " ripgrep
  if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
    set grepprg=rg\ --vimgrep
    command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
  endif

  let $FZF_DEFAULT_OPTS='--layout=reverse'
  let g:fzf_layout = { 'window': 'call FloatingFZF()' }

  function! FloatingFZF()
    if ! has('nvim')
      return
    endif
    let buf = nvim_create_buf(v:false, v:true)
    call setbufvar(buf, 'number', 'no')

    let height = float2nr(&lines/2)
    let width = float2nr(&columns - (&columns * 2 / 10))
    "let width = &columns
    let row = float2nr(&lines / 3)
    let col = float2nr((&columns - width) / 3)

    let opts = {
          \ 'relative': 'editor',
          \ 'row': row,
          \ 'col': col,
          \ 'width': width,
          \ 'height':height,
          \ }
    let win =  nvim_open_win(buf, v:true, opts)
    call setwinvar(win, '&number', 0)
    call setwinvar(win, '&relativenumber', 0)
  endfunction

  " Files + devicons
  function! FzfFiles()
    let l:fzf_files_options = ' --preview "rougify {2..-1} | head -'.&lines.'"'

    function! s:files()
      let l:files = split(system($FZF_DEFAULT_COMMAND), '\n')
      return s:prepend_icon(l:files)
    endfunction

    function! s:prepend_icon(candidates)
      let l:result = []
      for l:candidate in a:candidates
        let l:filename = fnamemodify(l:candidate, ':p:t')
        let l:icon = WebDevIconsGetFileTypeSymbol(l:filename, isdirectory(l:filename))
        call add(l:result, printf('%s %s', l:icon, l:candidate))
      endfor

      return l:result
    endfunction

    function! s:edit_file(item)
      let l:pos = stridx(a:item, ' ')
      let l:file_path = a:item[pos+1:-1]
      execute('silent e'. l:file_path)
    endfunction

    call fzf#run({
          \ 'source': <sid>files(),
          \ 'sink':   function('s:edit_file'),
          \ 'options': '-m ' . l:fzf_files_options,
          \ 'down':    '40%' ,
          \ 'window': 'call FloatingFZF()'})
  endfunction
" }}


" https://github.com/rhysd/git-messenger.vim {{
  let g:git_messenger_no_default_mappings = v:true
  " none | current
  let g:git_messenger_include_diff = 'none'
  let g:git_messenger_always_into_popup = v:true
  nmap <leader>gm <Plug>(git-messenger)

  function! SetupGitMessengerPopup() abort
    " Your favorite configuration here
    nmap <buffer><C-p> o
    nmap <buffer><C-n> O
    nmap <buffer><Esc> q
  endfunction
  autocmd FileType gitmessengerpopup call SetupGitMessengerPopup()
" }}


" https://github.com/leafgarland/typescript-vim {{
  " fix filetype
  autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  autocmd BufNewFile,BufRead *.tsx set filetype=typescript.tsx
" }}
"

" https://github.com/posva/vim-vue {{
  let g:vue_disable_pre_processors = 1

  cnoremap <silent>vuecolor :syntax sync fromstart<CR>
" }}

" https://github.com/iamcco/markdown-preview.nvim {{
  nnoremap <leader>m :MarkdownPreview<CR>
  nnoremap <leader>M :MarkdownPreviewStop<CR>
" }}


" https://github.com/Valloric/MatchTagAlways {{
  let g:mta_filetypes = {
        \ 'html' : 1,
        \ 'xhtml' : 1,
        \ 'xml' : 1,
        \ 'javascript' : 1,
        \ 'jsx' : 1,
        \ 'typescript' : 1,
        \ 'tsx' : 1,
        \ 'vue' : 1,
        \}
" }}


" https://github.com/heavenshell/vim-jsdoc {{
  nmap <silent> <leader>dd :call GenJsDoc()<CR>
  function! GenJsDoc()
    try
      let ft = &filetype
      " patch for vue
      if ft == 'vue'
        " works but not perfect ...
        " autocmd BufRead,BufNewFile *.vue setlocal filetype=javascript.html
        execute('setlocal filetype=javascript.html')
        execute('JsDoc')
        execute('setlocal filetype=vue')
        return
      endif
      execute('JsDoc')
    catch
      " catch and do nothing for not supported filetype
    endtry
  endfunction

  let g:jsdoc_allow_input_prompt = 0
  let g:jsdoc_enable_es6 = 1
  let g:jsdoc_access_descriptions = 2
  let g:jsdoc_underscore_private = 1
  let g:jsdoc_custom_args_regex_only = 1
  let g:jsdoc_custom_args_hook = {
        \ '^\(callback\|cb\)$': {
        \   'type': ' {Function} ',
        \   'description': 'Callback function'
        \ },
        \ '\(err\|error\)$': {
        \   'type': '{Error}'
        \ },
        \ '^\(opt\|options\)$': {
        \   'type': '{Object}'
        \ },
        \ 'handler$': {
        \   'type': '{Function}'
        \ },
        \ '^\(n\|i\)$': {
        \   'type': ' {Number} '
        \ },
        \ '^i$': {
        \   'type': ' {Number} '
        \ },
        \ '^num': {
        \   'type': ' {Number} '
        \ },
        \ '^_\?\(is\|has\)': {
        \   'type': ' {Boolean} '
        \ },
        \ '^arr$': {
        \   'type': ' {Array} '
        \ },
        \ '^str$': {
        \   'type': ' {String} '
        \ },
        \ '^e$': {
        \   'type': ' {Event} '
        \ },
        \ 'el$': {
        \   'type': ' {Element} '
        \ },
        \ '^node$': {
        \   'type': ' {Element} '
        \ },
        \ '^o$': {
        \   'type': ' {Object} '
        \ },
        \ '^obj$': {
        \   'type': ' {Object} '
        \ },
        \ '^fn$': {
        \   'type': ' {Function} '
        \ },
        \}
" }}
