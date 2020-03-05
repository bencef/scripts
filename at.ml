open Shexp_process
open Shexp_process.Let_syntax

let usage: unit t = echo "TODO: usage"

let main: unit t =
  let%bind bash_opt = Util.command_opt "bash" in
  let%bind sh_opt = Util.command_opt "sh" in
  let%bind dash_opt = Util.command_opt "dash" in
  (* TODO: make it lazy *)
  let shell_opt = Util.(bash_opt <|> sh_opt <|> dash_opt) in
  match shell_opt with
  | None -> eprint "No suitable shell found."
  | Some shell -> shell ["-c"; "echo hello from the shell"]

let () =
  Util.wrap_main main
