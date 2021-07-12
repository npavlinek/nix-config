local helper = {}

local function map(mode, bind, action)
  vim.api.nvim_set_keymap(mode, bind, action, {silent = true, noremap = true})
end

function helper.imap(bind, action)
  map('i', bind, action)
end

function helper.nmap(bind, action)
  map('n', bind, action)
end

return helper
