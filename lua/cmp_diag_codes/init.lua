local source = {}

local defaults = {
  in_comment = true,
}

-- the options are being passed via cmp.setup.sources, e.g.
-- require('cmp').setup { sources = { { name = 'diag-codes', opts = {...} } } }
local function init_options(params)
  params.option = vim.tbl_deep_extend("keep", params.option, defaults)
  vim.validate({
    in_comment = { params.option.in_comment, "boolean" },
  })
end

function source:is_available()
  local diags = vim.diagnostic.get(0)
  return #diags > 0
end

function source:complete(params, callback)
  init_options(params)
  if params.option.in_comment then
    local context = require("cmp.config.context")
    local in_comment = context.in_syntax_group("@comment") or context.in_syntax_group("Comment")
    if not in_comment then
      callback({})
      return
    end
  end
  local diags = {}
  local hash = {}
  for _, value in ipairs(vim.diagnostic.get(0)) do
    if not hash[value.code] then
      table.insert(diags, { label = value.code })
      hash[value.code] = 1
    end
  end
  callback(diags)
end

function source:resolve(completion_item, callback)
  callback(completion_item)
end

function source:execute(completion_item, callback)
  callback(completion_item)
end

return source
