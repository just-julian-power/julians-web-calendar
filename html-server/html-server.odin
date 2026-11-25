//compile from main directory with odin build cal-write -target:wasi_wasm32 -out:cal_write.wasm

package main

import "core:fmt"
import "core:os"
import "core:log"

main :: proc() {

    context.logger = log.create_console_logger()
    defer log.destroy_console_logger(context.logger)

    path := "message.txt"
    fs, open_err := os.open(path)

    if open_err != nil {
        log.fatal("no file:", path)
    }

    for {
        data := make([]byte, 8) //sets up an 8-byte data slice

        //os.read interprets whatever can fit into 'data' then moves along that many bytes
        n, read_err := os.read(fs,data) 
        if read_err != nil {
            break
        }

        fmt.printf("read: %s\n", data[:8])
    }
}