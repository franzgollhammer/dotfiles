local M = {}

function M.setup(p, opts)
  local transparent = opts.transparent
  local styles = opts.styles or {}
  local comment_style = styles.comments or {}
  local keyword_style = styles.keywords or {}
  local function_style = styles.functions or {}
  local variable_style = styles.variables or {}

  local bg = transparent and p.none or p.bg
  local bg_float = transparent and p.none or p.bg_float
  local bg_sidebar = transparent and p.none or p.bg_float

  local hl = {}

  -- editor
  hl.Normal = { fg = p.fg, bg = bg }
  hl.NormalFloat = { fg = p.fg, bg = bg_float }
  hl.NormalNC = { fg = p.fg, bg = bg }
  hl.SignColumn = { fg = p.fg_dim, bg = bg }
  hl.LineNr = { fg = p.fg_dim }
  hl.CursorLineNr = { fg = p.fg, bold = true }
  hl.CursorLine = { bg = transparent and p.none or p.bg_float }
  hl.CursorColumn = { link = "CursorLine" }
  hl.ColorColumn = { bg = transparent and p.none or p.bg_float }
  hl.Cursor = { fg = p.bg, bg = p.cursor }
  hl.lCursor = { link = "Cursor" }
  hl.CursorIM = { link = "Cursor" }
  hl.TermCursor = { link = "Cursor" }
  hl.TermCursorNC = { fg = p.bg, bg = p.fg_dim }
  hl.Visual = { bg = p.bg_visual }
  hl.VisualNOS = { link = "Visual" }
  hl.Search = { bg = p.bg_search, fg = p.fg }
  hl.IncSearch = { bg = p.accent, fg = p.bg }
  hl.CurSearch = { link = "IncSearch" }
  hl.Substitute = { bg = p.keyword, fg = p.bg }
  hl.Folded = { fg = p.fg_dim, bg = transparent and p.none or p.bg_float }
  hl.FoldColumn = { fg = p.fg_dim, bg = bg }
  hl.MatchParen = { bg = p.bg_visual, bold = true }
  hl.Pmenu = { fg = p.fg, bg = transparent and p.none or p.bg_popup }
  hl.PmenuSel = { bg = p.bg_visual }
  hl.PmenuSbar = { bg = transparent and p.none or p.bg_popup }
  hl.PmenuThumb = { bg = p.fg_dim }
  hl.WildMenu = { link = "PmenuSel" }
  hl.StatusLine = { fg = p.fg, bg = bg_sidebar }
  hl.StatusLineNC = { fg = p.fg_dim, bg = bg_sidebar }
  hl.TabLine = { fg = p.fg_dim, bg = bg_sidebar }
  hl.TabLineFill = { bg = bg_sidebar }
  hl.TabLineSel = { fg = p.fg, bg = bg }
  hl.WinSeparator = { fg = p.border, bg = bg }
  hl.VertSplit = { link = "WinSeparator" }
  hl.FloatBorder = { fg = p.border, bg = bg_float }
  hl.FloatTitle = { fg = p.accent, bg = bg_float, bold = true }
  hl.Title = { fg = p.accent, bold = true }
  hl.NonText = { fg = p.fg_dark }
  hl.SpecialKey = { fg = p.fg_dark }
  hl.Whitespace = { fg = p.fg_dark }
  hl.EndOfBuffer = { fg = transparent and p.fg_dark or p.bg }
  hl.Conceal = { fg = p.fg_dim }
  hl.SpellBad = { undercurl = true, sp = p.error }
  hl.SpellCap = { undercurl = true, sp = p.warning }
  hl.SpellLocal = { undercurl = true, sp = p.info }
  hl.SpellRare = { undercurl = true, sp = p.hint }
  hl.MsgArea = { fg = p.fg }
  hl.ErrorMsg = { fg = p.error }
  hl.WarningMsg = { fg = p.warning }
  hl.MoreMsg = { fg = p.accent }
  hl.ModeMsg = { fg = p.fg, bold = true }
  hl.Question = { fg = p.accent }
  hl.Directory = { fg = p.accent }
  hl.QuickFixLine = { bg = p.bg_visual }
  hl.DiffAdd = { bg = p.diff_add }
  hl.DiffChange = { bg = p.diff_change }
  hl.DiffDelete = { bg = p.diff_delete }
  hl.DiffText = { bg = p.diff_text }
  hl.WinBar = { fg = p.fg, bg = bg }
  hl.WinBarNC = { fg = p.fg_dim, bg = bg }

  -- syntax (vim builtin groups)
  hl.Comment = vim.tbl_extend("force", { fg = p.comment }, comment_style)
  hl.Constant = { fg = p.constant }
  hl.String = { fg = p.string }
  hl.Character = { fg = p.string }
  hl.Number = { fg = p.constant }
  hl.Boolean = { fg = p.constant }
  hl.Float = { fg = p.constant }
  hl.Identifier = vim.tbl_extend("force", { fg = p.variable }, variable_style)
  hl.Function = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl.Statement = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl.Conditional = { link = "Statement" }
  hl.Repeat = { link = "Statement" }
  hl.Label = { fg = p.accent }
  hl.Operator = { fg = p.operator }
  hl.Keyword = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl.Exception = { fg = p.keyword }
  hl.PreProc = { fg = p.keyword }
  hl.Include = { fg = p.keyword }
  hl.Define = { fg = p.keyword }
  hl.Macro = { fg = p.keyword }
  hl.PreCondit = { fg = p.keyword }
  hl.Type = { fg = p.type }
  hl.StorageClass = { fg = p.keyword }
  hl.Structure = { fg = p.type }
  hl.Typedef = { fg = p.type }
  hl.Special = { fg = p.special }
  hl.SpecialChar = { fg = p.special }
  hl.Tag = { fg = p.tag }
  hl.Delimiter = { fg = p.punctuation }
  hl.SpecialComment = { fg = p.comment, bold = true }
  hl.Debug = { fg = p.warning }
  hl.Underlined = { underline = true }
  hl.Ignore = { fg = p.fg_dark }
  hl.Error = { fg = p.error }
  hl.Todo = { fg = p.accent, bold = true }

  -- diagnostics
  hl.DiagnosticError = { fg = p.error }
  hl.DiagnosticWarn = { fg = p.warning }
  hl.DiagnosticInfo = { fg = p.info }
  hl.DiagnosticHint = { fg = p.hint }
  hl.DiagnosticOk = { fg = p.success }
  hl.DiagnosticUnderlineError = { undercurl = true, sp = p.error }
  hl.DiagnosticUnderlineWarn = { undercurl = true, sp = p.warning }
  hl.DiagnosticUnderlineInfo = { undercurl = true, sp = p.info }
  hl.DiagnosticUnderlineHint = { undercurl = true, sp = p.hint }
  hl.DiagnosticUnderlineOk = { undercurl = true, sp = p.success }
  hl.DiagnosticVirtualTextError = { fg = p.error, bg = transparent and p.none or p.diff_delete }
  hl.DiagnosticVirtualTextWarn = { fg = p.warning, bg = transparent and p.none or p.diff_change }
  hl.DiagnosticVirtualTextInfo = { fg = p.info, bg = transparent and p.none or p.diff_change }
  hl.DiagnosticVirtualTextHint = { fg = p.hint, bg = transparent and p.none or p.diff_add }
  hl.DiagnosticSignError = { fg = p.error }
  hl.DiagnosticSignWarn = { fg = p.warning }
  hl.DiagnosticSignInfo = { fg = p.info }
  hl.DiagnosticSignHint = { fg = p.hint }

  -- treesitter
  hl["@variable"] = vim.tbl_extend("force", { fg = p.variable }, variable_style)
  hl["@variable.builtin"] = { fg = p.keyword }
  hl["@variable.parameter"] = { fg = p.parameter }
  hl["@variable.member"] = { fg = p.property }
  hl["@constant"] = { fg = p.constant }
  hl["@constant.builtin"] = { fg = p.constant }
  hl["@constant.macro"] = { fg = p.constant }
  hl["@module"] = { fg = p.variable }
  hl["@label"] = { fg = p.accent }
  hl["@string"] = { fg = p.string }
  hl["@string.escape"] = { fg = p.special }
  hl["@string.regexp"] = { fg = p.special }
  hl["@string.special"] = { fg = p.special }
  hl["@character"] = { fg = p.string }
  hl["@number"] = { fg = p.constant }
  hl["@boolean"] = { fg = p.constant }
  hl["@float"] = { fg = p.constant }
  hl["@function"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@function.builtin"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@function.call"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@function.macro"] = { fg = p.func }
  hl["@function.method"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@function.method.call"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@constructor"] = { fg = p.type }
  hl["@operator"] = { fg = p.operator }
  hl["@keyword"] = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl["@keyword.conditional"] = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl["@keyword.repeat"] = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl["@keyword.return"] = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl["@keyword.function"] = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl["@keyword.operator"] = { fg = p.keyword }
  hl["@keyword.import"] = { fg = p.keyword }
  hl["@keyword.storage"] = { fg = p.keyword }
  hl["@keyword.exception"] = { fg = p.keyword }
  hl["@type"] = { fg = p.type }
  hl["@type.builtin"] = { fg = p.type }
  hl["@type.definition"] = { fg = p.type }
  hl["@type.qualifier"] = { fg = p.keyword }
  hl["@attribute"] = { fg = p.special }
  hl["@property"] = { fg = p.property }
  hl["@comment"] = vim.tbl_extend("force", { fg = p.comment }, comment_style)
  hl["@comment.todo"] = { fg = p.accent, bold = true }
  hl["@comment.note"] = { fg = p.info, bold = true }
  hl["@comment.warning"] = { fg = p.warning, bold = true }
  hl["@comment.error"] = { fg = p.error, bold = true }
  hl["@punctuation.bracket"] = { fg = p.punctuation }
  hl["@punctuation.delimiter"] = { fg = p.punctuation }
  hl["@punctuation.special"] = { fg = p.special }
  hl["@tag"] = { fg = p.tag }
  hl["@tag.attribute"] = { fg = p.variable }
  hl["@tag.delimiter"] = { fg = p.punctuation }
  hl["@markup.heading"] = { fg = p.accent, bold = true }
  hl["@markup.italic"] = { italic = true }
  hl["@markup.strong"] = { bold = true }
  hl["@markup.strikethrough"] = { strikethrough = true }
  hl["@markup.underline"] = { underline = true }
  hl["@markup.link"] = { fg = p.accent, underline = true }
  hl["@markup.link.url"] = { fg = p.string, underline = true }
  hl["@markup.raw"] = { fg = p.string }
  hl["@markup.list"] = { fg = p.accent }

  -- LSP semantic tokens
  hl["@lsp.type.class"] = { fg = p.type }
  hl["@lsp.type.decorator"] = { fg = p.special }
  hl["@lsp.type.enum"] = { fg = p.type }
  hl["@lsp.type.enumMember"] = { fg = p.constant }
  hl["@lsp.type.function"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@lsp.type.interface"] = { fg = p.type }
  hl["@lsp.type.macro"] = { fg = p.keyword }
  hl["@lsp.type.method"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@lsp.type.namespace"] = { fg = p.variable }
  hl["@lsp.type.parameter"] = { fg = p.parameter }
  hl["@lsp.type.property"] = { fg = p.property }
  hl["@lsp.type.struct"] = { fg = p.type }
  hl["@lsp.type.type"] = { fg = p.type }
  hl["@lsp.type.typeParameter"] = { fg = p.type }
  hl["@lsp.type.variable"] = vim.tbl_extend("force", { fg = p.variable }, variable_style)
  hl["@lsp.mod.deprecated"] = { strikethrough = true }

  -- gitsigns
  hl.GitSignsAdd = { fg = p.git_add }
  hl.GitSignsChange = { fg = p.git_change }
  hl.GitSignsDelete = { fg = p.git_delete }

  -- telescope
  hl.TelescopeBorder = { fg = p.border, bg = bg_float }
  hl.TelescopeNormal = { fg = p.fg, bg = bg_float }
  hl.TelescopePromptNormal = { fg = p.fg, bg = bg_float }
  hl.TelescopePromptBorder = { fg = p.border, bg = bg_float }
  hl.TelescopePromptTitle = { fg = p.accent, bold = true }
  hl.TelescopePreviewTitle = { fg = p.accent, bold = true }
  hl.TelescopeResultsTitle = { fg = p.accent, bold = true }
  hl.TelescopeSelection = { bg = p.bg_visual }
  hl.TelescopeMatching = { fg = p.accent, bold = true }

  -- neo-tree
  hl.NeoTreeNormal = { fg = p.fg, bg = bg_sidebar }
  hl.NeoTreeNormalNC = { fg = p.fg, bg = bg_sidebar }
  hl.NeoTreeDirectoryName = { fg = p.accent }
  hl.NeoTreeDirectoryIcon = { fg = p.accent }
  hl.NeoTreeRootName = { fg = p.accent, bold = true }
  hl.NeoTreeFileName = { fg = p.fg }
  hl.NeoTreeGitAdded = { fg = p.git_add }
  hl.NeoTreeGitDeleted = { fg = p.git_delete }
  hl.NeoTreeGitModified = { fg = p.git_change }
  hl.NeoTreeGitConflict = { fg = p.error }
  hl.NeoTreeGitUntracked = { fg = p.variable }
  hl.NeoTreeIndentMarker = { fg = p.fg_dark }
  hl.NeoTreeWinSeparator = { fg = p.border, bg = bg }

  -- indent-blankline / ibl
  hl.IblIndent = { fg = p.fg_dark }
  hl.IblScope = { fg = p.accent }

  -- notify
  hl.NotifyERRORBorder = { fg = p.error }
  hl.NotifyWARNBorder = { fg = p.warning }
  hl.NotifyINFOBorder = { fg = p.info }
  hl.NotifyDEBUGBorder = { fg = p.fg_dim }
  hl.NotifyTRACEBorder = { fg = p.hint }
  hl.NotifyERRORIcon = { fg = p.error }
  hl.NotifyWARNIcon = { fg = p.warning }
  hl.NotifyINFOIcon = { fg = p.info }
  hl.NotifyDEBUGIcon = { fg = p.fg_dim }
  hl.NotifyTRACEIcon = { fg = p.hint }
  hl.NotifyERRORTitle = { fg = p.error }
  hl.NotifyWARNTitle = { fg = p.warning }
  hl.NotifyINFOTitle = { fg = p.info }
  hl.NotifyDEBUGTitle = { fg = p.fg_dim }
  hl.NotifyTRACETitle = { fg = p.hint }

  -- blink.cmp
  hl.BlinkCmpMenu = { fg = p.fg, bg = bg_float }
  hl.BlinkCmpMenuBorder = { fg = p.border, bg = bg_float }
  hl.BlinkCmpMenuSelection = { bg = p.bg_visual }
  hl.BlinkCmpLabel = { fg = p.fg }
  hl.BlinkCmpLabelMatch = { fg = p.accent, bold = true }
  hl.BlinkCmpKind = { fg = p.special }
  hl.BlinkCmpKindFunction = { fg = p.func }
  hl.BlinkCmpKindMethod = { fg = p.func }
  hl.BlinkCmpKindVariable = { fg = p.variable }
  hl.BlinkCmpKindKeyword = { fg = p.keyword }
  hl.BlinkCmpKindText = { fg = p.fg }
  hl.BlinkCmpKindProperty = { fg = p.property }
  hl.BlinkCmpKindUnit = { fg = p.constant }

  -- rainbow delimiters
  hl.RainbowDelimiterRed = { fg = p.keyword }
  hl.RainbowDelimiterYellow = { fg = p.variable }
  hl.RainbowDelimiterBlue = { fg = p.constant }
  hl.RainbowDelimiterOrange = { fg = p.warning }
  hl.RainbowDelimiterGreen = { fg = p.type }
  hl.RainbowDelimiterViolet = { fg = p.func }
  hl.RainbowDelimiterCyan = { fg = p.string }

  return hl
end

return M
