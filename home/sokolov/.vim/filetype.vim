" Syntax of these languages is fussy over tabs Vs spaces
au FileType make setlocal ts=8 sts=8 sw=8 noexpandtab
au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

au FileType html,htmljinja,htmldjango set omnifunc=htmlcomplete#CompleteTags
au FileType css set omnifunc=csscomplete#CompleteCSS
au FileType php set omnifunc=phpcomplete#CompletePHP
au FileType javascript set omnifunc=javascriptcomplete#CompleteJS

" au bufwritepost .vimrc source $MYVIMRC

au! BufRead,BufNewFile *.json set filetype=json foldmethod=syntax
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery
" au BufRead,BufNewFile *.html set ft=html syntax=htmljinja
au BufRead,BufNewFile *.twig set ft=html syntax=htmljinja
au Filetype html,xml,xsl,twig,htmljinja,htmldjango source ~/.vim/scripts/closetag.vim

au BufNewFile,BufRead *.less set filetype=less
au BufRead *error.log* setf apachelogs
au BufRead *access.log* setf httplog
