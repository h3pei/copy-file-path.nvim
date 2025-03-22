# copy-file-path.nvim

A Neovim plugin to copy file path to the clipboard.

![copy-file-path-nvim-demo](https://github.com/h3pei/copy-file-path.nvim/assets/1377455/48f97509-bf81-45c9-bb6d-61bda6b609ec)

## Usage

Simply install copy-file-path.nvim with your favourite plugin manager (e.g. vim-plug or lazy.nvim) and you will be able to use the following commands.

|Command|Description|
|:--|:--|
|`:CopyRelativeFilePath`|Copy relative file path to the clipboard.|
|`:CopyAbsoluteFilePath`|Copy absolute file path to the clipboard.|
|`:CopyRelativeFilePathFromHome`|Copy relative file path from `$HOME` to the clipboard.|
|`:CopyFileName`|Copy just the file name to the clipboard.|
|`:CopyFilePath`|Alias for `CopyRelativeFilePath`|
