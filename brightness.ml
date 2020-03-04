open Core
open Shexp_process

(* todo: make this overridable from the environment *)
let brightness_file = "/sys/class/backlight/intel_backlight/brightness"

type args =
  | Read
  | Set of int
  | Error of string

let read_amount amount =
  match int_of_string_opt amount with
  | None -> Error amount
  | Some number ->
     if number <= 900 && number >= 50
     then Set number
     else Error (Printf.sprintf "%d is out of range [50..900]" number)

let parse_args () =
  match Array.length Sys.argv with
  | 1 -> Read
  | 2 -> read_amount (Array.get Sys.argv 1)
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
