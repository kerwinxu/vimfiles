"我想整理一下我的vim配置。分成几个部分
"基本部分
"通用配置
"插件，都是按需加载。
"然后各个语言的配置。
"最底下是一堆函数。
"
"""""""""""""""""""""""""""""如下是通用配置""""""""""""""""""""""""""""
" \te: Skip initialization for vim - tiny or vim - small.
" set verbosefile=vim.log
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
" source $VIMRUNTIME/delmenu.vim
" source $VIMRUNTIME/menu.vim
" set guifont=Dejavu_Sans_Mono:h11:cANSI
" if has('gui')
"     " set background=light
"     colors solarized
"     " let g:solarized_italic=(abs(g:solarized_italic-1)) | colorscheme solarized
" else
"     colors Zenburn
" endif
colors solarized
""""""""""""设置备份及备份目录。
"必须得先设置生效，然后再设置目录"
set undofile
" set backup
" set backupdir=D:/Vim/bakfiles
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
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif        "打开文件的适合，跳转到上次编辑的位置          
"shift+f8，打开终端"
map <s-f8> <esc>:term<cr>
imap <s-f8> <esc>:term<cr>

let mapleader=" "


""""""""""""""""""""""""""""""""""""""""""如下是各个插件的""""""""""""""""""""""""""""""""""""""""""
call plug#begin('E:/home/kerwin/vimfiles/pugged')
filetype off
""""Gnudo是保存更改记录的,这个当然是一直加载啦""""
Plug 'sjl/gundo.vim' 
	let  g:gundo_prefer_python3=1 
	map <leader>h :GundoToggle<CR>

 Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' }
	let g:Lf_ShortcutF = '<f3>'
	map <c-f3> :LeaderfTag<cr>
	imap <c-f3> :LeaderfTag<cr>
	map <a-f3> :Leaderf rg -e ""
	imap <a-f3> :Leaderf rg -e ""
	let g:Lf_WorkingDirectoryMode='Ac'
	let g:Lf_RootMarkers= ['.root', '.svn', '.git', '.hg', '.project']
	
"快速搜索文件中的内容的
" if executable('ag')
"     let g:ackprg = 'ag --vimgrep'
"     map <a-F3> :Ack 
"     imap <a-F3> :Ack 
"     Plug 'mileszs/ack.vim'
" else 
"     "如果没有ag，就用vim自带的吧
"     map <a-F3> :vimgrep
"     imap <a-F3> :vimgrep
"     " vimgrep /pattern/ %           在当前打开文件中查找
"     " vimgrep /pattern/ *             在当前目录下查找所有
"     " vimgrep /pattern/ **            在当前目录及子目录下查找所有
"     " vimgrep /pattern/ *.c          查找当前目录下所有.c文件
"     " vimgrep /pattern/ **/*         只查找子目录
" endif
"快速配括号等
"这个跟cscope的快捷键冲突
Plug 'vim-scripts/surround.vim',{'for':['python', 'c', 'cpp', 'java', 'lua', 'vim', 'cs', 'css', 'html', 'js']}

"tagbar是一个taglist的替代品，比taglist更适合c++使用，函数能够按类区分，支持按类折叠显示等，
Plug 'majutsushi/Tagbar' ,{'on':'TagbarToggle'} "触发时才加载
"树形目录插件
Plug 'vim-scripts/The-NERD-tree' ,{'on':'NERDTreeToggle'} "触发时才加载
	map <F8> <ESC>:NERDTreeToggle <CR><ESC>:TagbarToggle<CR><ESC>
	imap <F8> <ESC>:NERDTreeToggle <CR><ESC>:TagbarToggle<CR><ESC>
"括号高亮，不同颜色的。这个是一直加载吧。
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

" 代码自动提示，按需加载吧。
Plug 'vim-scripts/AutoComplPop',{'for':['python', 'c', 'cpp', 'java', 'lua', 'vim', 'cs', 'css', 'html', 'js']}
	let g:acp_enableAtStartup = 1
	let g:acp_behaviorPythonOmniLength = 2
"就比如yy就是复制一行，dd是删除一行，如下这个插件就是做这个的,肯定是一直加载啦。。
" Plug 'vim-scripts/YankRing.vim'

Plug 'w0rp/ale' , { 'for':['python']}
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
Plug 'ludovicchabant/vim-gutentags' 
Plug 'skywind3000/gutentags_plus'  
	let g:gutentags_plus_switch = 1
	" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
	let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']
	" 所生成的数据文件的名称
	let g:gutentags_ctags_tagfile = '.tags'
	" 同时开启 ctags 和 gtags 支持：
	" enable gtags module
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
	" "禁用 gutentags 自动加载 gtags 数据库的行为
    " 避免多个项目数据库相互干扰
    " 使用plus插件解决问题
	let g:gutentags_auto_add_gtags_cscope = 0
	" change focus to quickfix window after search (optional).
	" 配置 ctags 的参数
	let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
	let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
	let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
	 let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
Plug 'skywind3000/vim-preview'
	"这个是高效预览的。
	autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
	autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
Plug 'lambdalisue/gina.vim'  ,{'for':['python', 'c', 'cpp', 'java', 'lua', 'vim', 'cs', 'css', 'html', 'js']}
	""这个git，我主要需要的是git status , git add  git commit  , git log , git diff
	", git push
	"我设置f9键为显示git，其他的看看按个最常用吧。
	"其中git log 用 Gina log 这个显示好些
	"而git diff 用 Gdiff好些
	map <f10> <esc>:Gina 
	map <c-f10> <esc>:Gdiff<cr>
"这个是异步执行的"
Plug 'skywind3000/asyncrun.vim' ,{'for':['python']}
	let g:asyncrun_encs = 'gbk' "支持中文很重要。我的终端是中文啊。


Plug 'davidhalter/jedi-vim' , { 'for':['python']}
	let g:jedi#auto_vim_configuration = 1
	let g:jedi#smart_auto_mappings = 1 "加上这个，就会增加比如，from PIL 后自动输入import ，然后弹出自动补全。
	" let g:neocomplete#force_omni_input_patterns.python.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
	let g:jedi#completions_command = "<a-Space>"
	let g:jedi#documentation_command = "<leader>k"
	let g:jedi#rename_command = "<F2>"

"快速注释代码
Plug 'scrooloose/nerdcommenter' ,{'for':['python', 'c', 'cpp', 'java', 'lua', 'vim', 'cs', 'css', 'html', 'js']}
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
	map <A-;> <leader>c<space>

"snippets补全
Plug 'SirVer/ultisnips' ,{'for':['python', 'c', 'cpp', 'java', 'lua', 'vim', 'cs', 'css', 'html', 'js']}
Plug 'honza/vim-snippets' ,{'for':['python', 'c', 'cpp', 'java', 'lua', 'vim', 'cs', 'css', 'html', 'js']}

""""""""""""""""""""""""""""""""""""""""""如下是各个语言的配置。""""""""""""""""""""""""""""""""""""
func! ProgramConfig()
	call AutoPair()
	source D:/gtags/share/gtags/gtags.vim
	source D:/gtags/share/gtags/gtags-cscope.vim
	nmap <f12> :GscopeFind g <C-R><C-W><cr>"跳转到光标所在函数的定义
	nmap <s-f12> :GscopeFind c <C-R><C-W><cr>搜索光标所在函数的引用
	nmap <S-f3> :GscopeFind 
	"let g:gutentags_define_advanced_commads = 1
	"格式化代码。
	map <c-f8> :call FormartSrc()<CR>
	imap <c-f8> <esc>:call FormartSrc()<CR>
	"异步运行代码"
	nnoremap <F5> :call CompileRunGcc()<cr>
endfunc
autocmd FileType c,cpp,ruby,eruby,python,xml,java,cs,lisp,vim,c :call ProgramConfig()

func! PythonConfig()
	"set foldmethod=indent "代码折叠只以缩进为依据
	setlocal foldlevelstart=99	"默认不折叠
	setlocal et | setlocal sta | setlocal sw=4
	" Python Unittest 的一些设置
	" " 可以让我们在编写 Python 代码及 unittest 测试时不需要离开 vim
	" " 键入 :make 或者点击 gvim 工具条上的 mak/pythe 按钮就自动执行测试用例
	" 这个暂时不用吧，因为用不到，以后要用了就打开吧。这个设置要用200毫秒左右启动呢。
	compiler pyunit
	setlocal makeprg=python\ %
	"添加python的tags
	set tags+=D:/Anaconda3/tags
	let g:python_host_skip_check=1
	let g:python3_host_prog = 'd:/Anaconda3/python.exe'
	" python键的配置
	" 只有python的才可以加这个断点吧
	map <f9> :call AddPythonBreak()<CR> 
	"python的注释的，以后看看做成所有语言的，但好像有个注释插件。
	map <f7> :call CommentPython()<CR>
	imap <f7> <ESC>:call CommentPython()<CR>
	"如下这个会产生错误，以后看看吧。
	" py3 import os;import sys;sys.executable=os.path.join(sys.prefix,'python.exe')
endfunc
autocmd FileType python :call PythonConfig()

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
"这个是自动给python加上文件头的
func! HeaderPython()
    call setline(1, "#!/usr/bin/env python")
    call append(1, "# -*- coding: utf-8 -*-")
	call append(2, '# File Name: ' . expand("%"))
    call append(3, "# Author:  kerwin.cn@gmail.com" )
	call append(4, "# Created Time:" . strftime('%Y-%m-%d %H:%M:%S ', localtime()))
	call append(5, "# Last Change: " . strftime('%Y-%m-%d %H:%M:%S ', localtime()))
	call append(6, "# Description :  ")
	" call append(7,'')
	normal G
	normal k
	normal A
endfunc
autocmd BufNewFile *.py  :call HeaderPython()

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
			exec "AsyncRun -raw python %"
			exec "copen"
			exec "wincmd p"
		endif
	elseif  &filetype == 'markdown'
		" exec ":Instantmd"
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

"到这里Vundle就完成了
call plug#end()
filetype plugin indent on     " required! 
