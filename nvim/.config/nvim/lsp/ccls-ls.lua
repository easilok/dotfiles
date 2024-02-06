-- local lspconfig = require'lspconfig'
-- lspconfig.ccls.setup {
--   init_options = {
--     compilationDatabaseDirectory = "build";
--     index = {
--       threads = 0;
--     };
--     clang = {
--       excludeArgs = { "-frounding-math"} ;
--     };
--   },
--   filetypes = {"c", "cpp", "ino", "arduino"}
-- }

require'lspconfig'.clangd.setup{}

