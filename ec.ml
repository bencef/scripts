open Core
open Shexp_process
open Shexp_process.Let_syntax

let files =
  match Array.to_list Sys.argv with
  | _ :: rest -> rest
  | _ -> assert false


let main: unit t =
  let%bind emacs_client = Util.command_exn "emacsclient" in
  let open Base in
  emacs_client (List.append ["-ca"; ""] files)

let () = Util.wrap_main main
