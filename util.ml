open Core
open Shexp_process
open Shexp_process.Let_syntax

let command_exn (name: string) =
  let%map path = find_executable_exn name in
  fun args -> run path args

let wrap_main main =
  try
    eval main
  with
  | Failure error -> Out_channel.fprintf stderr "FATAL ERROR: %s\n" error
  | other -> raise other
