-- Lookup snip_env to discover usable constructors https://github.com/L3MON4D3/LuaSnip/blob/e8932ee0dcf283aa2ff84e6f0c4fe8cea3cf0356/lua/luasnip/config.lua#L122-L147

local jira_link = s({ trig = 'jira', name = 'Jira link', dscr = 'Create a link', }, {
    t('['), i(1, 'jira-0000'), t('](https://jira.localhost/'), rep(1), t(') - '), i(0, 'title of the ticket')
})


return {jira_link}, {}
