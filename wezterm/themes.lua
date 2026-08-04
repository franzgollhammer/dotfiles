-- Color schemes ported 1:1 from ghostty/themes/ so both terminals look identical.
-- Ghostty's `palette = 0..7` maps to `ansi`, `8..15` maps to `brights`.
-- Keep this file in sync when a ghostty theme changes.

return {
  ['xterm-dark'] = {
    background = '#000000',
    foreground = '#ffffff',
    cursor_bg = '#ffffff',
    cursor_fg = '#000000',
    cursor_border = '#ffffff',
    ansi = {
      '#000000', '#cd0000', '#00cd00', '#cdcd00',
      '#0000ee', '#cd00cd', '#00cdcd', '#e5e5e5',
    },
    brights = {
      '#7f7f7f', '#ff0000', '#00ff00', '#ffff00',
      '#5c5cff', '#ff00ff', '#00ffff', '#ffffff',
    },
  },

  ['xterm-light'] = {
    background = '#ffffff',
    foreground = '#000000',
    cursor_bg = '#000000',
    cursor_fg = '#ffffff',
    cursor_border = '#000000',
    ansi = {
      '#000000', '#cd0000', '#00cd00', '#cdcd00',
      '#0000ee', '#cd00cd', '#00cdcd', '#e5e5e5',
    },
    brights = {
      '#7f7f7f', '#ff0000', '#00ff00', '#ffff00',
      '#5c5cff', '#ff00ff', '#00ffff', '#ffffff',
    },
  },

  -- Matches the fzf palette in fzf/ — pick this pair to keep fzf popups
  -- visually flush with the terminal background.
  ['steel-dark'] = {
    background = '#121314',
    foreground = '#bbbebf',
    cursor_bg = '#bfbfbf',
    cursor_fg = '#121314',
    cursor_border = '#bfbfbf',
    selection_bg = '#264b5d',
    selection_fg = '#bbbebf',
    ansi = {
      '#1e1f20', '#c86971', '#72c892', '#cd861a',
      '#3994bc', '#c184c6', '#48c9c4', '#bbbebf',
    },
    brights = {
      '#858889', '#f48771', '#86cf86', '#e5ba7d',
      '#90d5ff', '#ad80d7', '#6edcd7', '#e5e5e5',
    },
  },

  ['steel-light'] = {
    background = '#ffffff',
    foreground = '#333333',
    cursor_bg = '#202020',
    cursor_fg = '#ffffff',
    cursor_border = '#202020',
    selection_bg = '#b3d4fc',
    selection_fg = '#202020',
    ansi = {
      '#000000', '#cd3131', '#107c10', '#949800',
      '#0451a5', '#bc05bc', '#0598bc', '#555555',
    },
    brights = {
      '#666666', '#cd3131', '#14ce14', '#b5ba00',
      '#0451a5', '#bc05bc', '#0598bc', '#a5a5a5',
    },
  },
}
