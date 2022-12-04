local opt = vim.opt

opt.foldlevel = 200
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
