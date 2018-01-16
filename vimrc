"Author : kerwin
"这个是我的vim配置，用在gvim上。
"如下是一些f键的按键
"键		单独		Ctrl		shift		Alt
"f1		帮助
"f2		重命名
"f3		ctrlp		doc			gtags -r	vimgrep
"F4
"f5		运行		
"f6		
"f7		文档注释
"f8		IDE			格式化		
"f9		:Gina		Gdiff		git push	commit -a -m		
"f10
"f11
"f12
"

"看到很多大佬用如下方法来配置，我也试试吧
"我的层次是
"打开插件管理
"通用配置
"编程通用配置
"python配置
"c/c++配置
"c#配置
"html插件
"lisp插件
"纯文本插件
"运行F5
"调试 f6
"ctags
"gtags
"格式化代码
"代码检查插件
"git相关
"修改时间
"异步插件
"
"
"
""""""""""""""""""如下是打开插件"""""""""""""
"设置目录
call plug#begin('E:/home/kerwin/vimfiles/pugged')

filetype off   
" Note: Skip initialization for vim-tiny or vim-small.
if 0 | endif

if &compatible
    set nocompatible               " Be iMproved
endif


"
""""""""""""""""""如下是通用配置"""""""""""""

let mapleader=' '
set fileformats=unix,dos
"判断操作系统
if has('win32')
    source $VIMRUNTIME/vimrc_example.vim
    source $VIMRUNTIME/mswin.vim
	source D:/gtags/share/gtags/gtags.vim
    behave mswin
endif
"vim 基本配置 
"编码配置
if has("win32")
	"set fileencoding=chinese
    set fileencoding=utf-8
	if has('gui')
		"如下的设置能保证在gvim，vim 中中文是没问题的.
		set encoding=utf-8
		set termencoding=UTF-8
		set langmenu=zh_CN.utf-8
		"解决菜单乱码
		source $VIMRUNTIME/delmenu.vim
		source $VIMRUNTIME/menu.vim
		"解决consle输出乱码
		language messages zh_CN.utf-8
		"
		set guifont=Dejavu_Sans_Mono:h11:cANSI
	endif
else
	set fileencoding=utf-8
endif

"编码配置
set fileencodings=utf-8,gb18030,gbk,gb2312,cp936,ucs-bom,shift-jis
"当字符大于这个的时候，会自动换行，取消这个选项吧
set textwidth=0
" 不要使用vi的键盘模式，而是vim自己的
set nocompatible
" 语法高亮
set syntax=on
"共享剪贴板  
set clipboard+=unnamed

""""""""""""设置备份及备份目录。
set backspace=indent,eol,start
if has('win32')
    set backupdir=d:\vim\bakfiles
	set undodir=d:\vim\undodir
elseif has('unix')
    set backupdir=~/.vim/bakfiles
	set undodir=~/.vim/undodir
endif
set autochdir

" history文件中需要记录的行数，恢复用到。
set history=1024
"tab相关配置
" Tab键的宽度
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

" 可以在buffer的任何地方使用鼠标（类似office中在工作区双击鼠标定位）
set mouse=a
set selection=exclusive
set selectmode=mouse,key
" 通过使用: commands命令，告诉我们文件的哪一行被改变过
set report=0
" 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=3
"反显光标当前行颜色
if has("gui_running")
	set cursorline
	hi cursorline guibg=#333333
endif
"自动补全  
filetype plugin indent on
set completeopt=longest,menu
"自动补全命令时候使用菜单式匹配列表  
set wildmenu
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
""""""""
" autocmd FileType python set omnifunc=python3complete#Complete
autocmd FileType python set omnifunc=jedi#completions
let g:neocomplete#enable_auto_select = 1
let g:jedi#popup_select_first=1
set completeopt=longest,menuone
let g:jedi#auto_vim_configuration = 1
let g:jedi#popup_on_dot = 1
if !exists('g:neocomplete#force_omni_input_patterns')
		let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\)\w*'
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
" let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
" let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<F2>"
"""""""""

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType java set omnifunc=javacomplete#Complet

"显示配置
syntax enable
if has('gui_running')
    set background=dark
else
    set background=dark
endif
colorscheme solarized
let g:solarized_italic=0 | colorscheme solarized
"colorscheme murphy "old 
"显示行号
set nu
set ruler                   " 打开状态栏标尺
"set cursorline              " 突出显示当前行

"搜索配置
"搜索忽略大小写
set ignorecase
"搜索逐字符高亮
set hlsearch
set incsearch
"行内替换，这个一定要注释掉，因为这个，我在:%s/a/b/g时，只能每行替换第一个。
"set gdefault
set magic           "使用正则时，除了$ . * ^以外的元字符都要加反斜线

"自动编码检测
Plug 'vim-scripts/FencView.vim'
""""Gnudo是保存更改记录的""""
" Plug 'sjl/gundo.vim'
	" let  g:gundo_prefer_python3=1 
	" map <leader>g :GundoToggle<CR>

"快速搜索文件的
Plug 'kien/ctrlp.vim'
	let g:ctrlp_map = '<f3>'
	let g:ctrlp_cmd = 'CtrlP'
	let g:ctrlp_working_path_mode = 'ra'
	let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows

Plug 'junegunn/fzf.vim'


" map <a-F3> :copen<cr>:vimgrep // **
" imap <a-F3> <esc>:copen<cr>:vimgrep // **

map <a-F3> :Ack 
imap <a-F3> :Ack 

"快速搜索文件中的内容的
if executable('ag')
	Plug 'mileszs/ack.vim'
	let g:ackprg = 'ag --vimgrep'
endif

"tagbar是一个taglist的替代品，比taglist更适合c++使用，函数能够按类区分，支持按类折叠显示等，
Plug 'majutsushi/Tagbar'
"快速配括号等
Plug 'vim-scripts/surround.vim'
"状态栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
	let g:airline_powerline_fonts = 1
	let g:airline_theme = 'bubblegum'
	""开tabline功能,方便查看Buffer和切换，这个功能比较不错"
	"""我还省去了minibufexpl插件，因为我习惯在1个Tab下用多个buffer"
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#buffer_nr_show = 1

	if !exists('g:airline_symbols')
		let g:airline_symbols = {}
	endif
"
"树形目录插件
Plug 'vim-scripts/The-NERD-tree'
"按f8就是打开一个IDE
map <F8> <ESC>:NERDTreeToggle <CR><ESC>:TagbarToggle<CR><ESC>
imap <F8> <ESC>:NERDTreeToggle <CR><ESC>:TagbarToggle<CR><ESC>

"括号高亮，不同颜色的。
Plug 'kien/rainbow_parentheses.vim'
	let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

	"always on
	au VimEnter * RainbowParenthesesToggle
	au Syntax * RainbowParenthesesLoadRound
	au Syntax * RainbowParenthesesLoadSquare
	au Syntax * RainbowParenthesesLoadBraces	
""""""""""""""""""如下是编程通用配置"""""""""
"括号等自动补全
"自动补全
function AutoPair()
	:inoremap ( ()<ESC>i
	:inoremap ) <c-r>=ClosePair(')')<CR>
	:inoremap { {<CR>}<ESC>O
	:inoremap } <c-r>=ClosePair('}')<CR>
	:inoremap [ []<ESC>i
	:inoremap ] <c-r>=ClosePair(']')<CR>
	:inoremap " ""<ESC>i
	:inoremap ' ''<ESC>i
endfunction
function! ClosePair(char)
    if getline('.')[col('.') - 1] == a:char
        return "\<Right>"
    else
        return a:char
    endif
endfunction

function! EqualSign(char)
    if a:char  =~ '='  && getline('.') =~ ".*[(<]"
        return a:char
    endif 
    let ex1 = getline('.')[col('.') - 3]
    let ex2 = getline('.')[col('.') - 2]

    if ex1 =~ "[-=+><>\/\*]"
        if ex2 !~ "\s"
            return "\<ESC>i".a:char."\<SPACE>"
        else
            return "\<ESC>xa".a:char."\<SPACE>"
        endif 
    else
        if ex2 !~ "\s"
            return "\<SPACE>".a:char."\<SPACE>\<ESC>a"
        else
            return a:char."\<SPACE>\<ESC>a"
        endif 
    endif
endf
" original repos on github<br>Bundle 'mattn/zencoding-vim'
" 代码补全的 快速自动完成一些if、switch、for、while结构模板代码,Ctrl-\组合键即可完成代码补全
Plug 'drmingdrmer/xptemplate'

"如下的这个是自动写注释的

Plug  'vim-scripts/DoxygenToolkit.vim' 
	let g:DoxygenToolkit_briefTag_pre="@Synopsis      "   
	let g:DoxygenToolkit_paramTag_pre="@Param         "   
	let g:DoxygenToolkit_returnTag   ="@Returns       "   
	let g:DoxygenToolkit_blockHeader="============================================================================"   
	let g:DoxygenToolkit_blockFooter="============================================================================"   
	let g:DoxygenToolkit_authorName="Kerwin Xu"   
	let g:DoxygenToolkit_fileTag = "@filename      "  
   let g:DoxygenToolkit_briefTag_funcName = "yes"

   " for C++ style, change the '@' to '\'
   let g:DoxygenToolkit_templateParamTag_pre = "@tparam "
   let g:DoxygenToolkit_throwTag_pre = "@throw " " @exception is also valid
   let g:DoxygenToolkit_fileTag = "@file "
   let g:DoxygenToolkit_dateTag = "@date "
   let g:DoxygenToolkit_authorTag = "@author : kerwin xu  "
   let g:DoxygenToolkit_versionTag = "@version		:"
   let g:DoxygenToolkit_blockTag = "@name "
   let g:DoxygenToolkit_classTag = "@class "
   let g:doxygen_enhanced_color = 1
   let g:load_doxygen_syntax = 1
	let g:DoxygenToolkit_briefTag_funcName = "yes"
"缩进插件
Plug 'Yggdroot/indentLine'

"Run
Plug 'chemzqm/vim-run'
let g:vim_run_command_map = {
  \'javascript': 'node',
  \'php': 'php',
  \'python': 'python',
  \}
"自动添加空格
fun AutoSpace()
		"设置= + - * 前后自动空格
	" ,后面自动添加空格
    inoremap <buffer>= <c-r>=EqualSign('=')<CR>
    inoremap <buffer>+ <c-r>=EqualSign('+')<CR>
    inoremap <buffer>- <c-r>=EqualSign('-')<CR>
    inoremap <buffer>* <c-r>=EqualSign('*')<CR>
    inoremap <buffer>/ <c-r>=EqualSign('/')<CR>
    inoremap <buffer>> <c-r>=EqualSign('>')<CR>
    inoremap <buffer>< <c-r>=EqualSign('<')<CR>
"    inoremap <buffer>: <c-r>=Swap()<CR>
    inoremap <buffer>, ,<space>
    inoremap <buffer># #<space>
	"实现+-*/前后自动添加空格，逗号后面自动添加空格，适用python
	"支持+= -+ *= /+格式
endfun

func! ProgramConfig()
	call AutoPair()
	call AutoSpace()

endfunc
autocmd FileType ruby,eruby,python,javascript,html,css,xml,java,cs,lisp :call ProgramConfig()

"代码自动提示
Plug 'vim-scripts/AutoComplPop'
	let g:acp_enableAtStartup = 1
	let g:acp_behaviorPythonOmniLength = 2

Plug 'vim-scripts/YankRing.vim'


"快速注释代码
Plug 'vim-scripts/The-NERD-Commenter'
	" Add spaces after comment delimiters by default
	let g:NERDSpaceDelims = 1
	" Use compact syntax for prettified multi-line comments
	let g:NERDCompactSexyComs = 1
	" Align line-wise comment delimiters flush left instead of following code indentation
	let g:NERDDefaultAlign = 'left'
	"n\cc : 为光标以下 n 行添加注释
	"n\cu : 为光标以下 n 行取消注释
	"n\cm : 为光标以下 n 行添加块注释
	"好像emacs的注释就是alt+;，这里也用这个吧。
	map <a-;> <leader>c<space>


""""""""""""""""""如下是python的配置"""""""""
"这个是自动给python加上文件头的
func! HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
	call append(2, '"""@File Name: ' . expand("%"))
    call append(3, "@Author:  kerwin.cn@gmail.com" )
	call append(4, "@Created Time:" . strftime('%Y-%m-%d %H:%M:%S ', localtime()))
	call append(5, "@Last Change: " . strftime('%Y-%m-%d %H:%M:%S ', localtime()))
	call append(6, "@Description :  ")
	call append(7,'"""')
	normal G
	normal k
	normal A
endfunc
"
"这个是给python添加调试的
func! AddPythonBreak()
if has('python3')
python3 <<EOF
_str_break = "import ipdb;ipdb.set_trace()"
#因为存在缩进，所以这里必须得先取得函数的缩进是多少。然后加上缩进迭代添加注释
cb = vim.current.buffer     # 获取当前缓冲区
#获得当前位置
(x,y)=vim.current.window.cursor
#获得当前行
line=cb[x-1]
#首先判断前面有几个缩进啦。
#然后遍历加上注释
num_space=0
len_line=len(line)
while(num_space<len_line):
	if(line[num_space].isspace()):
		num_space=num_space+1
	else:
		s=''.center(num_space,' ')
		cb.append(s+_str_break,x-1)
		break
EOF
endif
endfunc
map <Leader>b :call AddPythonBreak()<CR>

"这个是给python函数的注释，作为__doc__用
func! CommentPython()
if has('python3')
python3 << EOF
from vim import *
list_comment_function=[
	'"""',
	'    Description :',
	'    Arg :',
	'    Returns :',
	'    Raises	 :',
	'"""'
	]
list_comment_class=[
	'"""',
	'Attributes	:',
	'functions	:',
	'',
	'"""'
	]
#因为存在缩进，所以这里必须得先取得函数的缩进是多少。然后加上缩进迭代添加注释
cb = vim.current.buffer     # 获取当前缓冲区
#获得当前位置
(x,y)=vim.current.window.cursor
#获得当前行
line=cb[x-1]
#首先判断前面有几个缩进啦。
#然后遍历加上注释
num_space=0
len_line=len(line)
while(num_space<len_line):
	if(line[num_space].isspace()):
		num_space=num_space+1
	else:
		s=''.center(num_space+4,' ')
		#判断是class还是function。
		if(line[num_space:].startswith('class')):
			for i in list_comment_class:
				# 从x行开始添加注释
				cb.append(s+i,x)
				x=x+1
			
		elif(line[num_space:].startswith('def')):
			for i in list_comment_function:
				# 从x行开始添加注释
				cb.append(s+i,x)
				x=x+1
		break
EOF
endif
endfunc

map <f7> :call CommentPython()<CR>
imap <f7> <ESC>:call CommentPython()<CR>

"用py2exe的，废弃了吧。
func! HeaderSetupPython()
	call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
	call append(2, "# File Name: " . expand("%"))
    call append(2, "# Author:  kerwin.cn@gmail.com" )
	call append(3, "# Created Time:" . strftime('%Y-%m-%d %H:%M:%S ', localtime()))
	call append(4, "# Last Change: " . strftime('%Y-%m-%d %H:%M:%S ', localtime()))
	call setline(5,"")
	call append(6,"from distutils.core import setup")
	call append(7,"import py2exe, sys")\
	call append(8,"sys.argv.append('py2exe')")
	call append(9,"options = {\"py2exe\":{\"compressed\": 1, \"optimize\": 2, \"bundle_files\": 1}}")
	call append(10,"setup(console=[\"" . strpart( expand("%"),5) . "\"])")
    normal G
    normal o
    normal o
endfunc

autocmd BufNewFile *.py  :call HeaderPython()

func! PythonConfig()
	"set foldmethod=indent "代码折叠只以缩进为依据
	setlocal foldlevelstart=99	"默认不折叠
	" Python 文件的一般设置，比如不要 tab 等
	setlocal et | setlocal sta | setlocal sw=4
	" Python Unittest 的一些设置
	" " 可以让我们在编写 Python 代码及 unittest 测试时不需要离开 vim
	" " 键入 :make 或者点击 gvim 工具条上的 mak/pythe 按钮就自动执行测试用例
	compiler pyunit
	setlocal makeprg=python\ %

	"autocmd FileWritePre *.py :call LastModified()
	"添加python的tags
	set tags+=D:/Anaconda3/tags
endfunc

autocmd FileType python :call PythonConfig()

Plug 'davidhalter/jedi-vim' , { 'on': [] }
Plug 'w0rp/ale'
"ale
"始终开启标志列
let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = 'E:'
let g:ale_sign_warning = 'W:'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
" nmap <Leader>s :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
" nmap <Leader>d :ALEDetail<CR>
let g:ale_fix_on_save = 1
"
"
" 500 毫秒后调用 LoadPlug，且只调用一次, 见 `:h timer_start()`
call timer_start(500, 'LoadPlug')
function! LoadPlug(timer) abort
  " 手动加载
  call plug#load('jedi-vim')
  " call plug#load('python-mode')
  call plug#load('vim-gitgutter')

endfunction

" Plug 'maralla/completor.vim'
" set completeopt-=longest
" set completeopt+=menuone
" set completeopt-=menu
" if &completeopt !~# 'noinsert\|noselect'
  " set completeopt+=noselect
" endif

" Plug  'python-mode/python-mode'  , { 'on': [] }
    " let g:pymode_python = 'python3'
	" let g:pymode = 1
	" let g:pymode_path=[]
	" let g:pymode_options = 1
	" let g:pymode_warnings = 1
	" let g:pymode_options_max_line_length = 200
    " "开启python-mode定义的移动方式
    " let g:pymode_motion = 1
    " "按键	功能
    " "[[	Jump to previous class or function (normal, visual, operator modes)
	" "]]	Jump to next class or function (normal, visual, operator modes)
	" "[M	Jump to previous class or method (normal, visual, operator modes)
	" "]M	Jump to next class or method (normal, visual, operator modes)
	" "aC	Select a class. Ex: vaC, daC, yaC, caC (normal, operator modes)
	" "iC	Select inner class. Ex: viC, diC, yiC, ciC (normal, operator modes)
	" "aM	Select a function or method. Ex: vaM, daM, yaM, caM (normal, operator modes)
	" "iM	Select inner function or method. Ex: viM, diM, yiM, ciM (normal, operator modes)
	" " Documentation
	" let g:pymode_doc = 1
	" "let g:pymode_doc_key = 'K'
	" " Override view python doc key shortcut to Ctrl-Shift-d
	" let g:pymode_doc_bind = '<c-f3>'
	" "Linting,代码检查的部分的
	" let g:pymode_lint = 1
    " let g:pymode_lint_ignore="E501"
	" let g:pymode_lint_checker = ['pyflakes','pylint','pep8']
	" "let g:pymode_lint_config = '($VIM)/bundle/Python-mode-klen/pymode/libs/pylama/lint/pylama_pylint/pylint.rc'		
	" "Show error message if cursor placed at the error line  *'g:pymode_lint_message'*
	" let g:pymode_lint_message = 1
	" "Auto open cwindow (quickfix) if any errors have been found
	" let g:pymode_lint_cwindow = 1
	" " Auto check on save
	" let g:pymode_lint_write = 1
	" "Check code on every save (every)
	" let g:pymode_lint_unmodified = 1
	" "Check code when editing (on the fly)
	" let g:pymode_lint_on_fly = 1
	" let g:pymode_lint_sort = ['E', 'C', 'I']  " Errors first 'E',
	" "Auto open cwindow (quickfix) if any errors have been found
	
	" " Support virtualenv
	" let g:pymode_virtualenv = 0
	" " Enable breakpoints plugin
	" let g:pymode_breakpoint = 1
	" let g:pymode_breakpoint_key = 'b'
	" " syntax highlighting
	" let g:pymode_syntax = 1
	" let g:pymode_syntax_all = 1
    " "高亮缩进错误
	" let g:pymode_syntax_indent_errors = g:pymode_syntax_all
    " "高亮空格错误
	" let g:pymode_syntax_space_errors = g:pymode_syntax_all
	" "rope setting
	" let g:pymode_rope = 0
	" let g:pymode_rope_lookup_project = 0 "一定要加这个，要不然遇到中文目录会乱码 的
	" let g:pymode_rope_rename_bind = '<F2>' "改名的
	" let g:pymode_rope_autoimport = 0
    " "自动补全的
    " let g:pymode_rope_completion = 0
    " let g:pymode_rope_complete_on_dot = 1
	" let g:pymode_rope_show_doc_bind = '<C-c>d'
	" let g:pymode_rope_regenerate_on_write = 1 "Regenerate project cache on every save (if file has been modified)
    " "let g:pymode_rope_completion_bind = '<C-Tab>'
    " "<C-c>g跳转到定义处，同时新建竖直窗口打开
    " let g:pymode_rope_goto_definition_bind = '<C-c>g'
    " let g:pymode_rope_goto_definition_cmd = 'vnew'
	" let g:pymode_run = 1
	" "let g:pymode_run_bind = '<F5>'
	" "Folding
	" let g:pymode_folding = 0 "这个是一打开的时候，就折叠的




""""""""""""""""""如下是c#配置"""""""""""""""
fun CsConfig()
	"c#配置
	set makeprg=csc\ /nologo\ %
	set efm+=%A%f(%l\\,%c):%m
		set foldenable
	set foldmethod=indent
	set foldlevel=99 "默认不折叠
	nnoremap @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')

endfun
autocmd FileType cs :call CsConfig()


""""""""""""""""""如下是c/c++配置""""""""""""
func! CompileGcc()
    exec "w"
    let compilecmd="!gcc"
    let compileflag="-o %<"
    if search("mpi\.h")!=0
        let compilecmd="!mpicc"
    endif
    if search("glut\.h")!=0
        let compileflag.=" -lg1ut -lGLU -lGL "
    endif
    if search("cv\.h")!=0
        let compileflag.=" -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h")!=0
        let compileflag.=" -fopenmp "
    endif
    if search("math\.h")!=0
        let compileflag.=" -lm "
    endif
    exec compilecmd." % ".compileflag
endfunc
func! CompileGpp()
    exec "w"
    let compilecmd="!g++"
    let compileflag="-o %<"
    if search("mpi\.h")!=0
        let compilecmd="!mpic++"
    endif
    if search("glut\.h")!=0
        let compileflag.=" -lg1ut -lGLU -lGL "
    endif
    if search("cv\.h")!=0
        let compileflag.=" -lcv -lhighgui -lcvaux "
    endif
    if search("omp\.h")!=0
        let compileflag.=" -fopenmp "
    endif
    if search("math\.h")!=0
        let compileflag.=" -lm "
    endif
    exec compilecmd." % ".compileflag
endfunc

func CConfig()
	set foldenable
	set foldmethod=indent
	set foldlevel=99 "默认不折叠
	nnoremap @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')
endfunc

autocmd FileType cs :call CConfig()


"""""""""""""""""如下是lisp的插件""""""""""""
"Plug 'kovisoft/slimv'
" let g:slimv_impl = 'sbcl'
" let g:slimv_swank_cmd = '!start  "D:/SBCL/1.3.18/sbcl.exe"  --load "D:/Vim/bundle/slimv/slime/start-swank.lisp" '
" let g:paredit_electric_return=1

"""""""""""""""""纯文本"""""""""""""""""""""
au BufEnter *.txt setlocal ft=txt


""""""""""""""""""运行"""""""""""""""""""""""
"根据文件扩展名自动编译的
func! CompileCode()
    exec "w"
	let filePath=expand("%:p")
    if has('win32')
        if &filetype == 'c'
            exec "!d:/Vim/compile_cpp.bat \"%\""
        elseif &filetype == 'cpp'
            exec "!d:/Vim/compile_cpp.bat \"%\""
        elseif &filetype == 'java' 
            exec "!javac \"%\"" 
    	elseif &filetype == 'cs'
            exec "\"!C:\\Program Files (x86)\\MSBuild\\14.0\\Bin\\csc.exe\" \"%\""
    	elseif &filetype == 'python'
            exec "!start python \"%\""
    	elseif &filetype == 'lisp'
            exec "!sbcl --script \"%\""
        endif
    elseif has('unix')
        if &filetype == 'c'
            :call CompileGcc()
        elseif &filetype == 'cpp'
            :call CompileGpp()
        elseif &filetype == 'java' 
            exec "!javac \"%\"" 
    	elseif &filetype == 'cs'
            exec "!mcs \"%\""
    	elseif &filetype == 'python'
            exec "!python \"%\""
        endif
    endif
endfunc
"普通模式和插入模式都可以运行吧。
map <F5> :call CompileCode()<CR>
imap <F5> <ESC>:call CompileCode()<CR>


""""""""""""""""""调试"""""""""""""""""""""""
"根据文件扩展名自动调试的
func! CompileAndDebugC()
    exec "w"
    if &filetype == 'c'
        exec "!gcc % -o %.bin -g -std=c99"
        exec "!gdb ./%.bin"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %.bin -g"
        exec "!gdb ./%.bin"
	elseif &filetype == 'python'
		exec "!python -i -m pdb \"%\""
	endif
endfunc
map <c-f5> :call CompileAndDebugC()<cr>
imap <c-f5> :call CompileAndDebugC()<cr>



""""""""""""""""""ctags""""""""""""""""""""""
"如下是ctags配置
set tags+=tags;
set autochdir

"自动更新ctags
function! AutoUpdateCtags()
    let max = 10
    let dir = './'
    let i = 0
    let break = 0
    while isdirectory(dir) && i < max
        if filereadable(dir . 'tags')
			execute ':!start /B  cd ' . dir . ' & ctags -a tags'
			redraw
            let break = 1
        endif
        if break == 1
            execute 'lcd ' . dir
            break
        endif
        let dir = dir . '../'
        let i = i + 1
	endwhile
endf
autocmd BufWrite *.cpp,*.h,*.c,*.py,*.cs call AutoUpdateCtags()

""""""""""""""""""gtags""""""""""""""""""""""
"自动更新gtags
function! AutoUpdategtags()
    let max = 10
    let dir = './'
    let i = 0
    let break = 0
    while isdirectory(dir) && i < max
        if filereadable(dir . 'GTAGS')
			execute ':!start /B  cd ' . dir . ' & gtags -i'
			redraw
            let break = 1
        endif
        if break == 1
            execute 'lcd ' . dir
            break
		endif
        let dir = dir . '../'
        let i = i + 1
	endwhile
endf
autocmd BufWrite *.cpp,*.h,*.c,*.py,*.cs call AutoUpdategtags()

let Gtags_OpenQuickfixWindow = 1
"在项目文件中搜索匹配的单词（忽略大小写）
"nmap <a-F3> :Gtags -gi<cr><cr>
"在项目文件中搜索光标所在的单词
"nmap <A-e> :Gtags -gi<cr><cr><cr>*.[ch]<cr> 
"跳转到光标所在函数的定义
"nmap <C- :Gtags<cr><cr> 
"搜索光标所在函数的引用
nmap <S-f3> :Gtags -r<cr><cr>
"不用altkeys映射到窗口列表
"set winaltkeys=no 


""""""""""""""""""格式化代码""""""""""""""""
"定义FormartSrc()
function! FormartSrc()
	exec "w"
	if &filetype == 'c'
		exec "!astyle --style=ansi --one-line=keep-statements -a --suffix=none %"
	elseif &filetype == 'cpp' || &filetype == 'hpp'
		exec "r !astyle --style=ansi --one-line=keep-statements -a --suffix=none %> /dev/null 2>&1"
	elseif &filetype == 'perl'
		exec "!astyle --style=gnu --suffix=none %"
	elseif &filetype == 'py'||&filetype == 'python'
		exec "r !autopep8 -i --aggressive %"
	elseif &filetype == 'java'
		exec "!astyle --style=java --suffix=none %"
	elseif &filetype == 'jsp'
		exec "!astyle --style=gnu --suffix=none %"
	elseif &filetype == 'xml'
		exec "!astyle --style=gnu --suffix=none %"
	endif
	exec "e %"
	exec "w"
endfunc
"普通模式和插入模式都可以运行吧
map <c-f8> :call FormartSrc()<CR>
imap <c-f8> <esc>:call FormartSrc()<CR>

""""""""""""""""代码检查插件""""""""""""""""""""""""""""""""
"Bundle 'scrooloose/syntastic'
    ""### syntastic  ...
    "let g:syntastic_error_symbol='>>'
    "let g:syntastic_warning_symbol='>'
    "let g:syntastic_check_on_open=1     "在打开文件的时候检查
    "let g:syntastic_check_on_wq=0
    ""let g:syntastic_python_python_exec = 'python2'      "Configure the python checker to call a Python 3 interpreter rather than Python 2
    "let g:syntastic_enable_highlighting=1
    ""let g:syntastic_python3_checkers=['pyflakes', 'flake8'] "查看支持的选项https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers，这是指定检测python3的语法错误
    ""let g:syntastic_python_checkers=['pyflakes', 'flake8', 'pylint'] "查看支持的选项https://github.com/scrooloose/syntastic/wiki/Syntax-Checkers，这是指定检测python2的语法错误
    "let g:SyntasticCheck=['pyflakes', 'flake8']    "这是指定所有的语言的语法检测机制，最好不要用
    "let g:syntastic_javascript_checkers = ['jsl', 'jshint']
    "let g:syntastic_html_checkers=['tidy', 'jshint']
    "
    "set statusline+=%#warningmsg#
    "set statusline+=%{SyntasticStatuslineFlag()}
    "set statusline+=%*
    "let g:syntastic_always_populate_loc_list = 1
    "let g:syntastic_auto_loc_list = 1       "vim打开的时候，在状态栏下面显示错误栏
    "let g:syntastic_check_on_open = 1
    "let g:syntastic_check_on_wq = 0
    ""### end syntastic ...


"""""""""""""""""""""""如下是git相关"""""""""""""""""""""""""
Plug 'airblade/vim-gitgutter'  , { 'on': [] }
set updatetime=1000

"这个插件不能正常运行。
Plug 'tpope/vim-fugitive'
"Plug 'neoclide/vim-easygit'

"let g:easygit_enable_command = 1

Plug 'lambdalisue/gina.vim'

"这个git，我主要需要的是git status , git add  git commit  , git log , git diff
", git push
"我设置f9键为显示git，其他的看看按个最常用吧。
"其中git log 用 Gina log 这个显示好些
"而git diff 用 Gdiff好些
map <f9> <esc>:Gina 
map <s-f9> <esc>:AsyncRun git push<cr>
map <c-f9> <esc>:Gdiff<cr>
map <a-f9> <esc>:Gina commit -a -m "


"""""""""""""""""""""修改时间"""""""""""""""""""""""""""""""
"Last change用到的函数，返回时间，能够自动调整位置
function! LastChange(...)
	if &mod
	    let sbegin = ''
	    let send = ''
	    if a:0 >= 1
	        let sbegin = a:1.'\s*'
	    endif
	    if a:0 >= 2
	        let send = ' '.a:2
	    endif
	    let pattern =  'Last Change: .\+'
	        \. send
	    let pattern = '^\s*' . sbegin . pattern . '\s*$'
	    let now = strftime('%Y-%m-%d %H:%M:%S',
	        \localtime())
	    let row = search(pattern, 'n')
	    if row  == 0
	        let now = a:1 .  ' Last Change:  '
	            \. now . send
	        call append(2, now)
	    else
	        let curstr = getline(row)
	        let col = match( curstr , 'Last')
	        let spacestr = repeat(' ',col - 1)
	        let now = a:1 . spacestr . 'Last Change:  '
	            \. now . send
	        call setline(row, now)
	    endif
	endif
endfunction

" 保存代码文件前自动修改最后修改时间
au BufWritePre *.sh           call LastChange('#')
au BufWritePre .vimrc,*.vim   call LastChange('"')
au BufWritePre *.c,*.h        call LastChange('//')
au BufWritePre *.cpp,*.hpp    call LastChange('//')
au BufWritePre *.cxx,*.hxx    call LastChange('//')
au BufWritePre *.java         call LastChange('//')
au BufWritePre *.rb           call LastChange('#')
au BufWritePre *.py           call LastChange('#')
au BufWritePre Makefile       call LastChange('#')
au BufWritePre *.php call LastChange('<?php //', '?>')
au BufWritePre *.html,*htm call LastChange('<!--', '-->')



""""""""""""""""""""""""如下是所有函数方法的"""""""""""""""""


"根据文件扩展名自动编译的


"运行编译好的程序
func! RunResult()
    exec "w"
    if search("mpi\.h")!=0
        exec "!mpirun -np 4 ./%<"
    elseif &filetype == "cpp"
        exec "!./%<"
    elseif &filetype == "c"
        exec "!./%<"
    elseif &filetype == 'sh'
            :!./%
    elseif &filetype == "python"
        exec "!python \"%\""
    elseif &filetype == "java"
            exec "!java \"%<\""
    if has('win32')
        if &filetype == 'html'
            exec "\"!C:\\Users\\kerwin\\AppData\\Local\\Google\\Chrome\\Application\\chrome.exe \"" . l:filePath . "\""
        elseif &filetype == 'cs'
            exec "!\"%<.exe\""
        elseif &filetype == 'lisp'
            exec "!sbcl --script \"%\""
        endif
    elseif has('unix')
        if &filetype == 'cs'
            exec "!meno \"%<.exe\""
        endif

    endif
endfunc
"如下是别人编写的一个自动加载上层目录的CSCOPE的。
" function! AutoLoadCTagsAndCScope()
    " let max = 5
    " let dir = './'
    " let i = 0
    " let break = 0
    " while isdirectory(dir) && i < max
        " if filereadable(dir . 'cscope.out') 
            " execute 'cs add ' . dir . 'cscope.out'
            " let break = 1
		" endif
        " if filereadable(dir . 'tags')
            " execute 'set tags +=' . dir . 'tags'
            " let break = 1
        " endif
        " if break == 1
            " execute 'lcd ' . dir
            " break
        " endif
        " let dir = dir . '../'
        " let i = i + 1
    " endwhile
" endf


"call vundle#end()
"到这里Vundle就完成了
call plug#end()
filetype plugin indent on     " required! 
