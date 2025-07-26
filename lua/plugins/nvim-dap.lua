return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
		"williamboman/mason.nvim",
	},
	config = function()
		local dap = require("dap")
		local ui = require("dapui")
		local present_dap_utils, dap_utils = pcall(require, "dap.utils")

		require("dapui").setup()
		require("nvim-dap-virtual-text").setup()

		require("mason").setup()

		for _, adapterType in ipairs({ "node", "chrome", "msedge" }) do
			local pwaType = "pwa-" .. adapterType

			dap.adapters[pwaType] = {
				type = "server",
				host = "localhost",
				port = "${port}",
				executable = {
					command = "node",
					args = {
						vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
						"${port}",
					},
				},
			}

			-- this allow us to handle launch.json configurations
			-- which specify type as "node" or "chrome" or "msedge"
			-- dap.adapters[adapterType] = function(cb, config)
			-- 	local nativeAdapter = dap.adapters[pwaType]
			--
			-- 	config.type = pwaType
			--
			-- 	if type(nativeAdapter) == "function" then
			-- 		nativeAdapter(cb, config)
			-- 	else
			-- 		cb(nativeAdapter)
			-- 	end
			-- end
		end

		local enter_launch_url = function()
			local co = coroutine.running()
			return coroutine.create(function()
				vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:" }, function(url)
					if url == nil or url == "" then
						return
					else
						coroutine.resume(co, url)
					end
				end)
			end)
		end

		for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
			dap.configurations[language] = {
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file using Node.js (nvim-dap)",
					program = "${file}",
					cwd = "${workspaceFolder}",
				},
				{
					type = "pwa-node",
					request = "attach",
					name = "Attach to process using Node.js (nvim-dap)",
					processId = require("dap.utils").pick_process,
					cwd = "${workspaceFolder}",
				},
				-- requires ts-node to be installed globally or locally
				{
					type = "pwa-node",
					request = "launch",
					name = "Launch file using Node.js with ts-node/register (nvim-dap)",
					program = "${file}",
					cwd = "${workspaceFolder}",
					runtimeArgs = { "-r", "ts-node/register" },
				},
				{
					type = "pwa-chrome",
					request = "launch",
					name = "Launch Chrome (nvim-dap)",
					url = enter_launch_url,
					webRoot = "${workspaceFolder}",
					sourceMaps = true,
				},
				{
					type = "pwa-msedge",
					request = "launch",
					name = "Launch Edge (nvim-dap)",
					url = enter_launch_url,
					webRoot = "${workspaceFolder}",
					sourceMaps = true,
				},
			}
		end

		-- local fileexts = {
		-- 	"javascript",
		-- 	"javascriptreact",
		-- 	"typescript",
		-- 	"typescriptreact",
		-- }
		-- for i, ext in ipairs(fileexts) do
		-- 	dap.configurations[ext] = {
		-- 		{
		-- 			type = "pwa-chrome",
		-- 			request = "launch",
		-- 			name = 'Launch Chrome with "localhost"',
		-- 			url = function()
		-- 				local co = coroutine.running()
		-- 				return coroutine.create(function()
		-- 					vim.ui.input({ prompt = "Enter URL: ", default = "http://localhost:3000" }, function(url)
		-- 						if url == nil or url == "" then
		-- 							return
		-- 						else
		-- 							coroutine.resume(co, url)
		-- 						end
		-- 					end)
		-- 				end)
		-- 			end,
		-- 			webRoot = "${workspaceFolder}",
		-- 			protocol = "inspector",
		-- 			sourceMaps = true,
		-- 			userDataDir = false,
		-- 			skipFiles = { "<node_internals>/**", "node_modules/**", "${workspaceFolder}/node_modules/**" },
		-- 			resolveSourceMapLocations = {
		-- 				"${webRoot}/*",
		-- 				"${webRoot}/apps/**/**",
		-- 				"${workspaceFolder}/apps/**/**",
		-- 				"${webRoot}/packages/**/**",
		-- 				"${workspaceFolder}/packages/**/**",
		-- 				"${workspaceFolder}/*",
		-- 				"!**/node_modules/**",
		-- 			},
		-- 		},
		-- 		{
		-- 			type = "pwa-node",
		-- 			request = "launch",
		-- 			name = "Launch JS file",
		-- 			program = "${file}",
		-- 			cwd = "${workspaceFolder}",
		-- 		},
		-- 		{
		-- 			name = "Next.js: debug server-side (pwa-node)",
		-- 			type = "pwa-node",
		-- 			request = "attach",
		-- 			port = 9231,
		-- 			skipFiles = { "<node_internals>/**", "node_modules/**" },
		-- 			cwd = "${workspaceFolder}",
		-- 		},
		-- 		{
		-- 			type = "pwa-node",
		-- 			request = "launch",
		-- 			name = "Launch Current File (pwa-node)",
		-- 			cwd = vim.fn.getcwd(),
		-- 			args = { "${file}" },
		-- 			sourceMaps = true,
		-- 			protocol = "inspector",
		-- 			runtimeExecutable = "pnpm",
		-- 			runtimeArgs = {
		-- 				"run-script",
		-- 				"dev",
		-- 			},
		-- 			resolveSourceMapLocations = {
		-- 				"${workspaceFolder}/**",
		-- 				"!**/node_modules/**",
		-- 			},
		-- 		},
		-- 		{
		-- 			type = "pwa-node",
		-- 			request = "launch",
		-- 			name = "Launch Current File (pwa-node with ts-node)",
		-- 			cwd = vim.fn.getcwd(),
		-- 			runtimeArgs = { "--loader", "ts-node/esm" },
		-- 			runtimeExecutable = "node",
		-- 			args = { "${file}" },
		-- 			sourceMaps = true,
		-- 			protocol = "inspector",
		-- 			skipFiles = { "<node_internals>/**", "node_modules/**" },
		-- 			resolveSourceMapLocations = {
		-- 				"${workspaceFolder}/**",
		-- 				"!**/node_modules/**",
		-- 			},
		-- 		},
		-- 		{
		-- 			type = "pwa-node",
		-- 			request = "launch",
		-- 			name = "Launch Test Current File (pwa-node with jest)",
		-- 			cwd = vim.fn.getcwd(),
		-- 			runtimeArgs = { "${workspaceFolder}/node_modules/.bin/jest" },
		-- 			runtimeExecutable = "node",
		-- 			args = { "${file}", "--coverage", "false" },
		-- 			rootPath = "${workspaceFolder}",
		-- 			sourceMaps = true,
		-- 			console = "integratedTerminal",
		-- 			internalConsoleOptions = "neverOpen",
		-- 			skipFiles = { "<node_internals>/**", "node_modules/**" },
		-- 		},
		-- 		{
		-- 			type = "pwa-node",
		-- 			request = "launch",
		-- 			name = "Launch Test Current File (pwa-node with vitest)",
		-- 			cwd = vim.fn.getcwd(),
		-- 			program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
		-- 			args = { "--inspect-brk", "--threads", "false", "run", "${file}" },
		-- 			autoAttachChildProcesses = true,
		-- 			smartStep = true,
		-- 			console = "integratedTerminal",
		-- 			skipFiles = { "<node_internals>/**", "node_modules/**" },
		-- 		},
		-- 		{
		-- 			type = "pwa-node",
		-- 			request = "launch",
		-- 			name = "Launch Test Current File (pwa-node with deno)",
		-- 			cwd = vim.fn.getcwd(),
		-- 			runtimeArgs = { "test", "--inspect-brk", "--allow-all", "${file}" },
		-- 			runtimeExecutable = "deno",
		-- 			attachSimplePort = 9229,
		-- 		},
		-- 		{
		-- 			type = "pwa-chrome",
		-- 			request = "attach",
		-- 			name = "Attach Program (pwa-chrome, select port)",
		-- 			program = "${file}",
		-- 			cwd = vim.fn.getcwd(),
		-- 			sourceMaps = true,
		-- 			protocol = "inspector",
		-- 			port = function()
		-- 				return vim.fn.input("Select port: ", 9222)
		-- 			end,
		-- 			webRoot = "${workspaceFolder}",
		-- 			skipFiles = { "<node_internals>/**", "node_modules/**", "${workspaceFolder}/node_modules/**" },
		-- 			resolveSourceMapLocations = {
		-- 				"${webRoot}/*",
		-- 				"${webRoot}/apps/**/**",
		-- 				"${workspaceFolder}/apps/**/**",
		-- 				"${webRoot}/packages/**/**",
		-- 				"${workspaceFolder}/packages/**/**",
		-- 				"${workspaceFolder}/*",
		-- 				"!**/node_modules/**",
		-- 			},
		-- 		},
		-- 		{
		-- 			type = "pwa-node",
		-- 			request = "attach",
		-- 			name = "Attach Program (pwa-node, select pid)",
		-- 			cwd = vim.fn.getcwd(),
		-- 			processId = dap_utils.pick_process,
		-- 			skipFiles = { "<node_internals>/**" },
		-- 		},
		-- 	}
		-- end

		-- [[THIS ONE WORKING WITH]]
		dap.adapters.codelldb = {
			type = "executable",
			command = "codelldb",
		}
		--
		dap.configurations.rust = {
			{
				name = "Launch Rust file",
				type = "codelldb",
				request = "launch",
				program = function()
					vim.fn.system("cargo build")
					return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
			},
		}

		-- dap.configurations.javascript = {
		-- 	{
		-- 		type = "pwa-node",
		-- 		request = "launch",
		-- 		name = "Launch JS file",
		-- 		program = "${file}",
		-- 		cwd = "${workspaceFolder}",
		-- 	},
		-- }
		-- [[END! THIS ONE WORKING WITH]]

		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dgb", dap.run_to_cursor, { desc = "Run to cursor" })
		vim.keymap.set("n", "<leader>d?", function()
			require("dapui").eval(nil, { enter = true })
		end, { desc = "Inspect the current value" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
		vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "Step into" })
		vim.keymap.set("n", "<leader>dso", dap.step_over, { desc = "Step over" })
		vim.keymap.set("n", "<leader>dsO", dap.step_out, { desc = "Step Out" })
		vim.keymap.set("n", "<leader>dsb", dap.step_back, { desc = "Step back" })
		vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart" })

		dap.listeners.before.attach.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			ui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			ui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			ui.close()
		end
	end,
}
