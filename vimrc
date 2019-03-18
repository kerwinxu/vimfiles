"Author: kerwin
"这个是我的vim配置，用在gvim上。
"如下是一些f键的按键
"键		单独		Ctrl		shift		Alt
"f1		帮助
"f2		重命名
"f3		ctrlp					:Gtags -x	vimgrep
"F4
"f5		运行
"f6
"f7		文档注释
"f8		IDE			格式化		:term		
"f9		加断点	
"f10	:Gina		Gdiff		
"f11
"f12     跳转到定义				查找引用
" <leader>cd	Functions called by this function
" <leader>cc	Functions calling this function
" <leader>ct	Find text string under cursor
" <leader>ce	Find egrep pattern under cursor
" <leader>cf	Find file name under cursor
" <leader>ci	Find files #including the file name under cursor
" <leader>ca	Find places where current symbol is assigned
"<leader>h		打开更改记录
"cs "normal模式下vim-scripts/surround.vim,快速的更改括号的，
"顺便讲匹配的括号一起更换了。
"
"gd 转到当前光标所指的局部变量的定义
"总结是：
" 1，相同就跳到函数的开头：（如果都是左括号或者都是右括号），不同就跳到函数的结尾：
     " {和} 用来跳到函数的开头。
     " [] 和][用来跳到函数的结尾。
" 2，左右左右，“左”在前面。前后前后，“前”也在前面。因此左括号打头则表示向前，右括号打头则表示向后：
     " [[和[] 用来向前跳
     "]] 和][用来向后跳
	 "
"我的配置层次如下"
"通用配置
"各个函数
"插件管理
"
"
"
"""""""""""""""""""""""""""""如下是通用配置""""""""""""""""""""""""""""
" \te: Skip initialization for vim - tiny or vim - small.
source $VIMRUNTIME/mswin.vim
behave mswin "鼠标运行模式为windows模式
"如下的设置能保证在gvim，vim 中中文是没问题的.
set encoding=utf-8
set langmenu=en
" set langmenu=zh_CN.utf-8
language messages zh_CN.utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set makeencoding=char
set imcmdline
" set termencoding=utf-8
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
" set guifont=Dejavu_Sans_Mono:h11:cANSI
if has('gui')
	colors solarized
	" set background=dark
else
	colors Zenburn
endif
""""""""""""设置备份及备份目录。
"必须得先设置生效，然后再设置目录"
set undofile
set backup
set backupdir=D:/Vim/bakfiles
set undodir=D:/Vim/undodir
set cursorline "反显光标当前行颜色
set textwidth=0 "当字符大于这个的时候，会自动换行，取消这个选项吧
set nocompatible " 不要使用vi的键盘模式，而是vim自己的
set syntax=on " 语法高亮
set clipboard+=unnamed "共享剪贴板 
set backspace=indent,eol,start
set history=1024 " history文件中需要记录的行数，恢复用到
set tabstop=4 " Tab键的宽度
set softtabstop=4 " 统一缩进为4
set shiftwidth=4
set iskeyword+=_,$,@,%,#,- " 带有如下符号的单词不要被换行分割
set report=0  " 在被分割的窗口间显示空白，便于阅读
set fillchars=vert:\ ,stl:\ ,stlnc:\
set showmatch " 高亮显示匹配的括号
set matchtime=1 " 匹配括号高亮的时间（单位是十分之一秒）
set scrolloff=3 " 光标移动到buffer的顶部和底部时保持3行距离
set completeopt=longest,menu
set wildmenu "自动补全命令时候使用菜单式匹配列表  
set wildmenu  wildmode=longest,list,full "用于命令行的补全，tab
"自动补全的
	autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
	" autocmd FileType python set omnifunc=python3complete#Complete
	autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	autocmd FileType css set omnifunc=csscomplete#CompleteCSS
	autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
	autocmd FileType java set omnifunc=javacomplete#Complet
	autocmd FileType python set omnifunc=jedi#completions
	set wildchar=<Tab> wildcharm=<C-Z>
set nu "显示行号
set ruler                   " 打开状态栏标尺
set cursorline              " 突出显示当前行
set ignorecase "搜索忽略大小写
set hlsearch "搜索逐字符高亮
set incsearch
"行内替换，这个一定要注释掉，因为这个，我在:%s/a/b/g时，只能每行替换第一个。
"set gdefault
set magic           "使用正则时，除了$ . * ^以外的元字符都要加反斜线
set laststatus=2
" au BufEnter *.txt setlocal ft=txt
"如下是ctags配置
set tags=./.tags;,.tags
set autochdir
let mapleader = ' '
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif        "打开文件的适合，跳转到上次编辑的位置                                                


"""""""""""""""""""""""""""""""""""""""各个函数"""""""""""""""""""""""""""""""""""""""
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
""
function AutoPair()
	:inoremap ( ()<ESC>i
	:inoremap ) <c-r>=ClosePair(')')<CR>
	:inoremap { {}<ESC>i
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
""""""""""""""""""""""""""""""""""""
func! ProgramConfig()
	call AutoPair()
	source D:/gtags/share/gtags/gtags.vim
	source D:/gtags/share/gtags/gtags-cscope.vim
	nmap <f12> :Gtags<cr><cr>"跳转到光标所在函数的定义
	nmap <s-f12> :Gtags -r<cr><cr>"搜索光标所在函数的引用
	let g:gutentags_define_advanced_commands = 1
endfunc
autocmd FileType ruby,eruby,python,xml,java,cs,lisp,vim,c :call ProgramConfig()

""""""""""""""""""如下是python的配置"""""""""
py3 import os;import sys;sys.executable=os.path.join(sys.prefix,'python.exe')
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
autocmd BufNewFile *.py  :call HeaderPython()

nnoremap <F5> :call CompileRunGcc()<cr>

func! CompileRunGcc()
          exec "w"
          if &filetype == 'python'
                  if search("@profile")
                          exec "AsyncRun kernprof -l -v %"
                          exec "copen"
                          exec "wincmd p"
                  elseif search("set_trace()")
                          exec "!python %"
                  else
					  " call RunPython()
						  exec "AsyncRun -raw python  %"
						  exec "copen"
						  exec "wincmd p"
                  endif
          endif
endfunc

"按F5运行python"
" map <F5>  :call RunPython()<CR>
function RunPython()
    let mp = &makeprg
    let ef = &errorformat
    let exeFile = expand("%:t")
    setlocal makeprg=python\ -u 
    set efm=%C\ %.%#,%A\ \ File\ \"%f\"\\,\ line\ %l%.%#,%Z%[%^\ ]%\\@=%m
    silent make %
    copen
    let &makeprg = mp
    let &errorformat = ef
endfunction

func! PythonConfig()
	"set foldmethod=indent "代码折叠只以缩进为依据
	setlocal foldlevelstart=99	"默认不折叠
	setlocal et | setlocal sta | setlocal sw=4
	" Python Unittest 的一些设置
	" " 可以让我们在编写 Python 代码及 unittest 测试时不需要离开 vim
	" " 键入 :make 或者点击 gvim 工具条上的 mak/pythe 按钮就自动执行测试用例
	compiler pyunit
	setlocal makeprg=python\ %
	"添加python的tags
	set tags+=D:/Anaconda3/tags
	let g:python_host_skip_check=1
	let g:python3_host_prog = 'd:/Anaconda3/python.exe'
	" exec ":AcpDisable"
	" python键的配置
	" 只有python的才可以加这个断点吧
	map <f9> :call AddPythonBreak()<CR> 
	"python的注释的，以后看看做成所有语言的，但好像有个注释插件。
	map <f7> :call CommentPython()<CR>
	imap <f7> <ESC>:call CommentPython()<CR>
endfunc
autocmd FileType python :call PythonConfig()

"这个是给python添加调试的
func! AddPythonBreak()
" if has('python3')
python3 <<EOF
_str_break = "import ipdb;ipdb.set_trace()"
# 因为存在缩进，所以这里必须得先取得函数的缩进是多少。然后加上缩进迭代添加注释
cb = vim.current.buffer     # 获取当前缓冲区
# 获得当前位置
(x,y)=vim.current.window.cursor
# 获得当前行
line=cb[x-1]
# 首先判断前面有几个缩进啦。
# 然后遍历加上注释
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
" endif
exec "w"
endfunc

func! HelpMyKey()
"我打算用这个函数来做一个帮助文档，方便我查看我的快捷键的。
python2 <<EOF


EOF

endfunc

""""""""""""""""""""""""""""""""""""
"这个是给python函数的注释，作为__doc__用
func! CommentPython()
" if has('python3')
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
# 因为存在缩进，所以这里必须得先取得函数的缩进是多少。然后加上缩进迭代添加注释
cb = vim.current.buffer     # 获取当前缓冲区
# 获得当前位置
(x,y)=vim.current.window.cursor
# 获得当前行
line=cb[x-1]
# 首先判断前面有几个缩进啦。
# 然后遍历加上注释
num_space=0
len_line=len(line)
while(num_space<len_line):
	if(line[num_space].isspace()):
		num_space=num_space+1
	else:
		s=''.center(num_space+4,' ')
		# 判断是class还是function。
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
" endif
endfunc
""""""""""""""""""""""""""""""""""""
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
			" call append(0,
			" nowa"添加这个注释，表示如果我没有找到那个，就不修改吧。
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

""""""""""""""""""""""""""""""""""""""插件管理""""""""""""""""""""""""""""""""""""""
call plug#begin('E:/home/kerwin/vimfiles/pugged')
filetype off

"编码"
" Plug 'mbbill/fencview'


""""Gnudo是保存更改记录的""""
Plug 'sjl/gundo.vim' 
	let  g:gundo_prefer_python3=1 
	map <leader>h :GundoToggle<CR>

"快速搜索文件的
Plug 'kien/ctrlp.vim' ,{'on':['Ctrlp']}
	let g:ctrlp_map = '<f3>'
	let g:ctrlp_cmd = 'CtrlP'
	let g:ctrlp_working_path_mode = 'ra'
	let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" '  " Windows
	" let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows

"快速搜索文件中的内容的
if executable('ag')
	Plug 'mileszs/ack.vim'
	let g:ackprg = 'ag --vimgrep'
	map <a-F3> :Ack 
	imap <a-F3> :Ack 
else 
	"如果没有ag，就用vim自带的吧
	map <a-F3> :vimgrep
	imap <a-F3> :vimgrep
	" vimgrep /pattern/ %           在当前打开文件中查找
	" vimgrep /pattern/ *             在当前目录下查找所有
	" vimgrep /pattern/ **            在当前目录及子目录下查找所有
	" vimgrep /pattern/ *.c          查找当前目录下所有.c文件
	" vimgrep /pattern/ **/*         只查找子目录
endif

"tagbar是一个taglist的替代品，比taglist更适合c++使用，函数能够按类区分，支持按类折叠显示等，
Plug 'majutsushi/Tagbar' ,{'on':'TagbarToggle'} "触发时才加载
"快速配括号等
"这个跟cscope的快捷键冲突。都是cs，
Plug 'vim-scripts/surround.vim'
"树形目录插件
Plug 'vim-scripts/The-NERD-tree' ,{'on':'NERDTreeToggle'} "触发时才加载
"按f8就是打开一个IDE
	map <F8> <ESC>:NERDTreeToggle <CR><ESC>:TagbarToggle<CR><ESC>
	imap <F8> <ESC>:NERDTreeToggle <CR><ESC>:TagbarToggle<CR><ESC>
"shift+f8，打开终端"
map <s-f8> <esc>:term<cr>
imap <s-f8> <esc>:term<cr>

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

" 代码自动提示
Plug 'vim-scripts/AutoComplPop',{'for':['python','c','cpp','lua','vim','java','vim']}
	let g:acp_enableAtStartup = 1
	let g:acp_behaviorPythonOmniLength = 2
"就比如yy就是复制一行，dd是删除一行，如下这个插件就是做这个的。
Plug 'vim-scripts/YankRing.vim'

""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'w0rp/ale' , { 'for':['c','cpp','python']}
	let g:ale_linters_explicit = 1 "除g:ale_linters指定，其他不可用
	"始终开启标志列
	let g:ale_sign_column_always = 1
	let g:ale_set_highlights = 0
	"自定义error和warning图标
	let g:ale_sign_error = 'E:'
	let g:ale_sign_warning = 'W:'
	" 在vim自带的状态栏中整合ale
	let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
	" 显示Linter名称,出错或警告等相关信息
	let g:ale_echo_msg_error_str = 'E'
	let g:ale_echo_msg_warning_str = 'W'
	let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
	" "普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
	nmap sp <Plug>(ale_previous_wrap)
	nmap sn <Plug>(ale_next_wrap)
	" "<Leader>s触发/关闭语法检查
	" " nmap <Leader>s :ALEToggle<CR>
	" "<Leader>d查看错误或警告的详细信息
	" nmap <Leader>d :ALEDetail<CR>
	" Check Python files with flake8 and pylint.
	let g:ale_linters =	{'python': ['flake8','pylint']}
	" Fix Python files with autopep8 and yapf.
	let g:ale_fixers = {'python':['autopep8', 'yapf']}
	" Disable warnings about trailing whitespace for Python files.
	let g:ale_warn_about_trailing_whitespace = 0
	let g:ale_python_flake8_args = '--ignore=E501'
	let g:ale_fix_on_save = 1 "保存的时候自动更改格式错误。
	" Write this in your vimrc file
	" let g:ale_set_loclist = 0
	" let g:ale_set_quickfix = 1

Plug 'vim-latex/vim-latex',{'for':['tex']} 
	" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
	" " can be called correctly.
	set shellslash


"""""""""""""""""如下是lisp的插件""""""""""""
Plug 'kovisoft/slimv' ,{'for':['lisp']}
	let g:slimv_impl = 'sbcl'
	let g:slimv_swank_cmd = '!start  "D:/Program Files/Steel Bank Common Lisp/1.4.2/sbcl.exe"  --load "e:/home/kerwin/vimfiles/pugged/slimv/slime/start-swank.lisp" '
	let g:paredit_electric_return=1

Plug 'ludovicchabant/vim-gutentags' ,{'on':'NERDTreeToggle'}
Plug 'skywind3000/gutentags_plus' ,{'on':'NERDTreeToggle'} "这个插件是配合如上插件的
	" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
	let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
	" 所生成的数据文件的名称
	let g:gutentags_ctags_tagfile = '.tags'
	" 同时开启 ctags 和 gtags 支持：
	let g:gutentags_modules = []
	if executable('ctags')
		let g:gutentags_modules += ['ctags']
	endif
	if executable('gtags-cscope') && executable('gtags')
		let g:gutentags_modules += ['gtags_cscope']
	endif
	" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
	" let g:gutentags_cache_dir = expand('~/.cache/tags')
	let g:gutentags_auto_add_gtags_cscope = 0
	" change focus to quickfix window after search (optional).
	let g:gutentags_plus_switch = 1
	nmap <S-f3> :Gtags -x 
" 代码自动提示
Plug 'vim-scripts/AutoComplPop',{'for':['python','c','cpp','lua','vim','java','vim']}
	let g:acp_enableAtStartup = 1
	let g:acp_behaviorPythonOmniLength = 2
"就比如yy就是复制一行，dd是删除一行，如下这个插件就是做这个的。
Plug 'vim-scripts/YankRing.vim'

"这个是异步执行的"
Plug 'skywind3000/asyncrun.vim' ,{'for':['python','c','cpp']}
	let g:asyncrun_encs = 'gbk' "支持中文很重要。我的终端是中文啊。

" Plug 'Valloric/YouCompleteMe' ,{'for':['python','c','cpp']}
	" map <Leader>f :YcmCompleter GoToReferences<CR><cr>
	" map <Leader>k :YcmCompleter GetDoc<CR><cr>
	" map <Leader>d :YcmCompleter GoTo<CR><cr>
Plug 'davidhalter/jedi-vim' , { 'for':['python']}
	if !exists('g:neocomplete#force_omni_input_patterns')
			let g:neocomplete#force_omni_input_patterns = {}
	endif
	let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\)\w*'
	" let g:jedi#goto_command = "<leader>d"
	" let g:jedi#goto_assignments_command = "<leader>g"
	" " let g:jedi#goto_definitions_command = ""
	" let g:jedi#documentation_command = "<leader>k"
	" " let g:jedi#usages_command = "<leader>n"
	" " let g:jedi#completions_command = "<C-Space>"
	let g:jedi#rename_command = "<F2>"
	" "
Plug 'lambdalisue/gina.vim'
	"这个git，我主要需要的是git status , git add  git commit  , git log , git diff
	", git push
	"我设置f9键为显示git，其他的看看按个最常用吧。
	"其中git log 用 Gina log 这个显示好些
	"而git diff 用 Gdiff好些
	map <f10> <esc>:Gina 
	map <c-f10> <esc>:Gdiff<cr>

""""""""""""""""""""""方便浏览的
Plug 'skywind3000/vim-preview'

"快速注释代码
Plug 'vim-scripts/The-NERD-Commenter',{'for':['python','c','cpp','lua','vim','java','vim']}
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

"""延迟加载"""
augroup load_slow
autocmd!
" autocmd  FileType python call plug#load('jedi-vim') 
" autocmd  FileType python call plug#load('') 
augroup END
"
"到这里Vundle就完成了
call plug#end()
filetype plugin indent on     " required! 
