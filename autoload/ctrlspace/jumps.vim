let s:jumpCounter = 0

function! ctrlspace#jumps#IncrementJumpCounter() "{{{
	let s:jumpCounter += 1
	return s:jumpCounter
endfunction "}}}

