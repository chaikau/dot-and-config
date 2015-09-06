set nu
set cindent
set nocp
set nobackup
syntax on
filetype plugin on
set completeopt=longest,menu
set autoread
filetype indent on
set scrolloff=3
set iskeyword+=_,$,@,%,#,-
set smartindent
autocmd InsertLeave * se nocul
autocmd InsertEnter * se cul
autocmd Filetype c 	set omnifunc=ccomplete#Cpmplete
autocmd Filetype python	set omnifunc=pythoncomplete#CompleteTags
colo koehler
set guifont=Monospace\ 11
set noswapfile
set fenc=utf-8
set fencs=utf-8,gb18030,utf-16,big5 
"set fdm=syntax
""set t_Co=256


"##### auto fcitx  ###########
let g:input_toggle = 1
function! Fcitx2en()
   let s:input_status = system("fcitx-remote")
   if s:input_status == 2
      let g:input_toggle = 1
      let l:a = system("fcitx-remote -c")
   endif
endfunction

"function! Fcitx2zh()
"   let s:input_status = system("fcitx-remote")
"   if s:input_status != 2 && g:input_toggle == 1
"      let l:a = system("fcitx-remote -o")
"      let g:input_toggle = 0
"   endif
"endfunction

"退出插入模式
autocmd InsertLeave * call Fcitx2en()
"进入插入模式
"autocmd InsertEnter * call Fcitx2zh()
"##### auto fcitx end ######
"
"inoremap <C-t> :FufBuffer<cr>

"自动跳转
inoremap <Tab> <C-R>=TabSkip()<CR>
function TabSkip()
    let char = getline('.')[col('.') - 1]
    if char == '}' || char == ')' || char == ']' || char == ';' || char == '"' || char == '>' || char == "'"
        return "\<Right>"
    else
        return "\<Tab>"
    endif
endf

"自动括号补全
inoremap ( ()<Esc>i
inoremap [ []<Esc>i
inoremap { {}<Esc>i
inoremap {<CR> {<CR>}<Esc>O
autocmd Syntax html,vim inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
"inoremap < <lt>><Esc>i| inoremap > <c-r>=ClosePair('>')<CR>
inoremap ) <c-r>=ClosePair(')')<CR>
inoremap ] <c-r>=ClosePair(']')<CR>
"inoremap } <c-r>=CloseBracket()<CR>
inoremap " <c-r>=QuoteDelim('"')<CR>
inoremap ' <c-r>=QuoteDelim("'")<CR>
function ClosePair(char)
	if getline('.')[col('.') - 1] == a:char
		return "\<Right>"
	else
		return a:char
	endif
endf
"function CloseBracket()
"	if match(getline(line('.') + 1), '\s*}') < 0
"		return "\<CR>}"
"	else
"		return "\<Esc>j0f}a"
"	endif
"endf
function QuoteDelim(char)
	let line = getline('.')
	let col = col('.')
	if line[col - 2] == "\\"
		"Inserting a quoted quotation mark into the string
		return a:char
	elseif line[col - 1] == a:char
		"Escaping out of the string
		return "\<Right>"
	else
		"Starting a string
		return a:char.a:char."\<Esc>i"
	endif
endf


""map <C-i> :call Addsem()<CR>
""function! Addsem()
""    let lookups = ["%:p:r:s?src?inc?", "%:p:r:s?inc?src?", "%:p:r"]
""    let other_type = {'vs' : 'fs', 'fs' : 'vs', 'html' : 'js', 'js' : 'html', 'h' : 'cpp', 'cpp' : 'h'}
""    let type = expand("%:e")
""    if has_key(other_type, type)
""        let dst_types = get(other_type, type)
""        for pattern in lookups
""            let file = fnameescape(expand(pattern) . "." . dst_types)
""            if filereadable(file)
""                exec "e " file
""                return
""            endif
""        endfor
""    endif
""endfunction

map <F7> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!gcc % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "!time ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!java %<"
	elseif &filetype == 'sh'
		exec "!chmod u+x %"
		:!./%
	elseif &filetype == 'python'
		exec "!python2 %"
	elseif &filetype == 'tex'
		exec "!xelatex %"
	endif
endfunc

map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	if &filetype == 'c'
		exec "!gcc % -g -o %<"
		exec "!gdb ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -g -o %<"
		exec "!gdb ./%<"
	endif
endfunc

"map <F9> :call CompileRunAVRGCC()<CR>
"func! CompileRunAVRGCC()
"	exec "w"
"	if &filetype == 'c'
"		exec "!make"
"	endif
"endfunc
"
"map <F10> :call ProgramRunAVRDUDE()<CR>
"func! ProgramRunAVRDUDE()
"	exec "w"
"	if &filetype == 'c'
"		exec "!make program"
"	endif
"endfunc


autocmd BufNewFile *.cpp,*.[cmh],*.sh,*.java exec ":call SetTitle()" 

func SetTitle()
	if &filetype == 'sh' 
		call setline(1,"\###########################################################################") 
		call append(line("."), "\#	File Name: ".expand("%"))
		call append(line(".")+1, "\#	Author: chaikau")
		call append(line(".")+2, "\#	Mail: chaikau@163.com")
		call append(line(".")+3, "\#	Created Time: ".strftime("%c"))
		call append(line(".")+4, "\#	Program: ")
		call append(line(".")+5, "\#	History: ")
		call append(line(".")+6, "\###########################################################################") 
		call append(line(".")+7, "\#!/bin/bash") 
		call append(line(".")+8, "") 
	endif

	if &filetype == 'c'
		call setline(1, "/*************************************************************************") 
		call append(line("."), "	> File Name: ".expand("%")) 
		call append(line(".")+1, "	> Author: chaikau") 
		call append(line(".")+2, "	> Mail: chaikau@163.com ") 
		call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+4, "	> Program: ")
		call append(line(".")+5, " ************************************************************************/") 
		call append(line(".")+6, "")
		call append(line(".")+7, "#include \"csapp.c\"")
		call append(line(".")+8, "")
		call append(line(".")+9, "int main (int argc, char * argv[], char * envp[])")
		call append(line(".")+10, "{")
		call append(line(".")+11, "\texit(0);")
		call append(line(".")+12, "}")
	endif

	if &filetype == 'm'
		call setline(1, " %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%") 
		call append(line("."), "	%> File Name: ".expand("%")) 
		call append(line(".")+1, "	%> Author: chaikau") 
		call append(line(".")+2, "	%> Mail: chaikau@163.com ") 
		call append(line(".")+3, "	%> Created Time: ".strftime("%c")) 
		call append(line(".")+4, " %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%") 
		call append(line(".")+5, "")
		call append(line(".")+6, "#!/usr/bin/octave")
	endif


	if &filetype == 'cpp'
		call setline(1, "/*************************************************************************") 
		call append(line("."), "	> File Name: ".expand("%")) 
		call append(line(".")+1, "	> Author: chaikau") 
		call append(line(".")+2, "	> Mail: chaikau@163.com ") 
		call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
		call append(line(".")+4, " ************************************************************************/") 
		call append(line(".")+8, "")
		call append(line(".")+6, "#include<iostream>")
		call append(line(".")+7, "using namespace std;")
		call append(line(".")+5, "")
	endif

	"	if &filetype == 'java'
	"		call append(line(".")+6,"public class ".expand("%"))
	"		call append(line(".")+7,"")
	"	endif
endfunc 
autocmd BufNewFile * normal GA


