// Python course content, embedded as a Swift string.
let pythonFoundationsJSON = #"""
{
  "id": "python-foundations",
  "language": "python",
  "title": "Python Foundations",
  "subtitle": "Learn the basics by building a tip calculator, one piece at a time.",
  "capstone": "Tip Calculator",
  "capstoneCode": "def calculate_tip(bill, percent=0.10):\n    tip = bill * percent\n    return tip\n\nrating = 5\npercent = 0.10\nif rating >= 4:\n    percent = 0.20\n\nmeals = {\"Pasta\": 24.0, \"Steak\": 38.5}\nfor name, price in meals.items():\n    tip = calculate_tip(price, percent)\n    print(f\"{name}: tip ${tip:.2f}\")",
  "lessons": [
    {
      "id": "p1",
      "title": "Variables",
      "buildNote": "Your calculator now stores the bill amount.",
      "steps": [
        {
          "id": "p1s1",
          "kind": "learn",
          "title": "Variables in Python",
          "body": "A **variable** stores a value. In Python you write a name, `=`, then the value. No keyword needed.",
          "code": "bill_amount = 84.50\nprint(bill_amount)"
        },
        {
          "id": "p1s2",
          "kind": "gapFill",
          "title": "Name it",
          "body": "Fill in the blank so the variable is called `bill_amount`.",
          "code": "___ = 84.50",
          "options": [
            "bill_amount",
            "print",
            "def",
            "84.50"
          ],
          "answers": [
            "bill_amount"
          ]
        },
        {
          "id": "p1s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Create a variable named `bill_amount` set to `84.50`.",
          "answers": [
            "bill_amount = 84.50",
            "bill_amount = 84.5"
          ],
          "hint": "Name, equals sign, value."
        }
      ]
    },
    {
      "id": "p2",
      "title": "Numbers & maths",
      "buildNote": "It can now work out a tip from a percentage.",
      "steps": [
        {
          "id": "p2s1",
          "kind": "learn",
          "title": "Maths in Python",
          "body": "Python uses `+`, `-`, `*` and `/`. Multiply the bill by the tip percentage to get the tip.",
          "code": "total = 50.0 * 0.2"
        },
        {
          "id": "p2s2",
          "kind": "reorder",
          "title": "Order matters",
          "body": "Put the lines in order. A variable must exist before you use it.",
          "lines": [
            "bill_amount = 84.50",
            "tip_percent = 0.15",
            "tip = bill_amount * tip_percent"
          ]
        },
        {
          "id": "p2s3",
          "kind": "fixBug",
          "title": "Fix the bug",
          "body": "The tip should be the bill **multiplied** by the percentage. Fix the code.",
          "code": "tip_percent = 0.15\ntip = bill_amount + tip_percent",
          "answers": [
            "tip_percent = 0.15\ntip = bill_amount * tip_percent"
          ],
          "hint": "Which operator multiplies?"
        }
      ]
    },
    {
      "id": "p3",
      "title": "Text & print",
      "buildNote": "It now prints a friendly result.",
      "steps": [
        {
          "id": "p3s1",
          "kind": "learn",
          "title": "f-strings",
          "body": "Put a value inside text with an **f-string**: start the text with `f` and wrap the value in `{ }`.",
          "code": "name = \"Sam\"\nprint(f\"Hi {name}\")"
        },
        {
          "id": "p3s2",
          "kind": "gapFill",
          "title": "Show the tip",
          "body": "Fill in the blank so the message shows the tip.",
          "code": "print(f\"Tip: ${___}\")",
          "options": [
            "tip",
            "bill_amount",
            "print",
            "f"
          ],
          "answers": [
            "tip"
          ]
        },
        {
          "id": "p3s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Print `Tip: $` followed by the `tip` value using an f-string.",
          "answers": [
            "print(f\"Tip: ${tip}\")"
          ],
          "hint": "print(f\"... {value}\")"
        }
      ]
    },
    {
      "id": "p4",
      "title": "Functions",
      "buildNote": "Your calculator is now reusable with a function.",
      "steps": [
        {
          "id": "p4s1",
          "kind": "learn",
          "title": "Reusable code",
          "body": "A **function** packages code you can run again. Use `def`, a name, parameters and a colon, then an **indented** body.",
          "code": "def double(n):\n    return n * 2\n\nprint(double(4))"
        },
        {
          "id": "p4s2",
          "kind": "reorder",
          "title": "Build the function",
          "body": "Put the function in order. The indented lines belong to the function.",
          "lines": [
            "def calculate_tip(bill, percent):",
            "    tip = bill * percent",
            "    return tip"
          ]
        },
        {
          "id": "p4s3",
          "kind": "write",
          "title": "Call it",
          "body": "Create a variable `tip` by calling `calculate_tip` with `bill_amount` and `0.15`.",
          "answers": [
            "tip = calculate_tip(bill_amount, 0.15)"
          ],
          "hint": "Call it like double(4), but with two values."
        }
      ]
    },
    {
      "id": "p5",
      "title": "Decisions",
      "buildNote": "Your calculator now picks the tip size from a rating.",
      "steps": [
        {
          "id": "p5s1",
          "kind": "learn",
          "title": "Making decisions",
          "body": "An `if` runs code only when its condition is true. It ends with a **colon**, and the code inside is **indented**.",
          "code": "rating = 5\nif rating >= 4:\n    print(\"Great service!\")"
        },
        {
          "id": "p5s2",
          "kind": "gapFill",
          "title": "Pick the condition",
          "body": "Great service (a rating of **4 or more**) earns the bigger tip. Fill in the operator.",
          "code": "if rating ___ 4:\n    percent = 0.20",
          "options": [
            ">=",
            "==",
            "=",
            "<"
          ],
          "answers": [
            ">="
          ]
        },
        {
          "id": "p5s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write an `if` statement that sets `percent` to `0.20` when `rating` is 4 or more.",
          "answers": [
            "if rating >= 4:\n    percent = 0.20",
            "if rating >= 4:\n    percent = 0.2"
          ],
          "hint": "Don't forget the colon and the indent."
        }
      ]
    },
    {
      "id": "p6",
      "title": "Lists",
      "buildNote": "It can now hold a whole list of bills.",
      "steps": [
        {
          "id": "p6s1",
          "kind": "learn",
          "title": "Lists of values",
          "body": "A **list** holds several values in order. Use square brackets and commas. Counting starts at **0**, and `len()` tells you how many items there are.",
          "code": "bills = [42.0, 84.50, 19.99]\nprint(bills[0])\nprint(len(bills))"
        },
        {
          "id": "p6s2",
          "kind": "gapFill",
          "title": "Get the first bill",
          "body": "Lists count from 0. Fill in the blank to get the **first** bill.",
          "code": "first = bills[___]",
          "options": [
            "0",
            "1",
            "3",
            "first"
          ],
          "answers": [
            "0"
          ]
        },
        {
          "id": "p6s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Create a variable named `bills` holding `42.0`, `84.50` and `19.99`.",
          "answers": [
            "bills = [42.0, 84.50, 19.99]",
            "bills = [42.0, 84.5, 19.99]",
            "bills = [42, 84.50, 19.99]",
            "bills = [42, 84.5, 19.99]"
          ],
          "hint": "name = [a, b, c]"
        }
      ]
    },
    {
      "id": "p7",
      "title": "Loops",
      "buildNote": "It now works out a tip for every bill in the list.",
      "steps": [
        {
          "id": "p7s1",
          "kind": "learn",
          "title": "Repeating things",
          "body": "A **for loop** runs code once for each item in a collection. Like `if`, it ends with a colon and indents its body.",
          "code": "names = [\"Sam\", \"Alex\"]\nfor name in names:\n    print(f\"Hi {name}\")"
        },
        {
          "id": "p7s2",
          "kind": "reorder",
          "title": "Build the loop",
          "body": "Put the loop in order. The indented lines run once per bill.",
          "lines": [
            "for bill in bills:",
            "    tip = calculate_tip(bill, percent)",
            "    print(f\"Tip: ${tip}\")"
          ]
        },
        {
          "id": "p7s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write a `for` loop over `bills` that prints each `bill`. Call the current item `bill`.",
          "answers": [
            "for bill in bills:\n    print(bill)"
          ],
          "hint": "for item in collection:"
        }
      ]
    },
    {
      "id": "p8",
      "title": "Dictionaries",
      "buildNote": "Each bill now has a name attached.",
      "steps": [
        {
          "id": "p8s1",
          "kind": "learn",
          "title": "Pairs of values",
          "body": "A **dictionary** stores pairs: a key and its value. Look a value up by its key.",
          "code": "meals = {\"Pasta\": 24.0, \"Steak\": 38.5}\nprint(meals[\"Pasta\"])"
        },
        {
          "id": "p8s2",
          "kind": "gapFill",
          "title": "Look it up",
          "body": "Fill in the blank to get the price of the steak.",
          "code": "print(meals[___])",
          "options": [
            "\"Steak\"",
            "\"Pasta\"",
            "0",
            "meals"
          ],
          "answers": [
            "\"Steak\""
          ]
        },
        {
          "id": "p8s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Create a dictionary named `meals` with `Pasta` costing `24.0` and `Steak` costing `38.5`.",
          "answers": [
            "meals = {\"Pasta\": 24.0, \"Steak\": 38.5}",
            "meals = {\"Pasta\": 24.0, \"Steak\": 38.50}",
            "meals = {\"Pasta\": 24, \"Steak\": 38.5}",
            "meals = {\"Pasta\": 24, \"Steak\": 38.50}",
            "meals = {'Pasta': 24.0, 'Steak': 38.5}",
            "meals = {'Pasta': 24.0, 'Steak': 38.50}",
            "meals = {'Pasta': 24, 'Steak': 38.5}",
            "meals = {'Pasta': 24, 'Steak': 38.50}"
          ],
          "hint": "name = {\"key\": value, \"key\": value}"
        }
      ]
    },
    {
      "id": "p9",
      "title": "Formatting numbers",
      "buildNote": "Tips now print as tidy dollar amounts.",
      "steps": [
        {
          "id": "p9s1",
          "kind": "learn",
          "title": "Tidy numbers",
          "body": "In an f-string, add `:.2f` after a value to show exactly 2 decimal places.",
          "code": "tip = 12.675\nprint(f\"Tip: ${tip:.2f}\")"
        },
        {
          "id": "p9s2",
          "kind": "gapFill",
          "title": "How many decimals?",
          "body": "Fill in the blank to show 2 decimal places.",
          "code": "print(f\"Tip: ${tip:___}\")",
          "options": [
            ".2f",
            ".2",
            ".f",
            "2f"
          ],
          "answers": [
            ".2f"
          ]
        },
        {
          "id": "p9s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Print `Tip: $` followed by `tip` with 2 decimal places, using an f-string.",
          "answers": [
            "print(f\"Tip: ${tip:.2f}\")"
          ],
          "hint": "Use {tip:.2f} inside the f-string."
        }
      ]
    },
    {
      "id": "p10",
      "title": "Default values",
      "buildNote": "Calculating a tip now works without choosing a percentage.",
      "steps": [
        {
          "id": "p10s1",
          "kind": "learn",
          "title": "Defaults",
          "body": "A parameter can have a **default value**. If the caller leaves it out, the default is used.",
          "code": "def calculate_tip(bill, percent=0.10):\n    tip = bill * percent\n    return tip\n\nprint(calculate_tip(50))"
        },
        {
          "id": "p10s2",
          "kind": "reorder",
          "title": "Build the function",
          "body": "Put the function in order.",
          "lines": [
            "def calculate_tip(bill, percent=0.10):",
            "    tip = bill * percent",
            "    return tip"
          ]
        },
        {
          "id": "p10s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Print the result of calling `calculate_tip` for a bill of `50`, without giving a percentage.",
          "answers": [
            "print(calculate_tip(50))",
            "print(calculate_tip(50.0))"
          ],
          "hint": "Pass only the bill."
        }
      ]
    }
  ]
}
"""#
