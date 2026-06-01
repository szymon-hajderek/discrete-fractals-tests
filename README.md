# Tests

This directory contains an automated testing framework. It uses a custom hash-based validation system to ensure exact output matching. Cases where *crash* is the expected behaviour are handled as well. The feedback you'll get on each test is just `OK`/`FAIL`.

## -1. Assumptions about the correct solution:
The correct solution outputs nothing but the output sequence.

## 0. Structural overview

The exact script's usages are printed when called with wrong arguments.

* **`test_generators/`**: Python scripts that generate dynamic `.n` and `.stdin` test inputs. You are encouraged to write and share new ones! Test generator's structure is obvious. You'll get it just by looking at any of the examples I've created so far.
* **`tests/`**: The directory for the dynamically generated test files (ignored by Git).
* **`expected_hashes/`**: Contains the *hopefully good* hashes for each test case, along with the script to generate them (the script takes a *hopefully correct* program as an argument).
* **`all.sh`**: The main execution script that compares your program's hashes against the expected hashes.
* **`gen_tests.sh`**: Generates the test data using generators from `./test_generators` directory.
* **`run_test.sh`**: A wrapper script that runs the chosen program on a test with supplied name (for which `.n` and `.stdin` should reside in `tests` directory).
* **`hashed_run_test.sh`**: A wrapper script that safely pipes program output into the hash calculator while catching crashes/exit codes. You can use it to create your own tests.
* **`clean_generated_tests.sh`**: Removes the tests whose names do not end with `*manual.*`.

### 1. Generate the tests:

```bash
./gen_tests.sh
```

### 2. Run the tests:

```bash
./all.sh ../path/to/your/compiled_executable
```

### 3. Adding new tests:

- You can add tests with small input manually to `tests` directory. They should match the format enforced by the generators (The exact contents of the file will be passed - e.g. if `test_name.n` contains a newline character, program will **correctly** crash on such test. Make sure that each character in `test_name.n` is *intentional*.)

- Bigger tests should be preferably generated with generators. To ensure they don't take eternity to finish, you may want to utilize python's optimized string manipulation options (such as `"text" * 1000000`). Ask LLMs for assistance (;

- If you want to quickly add a single test, without regenerating all tests, you may want to call your generator directly (similarly to what is done in `gen_tests.sh`):

```bash
python3 "$test_generator_script" gen_n > "$SCRIPT_DIR/tests/${test_name}.n"
python3 "$test_generator_script" gen_stdin > "$SCRIPT_DIR/tests/${test_name}.stdin"
```

- If you absolutely detest python, you may supply a generator program written in language of your choice and have python run it (e.g. by first calling `make` and then running the compiled file).