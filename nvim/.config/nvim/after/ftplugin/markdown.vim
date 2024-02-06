set tw=120

syntax match mdUnckeck "\v- \[ \].*$"
syntax match mdCheck "\v- \[x\].*$"
syntax match mdTodo "\vTODO:"
syntax match mdDone "\vDONE:"

highlight mdTodo guifg=#00ff00
highlight mdUncheck guifg=#00ff00
highlight mdCheck guifg=#4c4c4c
highlight mdDone guifg=#4c4c4c
highlight link mdDone Comment
