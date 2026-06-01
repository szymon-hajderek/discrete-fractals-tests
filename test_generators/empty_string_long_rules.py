from lib.command import command, run

@command # Prints to stdout exactly the characters that are to be passed to the program as n.
def gen_n():
  print(1000000000, end='')

@command # Prints to stdout exactly the characters that are to be passed to the program as stdin.
def gen_stdin():
  print("\n\n" + "a" * 2000000000) # You may want to consider chunking for even bigger files but 2GB ram is ?fine? xd

if __name__ == "__main__":
  run()