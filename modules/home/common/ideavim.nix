{ ... }:
{
  # In your home.nix or home-manager configuration
  home.file.".ideavimrc".text = ''
    " Leader key configuration
    let mapleader=" "

    " Essential settings
    set number
    set relativenumber
    set clipboard=unnamedplus
    set scrolloff=8
    set incsearch
    set ignorecase
    set smartcase

    " Enable IdeaVim plugins
    set surround
    set commentary
    set multiple-cursors
    set easymotion
    set NERDTree
    set which-key

    " Window navigation
    map <C-h> <C-w>h
    map <C-j> <C-w>j
    map <C-k> <C-w>k
    map <C-l> <C-w>l

    " IDE actions
    map <leader>ff <Action>(GotoFile)
    map <leader>fg <Action>(FindInPath)
    map <leader>fr <Action>(RecentFiles)
    map <leader>rn <Action>(RenameElement)
    map <leader>ca <Action>(ShowIntentionActions)

    " Quick escape
    inoremap jj <ESC>
  '';

}
