-- Markdown formatter plugin
-- Formats markdown text with one sentence per line and smart punctuation handling

local M = {}

-- Check if a character position is inside a code span (`code`)
local function is_in_code_span(line, pos)
  local backtick_count = 0
  for i = 1, pos - 1 do
    if line:sub(i, i) == "`" then
      backtick_count = backtick_count + 1
    end
  end
  -- Odd number of backticks means we're inside a code span
  return backtick_count % 2 == 1
end

-- Check if line is a code block fence or inside a code block
local function is_code_block_line(line)
  return line:match("^%s*```") or line:match("^%s*~~~") or line:match("^%s%s%s%s") or line:match("^\t")
end

-- Check if line is a list item
local function is_list_item(line)
  -- Unordered lists: -, *, +
  if line:match("^%s*[%-%*%+]%s") then
    return true, line:match("^(%s*[%-%*%+]%s+)")
  end
  -- Ordered lists: 1., 2., etc.
  if line:match("^%s*%d+%.%s") then
    return true, line:match("^(%s*%d+%.%s+)")
  end
  return false, nil
end

-- Check if line is a heading
local function is_heading(line)
  return line:match("^#+%s") ~= nil
end

-- Check if line is a blockquote
local function is_blockquote(line)
  return line:match("^%s*>") ~= nil
end

-- Check if line is empty or whitespace only
local function is_empty(line)
  return line:match("^%s*$") ~= nil
end

-- Check if text appears to be a URL or inside markdown link
local function looks_like_url(text, start_pos)
  -- Check for common URL patterns around this position
  local before = text:sub(math.max(1, start_pos - 20), start_pos)
  local after = text:sub(start_pos, math.min(#text, start_pos + 20))
  local context = before .. after

  -- Look for http://, https://, www.
  if context:match("https?://") or context:match("www%.") then
    return true
  end

  -- Check if we're inside a markdown link [text](url)
  -- Look backwards for ]( without a closing )
  local open_link = before:reverse():find("%(%]")
  local close_link = before:reverse():find("%)")
  if open_link and (not close_link or open_link < close_link) then
    return true
  end

  return false
end

-- Find sentence boundaries in a line of text
-- Returns array of positions where sentences end (inclusive of trailing punctuation/space)
local function find_sentence_boundaries(line)
  local boundaries = {}
  local i = 1

  while i <= #line do
    local char = line:sub(i, i)

    -- Skip if we're inside a code span
    if is_in_code_span(line, i) then
      i = i + 1
      goto continue
    end

    -- Check for sentence-ending punctuation
    if char:match("[%.%!%?]") then
      -- Check if it looks like a URL
      if looks_like_url(line, i) then
        i = i + 1
        goto continue
      end

      -- Look ahead to see what follows
      local next_pos = i + 1
      local next_char = next_pos <= #line and line:sub(next_pos, next_pos) or ""

      -- Skip if followed by more punctuation (ellipsis, etc.)
      if next_char:match("[%.%!%?]") then
        i = i + 1
        goto continue
      end

      -- Skip common abbreviations
      local before = line:sub(math.max(1, i - 10), i)
      if before:match("Mr%.$") or before:match("Mrs%.$") or before:match("Dr%.$") or
         before:match("Ms%.$") or before:match("vs%.$") or before:match("etc%.$") or
         before:match("e%.g%.$") or before:match("i%.e%.$") then
        i = i + 1
        goto continue
      end

      -- Determine the actual end of sentence position
      -- Sentence ends after: punctuation + optional closing marks + space
      local boundary_pos = i
      local scan_pos = next_pos

      -- Skip over closing punctuation (parentheses, brackets, quotes)
      while scan_pos <= #line do
        local scan_char = line:sub(scan_pos, scan_pos)
        if scan_char:match("[%)%]\"'`]") then
          boundary_pos = scan_pos
          scan_pos = scan_pos + 1
        else
          break
        end
      end

      -- Now check if what follows is a new sentence
      local after_boundary = line:sub(boundary_pos + 1)

      -- This is a sentence boundary if:
      -- - We're at the end of the line
      -- - Followed by whitespace and then a capital letter
      if boundary_pos == #line then
        table.insert(boundaries, boundary_pos)
      elseif after_boundary:match("^%s+%u") or after_boundary:match("^%s+%d") then
        -- Find where the whitespace ends
        local ws_end = after_boundary:find("%S")
        if ws_end then
          table.insert(boundaries, boundary_pos + ws_end - 1)
        end
      end
    end

    i = i + 1
    ::continue::
  end

  return boundaries
end

-- Add period to end of text if it doesn't have sentence-ending punctuation
local function ensure_period(text)
  -- Trim trailing whitespace
  text = text:gsub("%s+$", "")

  -- Check if already ends with sentence punctuation
  if text:match("[%.%!%?]$") then
    return text
  end

  -- Don't add period to empty text or headings
  if text == "" or text:match("^#+%s") then
    return text
  end

  return text .. "."
end

-- Split line into sentences
local function split_into_sentences(line)
  local boundaries = find_sentence_boundaries(line)

  if #boundaries == 0 then
    return { line }
  end

  local sentences = {}
  local start_pos = 1

  for _, boundary in ipairs(boundaries) do
    local sentence = line:sub(start_pos, boundary)
    -- Trim leading whitespace from non-first sentences
    if start_pos > 1 then
      sentence = sentence:gsub("^%s+", "")
    end
    table.insert(sentences, sentence)
    start_pos = boundary + 1
  end

  -- Add remaining text if any
  if start_pos <= #line then
    local remaining = line:sub(start_pos)
    remaining = remaining:gsub("^%s+", "")
    if remaining ~= "" then
      table.insert(sentences, remaining)
    end
  end

  return sentences
end

-- Format a single paragraph of text
local function format_paragraph(lines)
  -- Join lines into single paragraph
  local paragraph = table.concat(lines, " ")

  -- Normalize whitespace
  paragraph = paragraph:gsub("%s+", " ")
  paragraph = paragraph:gsub("^%s+", "")
  paragraph = paragraph:gsub("%s+$", "")

  -- Split into sentences
  return split_into_sentences(paragraph)
end

-- Format list item content
local function format_list_item(line)
  local is_list, prefix = is_list_item(line)
  if not is_list then
    return { line }
  end

  -- Extract content after list marker
  local content = line:sub(#prefix + 1)
  content = ensure_period(content)

  -- Split into sentences if there are multiple
  local sentences = split_into_sentences(content)

  -- Add prefix to first sentence, indent others
  local result = {}
  for i, sentence in ipairs(sentences) do
    if i == 1 then
      table.insert(result, prefix .. sentence)
    else
      -- Match the indentation of the list item
      local indent = prefix:gsub("[%-%*%+%d%.]", " ")
      table.insert(result, indent .. sentence)
    end
  end

  return result
end

-- Format a range of lines
local function format_lines(lines)
  local result = {}
  local in_code_block = false
  local paragraph_buffer = {}
  local i = 1

  while i <= #lines do
    local line = lines[i]

    -- Check for code block markers
    if is_code_block_line(line) then
      -- Flush any buffered paragraph
      if #paragraph_buffer > 0 then
        local formatted = format_paragraph(paragraph_buffer)
        for _, l in ipairs(formatted) do
          table.insert(result, l)
        end
        paragraph_buffer = {}
      end

      -- Toggle code block state if it's a fence
      if line:match("^%s*```") or line:match("^%s*~~~") then
        in_code_block = not in_code_block
      end

      table.insert(result, line)
      i = i + 1
      goto continue
    end

    -- Pass through code block content unchanged
    if in_code_block then
      table.insert(result, line)
      i = i + 1
      goto continue
    end

    -- Handle empty lines - they separate paragraphs
    if is_empty(line) then
      -- Flush paragraph buffer
      if #paragraph_buffer > 0 then
        local formatted = format_paragraph(paragraph_buffer)
        for _, l in ipairs(formatted) do
          table.insert(result, l)
        end
        paragraph_buffer = {}
      end
      table.insert(result, line)
      i = i + 1
      goto continue
    end

    -- Handle headings - don't modify
    if is_heading(line) then
      if #paragraph_buffer > 0 then
        local formatted = format_paragraph(paragraph_buffer)
        for _, l in ipairs(formatted) do
          table.insert(result, l)
        end
        paragraph_buffer = {}
      end
      table.insert(result, line)
      i = i + 1
      goto continue
    end

    -- Handle blockquotes - preserve but format content
    if is_blockquote(line) then
      if #paragraph_buffer > 0 then
        local formatted = format_paragraph(paragraph_buffer)
        for _, l in ipairs(formatted) do
          table.insert(result, l)
        end
        paragraph_buffer = {}
      end
      -- For now, just pass through - could enhance to format blockquote content
      table.insert(result, line)
      i = i + 1
      goto continue
    end

    -- Handle list items
    local is_list, _ = is_list_item(line)
    if is_list then
      if #paragraph_buffer > 0 then
        local formatted = format_paragraph(paragraph_buffer)
        for _, l in ipairs(formatted) do
          table.insert(result, l)
        end
        paragraph_buffer = {}
      end

      local formatted_list = format_list_item(line)
      for _, l in ipairs(formatted_list) do
        table.insert(result, l)
      end
      i = i + 1
      goto continue
    end

    -- Regular paragraph line - buffer it
    table.insert(paragraph_buffer, line)
    i = i + 1

    ::continue::
  end

  -- Flush any remaining buffered paragraph
  if #paragraph_buffer > 0 then
    local formatted = format_paragraph(paragraph_buffer)
    for _, l in ipairs(formatted) do
      table.insert(result, l)
    end
  end

  return result
end

-- Format selection or entire buffer
function M.format(opts)
  opts = opts or {}

  local bufnr = vim.api.nvim_get_current_buf()
  local start_line, end_line

  if opts.range == 2 then
    -- Visual selection
    start_line = opts.line1
    end_line = opts.line2
  else
    -- Entire buffer
    start_line = 1
    end_line = vim.api.nvim_buf_line_count(bufnr)
  end

  -- Get the lines
  local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)

  -- Format them
  local formatted = format_lines(lines)

  -- Replace the lines
  vim.api.nvim_buf_set_lines(bufnr, start_line - 1, end_line, false, formatted)

  -- Notify user
  local msg = string.format("Formatted %d lines into %d lines", end_line - start_line + 1, #formatted)
  vim.notify(msg, vim.log.levels.INFO)
end

-- Setup function to register commands
function M.setup()
  -- Create user command
  vim.api.nvim_create_user_command("MarkdownFormat", function(opts)
    M.format(opts)
  end, {
    range = true,
    desc = "Format markdown with one sentence per line"
  })

  -- Create keybinding for markdown files
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
      vim.keymap.set(
        { "n", "v" },
        "<leader>mf",
        ":MarkdownFormat<CR>",
        { buffer = true, desc = "Format markdown sentences", silent = true }
      )
    end,
  })
end

return M
