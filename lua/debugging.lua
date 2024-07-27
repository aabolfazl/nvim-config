dap = require("dap")
dapui = require("dapui")
dappyton = require('dap-python')
daprusttools = require('rust-tools')

dapui_configs = {
  icons = { expanded = "▾", collapsed = "▸" },
  mappings = {
    -- Use a table to apply multiple mappings
    expand = { "<CR>", "<2-LeftMouse>" },
    open = "o",
    remove = "d",
    edit = "e",
    repl = "r",
    toggle = "t",
  },
    layouts = {
    {
      elements = {
        'scopes',
        'breakpoints',
        'stacks',
        'watches',
      },
      size = 40,
      position = 'left',
    },
    {
      elements = {
        'repl',
        'console',
      },
      size = 10,
      position = 'bottom',
    },
  },
--  sidebar = {
--    -- You can change the order of elements in the sidebar
--    elements = {
--      -- Provide as ID strings or tables with "id" and "size" keys
--      {
--        id = "scopes",
--        size = 0.25, -- Can be float or integer > 1
--      },
--      { id = "breakpoints", size = 0.25 },
--      { id = "stacks", size = 0.25 },
--      { id = "watches", size = 00.25 },
--    },
--    size = 40,
--    position = "left", -- Can be "left", "right", "top", "bottom"
--  },
--  tray = {
--    elements = { "repl" },
--    size = 10,
--    position = "bottom", -- Can be "left", "right", "top", "bottom"
--  },
  floating = {
    max_height = nil, -- These can be integers or a float between 0 and 1.
    max_width = nil, -- Floats will be treated as percentage of your screen.
    border = "single", -- Border style. Can be "single", "double" or "rounded"
    mappings = {
      close = { "q", "<Esc>" },
    },
  },
  windows = { indent = 1 },
}

dapui.setup(dapui_config)
dappyton.setup('~/.virtualenvs/debugpy/bin/python')
daprusttools.setup({})

require('telescope').load_extension('dap')
require("telescope").load_extension("i23")
require('dap.ext.vscode').load_launchjs()
require("nvim-dap-virtual-text").setup()

dappyton.test_runner = 'pytest'


dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/lib/llvm-14/bin/lldb-vscode', 
  name = "lldb"
}
dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = true,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html

    runInTerminal = true,

    -- 💀
    -- If you use `runInTerminal = true` and resize the terminal window,
    -- lldb-vscode will receive a `SIGWINCH` signal which can cause problems
    -- To avoid that uncomment the following option
    -- See https://github.com/mfussenegger/nvim-dap/issues/236#issuecomment-1066306073
    postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
  },
  {
    name = "Compile and Launch",
    type = "lldb",
    request = "launch",
    program = '',
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = {},

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html

    runInTerminal = false,

    -- 💀
    -- If you use `runInTerminal = true` and resize the terminal window,
    -- lldb-vscode will receive a `SIGWINCH` signal which can cause problems
    -- To avoid that uncomment the following option
    -- See https://github.com/mfussenegger/nvim-dap/issues/236#issuecomment-1066306073
    postRunCommands = {'process handle -p true -s false -n false SIGWINCH'}
  },
  {
      -- If you get an "Operation not permitted" error using this, try disabling YAMA:
      --  echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
      name = "Attach to process",
      type = 'cpp',  -- Adjust this to match your adapter name (`dap.adapters.<name>`)
      request = 'attach',
      pid = require('dap.utils').pick_process,
      args = {},
    },
}



dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
--dap.listeners.before.event_terminated.dapui_config = function()
--  dapui.close()
--end
--dap.listeners.before.event_exited.dapui_config = function()
--  dapui.close()
--end
vim.keymap.set('n', '<leader>dt', dap.toggle_breakpoint, {})
vim.keymap.set('n', '<leader>dc', dap.continue, {})
vim.keymap.set('n', '<leader>de', dapui.eval, {})

vim.keymap.set('n', '<F5>', dap.continue , {})
vim.keymap.set('n', '<leader>dc', dapui.close , {})
vim.keymap.set('n', '<S-F5>', dap.terminate , {})
vim.keymap.set('n', '<F10>', dap.step_over , {})
vim.keymap.set('n', '<F11>', dap.step_into , {})
vim.keymap.set('n', '<F12>', dap.step_out , {})

vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function()
  require('dap.ui.widgets').hover()
end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function()
  require('dap.ui.widgets').preview()
end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

local function is_virtualenv_active()
  return vim.env.VIRTUAL_ENV ~= nil and vim.env.VIRTUAL_ENV ~= ""
end

function venv_bin_detection(tool)
    if is_virtualenv_active() then 
        return vim.env.VIRTUAL_ENV .. '/bin/python'
    else
        local cwd = vim.loop.cwd()
        if vim.fn.executable(cwd .. '/.venv/bin/' .. tool) == 1 then
            return cwd .. '/.venv/bin/' .. tool
        end
        return tool
    end
end

function venv_python_path()
    local cwd = vim.loop.cwd()
    local where = venv_bin_detection('python')
    if where == 'python' then
        -- local handle = io.popen("which python3")
        -- local result = handle:read("*a")
        -- handle:close()
        -- print(result)
        -- return result
        return '/usr/bin/python3'
    end
    return where
end


--    require('dap-python').resolve_python = function()
--        return venv_python_path()
--    end
dap.configurations.python = {
    {
        type = 'python';
        request = 'launch';
        name = "Launch file";
        program = "${file}";
--        pythonPath = venv_python_path()
    },
    {
        type = 'debugpy',
        request = 'launch',
        name = 'Django',
        program = '${workspaceFolder}/manage.py',
        args = {
            'runserver',
        },
        justMyCode = true,
        django = true,
        console = "integratedTerminal",
--        pythonPath = venv_python_path()
    },
    {
        type = 'python';
        request = 'attach';
        name = 'Attach remote';
        connect = function()
            return {
                host = 'localhost',
                port = 5678
            }
        end;
    },
    {
        type = 'python';
        request = 'launch';
        name = 'Launch file with arguments';
        program = '${file}';
        args = function()
            local args_string = vim.fn.input('Arguments: ')
            return vim.split(args_string, " +")
        end;
        console = "integratedTerminal",
--        pythonPath = venv_python_path()
    }
}


dap.listeners.on_config['debugpy'] = function(config)
    local final_config = vim.deepcopy(config)
  
    -- Placeholder expansion for launch directives
    local placeholders = {
      ["${file}"] = function(_)
        return vim.fn.expand("%:p")
      end,
      ["${fileBasename}"] = function(_)
        return vim.fn.expand("%:t")
      end,
      ["${fileBasenameNoExtension}"] = function(_)
        return vim.fn.fnamemodify(vim.fn.expand("%:t"), ":r")
      end,
      ["${fileDirname}"] = function(_)
        return vim.fn.expand("%:p:h")
      end,
      ["${fileExtname}"] = function(_)
        return vim.fn.expand("%:e")
      end,
      ["${relativeFile}"] = function(_)
        return vim.fn.expand("%:.")
      end,
      ["${relativeFileDirname}"] = function(_)
        return vim.fn.fnamemodify(vim.fn.expand("%:.:h"), ":r")
      end,
      ["${workspaceFolder}"] = function(_)
        return vim.fn.getcwd()
      end,
      ["${workspaceFolderBasename}"] = function(_)
        return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
      end,
      ["${env:([%w_]+)}"] = function(match)
        return os.getenv(match) or ""
      end,
    }
    local expand_vars = function(v)
      local patterns = {
          ["${([%w_]+)}"] = function(match)
              return final_config.env[match] or os.getenv(match) or ""
          end,
      }
      for p, fn in pairs(patterns) do 
          v = v:gsub(p, fn)
      end 

      return v 
    end 
    if final_config.envFile then
      local filePaths = final_config.envFile
      if type(filePaths) == "string" then
          filePaths = {filePaths}
      end
      for index,filePath in ipairs(filePaths) do
          for key, fn in pairs(placeholders) do
            filePath = filePath:gsub(key, fn)
          end
      
          for line in io.lines(filePath) do
            if not (string.match(line, "^[%s]*#") or string.match(line, "^[%s]*$")) then
                local words = {}
                for word in string.gmatch(line, "[^=]+") do
                  table.insert(words, word)
                end
                if not final_config.env then
                  final_config.env = {}
                end
                words[2] = expand_vars(words[2])
                --print(vim.inspect(words))
                final_config.env[words[1]] = words[2]
            end
          end
      end
    end
    return final_config
end



--dap.adapters.debugpy = {
--    type = 'executable',
--    command = venv_python_path(),
--    args = {'-m', 'debugpy.adapter'},
--    enrich_config = function(finalConfig, on_config)
--      local final_config = vim.deepcopy(finalConfig)
--    
--      -- Placeholder expansion for launch directives
--      local placeholders = {
--        ["${file}"] = function(_)
--          return vim.fn.expand("%:p")
--        end,
--        ["${fileBasename}"] = function(_)
--          return vim.fn.expand("%:t")
--        end,
--        ["${fileBasenameNoExtension}"] = function(_)
--          return vim.fn.fnamemodify(vim.fn.expand("%:t"), ":r")
--        end,
--        ["${fileDirname}"] = function(_)
--          return vim.fn.expand("%:p:h")
--        end,
--        ["${fileExtname}"] = function(_)
--          return vim.fn.expand("%:e")
--        end,
--        ["${relativeFile}"] = function(_)
--          return vim.fn.expand("%:.")
--        end,
--        ["${relativeFileDirname}"] = function(_)
--          return vim.fn.fnamemodify(vim.fn.expand("%:.:h"), ":r")
--        end,
--        ["${workspaceFolder}"] = function(_)
--          return vim.fn.getcwd()
--        end,
--        ["${workspaceFolderBasename}"] = function(_)
--          return vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
--        end,
--        ["${env:([%w_]+)}"] = function(match)
--          return os.getenv(match) or ""
--        end,
--      }
--      local expand_vars = function(v)
--        local patterns = {
--            ["${([%w_]+)}"] = function(match)
--                return final_config.env[match] or os.getenv(match) or ""
--            end,
--        }
--        for p, fn in pairs(patterns) do 
--            v = v:gsub(p, fn)
--        end 
--
--        return v 
--      end 
--      if final_config.envFile then
--        local filePaths = final_config.envFile
--        if type(filePaths) == "string" then
--            filePaths = {filePaths}
--        end
--        for index,filePath in ipairs(filePaths) do
--            for key, fn in pairs(placeholders) do
--              filePath = filePath:gsub(key, fn)
--            end
--        
--            for line in io.lines(filePath) do
--              if not (string.match(line, "^[%s]*#") or string.match(line, "^[%s]*$")) then
--                  local words = {}
--                  for word in string.gmatch(line, "[^=]+") do
--                    table.insert(words, word)
--                  end
--                  if not final_config.env then
--                    final_config.env = {}
--                  end
--                  words[2] = expand_vars(words[2])
--                  --print(vim.inspect(words))
--                  final_config.env[words[1]] = words[2]
--              end
--            end
--        end
--      end
--    
--      on_config(final_config)
--    end,
--}





--set_python_dap()
--vim.api.nvim_create_autocmd({"DirChanged", "BufEnter"}, {
--    callback = function() set_python_dap() end,
--})

