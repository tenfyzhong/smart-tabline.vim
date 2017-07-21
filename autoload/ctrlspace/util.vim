" Workaround for a Vim bug after :only and e.g. help window:
" for the first time after :only gettabvar cannot properly ready any tab variable
" More info: https://github.com/vim/vim/issues/394
" TODO Remove when decided to drop support for Vim 7.3
function! ctrlspace#util#Gettabvar(nr, name) "{{{
	let value = gettabvar(a:nr, a:name)

	if type(value) == 1 && empty(value)
		unlet value
		let value = gettabvar(a:nr, a:name)
	endif

	return value
endfunction "}}}

