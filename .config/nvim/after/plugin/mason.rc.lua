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
        "efm",
        "eslint",
        "gopls",
        "graphql",
        "html",
        "jsonls",
        "jdtls",
        "jsonnet_ls",
        "kotlin_language_server",
        "marksman",
        -- "powershell_es",
        "pylsp",
        -- "solargraph",
        "rust_analyzer",
        -- "sqlls",
        "sumneko_lua",
        "svelte",
        "taplo",
        "tailwindcss",
        "terraformls",
        "vimls",
        "vuels",
        "lemminx",
        "yamlls",
        "tflint",
    },
    automatic_installation = true,
})
