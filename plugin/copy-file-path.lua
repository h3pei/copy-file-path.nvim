---@param mods string filename-modifiers
---@param buf_path string|nil file path (defaults to current buffer)
---@return string
---see: https://vim-jp.org/vimdoc-ja/cmdline.html#filename-modifiers
local function format_path(mods, buf_path)
  local path = buf_path or vim.fn.expand("%")
  return vim.fn.fnamemodify(path, mods)
end

---@param path string
local function copy_to_clipboard(path)
  vim.fn.setreg("+", path)
  vim.notify("Copied: " .. path, vim.log.levels.INFO)
end

---@param separator string
---@return string
local function parse_separator(separator)
  if separator == "\\n" then
    return "\n"
  elseif separator == "\\t" then
    return "\t"
  else
    return separator
  end
end

---@param mods string filename-modifiers
---@param opts table command options
local function copy_current_buffer_path(mods, opts)
  local path = format_path(mods)

  if opts.range > 0 then
    if opts.line1 == opts.line2 then
      path = path .. ":" .. opts.line1
    else
      path = path .. ":" .. opts.line1 .. "-" .. opts.line2
    end
  end

  copy_to_clipboard(path)
end

---@param mods string filename-modifiers
---@return string[]
local function get_all_buffer_paths(mods)
  local paths = {}
  local buffers = vim.api.nvim_list_bufs()

  for _, buf in ipairs(buffers) do
    if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) ~= "" then
      local path = format_path(mods, vim.api.nvim_buf_get_name(buf))
      table.insert(paths, path)
    end
  end

  return paths
end

---@param mods string filename-modifiers
local function copy_all_buffer_paths(mods, opts)
  local separator = opts.args and opts.args ~= "" and parse_separator(opts.args) or " "
  local paths = get_all_buffer_paths(mods)

  if #paths == 0 then
    vim.notify("No buffers with file paths found", vim.log.levels.WARN)
    return
  end

  local result = table.concat(paths, separator)
  copy_to_clipboard(result)
end

vim.api.nvim_create_user_command("CopyRelativeFilePath", function(opts)
  copy_current_buffer_path(":.", opts)
end, { nargs = 0, range = true, force = true, desc = "Copy relative file path to the clipboard" })

vim.api.nvim_create_user_command("CopyAbsoluteFilePath", function(opts)
  copy_current_buffer_path(":p", opts)
end, { nargs = 0, range = true, force = true, desc = "Copy absolute file path to the clipboard" })

vim.api.nvim_create_user_command("CopyRelativeFilePathFromHome", function(opts)
  copy_current_buffer_path(":~", opts)
end, { nargs = 0, range = true, force = true, desc = "Copy relative file path from $HOME to the clipboard" })

vim.api.nvim_create_user_command("CopyFileName", function(opts)
  copy_current_buffer_path(":t", opts)
end, { nargs = 0, range = true, force = true, desc = "Copy just the file name to the clipboard" })

vim.api.nvim_create_user_command("CopyAllRelativeFilePaths", function(opts)
  copy_all_buffer_paths(":.", opts)
end, { nargs = "?", force = true, desc = "Copy all relative file paths to the clipboard" })

vim.api.nvim_create_user_command("CopyAllAbsoluteFilePaths", function(opts)
  copy_all_buffer_paths(":p", opts)
end, { nargs = "?", force = true, desc = "Copy all absolute file paths to the clipboard" })

vim.api.nvim_create_user_command("CopyAllRelativeFilePathsFromHome", function(opts)
  copy_all_buffer_paths(":~", opts)
end, { nargs = "?", force = true, desc = "Copy all relative file paths from $HOME to the clipboard" })

vim.api.nvim_create_user_command("CopyAllFileNames", function(opts)
  copy_all_buffer_paths(":t", opts)
end, { nargs = "?", force = true, desc = "Copy all file names to the clipboard" })

vim.api.nvim_create_user_command("CopyFilePath", function(opts)
  copy_current_buffer_path(":.", opts)
end, { nargs = 0, range = true, force = true, desc = "Alias for CopyRelativeFilePath" })
