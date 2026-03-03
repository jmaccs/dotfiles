vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

vim.keymap.set("n", "<leader>ee", function()
	Snacks.explorer({
		layout = { position = "top-left" },
	})
end, { desc = "[E]xplor[e]r (CWD)" })

vim.keymap.set("n", "<leader>ec", function()
	Snacks.explorer({
		cwd = vim.fn.expand("%:p:h"),
		layout = { position = "top-left" },
	})
end, { desc = "[E]xplorer ([C]urrent file dir)" })

-- unset s for flash
-- vim.keymap.unset("n", "s")
-- zig
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*.zig", "*.zon" },
	callback = function()
		for _, client in ipairs(vim.lsp.get_active_clients({ bufnr = 0 })) do
			if client.supports_method("textDocument/codeAction") then
				vim.lsp.buf.code_action({
					apply = true,
					context = {
						only = {
							"source.fixAll",
							"source.organizeImports",
						},
					},
				})
				return
			end
		end
	end,
})

local wk = require("which-key")
local Snacks = require("snacks")
wk.add({
	-- top lvl groups
	{ "<leader>l", group = "[L]azy" },
	{ "<leader>s", group = "[S]earch" },
	{ "<leader>r", group = "[R]ename" },
	{ "<leader>c", group = "[C]ode" },
	{ "<leader>g", group = "[G]oto" },
	{ "<leader>d", group = "[D]ebug" },
	{ "<leader>w", group = "[W]orkspace" },
	{ "<leader>o", group = "[O]pen" },
	{ "<leader>e", group = "[E]xplorer" },
	{ "<leader>b", group = "[B]uild" },

	-- c++

	{ "<leader>bc", group = "[c]++" },
	{ "<leader>bcc", ":!clang++ -std=c++17 -Wall -Wextra -g % -o %:r<CR>", desc = "[c]ompile current file" },

	{ "<leader>bcm", ":!make<CR>", desc = "[m]ake" },
	{ "<leader>bcb", ":!cmake --build build<CR>", desc = "cMake [b]uild" },
	{ "<leader>bcl", ":!make clean<CR>", desc = "make c[L]ean" },
	{ "<leader>bcg", ":!bear -- make<CR>", desc = "[C]ompile database [G]enerate" },

	-- Code format
	{
		"<leader>cf",
		function()
			require("conform").format({ async = true, lsp_fallback = true })
		end,
		desc = "[C]ode [F]ormat",
	},
	-- [D]ebug group

	{
		"<leader>db",
		function()
			require("dap").toggle_breakpoint()
		end,
		desc = "[D]ebug [B]reakpoint",
	},
	{
		"<leader>dc",
		function()
			require("dap").continue()
		end,
		desc = "[D]ebug [C]ontinue",
	},
	{
		"<leader>di",
		function()
			require("dap").step_into()
		end,
		desc = "[D]ebug step [I]nto",
	},
	{
		"<leader>do",
		function()
			require("dap").step_over()
		end,
		desc = "[D]ebug step [O]ver",
	},
	{
		"<leader>dO",
		function()
			require("dap").step_out()
		end,
		desc = "[D]ebug step [O]ut",
	},
	{
		"<leader>dr",
		function()
			require("dap").repl.open()
		end,
		desc = "[D]ebug [R]EPL",
	},
	{
		"<leader>dl",
		function()
			require("dap").run_last()
		end,
		desc = "[D]ebug run [L]ast",
	},
	{
		"<leader>dt",
		function()
			require("dap").terminate()
		end,
		desc = "[D]ebug [T]erminate",
	},
	{
		"<leader>du",
		function()
			require("dapui").toggle()
		end,
		desc = "[D]ebug [U]I toggle",
	},

	{
		"<leader>lg",
		function()
			Snacks.lazygit()
		end,
		desc = "[L]azy[G]it",
	},
	{
		"<leader>ln",
		function()
			Snacks.notifier.show_history()
		end,
		desc = "[L]azy[N]otifications",
	},

	{
		"<c-/>",
		function()
			Snacks.terminal()
		end,
		desc = "Toggle Terminal",
		mode = { "n", "t" },
	},
	{
		"<c-_>",
		function()
			Snacks.terminal()
		end,
		desc = "which_key_ignore",
	},
	{
		"]]",
		function()
			Snacks.words.jump(vim.v.count1)
		end,
		desc = "Next Reference",
		mode = { "n", "t" },
	},
	{
		"[[",
		function()
			Snacks.words.jump(-vim.v.count1)
		end,
		desc = "Prev Reference",
		mode = { "n", "t" },
	},

	-- snacks key maps

	{
		"<leader>ss",
		function()
			Snacks.picker.smart()
		end,
		desc = "Smart Find Files",
	},
	{
		"<leader><space>",
		function()
			Snacks.picker.buffers()
		end,
		desc = "[ ] Find existing buffers",
	},
	{
		"<leader>sG",
		function()
			Snacks.picker.grep({ cwd = vim.fn.getcwd() })
		end,
		desc = "[S]earch by [g]rep (CWD)",
	},
	{
		"<leader>sg",
		function()
			Snacks.picker.grep({ cwd = vim.fn.expand("%:p:h") })
		end,
		desc = "[S]earch by [G]rep (buffer directory)",
	},
	{
		"<leader>sn",
		function()
			Snacks.picker.files({ cwd = vim.fn.stdpath("config") })
		end,
		desc = "[S]earch [N]eovim files",
	},
	{
		"<leader>sf",
		function()
			Snacks.picker.files()
		end,
		desc = "[S]earch [F]iles",
	},
	{
		"<leader>sp",
		function()
			Snacks.picker.pickers()
		end,
		desc = "[S]earch [P]ickers",
	},
	{
		"<leader>s.",
		function()
			Snacks.picker.recent()
		end,
		desc = "[S]earch Recent Files ('.' for repeat)",
	},
	{
		"<leader>sk",
		function()
			Snacks.picker.keymaps()
		end,
		desc = "[S]earch [K]eymaps",
	},
	{
		"<leader>sw",
		function()
			Snacks.picker.grep_word()
		end,
		desc = "[S]earch current [W]ord",
		mode = { "n", "x" },
	},
	{
		"<leader>sr",
		function()
			Snacks.picker.resume()
		end,
		desc = "[S]earch [R]esume",
	},
	{
		"<leader>sh",
		function()
			Snacks.picker.help()
		end,
		desc = "[S]earch [H]elp",
	},
	{
		"<leader>sd",
		function()
			Snacks.picker.diagnostics()
		end,
		desc = "[S]earch [D]iagnostics",
	},
	{
		"<leader>sD",
		function()
			Snacks.picker.diagnostics_buffer()
		end,
		desc = "Buffer Diagnostics",
	},
	{
		"<leader>s/",
		function()
			Snacks.picker.grep_buffers()
		end,
		desc = "[S]earch [/] in Open Files",
	},
	{
		"<leader>/",
		function()
			Snacks.picker.lines({
				-- use the Select layout
				layout = {
					preset = "select", -- ⟵ preset defined in docs :contentReference[oaicite:0]{index=0}
				},
			})
		end,
		desc = "[/] Fuzzily search in current buffer",
	},
})
