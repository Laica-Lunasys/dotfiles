local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- System
default_prog = null
if string.find(wezterm.target_triple, "windows") then
    default_prog = { "pwsh.exe" }
end
config.default_prog = default_prog

config.automatically_reload_config = true

-- IME (Japanese support)
config.use_ime = true
config.allow_win32_input_mode = true
config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"

-- UI
config.enable_tab_bar = true
config.enable_scroll_bar = true

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.75
config.window_background_gradient = {
    -- Can be "Vertical" or "Horizontal".  Specifies the direction
    -- in which the color gradient varies.  The default is "Horizontal",
    -- with the gradient going from left-to-right.
    -- Linear and Radial gradients are also supported; see the other
    -- examples below
    orientation = 'Vertical',

    -- Specifies the set of colors that are interpolated in the gradient.
    -- Accepts CSS style color specs, from named colors, through rgb
    -- strings and more
    colors = { '#000000' },

    -- Instead of specifying `colors`, you can use one of a number of
    -- predefined, preset gradients.
    -- A list of presets is shown in a section below.
    -- preset = "Warm",

    -- Specifies the interpolation style to be used.
    -- "Linear", "Basis" and "CatmullRom" as supported.
    -- The default is "Linear".
    interpolation = 'Linear',

    blend = 'Rgb'
}

config.window_padding = {
    left = 0,
    -- This will become the scrollbar width if you have enabled the scrollbar!
    right = 4,

    top = 4,
    bottom = 0
}

-- Theme
-- config.color_scheme = 'Macintosh (base16)'
-- config.color_scheme = 'Mathias'
-- config.color_scheme = 'MaterialDark'
-- config.color_scheme = 'midnight-in-mojave'

-- Font
config.font = wezterm.font_with_fallback({
    -- <built-in>
    "JetBrains Mono",

    -- <built-in>
    "Noto Color Emoji",

    -- <built-in>
    "Symbols Nerd Font Mono",

    -- M+
    "M+ 1p"
})

config.font_size = 12.0
-- config.custom_block_glyphs = true
-- config.allow_square_glyphs_to_overflow_width = "Always"
-- config.freetype_load_target = "Light"
-- config.freetype_load_flags = "NO_AUTOHINT"

-- 最大化 → ウィンドウタイトルドラッグ時にウィンドウが消えるのでfalse
-- って思ったけど関係なさそう。
config.prefer_egl = false

--------------
-- Key bind --
--------------
config.keys = {
    {
        key = ' ',
        mods = 'SHIFT|CTRL',
        action = wezterm.action.QuickSelect
    },
    {
        key = "{",
        mods = "SHIFT|ALT",
        action = wezterm.action {
            ActivateTabRelative = -1
        }
    },
    {
        key = "}",
        mods = "SHIFT|ALT",
        action = wezterm.action {
            ActivateTabRelative = 1
        }
    },
    {
        key = "!",
        mods = "SHIFT|CTRL",
        action = wezterm.action {
            SpawnCommandInNewTab = {
                args = { "wsl", "--cd", "~" }
            }
        }
    }
}
config.debug_key_events = false

---------------
-- UI Custom --
---------------

-- works only in non-fancy tab
config.tab_max_width = 32

-- use fancy tab
config.use_fancy_tab_bar = true

-- FANCY
config.window_frame = {
    font_size = 10.0,

    active_titlebar_fg = "#ffffff",
    active_titlebar_bg = 'rgba(0% 0% 0% 0%)',

    inactive_titlebar_fg = "#cccccc",
    inactive_titlebar_bg = 'rgba(0% 0% 0% 0%)',

    inactive_titlebar_border_bottom = "#000000",
    active_titlebar_border_bottom = "#000000",
    button_fg = "#cccccc",
    button_bg = "#2b2042",
    button_hover_fg = "#ffffff",
    button_hover_bg = "#3b3052"
}

config.colors = {
    background = 'rgba(0% 0% 0% 100%)',
    scrollbar_thumb = "rgba(70% 70% 70% 10%)",

    -- Cursor
    cursor_bg = 'rgba(70% 70% 70% 40%)',
    cursor_fg = "#000000",
    cursor_border = "rgba(70% 70% 70% 20%)",

    -- Selection
    -- the foreground color of selected text
    selection_fg = "none",
    -- the background color of selected text
    selection_bg = "rgba(50% 50% 50% 50%)",
    compose_cursor = "orange",

    tab_bar = {
        inactive_tab_edge = 'rgba(0% 0% 0% 0%)',
        background = 'rgba(0% 0% 0% 85%)',
        active_tab = {
            bg_color = 'rgba(0% 0% 0% 0%)',
            fg_color = '#AAAAAA',
            intensity = 'Bold',
        },
        inactive_tab = {
            bg_color = 'rgba(0% 0% 0% 0%)',
            fg_color = '#505050'
        },
        new_tab = {
            bg_color = 'rgba(0% 0% 0% 0%)',
            fg_color = '#808080'
        }
    }
}

wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
    local edge_background = config.colors.tab_bar.inactive_tab.bg_color
    local edge_foreground = config.colors.tab_bar.inactive_tab.fg_color

    local background = config.colors.tab_bar.inactive_tab.bg_color
    local foreground = config.colors.tab_bar.inactive_tab.fg_color

    if tab.is_active then
        background = config.colors.tab_bar.active_tab.bg_color
        foreground = config.colors.tab_bar.active_tab.fg_color
    elseif hover then
        background = config.colors.tab_bar.active_tab.bg_color
        foreground = config.colors.tab_bar.active_tab.fg_color
    end

    local title = tab_title(tab)

    -- ensure that the titles fit in the available space,
    -- and that we have room for the edges.
    title = wezterm.truncate_right(title, max_width - 2)

    return {
        {
            Background = {
                Color = edge_background
            }
        },
        {
            Foreground = {
                Color = edge_foreground
            }
        },
        {
            Text = " "
        },
        {
            Background = {
                Color = background
            }
        },
        {
            Foreground = {
                Color = foreground
            }
        },
        {
            Text = string.format("%d: %s", tab.tab_index + 1, title)
        },
        {
            Background = {
                Color = edge_background
            }
        },
        {
            Foreground = {
                Color = edge_foreground
            }
        },
        {
            Text = " "
        }
    }
end)

-- CLASSIC: TITLE BAR CONFIG
local SOLID_CLOSE = "×"
local SOLID_MAXIMIZE = "▢"
local SOLID_HIDE = "-"

config.tab_bar_style = {
    window_close = wezterm.format {
        {
            Text = '  ' .. SOLID_CLOSE .. '  '
        }
    },
    window_close_hover = wezterm.format {
        {
            Attribute = {
                Italic = false
            }
        },
        {
            Background = {
                Color = '#E81123'
            }
        },
        {
            Foreground = {
                Color = '#FFFFFF'
            }
        },
        {
            Text = '  ' .. SOLID_CLOSE .. '  '
        }
    },

    window_maximize = wezterm.format {
        {
            Text = '  ' .. SOLID_MAXIMIZE .. '  '
        }
    },
    window_maximize_hover = wezterm.format {
        {
            Attribute = {
                Italic = false
            }
        },
        {
            Text = '  ' .. SOLID_MAXIMIZE .. '  '
        }
    },

    window_hide = wezterm.format {
        {
            Text = '  ' .. SOLID_HIDE .. '  '
        }
    },
    window_hide_hover = wezterm.format {
        {
            Attribute = {
                Italic = false
            }
        },
        {
            Text = '  ' .. SOLID_HIDE .. '  '
        }
    }
}

return config
