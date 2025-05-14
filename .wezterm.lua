local wezterm = require 'wezterm'
local config = wezterm.config_builder()

--
-- STATIC CONFIGURATION
--
local options = {
    debug = false,
    japanese_support = true,
}

local platform = "unknown"
if string.find(wezterm.target_triple, "windows") then
    platform = "windows"
elseif string.find(wezterm.target_triple, "darwin") then
    platform = "macos"
elseif string.find(wezterm.target_triple, "linux") then
    platform = "linux"
end

config.default_prog = (function()
    if platform == "windows" then
        return { "pwsh.exe" }
    else
        return nil
    end
end)()

config.automatically_reload_config = true

--
-- UI
--
config.enable_tab_bar = true
config.enable_scroll_bar = true

config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.window_background_opacity = 0.75
config.window_background_gradient = {
    orientation = 'Vertical',
    colors = { '#000000' },
    interpolation = 'Linear',
    blend = 'Rgb'
}

-- use fancy tab
config.use_fancy_tab_bar = true

if config.use_fancy_tab_bar then
    -- FANCY
    config.window_frame = {
        -- font_size = 14.0,

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
else
    local SOLID_CLOSE = "×"
    local SOLID_MAXIMIZE = "▢"
    local SOLID_HIDE = "-"

    -- works only in non-fancy tab
    config.tab_max_width = 32

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
end

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

config.window_padding = {
    left = 0,
    right = 4,
    top = 4,
    bottom = 0
}

config.prefer_egl = false

-- Fonts
config.font = wezterm.font_with_fallback({
    { family = "CaskaydiaCove Nerd Font Mono" },
    -- <built-in>
    { family = "JetBrains Mono" },
    -- <built-in>
    { family = "Noto Color Emoji" },
    -- M+
    { family = "M PLUS 1 Code" },
})
config.warn_about_missing_glyphs = false

-- for FontAwesome
config.allow_square_glyphs_to_overflow_width = "WhenFollowedBySpace"
config.unicode_version = 15
--
-- Key Configuration
--
local keys = {
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
}

if platform == "windows" then
    table.insert(keys, {
        key = "!",
        mods = "SHIFT|CTRL",
        action = wezterm.action {
            SpawnCommandInNewTab = {
                args = { "wsl", "--cd", "~" }
            }
        }
    })
end

config.keys = keys

if options.debug then
    config.debug_key_events = false
end

--
-- MISC
--
if options.japanese_support then
    -- IME (Japanese support)
    config.use_ime = true
    config.allow_win32_input_mode = true
    config.macos_forward_to_ime_modifier_mask = "SHIFT|CTRL"
end

return config
