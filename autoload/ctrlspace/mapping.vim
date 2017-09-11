"==============================================================
"    file: mapping.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfy@tenfy.cn
" created: 2017-07-24 19:12:21
"==============================================================

function! s:NextCurBufnr(forward, wrapping_around) "{{{
    let tabnr = tabpagenr()
    let buffers = ctrlspace#api#BufferList(tabnr)
    if len(buffers) <= 1
        return 0
    endif

    let curBufnr = bufnr('%')
    let index = 0
    for buf in buffers
        if buf['index'] == curBufnr
            break
        endif
        let index += 1
    endfor

    if a:forward
        return index < len(buffers)-1 ? buffers[index+1]['index'] : 
                    \a:wrapping_around ? buffers[0]['index'] : 0
    else
        return index != 0 ? buffers[index-1]['index'] : 
                    \a:wrapping_around ? buffers[-1]['index'] : 0
    endif
endfunction "}}}

function! ctrlspace#mapping#NextBuffer(forward) "{{{
    let nextBufnr = <SID>NextCurBufnr(a:forward, g:ctrlspace#mapping#wrapping_around)
    if nextBufnr == 0
        echom "No next buffer"
        return
    endif
    let cmd = printf('b %d', nextBufnr)
    exec cmd
endfunction "}}}

