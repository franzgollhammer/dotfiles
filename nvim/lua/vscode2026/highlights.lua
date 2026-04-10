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
  hl.CursorLine = { bg = transparent and p.none or p.bg_line }
  hl.CursorColumn = { link = "CursorLine" }
  hl.ColorColumn = { bg = transparent and p.none or p.bg_line }
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
  hl.Folded = { fg = p.fg_dim, bg = transparent and p.none or p.bg_line }
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
  hl.FloatTitle = { fg = p.accent_bright, bg = bg_float, bold = true }
  hl.Title = { fg = p.accent_bright, bold = true }
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
  hl.MoreMsg = { fg = p.accent_bright }
  hl.ModeMsg = { fg = p.fg, bold = true }
  hl.Question = { fg = p.accent_bright }
  hl.Directory = { fg = p.accent_bright }
  hl.QuickFixLine = { bg = p.bg_visual }
  hl.DiffAdd = { bg = p.diff_add }
  hl.DiffChange = { bg = p.diff_change }
  hl.DiffDelete = { bg = p.diff_delete }
  hl.DiffText = { bg = p.diff_text }
  hl.WinBar = { fg = p.fg, bg = bg }
  hl.WinBarNC = { fg = p.fg_dim, bg = bg }

  -- ======================================================================
  -- syntax (vim builtin groups) -- VS Code 2026 Dark/Light mapping
  -- ======================================================================
  hl.Comment = vim.tbl_extend("force", { fg = p.comment }, comment_style)
  hl.Constant = { fg = p.number }       -- constant → blue
  hl.String = { fg = p.string }         -- string → light blue
  hl.Character = { fg = p.keyword }     -- constant.character → red
  hl.Number = { fg = p.number }
  hl.Boolean = { fg = p.constant_builtin }
  hl.Float = { fg = p.number }
  hl.Identifier = vim.tbl_extend("force", { fg = p.variable }, variable_style)
  hl.Function = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl.Statement = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl.Conditional = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl.Repeat = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl.Exception = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl.Label = { fg = p.label }
  hl.Operator = { fg = p.operator }
  hl.Keyword = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl.PreProc = { fg = p.keyword }
  hl.Include = { fg = p.keyword }
  hl.Define = { fg = p.keyword }
  hl.Macro = { fg = p.keyword }
  hl.PreCondit = { fg = p.keyword }
  hl.Type = { fg = p.variable_def }       -- entity.name fallthrough → orange
  hl.StorageClass = { fg = p.keyword }
  hl.Structure = { fg = p.variable_def }
  hl.Typedef = { fg = p.variable_def }
  hl.Special = { fg = p.keyword }         -- constant.character / punctuation.section.embedded → red
  hl.SpecialChar = { fg = p.string_escape, bold = true } -- string.regexp constant.character.escape
  hl.Tag = { fg = p.tag }
  hl.Delimiter = { fg = p.punctuation }
  hl.SpecialComment = { fg = p.comment, bold = true }
  hl.Debug = { fg = p.debug_token }
  hl.Underlined = { underline = true }
  hl.Ignore = { fg = p.fg_dark }
  hl.Error = { fg = p.invalid, italic = true }
  hl.Todo = { fg = p.accent_bright, bold = true }

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

  -- ======================================================================
  -- treesitter (2026 scope mapping)
  -- ======================================================================

  -- variables: usage/members/params default to fg syntax (variable.other)
  hl["@variable"] = vim.tbl_extend("force", { fg = p.variable }, variable_style)
  hl["@variable.builtin"] = { fg = p.constant_builtin } -- this, self, super (variable.language)
  hl["@variable.parameter"] = { fg = p.parameter }
  hl["@variable.parameter.builtin"] = { fg = p.parameter }
  hl["@variable.member"] = { fg = p.variable } -- obj.member access → fg
  hl["@property"] = { fg = p.property }        -- object literal keys → meta.property-name blue
  hl["@parameter"] = { fg = p.parameter }
  hl["@field"] = { fg = p.property }

  -- constants and literals
  hl["@constant"] = { fg = p.number }          -- variable.other.constant → blue
  hl["@constant.builtin"] = { fg = p.constant_builtin } -- null, true, false, nil
  hl["@constant.macro"] = { fg = p.number }
  hl["@number"] = { fg = p.number }
  hl["@number.float"] = { fg = p.number }
  hl["@boolean"] = { fg = p.constant_builtin }

  -- modules / namespaces
  hl["@module"] = { fg = p.namespace }         -- meta.module-reference → blue
  hl["@module.builtin"] = { fg = p.namespace }
  hl["@label"] = { fg = p.label }

  -- strings (note: @string.regexp is SAME as @string in 2026)
  hl["@string"] = { fg = p.string }
  hl["@string.documentation"] = { fg = p.string }
  hl["@string.escape"] = { fg = p.string_escape, bold = true }
  hl["@string.regexp"] = { fg = p.string }
  hl["@string.special"] = { fg = p.keyword }   -- placeholders → red
  hl["@string.special.symbol"] = { fg = p.number }
  hl["@string.special.url"] = { fg = p.string, underline = true }
  hl["@string.special.path"] = { fg = p.string }
  hl["@character"] = { fg = p.keyword }        -- constant.character → red
  hl["@character.special"] = { fg = p.string_escape, bold = true }

  -- functions: entity.name.function → purple; support.function → blue
  hl["@function"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@function.builtin"] = { fg = p.number }  -- support.function → blue
  hl["@function.call"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@function.macro"] = { fg = p.func }
  hl["@function.method"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@function.method.call"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@constructor"] = { fg = p.variable_def } -- entity.name → orange

  -- operators
  hl["@operator"] = { fg = p.operator }

  -- keywords (all red in 2026)
  hl["@keyword"] = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl["@keyword.function"] = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl["@keyword.operator"] = { fg = p.keyword } -- new, typeof, instanceof
  hl["@keyword.import"] = { fg = p.keyword }   -- import, from, export
  hl["@keyword.storage"] = { fg = p.keyword }  -- var, let, const
  hl["@keyword.modifier"] = { fg = p.keyword } -- public, private, async, static
  hl["@keyword.type"] = { fg = p.keyword }     -- class, struct, interface, enum
  hl["@keyword.directive"] = { fg = p.keyword }
  hl["@keyword.directive.define"] = { fg = p.keyword }
  hl["@keyword.conditional"] = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl["@keyword.conditional.ternary"] = { fg = p.operator }
  hl["@keyword.repeat"] = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl["@keyword.return"] = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl["@keyword.exception"] = vim.tbl_extend("force", { fg = p.keyword }, keyword_style)
  hl["@keyword.debug"] = { fg = p.keyword }
  hl["@keyword.coroutine"] = { fg = p.keyword } -- async/await

  -- types: entity.name fallthrough → orange for declarations and refs
  hl["@type"] = { fg = p.variable_def }
  hl["@type.builtin"] = { fg = p.number }      -- support.type → blue
  hl["@type.definition"] = { fg = p.variable_def }
  hl["@type.qualifier"] = { fg = p.keyword }

  -- attributes / decorators → purple (function-like)
  hl["@attribute"] = { fg = p.func }
  hl["@attribute.builtin"] = { fg = p.func }

  -- comments
  hl["@comment"] = vim.tbl_extend("force", { fg = p.comment }, comment_style)
  hl["@comment.documentation"] = { fg = p.comment, italic = true }
  hl["@comment.todo"] = { fg = p.accent_bright, bold = true }
  hl["@comment.note"] = { fg = p.info, bold = true }
  hl["@comment.warning"] = { fg = p.warning, bold = true }
  hl["@comment.error"] = { fg = p.error, bold = true }

  -- punctuation
  hl["@punctuation.delimiter"] = { fg = p.punctuation }
  hl["@punctuation.bracket"] = { fg = p.punctuation }
  -- ${} template expression → red (punctuation.section.embedded)
  hl["@punctuation.special"] = { fg = p.keyword }

  -- tags (HTML / JSX / Vue)
  hl["@tag"] = { fg = p.tag }
  hl["@tag.builtin"] = { fg = p.tag }
  hl["@tag.attribute"] = { fg = p.tag_attr }
  hl["@tag.delimiter"] = { fg = p.tag_delimiter }

  -- markdown
  hl["@markup.heading"] = { fg = p.number, bold = true }
  hl["@markup.heading.1"] = { fg = p.number, bold = true }
  hl["@markup.heading.2"] = { fg = p.number, bold = true }
  hl["@markup.heading.3"] = { fg = p.number, bold = true }
  hl["@markup.heading.4"] = { fg = p.number, bold = true }
  hl["@markup.heading.5"] = { fg = p.number, bold = true }
  hl["@markup.heading.6"] = { fg = p.number, bold = true }
  hl["@markup.italic"] = { italic = true, fg = p.variable }
  hl["@markup.strong"] = { bold = true, fg = p.variable }
  hl["@markup.strikethrough"] = { strikethrough = true }
  hl["@markup.underline"] = { underline = true }
  hl["@markup.link"] = { fg = p.string }       -- constant.other.reference.link → light blue
  hl["@markup.link.label"] = { fg = p.string }
  hl["@markup.link.url"] = { fg = p.string, underline = true }
  hl["@markup.raw"] = { fg = p.number }        -- markup.inline.raw → blue
  hl["@markup.raw.block"] = { fg = p.number }
  hl["@markup.list"] = { fg = p.variable_def } -- punctuation.definition.list → orange
  hl["@markup.list.checked"] = { fg = p.success }
  hl["@markup.list.unchecked"] = { fg = p.fg_dim }
  hl["@markup.quote"] = { fg = p.type }        -- markup.quote → green
  hl["@markup.math"] = { fg = p.number }
  hl["@markup.environment"] = { fg = p.keyword }

  -- diff (2026 markup.*/diff)
  hl["@diff.plus"] = { fg = p.type }           -- markup.inserted → green
  hl["@diff.minus"] = { fg = p.invalid }       -- markup.deleted → #ffa198
  hl["@diff.delta"] = { fg = p.variable_def }  -- markup.changed → orange

  -- bash/zsh specifics — $FOO whole token light like variable.other
  hl["@punctuation.special.bash"] = { fg = p.variable }
  hl["@variable.parameter.bash"] = { fg = p.variable }

  -- CSS / SCSS
  hl["@tag.css"] = { fg = p.tag }
  hl["@tag.scss"] = { fg = p.tag }
  hl["@property.css"] = { fg = p.property }
  hl["@type.css"] = { fg = p.tag }             -- .class / #id selectors → green
  hl["@attribute.css"] = { fg = p.tag }        -- :hover, :focus → green
  hl["@string.plain.css"] = { fg = p.string }
  hl["@number.css"] = { fg = p.number }
  hl["@function.css"] = { fg = p.func }

  -- JSON / YAML property names (2026 sets .json → green)
  hl["@property.json"] = { fg = p.tag }
  hl["@property.yaml"] = { fg = p.tag }
  hl["@label.json"] = { fg = p.tag }

  -- ======================================================================
  -- LSP semantic tokens (adds decl/usage distinction the textmate scopes
  -- provide via meta.definition.variable vs variable.other)
  -- ======================================================================
  hl["@lsp.type.namespace"] = { fg = p.namespace }
  hl["@lsp.type.type"] = { fg = p.variable_def }
  hl["@lsp.type.class"] = { fg = p.variable_def }
  hl["@lsp.type.enum"] = { fg = p.variable_def }
  hl["@lsp.type.interface"] = { fg = p.variable_def }
  hl["@lsp.type.struct"] = { fg = p.variable_def }
  hl["@lsp.type.typeParameter"] = { fg = p.variable_def }
  hl["@lsp.type.parameter"] = { fg = p.parameter }
  hl["@lsp.type.variable"] = vim.tbl_extend("force", { fg = p.variable }, variable_style)
  hl["@lsp.type.property"] = { fg = p.variable }
  hl["@lsp.type.enumMember"] = { fg = p.number }
  hl["@lsp.type.event"] = { fg = p.variable }
  hl["@lsp.type.function"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@lsp.type.method"] = vim.tbl_extend("force", { fg = p.func }, function_style)
  hl["@lsp.type.macro"] = { fg = p.keyword }
  hl["@lsp.type.label"] = { fg = p.label }
  hl["@lsp.type.comment"] = { fg = p.comment }
  hl["@lsp.type.string"] = { fg = p.string }
  hl["@lsp.type.keyword"] = { fg = p.keyword }
  hl["@lsp.type.number"] = { fg = p.number }
  hl["@lsp.type.regexp"] = { fg = p.string }
  hl["@lsp.type.operator"] = { fg = p.operator }
  hl["@lsp.type.decorator"] = { fg = p.func }
  hl["@lsp.type.modifier"] = { fg = p.keyword }
  hl["@lsp.type.selfParameter"] = { fg = p.constant_builtin }
  hl["@lsp.type.builtinConstant"] = { fg = p.constant_builtin }
  hl["@lsp.type.magicFunction"] = { fg = p.func }

  -- modifiers
  hl["@lsp.mod.deprecated"] = { strikethrough = true }
  hl["@lsp.mod.readonly"] = {}
  hl["@lsp.mod.defaultLibrary"] = {}

  -- typemod combinations: 2026 distinguishes declarations (orange) from usages (fg)
  hl["@lsp.typemod.variable.declaration"] = { fg = p.variable_def }
  hl["@lsp.typemod.variable.definition"] = { fg = p.variable_def }
  hl["@lsp.typemod.variable.readonly"] = { fg = p.number }
  hl["@lsp.typemod.variable.readonly.defaultLibrary"] = { fg = p.constant_builtin }
  hl["@lsp.typemod.variable.defaultLibrary"] = { fg = p.number }     -- console, Math, window
  hl["@lsp.typemod.variable.constant"] = { fg = p.number }
  hl["@lsp.typemod.function.declaration"] = { fg = p.func }
  hl["@lsp.typemod.function.definition"] = { fg = p.func }
  hl["@lsp.typemod.function.defaultLibrary"] = { fg = p.number }     -- support.function → blue
  hl["@lsp.typemod.method.defaultLibrary"] = { fg = p.number }
  hl["@lsp.typemod.type.defaultLibrary"] = { fg = p.number }         -- support.type → blue
  hl["@lsp.typemod.class.defaultLibrary"] = { fg = p.number }        -- support.class → blue
  hl["@lsp.typemod.interface.defaultLibrary"] = { fg = p.number }
  hl["@lsp.typemod.property.readonly"] = { fg = p.variable }
  hl["@lsp.typemod.enumMember.readonly"] = { fg = p.number }
  hl["@lsp.typemod.operator.controlFlow"] = { fg = p.keyword }
  hl["@lsp.typemod.keyword.controlFlow"] = { fg = p.keyword }
  hl["@lsp.typemod.keyword.async"] = { fg = p.keyword }

  -- gitsigns
  hl.GitSignsAdd = { fg = p.git_add }
  hl.GitSignsChange = { fg = p.git_change }
  hl.GitSignsDelete = { fg = p.git_delete }

  -- telescope
  hl.TelescopeBorder = { fg = p.border, bg = bg_float }
  hl.TelescopeNormal = { fg = p.fg, bg = bg_float }
  hl.TelescopePromptNormal = { fg = p.fg, bg = bg_float }
  hl.TelescopePromptBorder = { fg = p.border, bg = bg_float }
  hl.TelescopePromptTitle = { fg = p.accent_bright, bold = true }
  hl.TelescopePreviewTitle = { fg = p.accent_bright, bold = true }
  hl.TelescopeResultsTitle = { fg = p.accent_bright, bold = true }
  hl.TelescopeSelection = { bg = p.bg_visual }
  hl.TelescopeMatching = { fg = p.accent_bright, bold = true }

  -- neo-tree
  hl.NeoTreeNormal = { fg = p.fg, bg = bg_sidebar }
  hl.NeoTreeNormalNC = { fg = p.fg, bg = bg_sidebar }
  hl.NeoTreeDirectoryName = { fg = p.accent_bright }
  hl.NeoTreeDirectoryIcon = { fg = p.accent_bright }
  hl.NeoTreeRootName = { fg = p.accent_bright, bold = true }
  hl.NeoTreeFileName = { fg = p.fg }
  hl.NeoTreeGitAdded = { fg = p.git_add }
  hl.NeoTreeGitDeleted = { fg = p.git_delete }
  hl.NeoTreeGitModified = { fg = p.git_change }
  hl.NeoTreeGitConflict = { fg = p.error }
  hl.NeoTreeGitUntracked = { fg = p.git_add }
  hl.NeoTreeIndentMarker = { fg = p.fg_dark }
  hl.NeoTreeWinSeparator = { fg = p.border, bg = bg }

  -- indent-blankline / ibl
  hl.IblIndent = { fg = p.fg_dark }
  hl.IblScope = { fg = p.accent_bright }

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
  hl.BlinkCmpLabelMatch = { fg = p.accent_bright, bold = true }
  hl.BlinkCmpKind = { fg = p.special }
  hl.BlinkCmpKindFunction = { fg = p.func }
  hl.BlinkCmpKindMethod = { fg = p.func }
  hl.BlinkCmpKindVariable = { fg = p.variable }
  hl.BlinkCmpKindKeyword = { fg = p.keyword }
  hl.BlinkCmpKindText = { fg = p.fg }
  hl.BlinkCmpKindProperty = { fg = p.property }
  hl.BlinkCmpKindUnit = { fg = p.number }
  hl.BlinkCmpKindClass = { fg = p.variable_def }
  hl.BlinkCmpKindInterface = { fg = p.variable_def }
  hl.BlinkCmpKindStruct = { fg = p.variable_def }
  hl.BlinkCmpKindEnum = { fg = p.variable_def }
  hl.BlinkCmpKindEnumMember = { fg = p.number }
  hl.BlinkCmpKindConstant = { fg = p.number }
  hl.BlinkCmpKindModule = { fg = p.namespace }
  hl.BlinkCmpKindField = { fg = p.property }
  hl.BlinkCmpKindSnippet = { fg = p.comment }
  hl.BlinkCmpKindColor = { fg = p.string_escape }
  hl.BlinkCmpKindFile = { fg = p.fg }
  hl.BlinkCmpKindFolder = { fg = p.accent_bright }

  -- rainbow delimiters
  hl.RainbowDelimiterRed = { fg = p.keyword }
  hl.RainbowDelimiterYellow = { fg = p.variable_def }
  hl.RainbowDelimiterBlue = { fg = p.number }
  hl.RainbowDelimiterOrange = { fg = p.variable_def }
  hl.RainbowDelimiterGreen = { fg = p.type }
  hl.RainbowDelimiterViolet = { fg = p.func }
  hl.RainbowDelimiterCyan = { fg = p.accent_bright }

  return hl
end

return M
