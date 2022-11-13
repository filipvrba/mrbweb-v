module main

#flag -L/home/filip/.local/lib/mruby-3.1.0/build/host/lib -I/home/filip/.local/lib/mruby-3.1.0/include -I/home/filip/.local/lib/mruby-3.1.0/build/host/include -I/home/filip/.local/lib/mruby-3.1.0/mrbgems/mruby-time/include -I/home/filip/.local/lib/mruby-3.1.0/mrbgems/mruby-io/include -lm /home/filip/.local/lib/mruby-3.1.0/build/host/lib/libmruby.a -lm
#include "mruby.h"
#include "mruby/compile.h"

struct C.RClass {
}

struct C.mrb_state {
	object_class &C.RClass
}

struct C.mrb_value {
	w &char
}

struct C.mrb_kwargs {
}

type Func_t = fn (&C.mrb_state, C.mrb_value) C.mrb_value
type Aspec  = u32
type Args_format = &char
type Mrb_int = int

fn C.MRB_ARGS_NONE() Aspec
// fn C.MRB_ARGS_REQ(n) Aspec
fn C.MRB_ARGS_OPT(n_one Aspec) Aspec

fn C.mrb_open() &C.mrb_state
fn C.mrb_load_string(mrb &C.mrb_state, s &char) C.mrb_value
fn C.mrb_close(mrb &C.mrb_state)
fn C.mrb_define_class(mrb &C.mrb_state, name &char, super &C.RClass) &C.RClass
fn C.mrb_define_class_method(mrb_state &C.mrb_state, cla &C.RClass, name &char, fun Func_t, aspec Aspec) voidptr
fn C.mrb_get_args(mrb &C.mrb_state, format Args_format, value &C.mrb_kwargs) Mrb_int

fn mrb_code(code string, func_p_result Func_t) {
	mut mrb := C.mrb_open()
	mut obj_class := C.mrb_define_class(mrb, "Mrb".str, mrb.object_class)
	C.mrb_define_class_method(mrb, obj_class, 'p_result'.str, func_p_result, C.MRB_ARGS_NONE())

	C.mrb_load_string(mrb, code.str)
	C.mrb_close(mrb)
}
