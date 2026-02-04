# Contributing to dbtools

Thanks for your interest in contributing to dbtools! This document provides guidelines for contributing.

## Getting Started

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/db_tools.git
   cd db_tools
   ```
3. Make scripts executable:
   ```bash
   chmod +x dbtools.sh scripts/*.sh
   ```

## Project Structure

```
dbtools/
├── dbtools.sh           # Main entry point (auto-discovers scripts)
├── scripts/
│   ├── dump.sh          # Database dump command
│   ├── restore.sh       # Database restore command
│   └── update.sh        # Self-update command
├── get.sh               # Remote installer (curl one-liner)
├── install.sh           # Local installer
├── AGENTS.md            # Guidelines for AI coding agents
└── SKILL.md             # Detailed guide for adding new tools
```

## Adding a New Command

1. Create a new file in `scripts/` folder:
   ```bash
   touch scripts/mycommand.sh
   chmod +x scripts/mycommand.sh
   ```

2. Follow this template:
   ```bash
   #!/bin/bash
   # @description Short description here (REQUIRED - line 2)
   # @category Database

   show_help() {
       echo "Usage: dbtools mycommand [OPTIONS]"
       # ...
   }

   # Your code here
   ```

3. The command is automatically discovered - test with:
   ```bash
   ./dbtools.sh mycommand --help
   ```

See `SKILL.md` for a complete template and detailed guidelines.

## Code Style

- **Variables**: `UPPER_SNAKE_CASE` for globals, `lower_snake_case` with `local` for function variables
- **Functions**: `lower_snake_case`
- **Indentation**: 4 spaces
- **Quotes**: Always quote variables (`"$VAR"` not `$VAR`)
- **Line length**: Keep under 100 characters when possible

### Standard CLI Options

All database commands should support:

| Short | Long | Description |
|-------|------|-------------|
| `-u` | `--user` | Database username |
| `-p` | `--password` | Database password |
| `-h` | `--host` | Database host |
| `-P` | `--port` | Database port |
| `-d` | `--database` | Database name |
| | `--help` | Show help message |

## Testing Your Changes

```bash
# Check syntax
bash -n dbtools.sh
bash -n scripts/mycommand.sh

# Test help output
./dbtools.sh --help
./dbtools.sh mycommand --help

# Run shellcheck (if installed)
shellcheck dbtools.sh scripts/*.sh
```

## Submitting Changes

1. Create a feature branch:
   ```bash
   git checkout -b feature/my-new-command
   ```

2. Make your changes and commit:
   ```bash
   git add .
   git commit -m "Add mycommand for doing X"
   ```

3. Push and create a Pull Request:
   ```bash
   git push origin feature/my-new-command
   ```

4. In your PR description, include:
   - What the change does
   - Why it's needed
   - How to test it

## Reporting Bugs

When reporting bugs, please include:

- Your OS and Bash version (`bash --version`)
- MySQL client version (`mysql --version`)
- Steps to reproduce
- Expected vs actual behavior
- Any error messages

## Feature Requests

Feature requests are welcome! Please check `TODO.md` first to see if it's already planned. When requesting a feature:

- Describe the use case
- Explain why existing commands don't solve the problem
- Provide examples of expected usage

## Questions?

Feel free to open an issue for any questions about contributing.

---

Thank you for contributing!
