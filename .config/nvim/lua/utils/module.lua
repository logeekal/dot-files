local M = {}
function M.requireIfExists(name)
  local out; if xpcall(
        function() out = require(name) end,
        function(e) out = e end)
  then
    return out -- success
  else
    return nil, out
  end -- error
end

return M
