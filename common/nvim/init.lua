-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

vim.keymap.set({ "n", "v" }, "<leader><leader>", ":", { desc = "Command mode" })
vim.keymap.set("n", "s", "<cmd>write<cr>", { desc = "Save file" })
vim.keymap.set("n", ", ", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })
vim.keymap.set("i", "jk", "<esc>", { desc = "Exit insert mode" })

-- Y as a yank-to-system-clipboard operator (normal + visual). YY for whole line.
vim.keymap.set({ "n", "x" }, "Y", '"+y', { desc = "Yank to system clipboard" })
vim.keymap.set("n", "YY", '"+yy', { desc = "Yank line to system clipboard" })

-- Unified "code tooling" prefix.
local function code_map(suffix, rhs, desc, mode)
	mode = mode or "n"
	vim.keymap.set(mode, "<leader>c" .. suffix, rhs, { desc = desc })
end

-- Navigate
code_map("d", vim.lsp.buf.definition, "Goto definition")
vim.keymap.set("n", "<CR>", vim.lsp.buf.definition, { desc = "Goto definition" })
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Goto definition" })
vim.keymap.set("n", "<BS>", "<C-o>", { desc = "Jump back (previous jumplist position)" })
vim.keymap.set("n", "<Left>", "<C-o>", { desc = "Jump back (previous jumplist position)" })
vim.keymap.set("n", "<Right>", "<C-i>", { desc = "Jump forward (next jumplist position)" })
-- The global <CR> above shadows the quickfix/location-list window's built-in
-- "jump to entry" behavior. Un-map it there so <CR> falls through to the
-- builtin qf handling instead of firing goto-definition.
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "qf" },
	callback = function(args)
		vim.keymap.set("n", "<CR>", "<CR>", { buffer = args.buf, desc = "Jump to quickfix entry" })
	end,
})
code_map("r", function()
	Snacks.picker.lsp_references()
end, "References")
code_map("i", function()
	Snacks.picker.lsp_implementations()
end, "Implementations")
code_map("t", function()
	Snacks.picker.lsp_type_definitions()
end, "Type definition")
code_map("s", function()
	Snacks.picker.lsp_symbols()
end, "Document symbols")
code_map("S", function()
	Snacks.picker.lsp_workspace_symbols()
end, "Workspace symbols")

-- Info
code_map("k", vim.lsp.buf.hover, "Hover docs")
code_map("g", vim.lsp.buf.signature_help, "Signature help")
code_map("e", vim.diagnostic.open_float, "Diagnostic under cursor")
code_map("E", function()
	Snacks.picker.diagnostics()
end, "All diagnostics")

-- Refactor
code_map("n", vim.lsp.buf.rename, "Rename symbol")
code_map("a", vim.lsp.buf.code_action, "Code action", { "n", "x" })
code_map("f", function()
	require("conform").format({ async = true, lsp_format = "fallback" })
end, "Format", { "n", "x" })

-- Sends the visual selection to `claude -p` with a user-supplied instruction,
-- then opens the original and suggested versions as a side-by-side diff in a
-- new tab -- review-only, nothing is written back to the buffer.
local function claude_refactor_selection()
	local srow, erow = vim.fn.line("v"), vim.fn.line(".")
	if srow > erow then
		srow, erow = erow, srow
	end
	local original_lines = vim.api.nvim_buf_get_lines(0, srow - 1, erow, false)
	local original = table.concat(original_lines, "\n")
	local ft = vim.bo.filetype

	vim.ui.input(
		{ prompt = "Refactor instruction: ", default = "Refactor this code for clarity" },
		function(instruction)
			if not instruction or instruction == "" then
				return
			end
			local prompt = instruction
				.. "\n\nOutput ONLY the refactored code. No explanation, no markdown code fences.\n\n"
				.. original

			vim.notify("Asking Claude...", vim.log.levels.INFO)
			vim.system({ "claude", "-p", prompt }, { text = true }, function(obj)
				vim.schedule(function()
					if obj.code ~= 0 then
						vim.notify("claude failed:\n" .. (obj.stderr or ""), vim.log.levels.ERROR)
						return
					end

					vim.cmd("tabnew")
					local left = vim.api.nvim_get_current_buf()
					vim.bo[left].filetype = ft
					vim.api.nvim_buf_set_lines(left, 0, -1, false, original_lines)
					vim.cmd("diffthis")

					vim.cmd("vsplit")
					local right = vim.api.nvim_create_buf(false, true)
					vim.api.nvim_win_set_buf(0, right)
					vim.bo[right].filetype = ft
					vim.api.nvim_buf_set_lines(right, 0, -1, false, vim.split(obj.stdout, "\n"))
					vim.cmd("diffthis")
				end)
			end)
		end
	)
end
code_map("R", claude_refactor_selection, "Claude: refactor selection (diff)", "x")

-- Run `cmd` in a small tmux pane below, without stealing focus from nvim.
-- Falls back to :! when not inside tmux.
local function run_detached(cmd)
	if vim.env.TMUX then
		vim.fn.system({
			"tmux",
			"split-window",
			"-v",
			"-l",
			"15",
			"-d",
			cmd .. "; printf '\\n[press any key to close]'; read -n 1 -s",
		})
	else
		vim.notify("Not in tmux; running with :!", vim.log.levels.WARN)
		vim.cmd("!" .. cmd)
	end
end

-- Build
code_map("m", function()
	local makefile
	for _, name in ipairs({ "Makefile", "makefile", "GNUmakefile" }) do
		local found = vim.fn.findfile(name, ".;")
		if found ~= "" then
			makefile = vim.fn.fnamemodify(found, ":p")
			break
		end
	end
	if not makefile then
		vim.notify("No Makefile found", vim.log.levels.WARN)
		return
	end

	local items, seen, lineno = {}, {}, 0
	for line in io.lines(makefile) do
		lineno = lineno + 1
		-- target name, then `:` not followed by `=` (skip `:=` assignments)
		local name, after = line:match("^([%w][%w_%-%.%/]+):(.?)")
		if name and after ~= "=" and not seen[name] then
			seen[name] = true
			items[#items + 1] = { text = name, file = makefile, pos = { lineno, 0 } }
		end
	end
	table.sort(items, function(a, b)
		return a.text < b.text
	end)

	Snacks.picker.pick({
		source = "make_targets",
		title = "Make targets",
		items = items,
		format = "text",
		confirm = function(picker, item)
			picker:close()
			run_detached("make " .. item.text)
		end,
	})
end, "Pick make target")

-- Lint
local golangci_lint_ns = vim.api.nvim_create_namespace("golangcilint")
local golangci_lint_reqs = {} -- bufnr -> latest request id, so a slow run can't clobber a newer one's diagnostics

-- nvim-lint's own golangcilint runner reports failures only as "exited with
-- code N" (it never reads the process's stderr), discarding the actual
-- reason (bad .golangci.yml, a package that fails to load, etc.). Reuse its
-- cmd/args/parser but run it ourselves so real errors are visible. Exit code
-- is the reliable signal here: on success golangci-lint can still write
-- deprecated-linter warnings to stderr, so stderr is only trustworthy as an
-- error message when the exit code is actually nonzero.
local function run_golangci_lint()
	local bufnr = vim.api.nvim_get_current_buf()
	local linter = require("lint.linters.golangcilint")
	local cwd = vim.fn.getcwd()
	local args = vim.tbl_map(function(a)
		return type(a) == "function" and a() or a
	end, linter.args or {})

	local reqid = (golangci_lint_reqs[bufnr] or 0) + 1
	golangci_lint_reqs[bufnr] = reqid

	vim.system(vim.list_extend({ linter.cmd }, args), { text = true, cwd = cwd }, function(obj)
		vim.schedule(function()
			if golangci_lint_reqs[bufnr] ~= reqid or not vim.api.nvim_buf_is_valid(bufnr) then
				return
			end
			if obj.code ~= 0 then
				vim.notify("golangci-lint failed:\n" .. (obj.stderr or ""), vim.log.levels.ERROR)
				return
			end
			local ok, diagnostics = pcall(linter.parser, obj.stdout or "", bufnr, cwd)
			if ok then
				vim.diagnostic.set(golangci_lint_ns, bufnr, diagnostics)
			else
				vim.notify("golangci-lint output parse failed:\n" .. diagnostics, vim.log.levels.ERROR)
			end
		end)
	end)
end

code_map("l", function()
	if vim.bo.filetype == "go" then
		run_golangci_lint()
	else
		require("lint").try_lint()
	end
end, "Re-lint buffer")

-- Test running (Go). Separate <leader>t prefix.
local function test_map(suffix, rhs, desc)
	vim.keymap.set("n", "<leader>t" .. suffix, rhs, { desc = desc })
end

-- Shared with the nvim-coverage plugin spec's lang.go.coverage_file below.
local go_coverage_file = vim.fn.stdpath("cache") .. "/go-coverage.out"

-- Nearest `func TestXxx(t *testing.T)` at or above the cursor.
local function nearest_go_test_name()
	local lnum = vim.api.nvim_win_get_cursor(0)[1]
	local lines = vim.api.nvim_buf_get_lines(0, 0, lnum, false)
	for i = #lines, 1, -1 do
		local name = lines[i]:match("^func%s+(Test%a[%w_]*)%s*%(")
		if name then
			return name
		end
	end
end

local function all_go_test_names_in_buffer()
	local names = {}
	for _, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
		local name = line:match("^func%s+(Test%a[%w_]*)%s*%(")
		if name then
			names[#names + 1] = name
		end
	end
	return names
end

-- `go test` package argument for the current buffer's directory. Absolute,
-- since relativizing against cwd is ambiguous when cwd is already the
-- package dir (fnamemodify(":.") then returns the path unchanged, and
-- prepending "./" double-joins it with the tmux pane's cwd). vim.system
-- takes an argv list, so this doesn't need shell-escaping.
local function go_pkg_pattern()
	return vim.fn.expand("%:p:h")
end

-- Extracts "file.go:line: message" out of a failing test's -json output
-- lines (go always prefixes t.Error/t.Fatal output this way).
local function parse_failure_location(output_lines)
	for _, line in ipairs(output_lines or {}) do
		local file, lnum, msg = line:match("^%s*([%w_%-%.]+%.go):(%d+):%s*(.-)%s*$")
		if file then
			return file, tonumber(lnum), msg
		end
	end
end

-- Runs in the background; nvim stays interactive while it's in flight. Shows
-- a pass/fail/skip count notification, and populates the quickfix list with
-- one entry per failing test (jumping to an entry goes straight to the
-- t.Error/t.Fatal call site).
local function go_test(run_pattern)
	if vim.bo.filetype ~= "go" then
		vim.notify("Not a Go file", vim.log.levels.WARN)
		return
	end
	local dir = go_pkg_pattern()
	local pkgname = vim.fn.fnamemodify(dir, ":t")
	local cmd = { "go", "test", "-json", "-v", dir }
	if run_pattern then
		table.insert(cmd, "-run")
		table.insert(cmd, "^(" .. run_pattern .. ")$")
	end
	vim.system(cmd, { text = true }, function(obj)
		vim.schedule(function()
			local passed, failed, skipped = 0, 0, 0
			local test_output = {}
			local qf = {}
			for _, line in ipairs(vim.split(obj.stdout or "", "\n")) do
				if line ~= "" then
					local ok, event = pcall(vim.json.decode, line)
					if ok and type(event) == "table" and event.Test then
						if event.Action == "output" then
							test_output[event.Test] = test_output[event.Test] or {}
							table.insert(test_output[event.Test], event.Output)
						elseif event.Action == "pass" then
							passed = passed + 1
						elseif event.Action == "skip" then
							skipped = skipped + 1
						elseif event.Action == "fail" then
							failed = failed + 1
							local file, lnum, msg = parse_failure_location(test_output[event.Test])
							qf[#qf + 1] = {
								filename = dir .. "/" .. (file or ""),
								lnum = lnum or 1,
								text = ("%s/%s:%d %s"):format(pkgname, file or "?", lnum or 0, msg or event.Test),
							}
						end
					end
				end
			end

			vim.notify(
				("go test: %d passed, %d failed, %d skipped"):format(passed, failed, skipped),
				failed > 0 and vim.log.levels.ERROR or vim.log.levels.INFO
			)

			if #qf > 0 then
				vim.fn.setqflist(qf, " ")
				vim.fn.setqflist({}, "a", {
					title = "go test failures",
					quickfixtextfunc = function(info)
						local items = vim.fn.getqflist({ id = info.id, items = 0 }).items
						local lines = {}
						for i = info.start_idx, info.end_idx do
							lines[#lines + 1] = items[i].text
						end
						return lines
					end,
				})
				vim.cmd.copen()
			elseif vim.fn.getqflist({ title = 0 }).title == "go test failures" then
				-- Only touch the quickfix list if it's ours -- leave an unrelated
				-- list (e.g. from a grep) open.
				vim.fn.setqflist({}, "r")
				vim.cmd("cclose")
			end
		end)
	end)
end

test_map("s", function()
	local name = nearest_go_test_name()
	if not name then
		vim.notify("No enclosing test function found", vim.log.levels.WARN)
		return
	end
	go_test(name)
end, "Run nearest test")

test_map("f", function()
	local names = all_go_test_names_in_buffer()
	if #names == 0 then
		vim.notify("No test functions found in file", vim.log.levels.WARN)
		return
	end
	go_test(table.concat(names, "|"))
end, "Run tests in file")

test_map("p", function()
	go_test()
end, "Run tests in package")

-- <leader>tc (toggle coverage overlay) is defined in the nvim-coverage plugin
-- spec's `keys` table below, so pressing it also lazy-loads the plugin.
local coverage_visible = false

-- Snacks picker listing per-file %ages from the coverage report that
-- coverage.load() just parsed. The preview loads the real buffer (rather
-- than a scratch copy) so the Coverage*Line highlights show up in it too.
local function show_coverage_picker()
	local report = require("coverage.report").get()
	if not report then
		return
	end
	local go_mod = require("plenary.path"):new(vim.fn.expand("%:p")):find_upwards("go.mod")
	local mod_root = go_mod and go_mod:parent():absolute() or vim.fn.getcwd()

	local items = {}
	for fname, cov in pairs(report.files) do
		items[#items + 1] = {
			text = fname,
			file = mod_root .. "/" .. fname,
			percent = cov.summary.percent_covered,
		}
	end
	table.sort(items, function(a, b)
		return a.percent < b.percent
	end)

	Snacks.picker.pick({
		source = "go_coverage",
		title = "Go coverage",
		items = items,
		format = function(item)
			local hl = item.percent >= 80 and "DiagnosticOk"
				or (item.percent >= 50 and "DiagnosticWarn" or "DiagnosticError")
			return {
				{ ("%5.1f%%  "):format(item.percent), hl },
				{ item.text },
			}
		end,
		preview = function(ctx)
			local bufnr = vim.fn.bufadd(ctx.item.file)
			vim.fn.bufload(bufnr)
			ctx.item.buf = bufnr
			Snacks.picker.preview.file(ctx)
		end,
		confirm = function(picker, item)
			picker:close()
			vim.cmd.edit(vim.fn.fnameescape(item.file))
		end,
	})
end

-- ii / ai as treesitter text objects: innermost named node and its parent
local function select_ts_node(node)
	if not node then
		return
	end
	local srow, scol, erow, ecol = node:range()
	if ecol == 0 then
		erow = erow - 1
		ecol = math.max(0, vim.fn.col({ erow + 1, "$" }) - 2)
	else
		ecol = ecol - 1
	end
	vim.api.nvim_buf_set_mark(0, "<", srow + 1, scol, {})
	vim.api.nvim_buf_set_mark(0, ">", erow + 1, ecol, {})
	vim.cmd("normal! `<v`>")
end
vim.keymap.set({ "x", "o" }, "ii", function()
	select_ts_node(vim.treesitter.get_node())
end, { desc = "Innermost treesitter node" })
vim.keymap.set({ "x", "o" }, "ai", function()
	local node = vim.treesitter.get_node()
	select_ts_node(node and node:parent())
end, { desc = "Treesitter node parent" })

-- Suppress the :intro splash screen on startup
vim.opt.shortmess:append("I")

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99 -- open files fully unfolded; without this, everything starts collapsed

vim.o.winborder = "rounded" -- global default border for floats; per-plugin opts can still override
vim.opt.ruler = false -- hide row:col + % in the cmdline area

-- Reload buffers that changed on disk (e.g. edited outside nvim), and
-- autosave edits made inside nvim after a debounce -- keeps disk and buffer
-- in sync for the common case of switching between nvim and an external
-- editor/tool on the same file without them fighting over which version wins.
vim.opt.autoread = true

local autosave_group = vim.api.nvim_create_augroup("autosave_autoread", { clear = true })

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
	group = autosave_group,
	callback = function()
		if vim.bo.buftype == "" then
			vim.cmd("checktime")
		end
	end,
})

local autosave_timers = {}
local AUTOSAVE_DEBOUNCE_MS = 1500

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
	group = autosave_group,
	callback = function(args)
		local buf = args.buf
		if vim.bo[buf].buftype ~= "" or not vim.api.nvim_buf_get_name(buf):match("%S") then
			return
		end

		local timer = autosave_timers[buf]
		if not timer then
			timer = assert(vim.uv.new_timer())
			autosave_timers[buf] = timer
		end

		timer:stop()
		timer:start(AUTOSAVE_DEBOUNCE_MS, 0, function()
			vim.schedule(function()
				if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].modified then
					vim.api.nvim_buf_call(buf, function()
						vim.cmd("silent! write")
					end)
				end
			end)
		end)
	end,
})

vim.api.nvim_create_autocmd("BufDelete", {
	group = autosave_group,
	callback = function(args)
		local timer = autosave_timers[args.buf]
		if timer then
			timer:stop()
			timer:close()
			autosave_timers[args.buf] = nil
		end
	end,
})

require("lazy").setup({
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			preset = "modern",
			delay = 300,
			spec = {
				{ "<leader>c", group = "code" },
				{ "<leader>t", group = "test" },
				{ "<leader>f", group = "file" },
				{ "<leader>g", group = "git" },
			},
		},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {
			style = "night",
			transparent = true,
			styles = { sidebars = "transparent" },
			on_highlights = function(hl, c)
				hl.Comment = { fg = c.red, italic = true }
				local blend = require("tokyonight.util").blend
				-- Full-line tint for the nvim-coverage overlay (<leader>tc) -- the
				-- sign-column marker alone is too easy to miss.
				hl.CoverageCoveredLine = { bg = blend(c.green, 0.25, c.bg) }
				hl.CoverageUncoveredLine = { bg = blend(c.red, 0.45, c.bg) }
				hl.CoveragePartialLine = { bg = blend(c.yellow, 0.45, c.bg) }
			end,
		},
		config = function(_, opts)
			require("tokyonight").setup(opts)
			vim.cmd.colorscheme("tokyonight")
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		init = function()
			-- Snacks.toggle.* needs the Snacks global, which only exists after setup.
			-- Registering toggles on VeryLazy keeps them in one block as we add more.
			vim.api.nvim_create_autocmd("User", {
				pattern = "VeryLazy",
				callback = function()
					Snacks.toggle.diagnostics():map("<leader>tD")
				end,
			})
		end,
		opts = {
			picker = {
				layout = {
					layout = {
						box = "vertical",
						width = 0.95,
						height = 0.9,
						border = true,
						title = "{title} {live} {flags}",
						title_pos = "center",
						{ win = "input", height = 1, border = "bottom" },
						{ win = "preview", title = "{preview}", border = "bottom" },
						{ win = "list", height = 0.3, border = "none" },
					},
				},
			},
			input = {
				enabled = true,
				win = { row = 0.4 }, -- 0..1 = fraction of editor height (0.5 = dead center)
			},
			notifier = { enabled = true },
			indent = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			zen = {
				enabled = true,
				toggles = {
					dim = true,
					git_signs = false,
					mini_diff_signs = false,
					indent = false, -- hide indent guides inside zen
				},
				win = {
					width = 0, -- full width (default is 120)
					wo = {
						-- override the zen-style window opts; preserve the default winhighlight
						winhighlight = "NormalFloat:Normal",
						number = false,
						relativenumber = false,
					},
				},
			},
			scope = {
				enabled = true,
				keys = {
					textobject = {
						ii = false, -- replaced by treesitter-based innermost node below
						ai = false,
					},
				},
			},
		},
		keys = {
			{
				"<leader>ff",
				function()
					Snacks.picker.files()
				end,
				desc = "Find files",
			},
			{
				"<leader>f/",
				function()
					Snacks.picker.grep()
				end,
				desc = "Grep",
			},
			{
				"<leader>fw",
				function()
					Snacks.picker.grep_word()
				end,
				desc = "Grep word under cursor",
				mode = { "n", "x" },
			},
			{
				"<leader>bd",
				function()
					Snacks.bufdelete()
				end,
				desc = "Delete buffer (preserve layout)",
			},
			{ "<leader>bb", "<cmd>buffer #<cr>", desc = "Alternate buffer" },
			{
				"<leader>n",
				function()
					Snacks.notifier.show_history()
				end,
				desc = "Notification history",
			},
			{
				"<leader>fr",
				function()
					Snacks.rename.rename_file()
				end,
				desc = "Rename current file",
			},
			{
				"<leader>fa",
				function()
					local path = vim.api.nvim_buf_get_name(0)
					local dir = vim.fn.fnamemodify(path, ":h")
					local ext = vim.fn.fnamemodify(path, ":e")
					local stem = vim.fn.fnamemodify(path, ":t:r")
					if ext == "" or stem == "" then
						return
					end

					local is_test, alt_stems
					if stem:match("_test$") then
						is_test, alt_stems = true, { stem:gsub("_test$", "") }
					elseif stem:match("^test_") then
						is_test, alt_stems = true, { stem:gsub("^test_", "") }
					elseif stem:match("%.test$") then
						is_test, alt_stems = true, { stem:gsub("%.test$", "") }
					elseif stem:match("%.spec$") then
						is_test, alt_stems = true, { stem:gsub("%.spec$", "") }
					else
						is_test, alt_stems =
							false, { stem .. "_test", "test_" .. stem, stem .. ".test", stem .. ".spec" }
					end

					for _, alt_stem in ipairs(alt_stems) do
						local alt = dir .. "/" .. alt_stem .. "." .. ext
						if vim.fn.filereadable(alt) == 1 then
							vim.cmd.edit(vim.fn.fnameescape(alt))
							return
						end
					end
					-- No existing counterpart: only create one when going source -> test,
					-- using the first (most common) naming convention as a guess.
					if not is_test then
						vim.cmd.edit(vim.fn.fnameescape(dir .. "/" .. alt_stems[1] .. "." .. ext))
					end
				end,
				desc = "Toggle source <-> test file",
			},
			{
				"<leader>go",
				function()
					Snacks.gitbrowse.open({ what = "permalink" })
				end,
				desc = "Open on git forge (permalink)",
				mode = { "n", "x" },
			},
			{
				"<leader>z",
				function()
					Snacks.zen()
				end,
				desc = "Toggle zen mode",
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup()
			require("nvim-treesitter").install({
				"lua",
				"vim",
				"vimdoc",
				"query",
				"bash",
				"go",
				"rust",
				"python",
				"javascript",
				"typescript",
				"tsx",
				"json",
				"yaml",
				"toml",
				"markdown",
				"markdown_inline",
				"hcl",
				"dockerfile",
				"html",
				"css",
				"gitcommit",
				"diff",
				"regex",
			})
			vim.api.nvim_create_autocmd("FileType", {
				callback = function(args)
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {},
		keys = {
			{
				"<leader>gp",
				function()
					local gs = require("gitsigns")
					gs.preview_hunk()

					-- Let `u` undo the hunk while its preview popup is showing, on top of
					-- the normal `<leader>gu` binding below. Gitsigns tags the popup window
					-- with a `gitsigns_preview` win-var; find it to know when to clean up.
					local bufnr = vim.api.nvim_get_current_buf()
					local winid
					for _, w in ipairs(vim.api.nvim_list_wins()) do
						if vim.w[w].gitsigns_preview == "hunk" then
							winid = w
							break
						end
					end
					if not winid then
						return
					end

					local function cleanup()
						pcall(vim.keymap.del, "n", "u", { buffer = bufnr })
					end

					vim.keymap.set("n", "u", function()
						gs.reset_hunk()
						if vim.api.nvim_win_is_valid(winid) then
							vim.api.nvim_win_close(winid, true)
						end
						cleanup()
					end, { buffer = bufnr, desc = "Undo hunk under cursor" })

					-- Gitsigns closes the popup itself (on cursor move / insert) from
					-- inside its own CursorMoved autocmd. A WinClosed autocmd fired as a
					-- side effect of that doesn't run, since nested autocmd execution is
					-- off by default and gitsigns' internal handler isn't marked nested.
					-- Mirror its real close triggers directly instead of relying on
					-- WinClosed.
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI", "InsertEnter", "BufLeave" }, {
						buffer = bufnr,
						once = true,
						callback = cleanup,
					})
				end,
				desc = "Preview hunk diff under cursor",
			},
			{
				"<leader>gu",
				function()
					require("gitsigns").reset_hunk()
				end,
				desc = "Undo hunk under cursor",
			},
		},
	},
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup()
			vim.keymap.set("n", "S", "ysiw", { remap = true, desc = "Surround current word" })
		end,
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = {
			check_ts = true, -- use treesitter to avoid e.g. pairing quotes inside contractions/lifetimes
		},
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = { "MunifTanjim/nui.nvim" },
		opts = {
			cmdline = { view = "cmdline_popup" },
			messages = { enabled = false },
			popupmenu = { enabled = false },
			notify = { enabled = false },
			lsp = {
				progress = { enabled = false },
				hover = { enabled = false },
				signature = { enabled = false },
				message = { enabled = false },
			},
		},
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
			"folke/snacks.nvim",
		},
		cmd = "Neotree",
		keys = {
			{ "<leader>e", "<cmd>Neotree toggle reveal<cr>", desc = "Toggle file tree" },
		},
		opts = function(_, opts)
			opts.filesystem = opts.filesystem or {}
			opts.filesystem.use_libuv_file_watcher = true

			opts.window = opts.window or {}
			opts.window.width = 30 -- default (40) is wider than needed

			local function on_move(data)
				Snacks.rename.on_rename_file(data.source, data.destination)
			end
			local events = require("neo-tree.events")
			opts.event_handlers = opts.event_handlers or {}
			vim.list_extend(opts.event_handlers, {
				{ event = events.FILE_MOVED, handler = on_move },
				{ event = events.FILE_RENAMED, handler = on_move },
			})
		end,
	},
	{
		"mason-org/mason-lspconfig.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
			"saghen/blink.cmp",
		},
		config = function()
			vim.lsp.config("*", {
				capabilities = require("blink.cmp").get_lsp_capabilities(),
			})
			require("mason-lspconfig").setup({
				ensure_installed = {
					"gopls",
					"lua_ls",
					"terraformls",
					"rust_analyzer",
					"basedpyright",
					"ts_ls",
					"bashls",
					"jsonls",
					"yamlls",
				},
				automatic_enable = true,
			})
		end,
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "mason-org/mason.nvim" },
		event = "VeryLazy",
		opts = {
			ensure_installed = {
				"goimports",
				"stylua",
				"prettierd",
				"ruff",
				"shfmt",
				"shellcheck",
				"eslint_d",
				"golangci-lint",
			},
		},
		config = function(_, opts)
			local installer = require("mason-tool-installer")
			installer.setup(opts)
			-- The plugin's own auto-install hangs off a VimEnter autocmd created
			-- in its plugin/ file, which is already too late by VeryLazy, so
			-- ensure_installed silently never runs. Kick it off by hand.
			installer.check_install(false)
		end,
	},
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
				{ path = "snacks.nvim", words = { "Snacks" } },
			},
		},
	},
	{
		"saghen/blink.cmp",
		dependencies = { "rafamadriz/friendly-snippets" },
		version = "1.*",
		event = { "InsertEnter", "CmdlineEnter" },
		opts = {
			keymap = { preset = "default" },
			appearance = { nerd_font_variant = "mono" },
			completion = { documentation = { auto_show = true } },
			signature = {
				enabled = true,
				trigger = { enabled = false }, -- never auto-show; on-demand via <C-k>
				window = { max_width = 60 },
			},
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		cmd = { "ConformInfo" },
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				go = { "goimports", "gofmt" },
				python = { "ruff_format" },
				rust = { "rustfmt" },
				javascript = { "prettierd" },
				typescript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescriptreact = { "prettierd" },
				json = { "prettierd" },
				yaml = { "prettierd" },
				markdown = { "prettierd" },
				html = { "prettierd" },
				css = { "prettierd" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				terraform = { "terraform_fmt" },
			},
			format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
		},
	},
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			local lint = require("lint")
			-- Go is linted by run_golangci_lint (defined above, near <leader>cl)
			-- instead of nvim-lint's own runner, so failures show the real
			-- stderr message instead of a bare exit code.
			lint.linters_by_ft = {
				python = { "ruff" },
				javascript = { "eslint_d" },
				typescript = { "eslint_d" },
				sh = { "shellcheck" },
				bash = { "shellcheck" },
			}
			-- FileChangedShellPost fires after autoread silently reloads a buffer
			-- whose file changed on disk -- without it, lint diagnostics from
			-- before the reload linger until the next save/InsertLeave.
			vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave", "FileChangedShellPost" }, {
				callback = function()
					if vim.bo.filetype == "go" then
						run_golangci_lint()
					else
						lint.try_lint()
					end
				end,
			})
		end,
	},
	{
		"andythigpen/nvim-coverage",
		dependencies = { "nvim-lua/plenary.nvim" },
		cmd = {
			"Coverage",
			"CoverageLoad",
			"CoverageShow",
			"CoverageHide",
			"CoverageToggle",
			"CoverageSummary",
			"CoverageClear",
		},
		opts = {
			lang = {
				go = { coverage_file = go_coverage_file },
			},
		},
		config = function(_, opts)
			require("coverage").setup(opts)
			-- Drop the sign-column glyph entirely and rely only on the full-line
			-- background tint (sign_define merges rather than replaces, so this
			-- only overrides text/linehl, not texthl set by coverage.setup above).
			vim.fn.sign_define("coverage_covered", { text = "", linehl = "CoverageCoveredLine" })
			vim.fn.sign_define("coverage_uncovered", { text = "", linehl = "CoverageUncoveredLine" })
			vim.fn.sign_define("coverage_partial", { text = "", linehl = "CoveragePartialLine" })

			-- coverage.load() only places signs in buffers that already exist, so
			-- a file opened later (e.g. via the file tree) never gets them.
			-- Re-run it whenever a Go buffer loads while the overlay is toggled on.
			vim.api.nvim_create_autocmd("FileType", {
				pattern = "go",
				callback = function()
					if coverage_visible then
						require("coverage").load(true)
					end
				end,
			})
		end,
		keys = {
			{
				"<leader>tc",
				function()
					if vim.bo.filetype ~= "go" then
						vim.notify("Not a Go file", vim.log.levels.WARN)
						return
					end
					local coverage = require("coverage")
					if coverage_visible then
						coverage.hide()
						coverage_visible = false
						return
					end
					vim.system(
						{ "go", "test", "-coverprofile=" .. go_coverage_file, go_pkg_pattern() },
						{ text = true },
						function(obj)
							vim.schedule(function()
								if obj.code ~= 0 then
									vim.notify(
										"go test (coverage) failed:\n" .. (obj.stderr or ""),
										vim.log.levels.ERROR
									)
									return
								end
								coverage.load(true)
								coverage_visible = true
								show_coverage_picker()
							end)
						end
					)
				end,
				desc = "Toggle coverage overlay",
			},
		},
	},
	{
		"christoomey/vim-tmux-navigator",
		cmd = {
			"TmuxNavigateLeft",
			"TmuxNavigateDown",
			"TmuxNavigateUp",
			"TmuxNavigateRight",
			"TmuxNavigatePrevious",
			"TmuxNavigatorProcessList",
		},
		keys = {
			{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
			{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
			{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
			{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
			{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
		},
	},
})
