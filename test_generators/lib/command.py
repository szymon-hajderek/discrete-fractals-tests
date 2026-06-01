from typing import Callable
from sys import argv
_commands = {}

def command(f: Callable):
  _commands[f.__name__] = f

def run():
  assert len(argv) == 2, f"Usage: python3 {__name__} '[command_name]'"
  cmd_name = argv[1]

  assert "gen_n" in _commands, "Missing required function: print_n"
  assert "gen_stdin" in _commands, "Missing required function: print_stdin"
  assert cmd_name in _commands, f"Command '{cmd_name}' not found."

  _commands[cmd_name]()