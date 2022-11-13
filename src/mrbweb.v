module main

import vweb
import os

const (
    public_dir = 'public'
)

struct App {
    vweb.Context
mut:
    code_result string
}

fn main() {
	vweb.run_at(new_app(), vweb.RunParams{
        port: 8081
    }) or { panic(err) }
}

fn new_app() &App {
    mut app := &App{}
    dir_path := os.resource_abs_path('../$public_dir')
    app.mount_static_folder_at(dir_path, '/$public_dir')

    return app
}
