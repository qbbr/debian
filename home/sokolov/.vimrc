" trololo #fix ssh > vim > color
if has("terminfo")
    let &t_Co=8
    let &t_Sf="\e[3%p1%dm"
    let &t_Sb="\e[4%p1%dm"
else
    let &t_Co=8
    let &t_Sf="\e[3%dm"
    let &t_Sb="\e[4%dm"
endif

set nocompatible " режим несовместимый с Vi
set tabstop=4 " количество пробелов для табуляции
set softtabstop=4 " количество пробелов добавляемое при нажатии на клавишу табуляции
set shiftwidth=4 " количество пробелов в командах отступа, например >>, или <<
set expandtab " заменить табуляцию на пробелы
set list " показывать спец-символы
set listchars=tab:>-,trail:▸ " список спец-символов (eol:<символ_конца_строки>,tab:<начальный_символ_табуляции><последующие_символы_табуляции>,trail:<сивол_пробела_в_конце_строки>,nbsp:<символ_неразрывного_пробела>)
set nu " нумерация строк
set ruler " показывать курсов всегда
set showcmd " показывать незавершённые команды в статусбаре
set foldenable!
"set foldmethod=indent " фолдинг(сворачивание) по отступам
set incsearch " поиск по набору текста
" set nohlsearch " отключаем подсветку найденного

" режим редактирования, когда курсор на краю экрана
set scrolljump=7
set scrolloff=7
" no beep
set novisualbell
set t_vb=

" mouse
set mouse=a
set mousemodel=popup
set mousehide " скрывать мышь, когда печатаем

set termencoding=utf-8 " кодировка по умолчанию
set fileencodings=usc-bom,utf-8,default,cp1251,latin1

" Не выгружать буфер, когда переключаемся на другой
" Это позволяет редактировать несколько файлов в один и тот же момент без необходимости сохранения каждый раз
" когда переключаешься между ними
set hidden

set guioptions-=T
set ch=1 " высота командной строки
set autoindent " автоотступ
set backspace=indent,eol,start whichwrap+=<,>,[,]

set statusline=%<%f%h%m%r\ %b\ %{&encoding}\ 0x\ \ %l,%c%V\ %P " формат строки состояния
set laststatus=2
set smartindent " умные отступы (после{)

set fo+=cr " Fix <Enter> for comment
set sessionoptions=curdir,buffers,tabpages " опции сесссий

"map ^T :w!<CR>:!aspell check %<CR>:e! %<CR>

"set spell
set spelllang=ru,en

" выключаем  режим замены
imap >Ins> <Esc>i

syntax on

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

    autocmd bufwritepost .vimrc source $MYVIMRC
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
