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
  hl.Substitute = { bg = p.keyword_control, fg = p.bg }
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

  -- syntax (vim builtin groups) -- VS Code Dark+/Light+ mapping
  hl.Comment = vim.tbl_extend("force", { fg = p.comment }, comment_style)
  hl.Constant = { fg = p.constant }
  hl.String = { fg = p.string }
  hl.Character = { fg = p.string }
  hl.Number = { fg = p.number }
  hl.Boolean = { fg = p.constant_builtin }
  hl.Float = { fg = p.number }
  hl.Identifier = vim.tbl_extend("force", { fg = p.variable }, variable_style)
  hl.Function = vim.tbl_extend("force", { fg = p.func }, function_style)
  -- Statement family: control flow is purple in VS Code Dark+
  hl.Statement = vim.tbl_extend("force", { fg = p.keyword_control }, keyword_style)
  hl.Conditional = vim.tbl_extend("force", { fg = p.keyword_control }, keyword_style)
  hl.Repeat = vim.tbl_extend("force", { fg = p.keyword_control }, keyword_style)
  hl.Exception = vim.tbl_extend("force", { fg = p.keyword_control }, keyword_style)
  hl.Label = { fg = p.label }
  hl.Operator = { fg = p.operator }
  -- Keyword family: declarations/storage are blue
  hl.Keyword = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
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
  hl.SpecialChar = { fg = p.string_escape }
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

  -- treesitter: variables, parameters, properties
  hl["@variable"] = vim.tbl_extend("force", { fg = p.variable }, variable_style)
  hl["@variable.builtin"] = { fg = p.keyword } -- this, self, super
  hl["@variable.parameter"] = { fg = p.parameter }
  hl["@variable.parameter.builtin"] = { fg = p.parameter }
  hl["@variable.member"] = { fg = p.property }
  hl["@property"] = { fg = p.property }
  hl["@parameter"] = { fg = p.parameter }

  -- treesitter: constants and literals
  hl["@constant"] = { fg = p.constant }
  hl["@constant.builtin"] = { fg = p.constant_builtin } -- null, undefined, nil, True, False
  hl["@constant.macro"] = { fg = p.constant }
  hl["@number"] = { fg = p.number }
  hl["@number.float"] = { fg = p.number }
  hl["@boolean"] = { fg = p.constant_builtin }

  -- treesitter: modules/namespaces
  hl["@module"] = { fg = p.variable }
  hl["@module.builtin"] = { fg = p.keyword }
  hl["@label"] = { fg = p.label }

  -- treesitter: strings
  hl["@string"] = { fg = p.string }
  hl["@string.documentation"] = { fg = p.string }
  hl["@string.escape"] = { fg = p.string_escape }
  hl["@string.regexp"] = { fg = p.regexp }
  hl["@string.special"] = { fg = p.string_escape }
  hl["@string.special.symbol"] = { fg = p.constant }
  hl["@string.special.url"] = { fg = p.string, underline = true }
  hl["@string.special.path"] = { fg = p.string }
  hl["@character"] = { fg = p.string }
  hl["@character.special"] = { fg = p.string_escape }

  -- treesitter: functions
  hl["@function"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@function.builtin"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@function.call"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@function.macro"] = { fg = p.func }
  hl["@function.method"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@function.method.call"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@constructor"] = { fg = p.type }

  -- treesitter: operators
  hl["@operator"] = { fg = p.operator }

  -- treesitter: keywords (declarations/storage = blue, control-flow = purple)
  hl["@keyword"] = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl["@keyword.function"] = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl["@keyword.operator"] = { fg = p.keyword } -- new, typeof, instanceof, in, of
  hl["@keyword.import"] = { fg = p.keyword } -- import, from, export
  hl["@keyword.storage"] = { fg = p.keyword } -- var, let, const, static
  hl["@keyword.modifier"] = { fg = p.keyword } -- public, private, async
  hl["@keyword.type"] = { fg = p.keyword } -- class, struct, enum, interface
  hl["@keyword.directive"] = { fg = p.keyword }
  hl["@keyword.directive.define"] = { fg = p.keyword }
  -- control flow -> purple
  hl["@keyword.conditional"] = vim.tbl_extend("force", { fg = p.keyword_control }, keyword_style)
  hl["@keyword.conditional.ternary"] = { fg = p.operator }
  hl["@keyword.repeat"] = vim.tbl_extend("force", { fg = p.keyword_control }, keyword_style)
  hl["@keyword.return"] = vim.tbl_extend("force", { fg = p.keyword_control }, keyword_style)
  hl["@keyword.exception"] = vim.tbl_extend("force", { fg = p.keyword_control }, keyword_style)
  hl["@keyword.debug"] = { fg = p.keyword_control }
  hl["@keyword.coroutine"] = { fg = p.keyword_control } -- async/await lean purple (await-dominant)

  -- treesitter: types
  hl["@type"] = { fg = p.type }
  hl["@type.builtin"] = { fg = p.keyword } -- string, number, void (TS primitives)
  hl["@type.definition"] = { fg = p.type }
  hl["@type.qualifier"] = { fg = p.keyword }

  -- treesitter: attributes/decorators
  hl["@attribute"] = { fg = p.func } -- @decorator, Python @classmethod
  hl["@attribute.builtin"] = { fg = p.func }

  -- treesitter: comments
  hl["@comment"] = vim.tbl_extend("force", { fg = p.comment }, comment_style)
  hl["@comment.documentation"] = { fg = p.comment, italic = true }
  hl["@comment.todo"] = { fg = p.accent, bold = true }
  hl["@comment.note"] = { fg = p.info, bold = true }
  hl["@comment.warning"] = { fg = p.warning, bold = true }
  hl["@comment.error"] = { fg = p.error, bold = true }

  -- treesitter: punctuation
  hl["@punctuation.delimiter"] = { fg = p.punctuation }
  hl["@punctuation.bracket"] = { fg = p.punctuation }
  -- ${} in JS/TS template literals -> blue (VS Code punctuation.definition.template-expression)
  hl["@punctuation.special"] = { fg = p.keyword }

  -- treesitter: tags (HTML / JSX / Vue)
  hl["@tag"] = { fg = p.tag }
  hl["@tag.builtin"] = { fg = p.tag }
  hl["@tag.attribute"] = { fg = p.tag_attr }
  hl["@tag.delimiter"] = { fg = p.tag_delimiter }

  -- treesitter: markup (markdown)
  hl["@markup.heading"] = { fg = p.keyword, bold = true }
  hl["@markup.heading.1"] = { fg = p.keyword, bold = true }
  hl["@markup.heading.2"] = { fg = p.keyword, bold = true }
  hl["@markup.heading.3"] = { fg = p.keyword, bold = true }
  hl["@markup.heading.4"] = { fg = p.keyword, bold = true }
  hl["@markup.heading.5"] = { fg = p.keyword, bold = true }
  hl["@markup.heading.6"] = { fg = p.keyword, bold = true }
  hl["@markup.italic"] = { italic = true, fg = p.keyword_control }
  hl["@markup.strong"] = { bold = true, fg = p.keyword }
  hl["@markup.strikethrough"] = { strikethrough = true }
  hl["@markup.underline"] = { underline = true }
  hl["@markup.link"] = { fg = p.variable }
  hl["@markup.link.label"] = { fg = p.variable }
  hl["@markup.link.url"] = { fg = p.string, underline = true }
  hl["@markup.raw"] = { fg = p.string }
  hl["@markup.raw.block"] = { fg = p.string }
  hl["@markup.list"] = { fg = p.accent }
  hl["@markup.list.checked"] = { fg = p.success }
  hl["@markup.list.unchecked"] = { fg = p.fg_dim }
  hl["@markup.quote"] = { fg = p.comment, italic = true }
  hl["@markup.math"] = { fg = p.number }
  hl["@markup.environment"] = { fg = p.keyword }

  -- treesitter: diff
  hl["@diff.plus"] = { fg = p.git_add }
  hl["@diff.minus"] = { fg = p.git_delete }
  hl["@diff.delta"] = { fg = p.git_change }

  -- bash/zsh specifics
  -- $FOO: $ should feel like part of the variable (VS Code colors whole thing light blue)
  hl["@punctuation.special.bash"] = { fg = p.variable }
  hl["@variable.parameter.bash"] = { fg = p.variable }

  -- CSS/SCSS specifics
  hl["@tag.css"] = { fg = p.css_selector } -- div, body tag selectors
  hl["@tag.scss"] = { fg = p.css_selector }
  hl["@property.css"] = { fg = p.tag_attr } -- color:, margin:
  hl["@type.css"] = { fg = p.css_selector } -- .class / #id
  hl["@attribute.css"] = { fg = p.css_selector } -- :hover, :focus
  hl["@string.plain.css"] = { fg = p.string }
  hl["@number.css"] = { fg = p.number }
  hl["@function.css"] = { fg = p.func }

  -- JSON/YAML specifics
  hl["@property.json"] = { fg = p.variable }
  hl["@property.yaml"] = { fg = p.variable }

  -- LSP semantic tokens (VS Code semanticTokenColors + default mapping)
  hl["@lsp.type.namespace"] = { fg = p.namespace }
  hl["@lsp.type.type"] = { fg = p.type }
  hl["@lsp.type.class"] = { fg = p.type }
  hl["@lsp.type.enum"] = { fg = p.type }
  hl["@lsp.type.interface"] = { fg = p.type }
  hl["@lsp.type.struct"] = { fg = p.type }
  hl["@lsp.type.typeParameter"] = { fg = p.type }
  hl["@lsp.type.parameter"] = { fg = p.parameter }
  hl["@lsp.type.variable"] = vim.tbl_extend("force", { fg = p.variable }, variable_style)
  hl["@lsp.type.property"] = { fg = p.property }
  hl["@lsp.type.enumMember"] = { fg = p.constant }
  hl["@lsp.type.event"] = { fg = p.variable }
  hl["@lsp.type.function"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@lsp.type.method"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@lsp.type.macro"] = { fg = p.keyword }
  hl["@lsp.type.label"] = { fg = p.label }
  hl["@lsp.type.comment"] = { fg = p.comment }
  hl["@lsp.type.string"] = { fg = p.string }
  hl["@lsp.type.keyword"] = { fg = p.keyword }
  hl["@lsp.type.number"] = { fg = p.number }
  hl["@lsp.type.regexp"] = { fg = p.regexp }
  hl["@lsp.type.operator"] = { fg = p.operator }
  hl["@lsp.type.decorator"] = { fg = p.func }
  hl["@lsp.type.modifier"] = { fg = p.keyword }
  hl["@lsp.type.selfParameter"] = { fg = p.keyword }
  hl["@lsp.type.builtinConstant"] = { fg = p.constant_builtin }
  hl["@lsp.type.magicFunction"] = { fg = p.func }
  -- modifiers
  hl["@lsp.mod.deprecated"] = { strikethrough = true }
  hl["@lsp.mod.readonly"] = {}
  hl["@lsp.mod.defaultLibrary"] = {}
  -- typemod combinations
  hl["@lsp.typemod.variable.defaultLibrary"] = { fg = p.variable } -- console, Math, window
  hl["@lsp.typemod.function.defaultLibrary"] = { fg = p.func }
  hl["@lsp.typemod.method.defaultLibrary"] = { fg = p.func }
  hl["@lsp.typemod.type.defaultLibrary"] = { fg = p.type }
  hl["@lsp.typemod.class.defaultLibrary"] = { fg = p.type }
  hl["@lsp.typemod.variable.readonly"] = vim.tbl_extend("force", { fg = p.variable }, variable_style)
  hl["@lsp.typemod.variable.readonly.defaultLibrary"] = { fg = p.constant_builtin }
  hl["@lsp.typemod.variable.constant"] = { fg = p.constant }
  hl["@lsp.typemod.property.readonly"] = { fg = p.property }
  hl["@lsp.typemod.enumMember.readonly"] = { fg = p.constant }
  hl["@lsp.typemod.operator.controlFlow"] = { fg = p.keyword_control }
  hl["@lsp.typemod.keyword.controlFlow"] = { fg = p.keyword_control }
  hl["@lsp.typemod.keyword.async"] = { fg = p.keyword_control } -- async/await

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
  hl.BlinkCmpKindUnit = { fg = p.number }
  hl.BlinkCmpKindClass = { fg = p.type }
  hl.BlinkCmpKindInterface = { fg = p.type }
  hl.BlinkCmpKindStruct = { fg = p.type }
  hl.BlinkCmpKindEnum = { fg = p.type }
  hl.BlinkCmpKindEnumMember = { fg = p.constant }
  hl.BlinkCmpKindConstant = { fg = p.constant }
  hl.BlinkCmpKindModule = { fg = p.variable }
  hl.BlinkCmpKindField = { fg = p.property }
  hl.BlinkCmpKindSnippet = { fg = p.comment }
  hl.BlinkCmpKindColor = { fg = p.string_escape }
  hl.BlinkCmpKindFile = { fg = p.fg }
  hl.BlinkCmpKindFolder = { fg = p.accent }

  -- rainbow delimiters
  hl.RainbowDelimiterRed = { fg = p.error }
  hl.RainbowDelimiterYellow = { fg = p.func }
  hl.RainbowDelimiterBlue = { fg = p.keyword }
  hl.RainbowDelimiterOrange = { fg = p.string }
  hl.RainbowDelimiterGreen = { fg = p.number }
  hl.RainbowDelimiterViolet = { fg = p.keyword_control }
  hl.RainbowDelimiterCyan = { fg = p.type }

  return hl
end

return M
