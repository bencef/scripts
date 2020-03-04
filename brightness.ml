open Core
open Shexp_process

type args =
  | Read
  | Set of int
  | Error of string

let parse_args () =
  match Array.length Sys.argv with
  | 1 -> Read
  | 2 -> Set 500
  | _ -> Error "Too many arguments"

let read_brightness () =
  echo "read brightness"

let set_brightness amount =
  let output = Printf.sprintf "setting brightness to %d" amount in
  echo output

let main: unit t =
  match parse_args () with
  | Read -> read_brightness ()
  | Set amount -> set_brightness amount
  | Error args -> eprintf "Wrong argument: %s" args

let () =
  Util.wrap_main main
