# Smart-tabline.vim
This plugin is fork from [vim-ctrlspace/vim-ctrlspace](https://github.com/vim-ctrlspace/vim-ctrlspace). 
It remove all features but not tabline. You can't use it with vim-ctrlspace together.  

This plugin maintains buffers for the tab it belongs to.  

For example, you have two tabs. The first tab has 2 buffers, `a.txt` and `b.txt`. 
The second tab has 2 buffers, `1.txt` and `2.txt`. The tabline only show `a.txt` 
and `b.txt` when you are in the first tab. If you go to the second tab use `gt`, 
The tabline will show `1.txt` and `2.txt`.  

