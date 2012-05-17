filetype off
""" pathogen をコメントアウト
" call pathogen#runtime_append_all_bundles()
" call pathogen#helptags()
" set helpfile=$VIMRUNTIME/doc/help.txt
 
filetype plugin on

" 折り返さない
set nowrap

" タブ文字系
set tabstop=4
set shiftwidth=4

" 
set autoindent
set expandtab
set shiftwidth=4
set smarttab
set smartindent

" %で移動
source $VIMRUNTIME/macros/matchit.vim
let b:match_ignorecase = 1 
let b:match_words="if:endif,foreach:endforeach,\<begin\>:\<end\>"
filetype plugin on
 
""" Vundle '''
"set rtp+=~/.vim/vundle/
"call vundle#rc()

" 利用中のプラグインをBundle
"Bundle 'Shougo/neocomplcache'
"Bundle 'Shougo/unite.vim'
"Bundle 'scrooloose/nerdcommenter'
"Bundle 'tpope/vim-surround'
"Bundle 'thinca/vim-quickrun'
"Bundle 'thinca/vim-ref'
"Bundle 'kana/vim-fakeclip'

syntax on
set clipboard=unnamed
set number
set hlsearch 
"set readonly
set laststatus=2
set title
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/

" 検索
set incsearch
set noignorecase

" カレント行
set cursorline
highlight CursorLine ctermbg=Black

" ポップアップ色
highlight Pmenu ctermbg=DarkBlue
highlight PmenuSel ctermbg=red
highlight PmenuSbar ctermbg=Gray
highlight PmenuThumb ctermfg=White

" タブ画面設定
map <C-n> :tabe<CR>
map <C-h> :tabp<CR>
map <C-l> :tabn<CR>
set showtabline=2

hi TabLineSel  term=bold cterm=bold,underline ctermfg=LightGray ctermbg=DarkBlue gui=bold,underline guifg=LightGray guibg=DarkBlue
hi TabLine term=reverse cterm=underline ctermfg=Black ctermfg=Gray ctermbg=black gui=underline guifg=Black guibg=gray
hi TabLineFill term=reverse cterm=reverse,bold ctermfg=LightGray ctermbg=black gui=reverse,bold guifg=LightGray guibg=black
hi TabLineInfo term=reverse ctermfg=Black ctermbg=LightBlue guifg=black guibg=lightblue

" 文法チェック
set makeprg=php\ -l\ %
set errorformat=%m\ in\ %f\ on\ line\ %l
" カーソル位置保存
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

set ambiwidth=double

" 開いているファイルの文字コードを指定して開きなおす
" EUC-JP
nmap ,ee :e ++enc=euc-jp<CR>
" SJIS
nmap ,es :e ++enc=cp932<CR>
" JIS
nmap ,ej :e ++enc=iso-2022-jp<CR>
" UTF-8
nmap ,eu :e ++enc=utf-8<CR>
