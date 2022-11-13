module main

import vweb

// arg &C.mrb_kwargs this is crucial for given method arguments!
fn (mut a App) func_p_result (mrb &C.mrb_state, self C.mrb_value) C.mrb_value {
	a.code_result += "[C] fn p_result\n"
	return self
}

['/']
pub fn(mut app App) page_home() vweb.Result {
	code := app.query['code']
	unsafe {
		mrb_code(code, app.func_p_result)
	}
	mut code_result := app.code_result
	return $vweb.html()
}
