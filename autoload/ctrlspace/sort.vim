function! ctrlspace#sort#CompareByIndex(a, b)
    return a:a.index - a:b.index
endfunction

function! ctrlspace#sort#CompareByText(a, b)
    return a:a.text < a:b.text ? -1 : (a:a.text > a:b.text ? 1 : 0)
endfunction

function! ctrlspace#sort#CompareByPath(a, b)
    let lhs = fnamemodify(a:a.text, ':p')
    let rhs = fnamemodify(a:b.text, ':p')
    return lhs < rhs ? -1 : (lhs > rhs ? 1 : 0)
endfunction
