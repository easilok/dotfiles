-- install arduino-language-server https://github.com/arduino/arduino-language-server
-- require'lspconfig'.arduino_language_server.setup{}

local lspconfig = require'lspconfig'
lspconfig.arduino_language_server.setup({
	cmd =  {
		-- Required
		"arduino-language-server",
		"-cli-config", "~/.arduino15/arduino-cli.yaml",
		-- Optional
		"-cli", "/usr/bin/arduino-cli",
		"-clangd", "/usr/bin/clangd"
	}
})

