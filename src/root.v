module main

import vweb

['/']
pub fn(mut app App) page_home() vweb.Result {
	return app.text('root')
}