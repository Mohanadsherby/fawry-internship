# Options Breakdown

### 1. Help Message
- If the user runs:  
  `./mygrep.sh --help`  
  → The script prints usage instructions and exits.

### 2. Argument Check
- If fewer than 2 arguments are provided, the script prints an error and exits.

### 3. Default Options
- Before parsing, it sets:
  ```bash
  show_line_numbers=false
  invert_match=false
  ```

### 4. Parsing Options
- **While** the first argument starts with `-`:
  - If it's `-n`, it enables showing line numbers.
  - If it's `-v`, it enables invert matching.
  - If it's `-nv` or `-vn`, it enables both options together.
  - If any unknown option is provided, it prints an error and exits.
- After parsing, `shift` moves to the next argument, eventually reaching the `search_string` and `filename`.


### 5. Main Variables After Parsing
- `$1` becomes the **search string**.
- `$2` becomes the **filename**.

### 6. File Validation
- Checks if the file exists.
- If not, it prints an error and exits.

---


