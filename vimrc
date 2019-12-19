"我这个配置是用来查看文件的，然后是作为python的开发工具来用,以及在linux系统的c开发工具。
"总体上，我需要的功能是： 自动补全，改名，转到定义，查找引用，添加注释，格式化代码。
"我用jedi-vim来实现自动补全，改名和转到定义，但查找引用，jedi-vim没有啊，所以用gtags补充
"lsp模式据说是可以实现自动补全，改名，转到定义和查找引用，但是我试过了，还不稳定。vim-lsp可以运行了。试试吧。
"关于功能方面，这里先有几个F键的功能
"			只F键		ctrl		Alt		Shift
" f2		更改名字
" f3		搜索文件	搜索tag		正则搜索
" f5		运行
" f7		函数加注释
" f8		IDE			格式化代码
" f9		加断点
"
" f12		跳到定义						查找引用
"
"
"在python下,特殊的按键。
" Goto assignments <leader>g (typical goto function)
" Goto definitions <leader>d (follow identifier as far as possible, includes imports and statements)
" Show Documentation/Pydoc K (shows a popup with assignments)
"
"我的配置分成如下几个部分
"首先是判断是否有plug插件管理系统，如果没有，就下载
"各种插件
"通用配置
"程序语言通用的配置
"各个插件的配置
"python语言的配置
"一堆函数
"
"如下的设置能保证在gvim，vim 中中文是没问题的.
""如下的必须放在开头，否则菜单会乱码。
set encoding=utf-8
set langmenu=en
" set langmenu=zh_CN.utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set makeencoding=char
set imcmdline

"判断操作系统，然后下载插件管理系统。
if( has("win64") || has("win32") || has("win95") || has("win16"))
	if !filereadable(expand("~/vimfiles/autoload/plug.vim"))
		exec "!curl -fLo ".$HOME."/vimfiles/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" 
	endif
    let g:iswindows = 1
	let g:plug_path = "~/vimfiles/pugged/"   "win的插件目录放在这里吧。
	language messages zh_CN.utf-8
else
	if !filereadable(expand("~/.vim/autoload/plug.vim"))
		exec "!curl -fLo ~/.vim/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" 
	endif
    let g:iswindows = 0
	let g:plug_path = "~/.vim/pugged/"       "其他系统的插件目录是这里吧
endif

if has("gui_running")
    let g:isGUI = 1
else
    let g:isGUI = 0
endif

""""""""""""""""""""""""""""""""""""""""""如下是各个插件的""""""""""""""""""""""""""""""""""""""""""
call plug#begin(g:plug_path)
filetype off
	"插件部分，我打算分2种，一种是通用插件即不管打开哪种文件都加载的，另一种是分程序语言加载的
	"如下是通用的。
	"配色,一个用在gui，一个用在终端
	Plug 'altercation/vim-colors-solarized'
	Plug 'jnurmine/Zenburn'
	Plug 'sjl/gundo.vim'  "Gnudo是保存更改记录的,
	Plug 'vim-scripts/surround.vim' "快速配括号等 这个跟cscope的快捷键冲突
	Plug 'kien/rainbow_parentheses.vim' "括号高亮，不同颜色的。这个是一直加载吧。
	Plug 'ludovicchabant/vim-gutentags'  "两个是作为自动管理ctags，gtags等项目的。
	Plug 'skywind3000/gutentags_plus' 
	Plug 'skywind3000/vim-preview'   "这个是高效预览的。
	Plug 'lambdalisue/gina.vim'  
	Plug 'liuchengxu/vim-which-key'
	Plug 'Yggdroot/LeaderF', { 'do': '.\install.bat' } "搜索文件或者内容的
	" Plug 'airblade/vim-gitgutter'  ,{'for':['python', 'c', 'cpp', 'java', 'lua', 'vim', 'cs', 'css', 'html', 'js']}
	""如下是触发时才加载的。
	Plug 'majutsushi/Tagbar' ,{'on':'TagbarToggle'} "触发时才加载
	Plug 'vim-scripts/The-NERD-tree' ,{'on':'NERDTreeToggle'} "树形目录插件
	"如下是打开的是程序才加载的
	Plug 'w0rp/ale' ,{'for':[]} "动态监测语法
	Plug 'skywind3000/asyncrun.vim' ,{'for':[]}  "这个是异步执行的
	Plug 'scrooloose/nerdcommenter' ,{'for':[]} "快速注释代码
	Plug 'SirVer/ultisnips' ,{'for':[]} "snippets补全
	Plug 'honza/vim-snippets',{'for':[]}
	Plug 'Shougo/neocomplete.vim',{'for':[]} "自动弹出补全的

	"如下的只是在python中打开。
	Plug 'davidhalter/jedi-vim' , { 'for':[]}
	Plug 'python-mode/python-mode', { 'for': [], } , "启动慢点，但跟jedi一样，同样没有查找引用啊

	"lsp的配置如下，但不好用，十分的不好用
	" Plug 'autozimu/LanguageClient-neovim', {
	" \ 'branch': 'next',
	" \ 'do': 'powershell -executionpolicy bypass -File install.ps1',
	" \ }
	" " (Optional) Multi-entry selection UI.
	" Plug 'junegunn/fzf'
	" if has('nvim')
		" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	" else
		" Plug 'Shougo/deoplete.nvim'
		" Plug 'roxma/nvim-yarp'
		" Plug 'roxma/vim-hug-neovim-rpc'
	" endif
	" let g:deoplete#enable_at_startup = 1
	" let g:LanguageClient_serverCommands = {                                                                                       
	  " \ 'python': ['pyls'],
	  " \ } 
	
	Plug 'prabirshrestha/asyncomplete.vim'
	Plug 'prabirshrestha/async.vim'
	Plug 'prabirshrestha/vim-lsp'
	Plug 'prabirshrestha/asyncomplete-lsp.vim'
	if executable('pyls')
		" pip install python-language-server
		au User lsp_setup call lsp#register_server({
			\ 'name': 'pyls',
			\ 'cmd': {server_info->['pyls']},
			\ 'whitelist': ['python'],
			\ })
	endif


call plug#end()
filetype plugin indent on     " required! 

"插件大多数是后来加载的
function! LoadPlug(timer) abort
	if  &filetype == 'python' 
		call plug#load('jedi-vim')
			let g:jedi#rename_command = "<f2>"
			let g:jedi#smart_auto_mappings = 1 ""from module.name<space>`
			let g:jedi#completions_enabled = 1  "用coc来补全。

	endif
	if &filetype == 'c' ||  &filetype == 'python' ||  &filetype == 'cpp' ||  &filetype == 'java' ||  &filetype == 'vim' 
		call plug#load('ale')
			let g:ale_linters_explicit = 1 "除g:ale_linters指定，其他不可用
			let g:ale_sign_column_always = 1 "始终开启标志列
			let g:ale_set_highlights = 0
			let g:ale_sign_error = 'E:' "自定义error和warning图标
			let g:ale_sign_warning = 'W:'
			let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK'] " 在vim自带的状态栏中整合ale
			let g:ale_echo_msg_error_str = 'E' " 显示Linter名称,出错或警告等相关信息
			let g:ale_echo_msg_warning_str = 'W'
			let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
			nmap sp <Plug>(ale_previous_wrap)
			nmap sn <Plug>(ale_next_wrap)
			let g:ale_linters =	{'python': ['flake8','pylint']}
			let g:ale_fixers = {'python':['autopep8', 'yapf']}
			let g:ale_warn_about_trailing_whitespace = 0
			let g:ale_python_flake8_args = '--ignore=E501'
			let g:ale_fix_on_save = 1 "保存的时候自动更改格式错误。
			" Write this in your vimrc file
			" let g:ale_set_loclist = 0
			" let g:ale_set_quickfix = 1
		call plug#load('asyncrun.vim')
			let g:asyncrun_encs = 'gbk' "支持中文很重要。我的终端是中文啊。
		call plug#load('nerdcommenter')
			let g:NERDSpaceDelims = 1 "注释后边加上空格
			map <a-;> <plug>NERDCommenterToggle
		call plug#load('ultisnips')
		call plug#load('vim-snippets')
		call plug#load('neocomplete.vim')
			let g:acp_enableAtStartup = 1
			let g:acp_behaviorPythonOmniLength = 2
			let g:neocomplete#enable_at_startup = 1
			let g:neocomplete#enable_smart_case = 1
			let g:neocomplete#enable_auto_select = 1
			let g:neocomplete#sources#syntax#min_keyword_length = 3
			if !exists('g:neocomplete#sources#omni#input_patterns')
				let g:neocomplete#sources#omni#input_patterns = {}
			endif
			let g:neocomplete#sources#omni#input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
			let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
			let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
			" exec ":NeoCompleteEnable"
	endif
endfunction
call timer_start(100, 'LoadPlug')

"如下是一些通用的配置"
if g:iswindows
	source $VIMRUNTIME/mswin.vim
	behave mswin "鼠标运行模式为windows模式
endif
""""""""""""设置备份及备份目录。
"必须得先设置生效，然后再设置目录"
set undofile
set path+=**
" set backup
" set backupdir=D:/Vim/bakfiles
if g:iswindows
	set undodir=D:/Vim/undodir
else
	set undodir=~/Vim/undodir
endif
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
" set wildmenu "自动补全命令时候使用菜单式匹配列表  
" set wildmenu  wildmode=longest,list,full "用于命令行的补全，tab
"自动补全的
	" autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
	""autocmd FileType python set omnifunc=python3complete#Complete
	" autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
	" autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
	" autocmd FileType css set omnifunc=csscomplete#CompleteCSS
	" autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
	" autocmd FileType java set omnifunc=javacomplete#Complet
	" set wildchar=<Tab> wildcharm=<C-Z>
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
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif        "打开文件的时候，跳转到上次编辑的位置          
"如下是设置换行自动对齐的
set autoindent

"""""""""""""""""""""""""""""""""""""如下是各个插件的配置
"配置lsp
map <F2> <ESC>:LspRename<CR>
map <F12> <ESC>:LspDefinition<CR>
map <s-F12> <ESC>:LspReferences<CR>
let g:lsp_fold_enabled = 0




let g:project_root=['.root', '.svn', '.git', '.hg', '.project']
let g:gutentags_plus_switch = 1
let g:gutentags_project_root = g:project_root  " gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名

let g:gutentags_ctags_tagfile = '.tags' " 所生成的数据文件的名称
let g:gutentags_modules = []
if executable('ctags')
    let g:gutentags_modules += ['ctags']
endif
if executable('gtags-cscope') && executable('gtags')
    let g:gutentags_modules += ['gtags_cscope']
endif

" let g:gutentags_cache_dir = expand('~/.cache/tags') " 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
" 使用plus插件解决问题
let g:gutentags_auto_add_gtags_cscope = 0 " "禁用 gutentags 自动加载 gtags 数据库的行为 避免多个项目数据库相互干扰
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>

" let g:gutentags_plus_nomap = 1
" noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
" noremap <silent> <s-f12> :GscopeFind s <C-R><C-W><cr>
" noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
" noremap <silent> <f12> :GscopeFind g <C-R><C-W><cr>
" noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
" noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
" noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
" noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
" noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
" noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
" noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>

let  g:gundo_prefer_python3=1 
"配色配置。
if g:isGUI
	syntax enable
	set background=light
	colo solarized
else
	colo zenburn
endif

"配置LeaderF"
let g:Lf_ShortcutF = '<f3>'
let g:Lf_ShortcutB='<leader>sb'
map <c-f3> :LeaderfTag<cr>
imap <c-f3> :LeaderfTag<cr>
map <a-f3> :Leaderf rg -e ""
imap <a-f3> :Leaderf rg -e ""
let g:Lf_WorkingDirectoryMode='Ac'
let g:Lf_RootMarkers= g:project_root

map <F8> <ESC>:NERDTreeToggle <CR><ESC>:TagbarToggle<CR><ESC>
imap <F8> <ESC>:NERDTreeToggle <CR><ESC>:TagbarToggle<CR><ESC>

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


autocmd FileType c,cpp,ruby,eruby,python,xml,java,cs,lisp,vim,c,scheme :call ProgramConfig()
autocmd FileType python :call PythonConfig()
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
"""""""""""""""""""""""""""""""""""""""各个函数"""""""""""""""""""""""""""""""""""""""
func! PythonConfig()
	"启动跟python相关的插件
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
	if g:iswindows
		set tags+=D:/Anaconda3/tags
		let g:python3_host_prog = 'd:/Anaconda3/python.exe'
		let g:python_host_skip_check=1
	endif
	" python键的配置
	" 只有python的才可以加这个断点吧
	map <f9> :call AddPythonBreak()<CR> 
	"python的注释的，以后看看做成所有语言的，但好像有个注释插件。
	map <f7> :call CommentPython()<CR>
	imap <f7> <ESC>:call CommentPython()<CR>
	"如下这个会产生错误，以后看看吧。
	" py3 import os;import sys;sys.executable=os.path.join(sys.prefix,'python.exe')
endfunc

func! ProgramConfig()
	call AutoPair()
	if g:iswindows
		source D:/gtags/share/gtags/gtags.vim
		source D:/gtags/share/gtags/gtags-cscope.vim
		nmap <S-f3> :GscopeFind 
	endif
	"格式化代码。
	map <c-f8> :call FormartSrc()<CR>
	imap <c-f8> <esc>:call FormartSrc()<CR>
	"异步运行代码"
	nnoremap <F5> :call CompileRunGcc()<cr>

endfunc
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
	elseif  &filetype == 'scheme'
			exec "AsyncRun -raw scheme %"
			exec "copen"
			exec "wincmd p"

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

" 最后是如下是配置类似spaceemacs的那个按键的"
if isdirectory(expand(g:plug_path. "vim-which-key/"))
	let g:mapleader="\<Space>"
	nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
	nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
	let g:which_key_map = {}

	nnoremap  <leader>h :GundoToggle<CR>
	let g:which_key_map.h = "Gundo"
	
	nnoremap  <leader>t :term<CR>
	let g:which_key_map.t = "终端"
	
	let g:which_key_map.s = {
				\'name':'+search',
				\'f':['<f3>','search file <f3>'],
				\'t':['LeaderfTag','search tag <c-f3>'],
				\ 's':[':GscopeFind','查找符号'],
				\ 'g':[':GscopeFind g <C-R><C-W><cr>','查找定义'],
				\ 'c':[':GscopeFind c <C-R><C-W><cr>','查找引用'],
				\}
	let g:which_key_map.b = {
		  \ 'name' : '+buffer' ,
		  \ '1' : ['b1'        , 'buffer 1']        ,
		  \ '2' : ['b2'        , 'buffer 2']        ,
		  \ 'd' : ['bd'        , 'delete-buffer']   ,
		  \ 'f' : ['bfirst'    , 'first-buffer']    ,
		  \ 'h' : ['Startify'  , 'home-buffer']     ,
		  \ 'l' : ['blast'     , 'last-buffer']     ,
		  \ 'n' : ['bnext'     , 'next-buffer']     ,
		  \ 'p' : ['bprevious' , 'previous-buffer'] ,
		  \ '?' : ['Buffers'   , 'fzf-buffer']      ,
		  \ }
	let g:which_key_map['w'] = {
      \ 'name' : '+windows' ,
      \ 'w' : ['<C-W>w'     , 'other-window']          ,
      \ 'd' : ['<C-W>c'     , 'delete-window']         ,
      \ '-' : ['<C-W>s'     , 'split-window-below']    ,
      \ '|' : ['<C-W>v'     , 'split-window-right']    ,
      \ '2' : ['<C-W>v'     , 'layout-double-columns'] ,
      \ 'h' : ['<C-W>h'     , 'window-left']           ,
      \ 'j' : ['<C-W>j'     , 'window-below']          ,
      \ 'l' : ['<C-W>l'     , 'window-right']          ,
      \ 'k' : ['<C-W>k'     , 'window-up']             ,
      \ 'H' : ['<C-W>5<'    , 'expand-window-left']    ,
      \ 'J' : ['resize +5'  , 'expand-window-below']   ,
      \ 'L' : ['<C-W>5>'    , 'expand-window-right']   ,
      \ 'K' : ['resize -5'  , 'expand-window-up']      ,
      \ '=' : ['<C-W>='     , 'balance-window']        ,
      \ 's' : ['<C-W>s'     , 'split-window-below']    ,
      \ 'v' : ['<C-W>v'     , 'split-window-below']    ,
      \ '?' : ['Windows'    , 'fzf-window']            ,
      \ }

	let g:which_key_map['g'] = {
				\ 'name' : '+Gtags',
				\ 's':[ ':GscopeFind s <C-R><C-W><cr>' , 'Find this symbol'],
				\ 'g':[ ':GscopeFind g <C-R><C-W><cr>' , 'Find this definition'],
				\ 'c':[ ':GscopeFind c <C-R><C-W><cr>' , 'Find functions calling this function'],
				\ 'd':[ ':GscopeFind d <C-R><C-W><cr>' , 'Find functions called by this function'],
				\ 't':[ ':GscopeFind t <C-R><C-W><cr>' , 'Find this text string'],
				\ 'e':[ ':GscopeFind e <C-R><C-W><cr>' , 'Find this egrep patterng'],
				\ 'f':[ ':GscopeFind f <C-R>=expand("<cfile>")<cr><cr>' , 'Find this fileg'],
				\ 'i':[ ':GscopeFind i <C-R>=expand("<cfile>")<cr><cr>' , 'Find files #including this file'],
				\ 'a':[ ':GscopeFind a <C-R><C-W><cr>' , 'Find places where this symbol is assigned a value'],
				\}

	let g:which_key_map['p'] = {
				\ 'name' : '+Project',
				\ 's':[ ':Gina status' , ':Gina status'],
				\ 'c':[ ':Gina commit' , ':Gina commit'],
				\ 'l':[ ':Gina log' , ':Gina log'],
				\ 'p':[ ':Gina push' , ':Gina push'],
				\ 'd':[ ':Gina diff' , ':Gina diff'],
				\}

	let g:which_key_map['r'] = {
				\ 'name' : '+Run&Debug',
				\ 'r':[ '<f5>' , '+Run'],
				\ 'a':[ ':call AddPythonBreak()' , '添加python断点'],
				\ }

	let g:which_key_map['c'] = {
				\ 'name' : '+Comment',
				\ 'c':[ '<plug>NERDCommenterToggle' , '通用注释'],
				\ 'f':[ ':call CommentPython()' , 'python函数或者类注释'],}
	call which_key#register('<Space>', "g:which_key_map")
endif
