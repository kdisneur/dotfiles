-- Lookup snip_env to discover usable constructors https://github.com/L3MON4D3/LuaSnip/blob/e8932ee0dcf283aa2ff84e6f0c4fe8cea3cf0356/lua/luasnip/config.lua#L122-L147

local recursive_typedef
recursive_typedef = function()
  return sn(
    nil,
    c(1, {
      -- Order is important, sn(...) first would cause infinite loop of expansion.
      t(""),
      sn(nil, {t({'', '\t'}), i(1, 'Bar'), t(' '), i(2, 'string'), d(3, recursive_typedef, {}) }),
    })
  )
end

local type_struct = s({ trig = 'types', name = 'Go structure', dscr = 'Create a Go structure', }, {
   t('type '), i(1, 'Foo'), t(' struct {'), d(2, recursive_typedef, {}), t({'',
    '}', ''})
})

return {type_struct}, {}
