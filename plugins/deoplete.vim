" 常に補完候補を表示する
let g:deoplete#enable_at_startup = 1

" タブで補完候補を選択できるようにする
" inoremap <expr><Tab> pumvisible() ? "\<DOWN>" : "\<Tab>"
" inoremap <expr><S-Tab> pumvisible() ? "\<UP>" : "\<S-Tab>"

let g:deoplete#auto_complete_delay = 0
inoremap <expr><tab> pumvisible() ? "\<C-n>" :
      \ neosnippet#expandable_or_jumpable() ?
      \    "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
