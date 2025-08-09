;; Use project installed prettier
(set vim.g.neoformat_try_node_exe 1)
(set vim.g.neoformat_enabled_javascript ["prettier"])
(set vim.g.neoformat_enabled_typescript ["prettier"])
(set vim.g.neoformat_enabled_php ["laravelpint"])
(set vim.g.neoformat_python_black { :exe "black"
                                    :stdin 1
                                    :args ["-l 120" "-q" "-"]})

{}
