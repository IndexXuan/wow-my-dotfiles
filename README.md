# [IndexVim](https://github.com/IndexXuan/wow-my-dotfiles)

[![time tracker](https://wakatime.com/badge/github/IndexXuan/wow-my-dotfiles.svg)](https://wakatime.com/badge/github/IndexXuan/wow-my-dotfiles)

## 特性
- 基于 [coc.nvim](https://github.com/neoclide/coc.nvim) 强大特性，完整 LSP 支持，异步无阻塞代码补全
- 专注前端以及 Node.js 开发，精选 Vim 插件以及 coc.nvim 扩展
- 极速启动，延时加载 & 按需加载几乎全部插件（基于 Timer 特性）
* 启动时间`nvim --startuptime ~/vimstart.log`:

  PluginCount | StartupTime | File
  ----------- | ----------- |---------
     23+23    | 77 ~ 86ms   | empty (2021.03.05)
     23+23    | 86 ~ 100ms  | 700~ lines *.ts file (2021.03.05)

## 必要环境
* Mac OS
* neovim >= 0.4.0 ( floatwindow feature )
* python3 support for neovim

```bash
pip3 install --user pynvim
```
* [Node](https://github.com/nvm-sh/nvm) and Yarn(https://yarnpkg.com/zh-Hant/)
* [NerdFont](https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts)

```bash
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
```

### 必要工具
- rg (Ripgrep): [BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep) | CtrlP & CtrlSF
- Universal ctags: [ctags.io](https://ctags.io/)，比如 coc outline 为 markdown 生成大纲，算是一种兜底
- code-minimap: [minimap](https://github.com/wfxr/code-minimap)，Rust 写得，用于渲染右侧代码缩略图

## 结构
- [.vimrc](https://github.com/IndexXuan/IndexVim/blob/master/.vimrc) 基础配置，可开关是否加载插件 ( 基础配置已调优，足够在无插件情况下使用 )
- [.plug.vim](https://github.com/IndexXuan/IndexVim/blob/master/.plug.vim) 插件配置
    - 插件由两部分构成，vim-plug 方法块之间的声明以及对应的配置区域 ( 使用双花括号标记每个插件配置，便于导航 )

## 正常初始化加载插件 - 1
Name           | Description
-------------- | ----------------------
[neoclide/coc.nvim](https://github.com/neoclide/coc.nvim) | 基础插件，包含补全，LSP 等强大特性

## 延时加载插件 - 15
Name           | Description
-------------- | ----------------------
[01. vim-wakatime](https://github.com/wakatime/vim-wakatime) | Wakatime 插件
[02. vim-editorconfig](https://github.com/sgur/vim-editorconfig) | editerconfig 支持，纯 viml 实现
[03. comfortable-motion.vim](https://github.com/yuttie/comfortable-motion.vim) | 平滑滚动增强
[04. nerdcommenter](https://github.com/scrooloose/nerdcommenter) | 注释切换功能
[05. MatchTagAlways](https://github.com/Valloric/MatchTagAlways) | 类 xml tag 配置高亮，依赖 python
[06. vim-startify](https://github.com/mhinz/vim-startify) | 启动屏
[07. nerdtree](https://github.com/scrooloose/nerdtree) | 文件树
[08. lightline.vim](https://github.com/itchyny/lightline.vim) | 底部状态栏
[09. vim-nerdtree-syntax-highlight](https://github.com/tiagofumo/vim-nerdtree-syntax-highlight) | 文件树文件类型不同颜色高亮
[10. nerdtree-git-plugin](https://github.com/tsony-tsonev/nerdtree-git-plugin) | 文件树 Git 状态标识
[11. quickmenu.vim](https://github.com/skywind3000/quickmenu.vim) | 自定义菜单栏
[12. vim-devicons](thub.com/ryanoasis/vim-devicons) | Vim 文件类型图标支持
[13. ctrlp.vim](https://github.com/ctrlpvim/ctrlp.vim) | 模糊搜索项目内文件
[14. vim-fugitive](https://github.com/tpope/vim-fugitive) | Git 封装
[15. vim-snippets](https://github.com/honza/vim-snippets) | 提供基础常用 snippets

## 按需加载插件 - 4
Name           | Description
-------------- | ----------------------
[01. vim-which-key](https://github.com/liuchengxu/vim-which-key) | 快捷键导航
[02. open-browser.vim](https://github.com/vim-scripts/open-browser.vim) | 唤起浏览器
[03. ctrlsf.vim](https://github.com/dyng/ctrlsf.vim) | 全局字符搜索
[04. git-messenger](https://github.com/rhysd/git-messenger.vim) | 当前字符 Git 信息展示与历史浏览

## 按文件类型加载插件 - 3
Name           | Description
-------------- | ----------------------
[01. typescript.vim](https://github.com/leafgarland/typescript-vim) | TypeScript
[02. vim-vue](https://github.com/posva/vim-vue) | Vue
[03. markdown-preview.nvim](https://github.com/iamcco/markdown-preview.nvim) | Markdown

## Coc Extensions - 23
Name           | Description
-------------- | ----------------------
[01. coc-git](https://github.com/neoclide/coc-git)                          | Git 扩展
[02. coc-list](https://github.com/neoclide/coc-list)                        | 常用 source list
[03. coc-word](https://github.com/neoclide/coc-word)                        | 单词补全扩展
[04. coc-dictionary](https://github.com/neoclide/coc-sources)               | &directory 补全
[05. coc-emoji](https://github.com/neoclide/coc-emoji)                      | emoji 输入补全扩展
[06. coc-highlight](https://github.com/neoclide/coc-highlight)              | 高亮，支持展示 CSS 颜色代码
[07. coc-pairs](https://github.com/neoclide/coc-pairs)                      | 成对符号补全
[08. coc-yank](https://github.com/neoclide/coc-yank)                        | 复制历史记录列表
[09. coc-vimlsp](https://github.com/iamcco/coc-vimlsp)                      | Vim Language Server
[10. coc-tsserver](https://github.com/neoclide/coc-tsserver)                | TypeScript / JavaScript Language Server
[11. coc-vetur](https://github.com/neoclide/coc-vetur)                      | Vue Language Server
[12. coc-html](https://github.com/neoclide/coc-html)                        | HTML Language Server
[13. coc-css](https://github.com/neoclide/coc-css)                          | CSS Language Server ( css / scss / less ... )
[14. coc-json](https://github.com/neoclide/coc-json)                        | JSON Language Server
[15. coc-yaml](https://github.com/neoclide/coc-yaml)                        | YAML Language Server
[16. coc-prettier](https://github.com/neoclide/coc-prettier)                | 代码格式化
[17. coc-jest](https://github.com/neoclide/coc-jest)                        | Jest 插件
[18. coc-eslint](https://github.com/neoclide/coc-eslint)                    | eslint 插件
[19. coc-stylelintplus](https://github.com/bmatcuk/coc-stylelintplus)       | stylelint 插件
[20. coc-snippets](https://github.com/neoclide/coc-snippets)                | 适配 UltiSnips and VSCode Snippets
[21. vscode-javascript](https://github.com/xabikos/vscode-javascript)       | VSCode JavaScript Snippets
[22. vue-vscode-snippets](https://github.com/IndexXuan/vue-vscode-snippets) | VSCode Vue Snippets
[23. coc-translator](https://github.com/voldikss/coc-translator)            | 翻译插件

## 键位操作
- 默认 `<leader>` 为 `;` 可根据你的习惯修改
- 根据功能的首字母进行组合，充分利用了 a-z 的 26 个字母 ( 极少数为大写 )，便于记忆
- 可以敲击 `<leader>` 键，查看 [vim-which-key](https://github.com/liuchengxu/vim-which-key) 渲染出来的快捷键导航
- `<Space>` 触发 coc 相关命令，也可以敲击 `<Space>` 键，查看 vim-which-key 渲染出来的快捷键导航

* Remap

Keys           | Mode   | Description
-------------- | -------| ----------------
j + j          | Insert | `<Esc>`
Q + Q          | Normal | `:q!`
`=`             | Visual | indent
`-`            | Visual | retab
Y              | Normal | y$
D              | Normal | d$
`<BackSpace>`  | Visual | d
j              | Normal | gj
k              | Normal | gk
`<`            | Visual | `<gv`
`>`            | Visual | `>gv`
y              | Visual | y`]
p              | Normal | p`]
`(`            | Normal | older change position
`)`            | Normal | newer change position


* Emacs-Like Basic Motions ( Insert & Command Mode )

Keys           | Mode   | Description
-------------- | -------| ----------------
Ctrl + b | Insert  | 向左移动
Ctrl + f | Insert  | 向右移动
Ctrl + p | Insert  | 向上移动
Ctrl + n | Insert  | 向下移动
Ctrl + a | Insert  | 移到行首
Ctrl + e | Insert  | 移到行尾
Ctrl + o | Insert  | 生成新行
Ctrl + w | Insert  | 删除光标下整个单词
Ctrl + h | Insert  | 删除映射 `BackSpace`
Ctrl + d | Insert  | 删除光标所在字符
Ctrl + u | Insert  | 当前光标删除到行首
Ctrl + b | Command | 向左移动
Ctrl + f | Command | 向右移动
Ctrl + p | Command | 向上移动
Ctrl + n | Command | 向下移动
Ctrl + a | Command | 移动到行首
Ctrl + e | Command | 移动到行尾
Ctrl + d | Command | 删除光标所在字符
Ctrl + h | Command | 删除映射 `BackSpace`
Ctrl + u | Command | 当前光标删除到行首
Ctrl + t | Command | 回显当前路径

* Advanced Motions

Keys         | Mode   | Description
------------ | -------| ----------------
f            | Normal | 跳转到行首 ( 按理应该为 a，但 a 是内置命令字符 )
e            | Normal | 跳转到行尾

* Window

Keys           | Mode   | Description
-------------- | -------| ----------------
Ctrl + h   | Normal | 移动到左边窗口
Ctrl + l   | Noraml | 移动到右边窗口
Ctrl + j   | Normal | 移动到下边窗口
Ctrl + k   | Normal | 移动到上边窗口
`<Space>`[ | Normal | 窗口宽度减 5
`<Space>`] | Normal | 窗口宽度加 5

* Tabline

Keys          | Mode   | Description
------------- | -------| ----------------
Ctrl + t     | Normal | 新建 tab
Ctrl + t     | Insert | 新建 tab
`<leader>`q  | Normal | 关闭当前 tab
`<Tab>`      | Normal | 切换活跃 tab
`<S-Tab>`    | Normal | 反向切换活跃 tab

* find & filter

Keys           | Mode   | Description
-------------- | -------| ----------------
Ctrl + p      | Normal | CtrlP

 * Git

Keys           | Mode   | Description
-------------- | -------| ----------------
`<leader>`gc  | Normal | git-commit
`<leader>`gm  | Normal | git-commit-msg
`<leader>`gn  | Normal | git-next-chunk
`<leader>`go  | Normal | git-open-browser
`<leader>`gp  | Normal | git-preview-chunk

* leaderKey

Keys          | Mode   | Description
--------------| -------| ----------------
`<leader>`数字| Normal | 数字[0-9]选择 tab
`<leader>`'   | Normal | 开发终端
`<leader>`-   | Normal | 下分屏
`<leader>`/   | Normal | 右分屏
`<leader>`a   | Normal | 显示单词类型文档
`<leader>`b   | Normal | 切换右侧菜单栏显隐
`<leader>`c   | Normal | 切换当前代码注释开关
`<leader>`c   | Visual | 切换当前代码注释开关
`<leader>`ca  | Normal | 代码辅助自动修复
`<leader>`d   | Normal | 显示类型
`<leader>`e   | Normal | 切换编辑模式
`<leader>`g   | Normal | +git 相关 prefix，如上
`<leader>`ip  | Normal | 查找类型的实现
`<leader>`m   | Normal | 开始预览当前编辑的 markdown 文件
`<leader>`M   | Normal | 结束预览当前编辑的 markdown 文件
`<leader>`n   | Normal | 切换行号展示 ( number & relativenumber 混合显示 )
`<leader>`o   | Normal | 使用默认浏览器打开当前链接或搜索当前单词
`<leader>`p   | Normal | 调用 Prettier 命令进行代码自动风格纠正
`<leader>`q   | Normal | 保存并退出 Vim
`<leader>`rr  | Normal | 运行当前文件代码
`<leader>`rf  | Normal | 搜索当前 symbol 引用
`<leader>`rn  | Normal | 当前 symbol 重命名
`<leader>`s   | Normal | 搜索当前 symbol
`<leader>`sf  | Normal | 项目内搜索单词
`<leader>`t   | Normal | 切换左侧文件树显隐
`<leader>`td  | Normal | 显示类型定义
`<leader>`tt  | Normal | 显示当前单词的翻译
`<leader>`w   | Normal | 保存
`<leader>`W   | Normal | 强制保存
`<leader>`x   | Normal | 删除当前文件行尾多余空白
`<leader>`y   | Normal | +empty
`<leader>`z   | Normal | 切换代码折叠

* Coc

Keys       | Mode   | Description
---------- | ------ | ----------------
`<Space>`c | Normal | Coc 可用命令列表
`<Space>`d | Normal | Coc 代码错误诊断列表
`<Space>`e | Normal | Coc 已安装扩展列表
`<Space>`l | Normal | Coc List 列表
`<Space>`o | Normal | Coc 代码大纲
`<Space>`r | Normal | Coc 重复上次操作
`<Space>`y | Normal | Coc yank 历史列表

* TextObject

Keys           | Mode   | Description
-------------- | ------ | ----------------
cs[][]         | Normal | 快速替换成对符号
ds[]           | Normal | 快速删除成对符号内的内容
ysiw[]         | Normal | 快速添加成对符号
yss[]          | Normal | 快速为整句添加成对符号


## 鸣谢
* [coc.nvim](https://github.com/neoclide/coc.nvim) by [@chemzqm](https://github.com/chemzqm)
* [k-vim](https://github.com/wklken/k-vim)
* [ThinkVim](https://github.com/taigacute/ThinkVim)

