"-------------------------
" PHP настройки
"-------------------------

" Используем словарь PHP для автодополнения,
" который можно скачать отсюда http://lerdorf.com/funclist.txt
set dictionary=~/.vim/dic/php

" Сделаем удобную навигацию по мануалу PHP
set keywordprg=~/.vim/bin/php_doc 

" Проверка синтаксиса PHP
set makeprg=php\ -l\ %

" Формат вывода ошибок PHP
set errorformat=%m\ in\ %f\ on\ line\ %l

" Полезные "быстрые шаблоны"
" Вывод отладочной информации
iabbrev dbg echo '<pre>';var_dump( );echo '</pre>';
iabbrev tm echo 'Test message in file: '.__FILE__.', on line: '.__LINE__;

let g:pdv_cfg_Uses = 1

" Vim постовляется с достаточно мощным плугином подстветки синтаксиса PHP.
" Помимо прочего он умеет:

" Включаем фолдинг для блоков классов/функций
let php_folding = 1

" Не использовать короткие теги PHP для поиска PHP блоков
let php_noShortTags = 1

" Подстветка SQL внутри PHP строк
let php_sql_query=1

" Подстветка HTML внутри PHP строк
let php_htmlInStrings=1 

" Подстветка базовых функций PHP
let php_baselib = 1
