local status, mason = pcall(require, "mason")
if (not status) then return end

local status2, lspconfig = pcall(require, "mason-lspconfig")
if (not status2) then return end

mason.setup()

lspconfig.setup({
    ensure_installed = {
        -- LSP
        "bashls",
        "clangd",
        "cssls",
        "dockerls",
        "eslint",
        "gopls",
        "graphql",
        "html",
        "jsonls",
        "jdtls",
        "jsonnet_ls",
        "kotlin_language_server",
        "lua-launguage-server",
        "marksman",
        "powershell_es",
        "pylsp",
        "solargraph",
        "rust_analyzer",
        "sqlls",
        "svelte",
        "taplo",
        "tailwindcss",
        "terraformls",
        "tsserver",
        "vimls",
        "vuels",
        "lemminx",
        "yamlls",

        -- Linter
        "buf",
        "flake8",
        "rubocop",
        "tflint",
        "shellcheck",
        "yamllint",

        -- Formatter
        "autopep8",
        "clang-format",
        "goimports",
        "jq",
        "markdownlint",
        "prettier",
        "shfmt",
        "yamlfmt"
    },
    automatic_installation = true,
})
