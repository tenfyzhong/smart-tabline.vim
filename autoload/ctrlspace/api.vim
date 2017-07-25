function! ctrlspace#api#BufferList(tabnr)
	let bufferList     = []
	let singleList     = ctrlspace#buffers#Buffers(a:tabnr)
	let visibleBuffers = tabpagebuflist(a:tabnr)

	for i in keys(singleList)
		let i = str2nr(i)

		let bufname = bufname(i)
		let bufVisible = index(visibleBuffers, i) != -1
		let bufModified = (getbufvar(i, '&modified'))

		if !strlen(bufname) && (bufModified || bufVisible)
			let bufname = '[' . i . '*No Name]'
		endif

		if strlen(bufname)
			call add(bufferList, { "index": i, "text": bufname, "visible": bufVisible, "modified": bufModified })
		endif
	endfor

    if g:ctrlspace#tabline#sort_method == 't'
        call sort(bufferList, function("ctrlspace#sort#CompareByText"))
    elseif g:ctrlspace#tabline#sort_method == 'p'
        call sort(bufferList, function("ctrlspace#sort#CompareByPath"))
    else
        call sort(bufferList, function("ctrlspace#sort#CompareByIndex"))
    endif

	return bufferList
endfunction

function! ctrlspace#api#Buffers(tabnr)
	let bufferList     = {}
	let ctrlspaceList  = ctrlspace#buffers#Buffers(a:tabnr)
	let visibleBuffers = tabpagebuflist(a:tabnr)

	for i in keys(ctrlspaceList)
		let i = str2nr(i)

		let bufname = bufname(i)

		if !strlen(bufname) && (getbufvar(i, '&modified') || (index(visibleBuffers, i) != -1))
			let bufname = '[' . i . '*No Name]'
		endif

		if strlen(bufname)
			let bufferList[i] = bufname
		endif
	endfor

	return bufferList
endfunction

function! ctrlspace#api#TabModified(tabnr)
	for b in map(keys(ctrlspace#buffers#Buffers(a:tabnr)), "str2nr(v:val)")
		if getbufvar(b, '&modified')
			return 1
		endif
	endfor
	return 0
endfunction


function! ctrlspace#api#TabBuffersNumber(tabnr)
	let buffersNumber = len(ctrlspace#api#Buffers(a:tabnr))
	let numberToShow  = ""

	if buffersNumber > 1
        let numberToShow = string(buffersNumber)
	endif

	return numberToShow
endfunction

function! ctrlspace#api#TabTitle(tabnr, bufnr, bufname)
	let bufname = a:bufname
	let bufnr   = a:bufnr
	let title   = ctrlspace#util#Gettabvar(a:tabnr, "CtrlSpaceLabel")

	if empty(title)
		if empty(bufname)
			let title = "[" . bufnr . "*No Name]"
		else
            if g:ctrlspace#tabline#fnamemod != ''
                let title = "[" . fnamemodify(bufname, g:ctrlspace#tabline#fnamemod) . "]"
            else
                let title = "[" . bufname . "]"
            endif
		endif
	endif

	return title
endfunction

function! ctrlspace#api#Guitablabel()
	let winnr      = tabpagewinnr(v:lnum)
	let buflist    = tabpagebuflist(v:lnum)
	let bufnr      = buflist[winnr - 1]
	let bufname    = bufname(bufnr)
	let title      = ctrlspace#api#TabTitle(v:lnum, bufnr, bufname)
	let bufsNumber = ctrlspace#api#TabBuffersNumber(v:lnum)

	if !empty(bufsNumber)
		let bufsNumber = ":" . bufsNumber
	end

	let label = '' . v:lnum . bufsNumber . ' '

	if ctrlspace#api#TabModified(v:lnum)
		let label .= '+ '
	endif

	let label .= title . ' '

	return label
endfunction

function! ctrlspace#api#TabList()
	let tabList     = []
	let lastTab    = tabpagenr("$")
	let currentTab = tabpagenr()

	for t in range(1, lastTab)
		let winnr       = tabpagewinnr(t)
		let buflist     = tabpagebuflist(t)
		let bufnr       = buflist[winnr - 1]
		let bufname     = bufname(bufnr)
		let tabTitle    = ctrlspace#api#TabTitle(t, bufnr, bufname)
		let tabModified = ctrlspace#api#TabModified(t)
		let tabCurrent  = t == currentTab

		call add(tabList, { "index": t, "title": tabTitle, "current": tabCurrent, "modified": tabModified })
        endfor

        return tabList
endfunction

function! ctrlspace#api#Tabline() abort "{{{
	let currentTab = tabpagenr()
	let tabline    = ''
    let bufferList = ctrlspace#api#BufferList(currentTab)
    let currentBuf = bufnr('%')
    let leftLen = 0
    let lastItemIsSel = 1
    for b in bufferList
        let text = b['text']
        if g:ctrlspace#tabline#fnamemod != ''
            let text = fnamemodify(text, g:ctrlspace#tabline#fnamemod)
        endif
        if !lastItemIsSel && b['index'] != currentBuf
            let text = g:ctrlspace#tabline#sep . ' '. text
        else
            let text = ' ' . text
        endif

        if b['index'] == currentBuf
            let lastItemIsSel = 1
            let tabline .= '%#TabLineSel#'
        else
            let lastItemIsSel = 0
            let tabline .= '%#TabLine#'
        endif

        let tabline .= b['index'] == currentBuf ? '%#TabLineSel#' : '%#TabLine#'
        let tabline .= text
        let tabline .= b['modified'] ? '+ ' : '  '
        let leftLen += len(text) + 2
    endfor

	let tabline .= '%#TabLineFill#'
    let tabline .= '%#TabLine#'
    let right = ' t%(%{tabpagenr()}%)/%(%{tabpagenr("$")}%)'

    let space = &columns - leftLen - 3 - len(string(tabpagenr())) - 1 - len(string(tabpagenr('$')))
    let tabline .= repeat(' ', space)
    let tabline .= '|'
    let tabline .= '%#TabLineSel#'
    let tabline .= right

    return tabline
endfunction "}}}

