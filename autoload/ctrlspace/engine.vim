function! ctrlspace#engine#CompareByText(a, b)
    let lhs = fnamemodify(a:a.text, ':p')
    let rhs = fnamemodify(a:b.text, ':p')
    return lhs < rhs ? -1 : (lhs > rhs ? 1 : 0)
endfunction

