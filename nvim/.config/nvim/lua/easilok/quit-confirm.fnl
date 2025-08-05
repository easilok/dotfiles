(fn starts-with [haystack needle]
  "Checks if a string starts with the specific sequence"
  (let [s (string.sub haystack 1 (length needle))]
    (= s needle)))

(fn confirm-and-execute [cmd opts]
  "Ask user confirmation before running a command"
  (let [prompt (or (. opts :prompt) "Are you sure?")
        abort (or (. opts :abort) "Aborted")]
    (vim.ui.input {:prompt (.. prompt " ")}
                  (fn [input]
                    (if (starts-with input "y")
                        (vim.cmd cmd)
                        (print "Aborted."))))))

;; Move to macro
(fn unless-filetype-do [ignored fn-to-run]
  (let [ft (vim.bo.filetype)]
    (when (not (vim.tbl_contains ignored ft))
      (fn-to-run))))

(local ignored-filetypes ["gitcommit"])
(vim.api.nvim_create_user_command "X"
  (fn [_args]
    (let [ft vim.bo.filetype
          cmd "x"]
      (if (vim.tbl_contains ignored-filetypes ft)
          (vim.cmd cmd) ;; fallback to default
          (confirm-and-execute cmd {:prompt "Are you really quitting?"}))))
  {:nargs 0 :desc "Save and quit with user confirmation"})

(vim.api.nvim_create_user_command "XA"
  (fn [_args]
    (let [ft vim.bo.filetype
          cmd "xa"]
      (if (vim.tbl_contains ignored-filetypes ft)
          (vim.cmd cmd) ;; fallback to default
          (confirm-and-execute cmd {:prompt "Are you really quitting?"}))))
  {:nargs 0 :desc "Save all files and quit with user confirmation"})
