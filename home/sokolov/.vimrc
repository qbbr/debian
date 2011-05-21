"--------------------------------------------------
"            ___  ____  ____  ____  _
"           / _ \| __ )| __ )|  _ \( )___
"          | | | |  _ \|  _ \| |_) |// __|
"          | |_| | |_) | |_) |  _ <  \__ \
"          \__\_\____/|____/|_| \_\ |___/
"
"                   _
"           __   __(_)_ __ ___  _ __ ___
"           \ \ / /| | '_ ` _ \| '__/ __|
"           _\ V / | | | | | | | | | (__
"          (_)\_/  |_|_| |_| |_|_|  \___|
"
" Sokolov Innokenty, <sokolov.innokenty@gmail.com>
"--------------------------------------------------


" fix ssh > vim > color
if has("terminfo")
    let &t_Co=8
    let &t_Sf="\e[3%p1%dm"
    let &t_Sb="\e[4%p1%dm"
else
    let &t_Co=8
    let &t_Sf="\e[3%dm"
    let &t_Sb="\e[4%dm"
endif

set nocompatible                            " режим несовместимый с Vi
set tabstop=4                               " количество пробелов для табуляции
set softtabstop=4                           " количество пробелов добавляемое при нажатии на клавишу табуляции
set shiftwidth=4                            " количество пробелов в командах отступа, например >>, или <<
set expandtab                               " заменить табуляцию на пробелы
set list                                    " показывать спец-символы
set listchars=tab:>-,trail:▸                " список спец-символов (eol:<символ_конца_строки>,tab:<начальный_символ_табуляции><последующие_символы_табуляции>,trail:<сивол_пробела_в_конце_строки>,nbsp:<символ_неразрывного_пробела>)
set nu                                      " нумерация строк
set ruler                                   " показывать курсов всегда
set showcmd                                 " показывать незавершённые команды в статусбаре

set foldenable!                             " выключаем фолдинг(сворачивание)
" set foldmethod=indent                       " фолдинг по отступам

set incsearch                               " поиск по набору текста
set ignorecase                              " игнорировать регистр
" set nohlsearch                              " отключаем подсветку найденного

set backup                                  " сохранять резервную копию файла
set backupdir=~/.vim/backup                 " сюда

set scrolljump=7                            " теперь нет необходимости передвигать курсор к краю экрана, чтобы подняться в режиме редактирования
set scrolloff=7                             " теперь нет необходимости передвигать курсор к краю экрана, чтобы опуститься в режиме редактирования

set novisualbell                            " выключаем надоедливый "звонок"
set t_vb=

set mouse=a                                 " включаем поддержку мыши
set mousemodel=popup                        " правая кнопка мыши всплывает меню
set mousehide                               " скрывать мышь, когда печатаем

set termencoding=utf-8                      " кодировка по умолчанию
set fileencodings=usc-bom,utf-8,default,    " список кодировок, которые Vim будет перебирать при открытии файла
set fileencodings+=,cp1251,latin1
" для явного указания кодировки файла используйте `:e ++enc=koi8-r foo.txt`

" не выгружать буфер, когда переключаемся на другой
" это позволяет редактировать несколько файлов в один
" и тот же момент без необходимости сохранения каждый раз,
" когда переключаешься между ними
set hidden

set guioptions-=T
set guifont=Terminus\ 12                    " шрифт в gvim

set ch=1                                    " высота командной строки
set autoindent                              " автоотступ
set backspace=indent,eol,start
set whichwrap+=<,>,[,]                      " разрешить переход на новую/предыдущую строку при достижении конца/начала текущей

" строка состояния
set statusline=
set statusline+=%2*%-3.3n%0*\               " номер буфера
set statusline+=%f\                         " название файла
set statusline+=%h%1*%m%r%w%0*              " флаги
set statusline+=[%{&encoding},              " кодировка
set statusline+=%{&fileformat}]             " формат файла
set statusline+=\ %{strlen(&ft)?&ft:'none'} " тип файла
set statusline+=\ %{fugitive#statusline()}  " git
set statusline+=%=                          " выравнивание по правой стороне (align right)
set statusline+=%2*0x%-8B\                  " текущий символ
set statusline+=%-10.(%l,%c%V%)\ %<%P       " номер строки, номер столбца]
set laststatus=2

set smartindent                             " умные отступы (после{)
set fo+=cr                                  " Fix <Enter> for comment
set sessionoptions=curdir,buffers,tabpages  " опции сесссий

" set spell                                   " проверка офографии
set spelllang=ru,en                         " список языков

syntax on                                   " подсветка синтаксиса

colorscheme wombat
"highlight Normal guibg=grey90
"highlight Cursor guibg=Green guifg=NONE
"highlight NonText guibg=grey80
"highlight Constant gui=NONE guibg=grey95
"highlight Special gui=NONE guibg=grey95

au BufNewFile,BufRead *.less set filetype=less
au BufRead *error.log* setf apachelogs
au BufRead *access.log* setf httplog


if has("autocmd")
    " Enable file type detection
    filetype on

    " Syntax of these languages is fussy over tabs Vs spaces
    autocmd FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
    autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

    " autocmd bufwritepost .vimrc source $MYVIMRC
endif


function! StripTrailingWhitespaces(command)
    " Preparation: save last search, and cursor position.
    let _s=@/
    let l = line(".")
    let c = col(".")
    " Do the business:
    execute a:command
    " Clean up: restore previous search history, and cursor position
    let @/=_s
    call cursor(l, c)
endfunction
nmap _$ :call StripTrailingWhitespaces("%s/\\s\\+$//e")<CR>

"runtime! debian.vim

"=======================
"=== горячие клавиши ===
"=======================

" выключаем  режим замены
imap >Ins> <Esc>i

" Пробел в нормальном режиме перелистывает страницы
"nmap <Space> <PageDown>

" CTRL-F для omni completion
map <C-F> <C-X><C-O>

" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

" Ctrl+C, Ctrl+V
"map <C-C> "+y
"vmap <C-C> "+y
"imap <C-C> "+y
"map <C-V> "+P
"vmap <C-V> <esc>"+pli
"imap <C-V> <esc>"+pli

" Shift+Insert (Xterm mode)
map <S-Insert> <MiddleMouse>

" Поиск и замена слова под курсором
nmap ; :%s/\<<c-r>=expand("<cword>")<cr>\>/

" F5 - просмотр списка буферов
nmap <F5> <Esc>:BufExplorer<cr>
vmap <F5> <esc>:BufExplorer<cr>
imap <F5> <esc><esc>:BufExplorer<cr>

" F6 - предыдущий буфер
map <F6> :bp<cr>
vmap <F6> <esc>:bp<cr>i
imap <F6> <esc>:bp<cr>i

" F7 - следующий буфер
map <F7> :bn<cr>
vmap <F7> <esc>:bn<cr>i
imap <F7> <esc>:bn<cr>i

" F8 - список закладок
map <F8> :MarksBrowser<cr>
vmap <F8> <esc>:MarksBrowser<cr>
imap <F8> <esc>:MarksBrowser<cr>

" F12 - обозреватель файлов
map <F12> :Ex<cr>
vmap <F12> <esc>:Ex<cr>i
imap <F12> <esc>:Ex<cr>i

" Парные скобки
imap [ []<LEFT>
imap {<CR> {<CR>}<Esc>0

" NERDTree
nmap <C-N> :NERDTree<cr>
vmap <C-N> <esc>:NERDTree<cr>i
imap <C-N> <esc>:NERDTree<cr>i

nmap <C-B> :NERDTreeClose<cr>
vmap <C-B> <esc>:NERDTreeClose<cr>i
imap <C-B> <esc>:NERDTreeClose<cr>i

" php-doc
inoremap <C-D> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-D> :call PhpDocSingle()<CR>
vnoremap <C-D> :call PhpDocRange()<CR>
