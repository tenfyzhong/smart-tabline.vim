function! ctrlspace#init#Init()
    set tabline=%!ctrlspace#api#Tabline()

    if has("gui_running") && (&go =~# "e")
        set guitablabel=%{ctrlspace#api#Guitablabel()}

        " Fix MacVim issues:
        " http://stackoverflow.com/questions/11595301/controlling-tab-names-in-vim
        au BufEnter * set guitablabel=%{ctrlspace#api#Guitablabel()}
    endif

	au BufEnter * call ctrlspace#buffers#AddBuffer()
	au VimEnter * call ctrlspace#buffers#Init()
	au TabEnter * let t:CtrlSpaceTabJumpCounter = ctrlspace#jumps#IncrementJumpCounter()
endfunction

