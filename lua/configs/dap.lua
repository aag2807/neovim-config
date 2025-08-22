local dap = require('dap')

-- Node.js debugging
dap.adapters.node2 = {
  type = 'executable',
  command = 'node',
  args = {vim.fn.stdpath("data") .. '/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js'},
}

-- JavaScript/TypeScript configurations
dap.configurations.javascript = {
  {
    name = 'Launch Node.js',
    type = 'node2',
    request = 'launch',
    program = '${file}',
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Attach to Node.js',
    type = 'node2',
    request = 'attach',
    processId = require'dap.utils'.pick_process,
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**/*.js'},
  },
  {
    name = 'Launch Node.js with npm start',
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = {'run', 'start'},
    runtimeExecutable = 'npm',
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Debug Jest Tests',
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = {'--inspect-brk', '${workspaceFolder}/node_modules/.bin/jest', '--runInBand'},
    runtimeExecutable = 'node',
    sourceMaps = true,
    protocol = 'inspector',
    skipFiles = {'<node_internals>/**', 'node_modules/**'},
    console = 'integratedTerminal',
    internalConsoleOptions = 'neverOpen',
    port = 9229,
  },
  {
    name = 'Debug Vitest',
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    program = '${workspaceFolder}/node_modules/vitest/vitest.mjs',
    args = {'--inspect-brk', '--no-coverage', '${relativeFile}'},
    autoAttachChildProcesses = true,
    smartStep = true,
    console = 'integratedTerminal',
    skipFiles = {'<node_internals>/**', 'node_modules/**'},
  },
  {
    name = 'Debug React App (CRA)',
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = {'start'},
    runtimeExecutable = 'npm',
    env = {
      BROWSER = 'none',
      REACT_DEBUGGER = 'true'
    },
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
  {
    name = 'Debug Next.js',
    type = 'node2',
    request = 'launch',
    cwd = vim.fn.getcwd(),
    runtimeArgs = {'run', 'dev'},
    runtimeExecutable = 'npm',
    env = {
      NODE_OPTIONS = '--inspect'
    },
    sourceMaps = true,
    protocol = 'inspector',
    console = 'integratedTerminal',
  },
}

-- TypeScript uses same configs as JavaScript
dap.configurations.typescript = dap.configurations.javascript
dap.configurations.typescriptreact = dap.configurations.javascript
dap.configurations.javascriptreact = dap.configurations.javascript

-- Python debugging
dap.adapters.python = function(cb, config)
  if config.request == 'attach' then
    local port = (config.connect or config).port
    local host = (config.connect or config).host or '127.0.0.1'
    cb({
      type = 'server',
      port = assert(port, '`connect.port` is required for a python `attach` configuration'),
      host = host,
      options = {
        source_filetype = 'python',
      },
    })
  else
    cb({
      type = 'executable',
      command = vim.fn.stdpath("data") .. '/mason/packages/debugpy/venv/Scripts/python.exe',
      args = { '-m', 'debugpy.adapter' },
      options = {
        source_filetype = 'python',
      },
    })
  end
end

dap.configurations.python = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      local venv_paths = {
        cwd .. "/env/Scripts/python.exe", -- Windows
        cwd .. "/env/bin/python",         -- Linux/Mac
        cwd .. "/.venv/Scripts/python.exe", -- Windows
        cwd .. "/.venv/bin/python",       -- Linux/Mac
        cwd .. "/venv/Scripts/python.exe", -- Windows
        cwd .. "/venv/bin/python",        -- Linux/Mac
      }
      
      for _, path in ipairs(venv_paths) do
        if vim.fn.executable(path) == 1 then
          return path
        end
      end
      
      return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
    end,
  },
  {
    type = 'python',
    request = 'attach',
    name = 'Attach remote',
    connect = function()
      local host = vim.fn.input('Host [127.0.0.1]: ')
      host = host ~= '' and host or '127.0.0.1'
      local port = tonumber(vim.fn.input('Port [5678]: ')) or 5678
      return { host = host, port = port }
    end,
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Launch Django',
    program = vim.fn.getcwd() .. '/manage.py',
    args = {'runserver'},
    django = true,
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Launch FastAPI',
    program = vim.fn.getcwd() .. '/main.py',
    console = 'integratedTerminal',
  },
  {
    type = 'python',
    request = 'launch',
    name = 'Debug pytest',
    module = 'pytest',
    args = {'${file}'},
  },
}

-- Key mappings for DAP
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<Leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<Leader>B', function() require('dap').set_breakpoint() end)
vim.keymap.set('n', '<Leader>lp', function() require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<Leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<Leader>dl', function() require('dap').run_last() end)
vim.keymap.set({'n', 'v'}, '<Leader>dh', function() require('dap.ui.widgets').hover() end)
vim.keymap.set({'n', 'v'}, '<Leader>dp', function() require('dap.ui.widgets').preview() end)
vim.keymap.set('n', '<Leader>df', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.frames)
end)
vim.keymap.set('n', '<Leader>ds', function()
  local widgets = require('dap.ui.widgets')
  widgets.centered_float(widgets.scopes)
end)

-- DAP UI keymaps
vim.keymap.set('n', '<Leader>du', function() require('dapui').toggle() end)
vim.keymap.set('n', '<Leader>de', function() require('dapui').eval() end)