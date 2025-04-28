# What part of the script was hardest to implement and why?

The **hardest** part is the **search loop part** (starting from `while IFS= read -r line`).

---

**Why the search loop is the hardest:**
- manually handled **case-insensitive search** by lowering both search word and line. (`tr 'A-Z' 'a-z'`)
- implemented **invert matching** (need to carefully flip `true/false` flags).
- did **highlighting** using `sed` with color codes (regex replace with `\x1b`).
- added **line numbers** optionally.
- handle **per-line processing** (with correct `IFS= read -r` to avoid issues with spaces and backslashes).