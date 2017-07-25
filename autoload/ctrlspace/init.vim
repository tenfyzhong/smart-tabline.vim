function! ctrlspace#init#Init() "{{{
    set tabline=%!ctrlspace#api#Tabline()

    if has("gui_running") && (&go =~# "e")
        set guitablabel=%{ctrlspace#api#Guitablabel()}

        " Fix MacVim issues:
        " http://stackoverflow.com/questions/11595301/controlling-tab-names-in-vim
        au BufEnter * set guitablabel=%{ctrlspace#api#Guitablabel()}
    endif

	au BufEnter * call ctrlspace#buffers#AddBuffer()
	au VimEnter * call ctrlspace#buffers#Init()

    let g:ctrlspace#tabline#wrapping_around = get(g:, 'ctrlspace#tabline#wrapping_around', 1)
    let g:ctrlspace#tabline#sep = get(g:, 'ctrlspace#tabline#sep', '|')
    let g:ctrlspace#tabline#sort_method = get(g:, 'ctrlspace#tabline#sort_method', 'i')
    let g:ctrlspace#tabline#fnamemod = get(g:, 'ctrlspace#tabline#fnamemod', ':t')
endfunction "}}}

nnoremap <Plug>(ctrlspace#mapping#NextBuffer) :<c-u>call ctrlspace#mapping#NextBuffer(1)<cr>
nnoremap <Plug>(ctrlspace#mapping#PreviousBuffer) :<c-u>call ctrlspace#mapping#NextBuffer(0)<cr>

