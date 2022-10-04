local lspconfig = require'lspconfig'
lspconfig.ccls.setup {
  init_options = {
    compilationDatabaseDirectory = "build";
    index = {
      threads = 0;
    };
    clang = {
      excludeArgs = { "-frounding-math"} ;
    };
  }
}

-- vim.cmd [
-- [ autocmd BufWritePre *.css lua vim.lsp.buf.formatting_sync(nil, 100) ] , 
-- [ autocmd BufWritePre *.scss lua vim.lsp.buf.formatting_sync(nil, 100) ]]
