local Util = {}

function Util.map (kind, lhs, rhs, opts)
  vim.api.nvim_set_keymap(kind, lhs, rhs, opts)
end

function Util.subtract_tables(t1, t2)
  local existence = {}
  for _,v in pairs(t1) do
    existence[v] = true;
  end

  local res = {}
  for _, v in pairs(t2) do
    if not existence[v] then
      res[#res+1] = v
    end
  end

  return res
end


return Util
