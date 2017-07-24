let s:allBuffers = {}

function! ctrlspace#buffers#Init() "{{{
	for current in range(1, bufnr("$"))
		if !getbufvar(current, "&buflisted")
			break
		endif

		if !has_key(s:allBuffers, current)
			let s:allBuffers[current] = len(s:allBuffers) + 1
		endif
	endfor
endfunction "}}}

function! ctrlspace#buffers#AddBuffer() "{{{
	let current = bufnr('%')

	if !getbufvar(current, "&buflisted")
		return
	endif

	if !has_key(s:allBuffers, current)
		let s:allBuffers[current] = len(s:allBuffers) + 1
	endif

	if !exists("t:CtrlSpaceList")
		let t:CtrlSpaceList = {}
	endif

	if !has_key(t:CtrlSpaceList, current)
		let t:CtrlSpaceList[current] = len(t:CtrlSpaceList) + 1
	endif
endfunction "}}}

function! ctrlspace#buffers#Buffers(tabnr) "{{{
	if a:tabnr
		let buffers = gettabvar(a:tabnr, "CtrlSpaceList")

		" Workaround for a Vim bug after :only and e.g. help window:
		" for the first time after :only gettabvar cannot properly ready any tab variable
		" More info: https://github.com/vim/vim/issues/394
		" TODO Remove when decided to drop support for Vim 7.3
		if type(buffers) == 1
			unlet buffers
			let buffers = gettabvar(a:tabnr, "CtrlSpaceList")
		endif

		if type(buffers) != 4
			return {}
		endif
	else
		let buffers = s:allBuffers
	endif

	return filter(buffers, "buflisted(str2nr(v:key))") " modify proper dictionary and return it
endfunction "}}}"

