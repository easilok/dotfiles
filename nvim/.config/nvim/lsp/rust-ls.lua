-- install following https://rust-analyzer.github.io/manual.html#rust-analyzer-language-server-binary
local branch = "stable"
-- branch = "nightly"
require'lspconfig'.rust_analyzer.setup({
    -- cmd = { "rustup", "run", "nightly", "rust-analyzer" }
    cmd = { "rustup", "run", branch, "rust-analyzer" }
})
