我的Vim配置  
==  
# 前言  
我的目标大部分是为了编写python，python方面做的测试较多。我要将gvim当python 的ide用  
# 分类  
## 工程管理  
这方面的插件是用git来做的，比如  
### gina.vim  
这个插件我只放了1个快捷键  
	map <f10> <esc>:Gina   
够用就行  
### vim-gutentags 和 gutentags_plus  
这两个插件，我用来自动更新git的，这工程目录的判定是当前文件路径向上递归，直到碰到特殊的文件或者目录，比如git的.git目录，就表示这个目录是在git管理下。  
这两个插件不用记住特殊的键。  
### 打开IDE界面  
通常的IDE一般包括文件浏览器，函数列表，代码区之类的吧，我这里用The-NERD-tree和Tagbar来做，快捷键是  
	map <F8> <ESC>:NERDTreeToggle <CR><ESC>:TagbarToggle<CR><ESC>  
### 搜索  
我这个包含几个方面吧  
#### ctrlp.vim 搜索文件 <f3>  
这个就不用解释了吧，搜索文件用的。  
#### 搜索内容vimgrep或者ack <a-f3>  
我是用ack插件来的，不过，vim本身也有vimgrep，两个是重复的  
# 文件编写  
## 代码编写  
### 自动补全  
经我测试，python-mode，ycm，jedi-vim中，我认为最好的是jedi-vim，在代码补全方面，比如经常在写import，jedi-vim比较只能，比如from sys ，空格后就会自动输入import 后跳出补全列表。并且在启动方面，虽说python-mode和ycm启动快，但是只是客户端启动快而已，其自动补全部分，得好长时间才会真正启动。  
关于jedi-vim，唯一需要记住的就是<f2>，我设置成自动改名了。  
### 代码跳转  
我没有用jedi中的代码跳转，而是用gtag中的代码跳转。  
	nmap <f12> :Gtags<cr><cr>"跳转到光标所在函数的定义  
	nmap <s-f12> :Gtags -r<cr><cr>"搜索光标所在函数的引用  
### surround.vim  

这个只是为了更改成对的括号之类的，比如将成对的单引号转成双引号啦。  
我这里直接粘贴官方的吧  
Normal mode  
ds  - delete a surrounding  
cs  - change a surrounding  
ys  - add a surrounding  
yS  - add a surrounding and place the surrounded text on a new line + indent it  
yss - add a surrounding to the whole line  
ySs - add a surrounding to the whole line, place it on a new line + indent it  
ySS - same as ySs  
Visual mode  
s   - in visual mode, add a surrounding  
S   - in visual mode, add a surrounding but place text on new line + indent it  
Insert mode  
<CTRL-s> - in insert mode, add a surrounding  
<CTRL-s><CTRL-s> - in insert mode, add a new line + surrounding + indent  
<CTRL-g>s - same as <CTRL-s>  
<CTRL-g>S - same as <CTRL-s><CTRL-s>  
## 代码纠错  
我这里用ale来进行，没有需要记住的键，只需要记住，我是设置成保存后自动fix的。  
## 代码折叠  
这个是vim自己的，我只是记录一下命令  
zc      折叠  
zC     对所在范围内所有嵌套的折叠点进行折叠  
zo      展开折叠  
zO     对所在范围内所有嵌套的折叠点展开  
[z       到当前打开的折叠的开始处。  
]z       到当前打开的折叠的末尾处。  
zj       向下移动。到达下一个折叠的开始处。关闭的折叠也被计入。  
zk      向上移动到前一折叠的结束处。关闭的折叠也被计入。  
## 函数注释  
map <f7> :call CommentPython()<CR>  
我自己实现了一个加注释的简单版本。  
## 断点  
map <f9> :call AddPythonBreak()<CR>   
我自己实现了一个加断点的简单版本。  
## 更改记录 gundo.vim  
这个插件可以记录更改的内容，一个时光机。  
需要记住的快捷键就是  
map <leader>h :GundoToggle<CR>  
# 终端  
vim8支持打开一个终端，记录一下命令  
map <s-f8> <esc>:term<cr>  
