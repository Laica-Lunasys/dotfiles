local status, ts = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

ts.setup {
    highlight = {
        enable = true,
        disable = {},
        additional_vim_regex_highlighting = true,
    },
    indent = {
        enable = true,
        disable = {},
    },
    -- ensure_installed = "all",
    ensure_installed = {
        "bash",
        "c",
        "c_sharp",
        "cpp",
        "go",
        "gomod",
        "graphql",
        "hcl",
        "java",
        "jsonnet",
        "python",
        "tsx",
        "toml",
        "fish",
        "php",
        "proto",
        "json",
        "yaml",
        "css",
        "html",
        "lua"
    },
    autotag = {
        enable = true,
    },
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
