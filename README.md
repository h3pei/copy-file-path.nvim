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
|`:CopyAllRelativeFilePaths [separator]`|Copy all relative file paths to the clipboard. Default separator is space.|
|`:CopyAllAbsoluteFilePaths [separator]`|Copy all absolute file paths to the clipboard. Default separator is space.|
|`:CopyAllRelativeFilePathsFromHome [separator]`|Copy all relative file paths from `$HOME` to the clipboard. Default separator is space.|
|`:CopyAllFileNames [separator]`|Copy all file names to the clipboard. Default separator is space.|

The single-file commands (`CopyRelativeFilePath`, `CopyAbsoluteFilePath`, `CopyRelativeFilePathFromHome`, `CopyFileName` and `CopyFilePath`) accept a range, which appends line numbers to the copied path:

- Select lines in visual mode and run `:'<,'>CopyRelativeFilePath` → `path/to/file.lua:10-20`
- Run with a line number like `:42CopyRelativeFilePath` → `path/to/file.lua:42`

For the `CopyAll*` commands, you can specify a separator:
- `,` for comma separation
- `"\n"` for newline separation
- `"\t"` for tab separation
- Any other string as a custom separator

## License

[MIT License](LICENSE)
