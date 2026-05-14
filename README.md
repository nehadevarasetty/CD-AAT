Lexical Analyzer using Lex and Yacc

This project implements a lexical analyzer for a subset of the C programming language using Lex and Yacc.

Project Files

File	Description
lexer.l	Lex specification for tokenizing input
parser.y	Yacc grammar and token definitions
Makefile	Build automation file
test_input.c	Sample input C program

⸻

Running the Project on macOS

Prerequisites

Install the following:

* Xcode Command Line Tools OR Homebrew
* Lex/Flex
* Yacc/Bison
* GCC

Option 1: Using Homebrew (Recommended)

Install Homebrew

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

Install Flex and Bison

brew install flex bison

Verify Installation

lex --version
bison --version

⸻

Build the Project

Run the following commands inside the project directory:

lex lexer.l
bison -dy parser.y
gcc y.tab.c lex.yy.c -o parser

⸻

Run the Program

./parser test_input.c

⸻

Running the Project on Windows

Prerequisites

Install the following:

* MinGW or GCC compiler
* Flex
* Bison

Recommended package:

* WinFlexBison

Download:

https://github.com/lexxmark/winflexbison

⸻

Add WinFlexBison to PATH

After installation, add the installation folder to the system PATH.

Verify installation:

win_flex --version
win_bison --version

⸻

Build the Project

Open Command Prompt inside the project folder and run:

win_flex lexer.l
win_bison -dy parser.y
gcc y.tab.c lex.yy.c -o parser.exe

⸻

Run the Program

parser.exe test_input.c

⸻

Sample Output

The program generates a token table containing:

* Lexeme
* Token Type
* Line Number
* Token Count

Example:

| Lexeme | Token Type |
| int    | KEYWORD    |
| main   | IDENTIFIER |
| =      | ASSIGN_OP  |

⸻

Notes

* Generated files such as lex.yy.c, y.tab.c, y.tab.h, and executables are ignored using .gitignore.
* The project follows the traditional Lex/Yacc workflow.
* Compatible with standard compiler design laboratory environments.
