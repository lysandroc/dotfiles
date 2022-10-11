require('nvim-magic').setup(
	{
		backends = {
			default = require('nvim-magic-openai').new({
				api_endpoint = 'https://api.openai.com/v1/engines/text-davinci-002/completions',
			}),
		},
		use_default_keymap = true
	}
)


