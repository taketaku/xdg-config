" vim:set foldmethod=marker:
" filetype off {{{
filetype off
filetype plugin indent off
" }}}
" reset augroup {{{
augroup MyAutoCmd
  autocmd!
augroup END
" }}}
" vim options {{{
set fenc=utf-8
set nobackup            " バックアップファイルを作らない
set noswapfile          " スワップファイルを作らない
set autoread            " 編集中のファイルが変更されたら自動で読み直す
set hidden              " バッファが編集中でもその他のファイルを開けるように
set showcmd             " 入力中のコマンドをステータスに表示する
set number              " 行番号を表示
set smartindent         " インデントはスマートインデント
set visualbell          " ビープ音を可視化
set showmatch           " 括弧入力時の対応する括弧を表示
set laststatus=2        " ステータスラインを常に表示

set list listchars=tab:\▸\-,trail:-,eol:↲ 
set expandtab           " Tab文字を半角スペースにする
set tabstop=4           " 行頭以外のTab文字の表示幅（スペースいくつ分）
set shiftwidth=4        " 行頭でのTab文字の表示幅

set nocursorline

set ignorecase " 小文字のみの検索文字列なら大文字小文字を区別なく検索する
set smartcase  " 検索文字列に大文字が含まれている場合は区別して検索する
set incsearch  " 検索文字列入力時に順次対象文字列にヒットさせる
set wrapscan   " 検索時に最後まで行ったら最初に戻る
set hlsearch   " 検索語をハイライト表示

" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" コマンドラインの補完
set wildmode=list:longest

set completeopt=menu,preview
"set clipboard+=unnamedplus
set clipboard=unnamed,unnamedplus
"}}}
" keymap settings {{{
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" quickfix
nnoremap [q :cprevious<CR>
nnoremap ]q :cnext<CR>
nnoremap [Q :<C-u>cfirst<CR>
nnoremap ]Q :<C-u>clast<CR>
" make
nnoremap mk :<C-u>make<CR>
nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>
"定義移動
"nnoremap <C-S-P> :tp<CR>
"nnoremap <C-S-N> :tn<CR>
inoremap <silent> jj <ESC>
" }}}
" termui settings {{{
if has("termguicolors")
  set termguicolors
  let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
endif
"}}}
" python runtime settings {{{
"let g:python_host_prog = "/usr/bin/python2"
"let g:python3_host_prog = "/usr/bin/python3"
let g:python_host_prog = "/Users/tt/.anyenv/envs/pyenv/versions/2.7.14/bin/python"
let g:python3_host_prog = "/Users/tt/.anyenv/envs/pyenv/versions/3.6.3/bin/python"
" }}}
" ruby runtime settings {{{
let g:ruby_host_prog = "/Users/tt/.anyenv/envs/rbenv/versions/2.4.2/bin/ruby"
" }}}
" global/gtags settings {{{
" }}}
" dein settings {{{
" プラグインの追加・削除やtomlファイルの設定を変更した後は
" 適宜 call dein#update や call dein#clear_state を呼んでください。
" そもそもキャッシュしなくて良いならload_state/save_stateを呼ばないようにしてください。
"
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_cache_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_cache_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath
" プラグイン読み込み＆キャッシュ作成
let s:toml_dir = fnamemodify(expand('<sfile>'), ':h')
if dein#load_state(s:dein_cache_dir)
  call dein#begin(s:dein_cache_dir)
  call dein#load_toml(s:toml_dir . '/dein_immed.toml', {'lazy': 0})
  call dein#load_toml(s:toml_dir . '/dein_lazy.toml',  {'lazy': 1})
  call dein#end()
  call dein#save_state()
endif
" 不足プラグインの自動インストール
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
" FIXME vimprocだけは最初にインストールしてほしい
"if dein#check_install(['vimproc'])
"  call dein#install(['vimproc'])
"endif
" その他インストールしていないものはこちらに入れる
if dein#check_install()
  call dein#install()
endif
" hook_post_sourceがcallされるようにする
augroup x_Dein
  autocmd! x_Dein
  autocmd VimEnter * call dein#call_hook('post_source')
augroup END
" }}}
" mouse settings {{{
if has('mouse') && !has('nvim')
  set mouse=a
  if has('mouse_sgr') 
    set ttymouse=sgr
  elseif v:version > 703 || v:version is 703 && has('patch632') " I couldn't use has('mouse_sgr') :-(
    set ttymouse=sgr
  else
    set ttymouse=xterm2
  endif
endif
"}}}
" cursorline settings {{{
augroup x_cursorline
  autocmd! x_cursorline
  autocmd WinLeave         * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
  autocmd InsertEnter      * set nocursorline
  autocmd InsertLeave      * set cursorline
augroup END
"}}}
" color settings {{{
function! s:X_Colorscheme_HighLights() abort
  " カーソル行
  hi clear CursorLine
  hi CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
  hi CursorLine   gui=underline   guifg=NONE   guibg=NONE
  " 改行文字
  hi NonText    guibg=NONE guifg=Gray50
  " タブ文字
  hi SpecialKey guibg=NONE guifg=Gray50
  " 行番号
  hi CursorLineNr term=bold   cterm=NONE ctermfg=228 ctermbg=NONE
endfunction
call s:X_Colorscheme_HighLights()
augroup x_colorschme
  autocmd! x_colorschme
  autocmd ColorScheme * call s:X_Colorscheme_HighLights()
augroup END
"}}}
" syntax settings {{{
syntax on
" }}}
" filetype on {{{
filetype plugin indent on
" }}}
