open Shexp_process
open Shexp_process.Let_syntax

let main: unit t =
  let%bind tr = Util.command_exn "tr" in
  echo "hello" |- tr ["h"; "H"]

let () = Util.wrap_main main
