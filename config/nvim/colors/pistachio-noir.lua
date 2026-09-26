-- Pistachio Noir — Neovim colorscheme
-- Install: save as ~/.config/nvim/colors/pistachio-noir.lua
-- Enable:  vim.cmd("colorscheme pistachio-noir")   (or set colorscheme = "pistachio-noir" in lazy/packer opts)

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.o.background = "dark"
vim.o.termguicolors = true
vim.g.colors_name = "pistachio-noir"

local c = {
  bg          = "#15170F",
  bg_alt      = "#1D2016",
  overlay     = "#2A2F1F",
  overlay2    = "#39412A",
  muted       = "#626F51",
  subtext     = "#A3B08F",
  text        = "#E5E9D8",
  text_bright = "#F6F8EF",

  pistachio      = "#9FD88A",
  pistachio_deep = "#7BB864",
  terracotta     = "#DB8267",
  gold           = "#E0B15E",
  clay           = "#D9975A",
  teal           = "#7FC9A8",
  sage_blue      = "#7DA3B3",
  lavender       = "#AC8ED0",
}

local hl = vim.api.nvim_set_hl

-- Editor UI -----------------------------------------------------------------
hl(0, "Normal",         { fg = c.text, bg = c.bg })
hl(0, "NormalFloat",    { fg = c.text, bg = c.bg_alt })
hl(0, "FloatBorder",    { fg = c.overlay2, bg = c.bg_alt })
hl(0, "Cursor",         { fg = c.bg, bg = c.pistachio })
hl(0, "CursorLine",     { bg = c.bg_alt })
hl(0, "CursorLineNr",   { fg = c.pistachio, bold = true })
hl(0, "LineNr",         { fg = c.muted })
hl(0, "SignColumn",     { bg = c.bg })
hl(0, "ColorColumn",    { bg = c.overlay })
hl(0, "Visual",         { bg = c.overlay2 })
hl(0, "VisualNOS",      { bg = c.overlay2 })
hl(0, "Search",         { fg = c.bg, bg = c.gold })
hl(0, "IncSearch",      { fg = c.bg, bg = c.pistachio })
hl(0, "CurSearch",      { fg = c.bg, bg = c.pistachio })
hl(0, "Pmenu",          { fg = c.text, bg = c.bg_alt })
hl(0, "PmenuSel",       { fg = c.bg, bg = c.pistachio })
hl(0, "PmenuSbar",      { bg = c.overlay })
hl(0, "PmenuThumb",     { bg = c.muted })
hl(0, "StatusLine",     { fg = c.text, bg = c.bg_alt })
hl(0, "StatusLineNC",   { fg = c.muted, bg = c.bg_alt })
hl(0, "WinSeparator",   { fg = c.overlay })
hl(0, "VertSplit",      { fg = c.overlay })
hl(0, "TabLine",        { fg = c.muted, bg = c.bg_alt })
hl(0, "TabLineFill",    { bg = c.bg_alt })
hl(0, "TabLineSel",     { fg = c.pistachio, bg = c.bg })
hl(0, "Folded",         { fg = c.subtext, bg = c.bg_alt })
hl(0, "FoldColumn",     { fg = c.muted, bg = c.bg })
hl(0, "MatchParen",     { fg = c.gold, bold = true })
hl(0, "NonText",        { fg = c.overlay2 })
hl(0, "Whitespace",     { fg = c.overlay2 })
hl(0, "SpecialKey",     { fg = c.overlay2 })
hl(0, "EndOfBuffer",    { fg = c.bg })
hl(0, "Directory",      { fg = c.sage_blue })
hl(0, "Title",          { fg = c.pistachio, bold = true })
hl(0, "ErrorMsg",       { fg = c.terracotta, bold = true })
hl(0, "WarningMsg",     { fg = c.gold })
hl(0, "ModeMsg",        { fg = c.text })
hl(0, "MoreMsg",        { fg = c.pistachio })
hl(0, "Question",       { fg = c.pistachio })
hl(0, "WildMenu",       { fg = c.bg, bg = c.pistachio })

-- Syntax ----------------------------------------------------------------------
hl(0, "Comment",        { fg = c.muted, italic = true })
hl(0, "Constant",       { fg = c.clay })
hl(0, "String",         { fg = c.pistachio })
hl(0, "Character",      { fg = c.pistachio })
hl(0, "Number",         { fg = c.clay })
hl(0, "Boolean",        { fg = c.clay, bold = true })
hl(0, "Float",          { fg = c.clay })
hl(0, "Identifier",     { fg = c.text })
hl(0, "Function",       { fg = c.sage_blue, bold = true })
hl(0, "Statement",      { fg = c.lavender })
hl(0, "Conditional",    { fg = c.lavender })
hl(0, "Repeat",         { fg = c.lavender })
hl(0, "Label",          { fg = c.lavender })
hl(0, "Operator",       { fg = c.teal })
hl(0, "Keyword",        { fg = c.lavender, bold = true })
hl(0, "Exception",      { fg = c.terracotta })
hl(0, "PreProc",        { fg = c.teal })
hl(0, "Include",        { fg = c.lavender })
hl(0, "Define",         { fg = c.teal })
hl(0, "Macro",          { fg = c.teal })
hl(0, "PreCondit",      { fg = c.teal })
hl(0, "Type",           { fg = c.gold })
hl(0, "StorageClass",   { fg = c.gold })
hl(0, "Structure",      { fg = c.gold })
hl(0, "Typedef",        { fg = c.gold })
hl(0, "Special",        { fg = c.pistachio_deep })
hl(0, "SpecialChar",    { fg = c.pistachio_deep })
hl(0, "Tag",            { fg = c.lavender })
hl(0, "Delimiter",      { fg = c.subtext })
hl(0, "SpecialComment", { fg = c.muted, italic = true })
hl(0, "Debug",          { fg = c.terracotta })
hl(0, "Underlined",     { underline = true })
hl(0, "Ignore",         { fg = c.overlay2 })
hl(0, "Error",          { fg = c.terracotta, bold = true })
hl(0, "Todo",           { fg = c.bg, bg = c.gold, bold = true })

-- Treesitter --------------------------------------------------------------------
hl(0, "@variable",              { fg = c.text })
hl(0, "@variable.builtin",      { fg = c.terracotta, italic = true })
hl(0, "@variable.parameter",    { fg = c.subtext })
hl(0, "@variable.member",       { fg = c.text })
hl(0, "@constant",              { fg = c.clay })
hl(0, "@constant.builtin",      { fg = c.clay, bold = true })
hl(0, "@string",                { fg = c.pistachio })
hl(0, "@string.escape",         { fg = c.pistachio_deep, bold = true })
hl(0, "@number",                { fg = c.clay })
hl(0, "@boolean",                { fg = c.clay, bold = true })
hl(0, "@function",              { fg = c.sage_blue, bold = true })
hl(0, "@function.builtin",      { fg = c.sage_blue })
hl(0, "@function.call",         { fg = c.sage_blue })
hl(0, "@method",                { fg = c.sage_blue })
hl(0, "@method.call",           { fg = c.sage_blue })
hl(0, "@constructor",           { fg = c.gold })
hl(0, "@keyword",               { fg = c.lavender, bold = true })
hl(0, "@keyword.function",      { fg = c.lavender })
hl(0, "@keyword.return",        { fg = c.lavender, italic = true })
hl(0, "@keyword.operator",      { fg = c.teal })
hl(0, "@conditional",           { fg = c.lavender })
hl(0, "@repeat",                { fg = c.lavender })
hl(0, "@operator",              { fg = c.teal })
hl(0, "@type",                  { fg = c.gold })
hl(0, "@type.builtin",          { fg = c.gold, italic = true })
hl(0, "@property",              { fg = c.text })
hl(0, "@field",                 { fg = c.text })
hl(0, "@tag",                   { fg = c.lavender })
hl(0, "@tag.attribute",         { fg = c.gold })
hl(0, "@tag.delimiter",         { fg = c.subtext })
hl(0, "@punctuation.bracket",   { fg = c.subtext })
hl(0, "@punctuation.delimiter", { fg = c.subtext })
hl(0, "@punctuation.special",   { fg = c.teal })
hl(0, "@comment",               { fg = c.muted, italic = true })
hl(0, "@comment.todo",          { fg = c.bg, bg = c.gold, bold = true })
hl(0, "@comment.error",         { fg = c.bg, bg = c.terracotta, bold = true })
hl(0, "@comment.warning",       { fg = c.bg, bg = c.gold, bold = true })
hl(0, "@comment.note",          { fg = c.bg, bg = c.sage_blue, bold = true })
hl(0, "@markup.heading",        { fg = c.pistachio, bold = true })
hl(0, "@markup.strong",         { bold = true })
hl(0, "@markup.italic",         { italic = true })
hl(0, "@markup.link",           { fg = c.sage_blue, underline = true })
hl(0, "@markup.link.url",       { fg = c.teal, underline = true })
hl(0, "@markup.list",           { fg = c.lavender })
hl(0, "@markup.raw",            { fg = c.pistachio_deep })

-- LSP diagnostics -----------------------------------------------------------------
hl(0, "DiagnosticError",            { fg = c.terracotta })
hl(0, "DiagnosticWarn",             { fg = c.gold })
hl(0, "DiagnosticInfo",             { fg = c.sage_blue })
hl(0, "DiagnosticHint",             { fg = c.teal })
hl(0, "DiagnosticOk",               { fg = c.pistachio })
hl(0, "DiagnosticUnderlineError",   { undercurl = true, sp = c.terracotta })
hl(0, "DiagnosticUnderlineWarn",    { undercurl = true, sp = c.gold })
hl(0, "DiagnosticUnderlineInfo",    { undercurl = true, sp = c.sage_blue })
hl(0, "DiagnosticUnderlineHint",    { undercurl = true, sp = c.teal })
hl(0, "DiagnosticVirtualTextError", { fg = c.terracotta, bg = c.bg_alt })
hl(0, "DiagnosticVirtualTextWarn",  { fg = c.gold, bg = c.bg_alt })
hl(0, "DiagnosticVirtualTextInfo",  { fg = c.sage_blue, bg = c.bg_alt })
hl(0, "DiagnosticVirtualTextHint",  { fg = c.teal, bg = c.bg_alt })
hl(0, "LspReferenceText",           { bg = c.overlay })
hl(0, "LspReferenceRead",           { bg = c.overlay })
hl(0, "LspReferenceWrite",          { bg = c.overlay2 })

-- Diff / git ------------------------------------------------------------------------
hl(0, "DiffAdd",        { fg = c.pistachio, bg = c.bg_alt })
hl(0, "DiffChange",     { fg = c.gold, bg = c.bg_alt })
hl(0, "DiffDelete",     { fg = c.terracotta, bg = c.bg_alt })
hl(0, "DiffText",       { fg = c.text_bright, bg = c.overlay2 })
hl(0, "GitSignsAdd",    { fg = c.pistachio })
hl(0, "GitSignsChange", { fg = c.gold })
hl(0, "GitSignsDelete", { fg = c.terracotta })

-- A few common plugins ------------------------------------------------------------------
hl(0, "TelescopeBorder",          { fg = c.overlay2, bg = c.bg_alt })
hl(0, "TelescopeNormal",          { fg = c.text, bg = c.bg_alt })
hl(0, "TelescopeSelection",       { bg = c.overlay, fg = c.pistachio })
hl(0, "TelescopeMatching",        { fg = c.gold, bold = true })
hl(0, "TelescopePromptTitle",     { fg = c.bg, bg = c.pistachio, bold = true })
hl(0, "CmpItemAbbrMatch",         { fg = c.pistachio, bold = true })
hl(0, "CmpItemKindFunction",      { fg = c.sage_blue })
hl(0, "CmpItemKindVariable",      { fg = c.text })
hl(0, "CmpItemKindKeyword",       { fg = c.lavender })
hl(0, "NvimTreeNormal",           { fg = c.text, bg = c.bg })
hl(0, "NvimTreeFolderIcon",       { fg = c.pistachio_deep })
hl(0, "NvimTreeOpenedFolderName", { fg = c.pistachio, bold = true })
hl(0, "NvimTreeIndentMarker",     { fg = c.overlay2 })
hl(0, "WhichKey",                 { fg = c.pistachio, bold = true })
hl(0, "WhichKeyGroup",            { fg = c.lavender })
hl(0, "WhichKeyDesc",             { fg = c.text })

-- :terminal ANSI colors — same mapping as foot/kitty for the rest of the rice
vim.g.terminal_color_0  = c.bg_alt
vim.g.terminal_color_1  = c.terracotta
vim.g.terminal_color_2  = c.pistachio
vim.g.terminal_color_3  = c.gold
vim.g.terminal_color_4  = c.sage_blue
vim.g.terminal_color_5  = c.lavender
vim.g.terminal_color_6  = c.teal
vim.g.terminal_color_7  = c.text
vim.g.terminal_color_8  = c.muted
vim.g.terminal_color_9  = c.terracotta
vim.g.terminal_color_10 = c.pistachio
vim.g.terminal_color_11 = c.gold
vim.g.terminal_color_12 = c.sage_blue
vim.g.terminal_color_13 = c.lavender
vim.g.terminal_color_14 = c.teal
vim.g.terminal_color_15 = c.text_bright
