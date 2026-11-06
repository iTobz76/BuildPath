// The Swift course lives in a Swift string so no bundle resources are needed.
let swiftFoundationsJSON = #"""
{
  "id": "swift-foundations",
  "language": "swift",
  "title": "Swift Foundations",
  "subtitle": "Learn the basics by building a tip calculator, one piece at a time.",
  "capstone": "Tip Calculator",
  "capstoneCode": "import Foundation\n\nstruct Meal {\n    let name: String\n    let price: Double\n}\n\nfunc calculateTip(bill: Double, percent: Double) -> Double {\n    return bill * percent\n}\n\nlet rating: Int? = 5\nvar percent = 0.10\nif (rating ?? 3) >= 4 {\n    percent = 0.20\n}\n\nlet meals = [Meal(name: \"Pasta\", price: 24.0), Meal(name: \"Steak\", price: 38.5)]\nfor meal in meals {\n    let tip = calculateTip(bill: meal.price, percent: percent)\n    print(\"\\(meal.name): tip $\\(String(format: \"%.2f\", tip))\")\n}",
  "lessons": [
    {
      "id": "l1",
      "title": "Constants",
      "buildNote": "Your calculator now stores the bill amount.",
      "steps": [
        {
          "id": "l1s1",
          "kind": "learn",
          "title": "Constants with let",
          "body": "A **constant** stores a value that never changes. Write `let`, a name, `=`, then the value.",
          "code": "let billAmount = 84.50\nprint(billAmount)"
        },
        {
          "id": "l1s2",
          "kind": "gapFill",
          "title": "Store the bill",
          "body": "Fill in the blank to create a constant called `billAmount`.",
          "code": "___ billAmount = 84.50",
          "options": [
            "let",
            "var",
            "func",
            "print"
          ],
          "answers": [
            "let"
          ]
        },
        {
          "id": "l1s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write a constant named `billAmount` set to `84.50`.",
          "answers": [
            "let billAmount = 84.50",
            "let billAmount = 84.5"
          ],
          "hint": "Start with let."
        }
      ]
    },
    {
      "id": "l2",
      "title": "Numbers & maths",
      "buildNote": "It can now work out a tip from a percentage.",
      "steps": [
        {
          "id": "l2s1",
          "kind": "learn",
          "title": "Maths in Swift",
          "body": "Swift uses `+`, `-`, `*` and `/`. Multiply the bill by the tip percentage to get the tip.",
          "code": "let total = 50.0 * 0.2"
        },
        {
          "id": "l2s2",
          "kind": "reorder",
          "title": "Order matters",
          "body": "Put the lines in order. A constant must exist before you use it.",
          "lines": [
            "let billAmount = 84.50",
            "let tipPercent = 0.15",
            "let tip = billAmount * tipPercent"
          ]
        },
        {
          "id": "l2s3",
          "kind": "fixBug",
          "title": "Fix the bug",
          "body": "The tip should be the bill **multiplied** by the percentage. Fix the code.",
          "code": "let tipPercent = 0.15\nlet tip = billAmount + tipPercent",
          "answers": [
            "let tipPercent = 0.15\nlet tip = billAmount * tipPercent"
          ],
          "hint": "Which operator multiplies?"
        }
      ]
    },
    {
      "id": "l3",
      "title": "Strings & output",
      "buildNote": "It now prints a friendly result.",
      "steps": [
        {
          "id": "l3s1",
          "kind": "learn",
          "title": "String interpolation",
          "body": "Put a value inside text with `\\( )`.",
          "code": "let name = \"Sam\"\nprint(\"Hi \\(name)\")"
        },
        {
          "id": "l3s2",
          "kind": "gapFill",
          "title": "Show the tip",
          "body": "Fill in the blank so the message shows the tip.",
          "code": "print(\"Tip: $\\(___)\")",
          "options": [
            "tip",
            "billAmount",
            "let",
            "print"
          ],
          "answers": [
            "tip"
          ]
        },
        {
          "id": "l3s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Print `Tip: $` followed by the `tip` value using interpolation.",
          "answers": [
            "print(\"Tip: $\\(tip)\")"
          ],
          "hint": "print(\"... \\(value)\")"
        }
      ]
    },
    {
      "id": "l4",
      "title": "Functions",
      "buildNote": "Your calculator is now reusable with a function.",
      "steps": [
        {
          "id": "l4s1",
          "kind": "learn",
          "title": "Reusable code",
          "body": "A **function** packages code you can run again. `->` says what type it gives back.",
          "code": "func double(_ n: Int) -> Int {\n    return n * 2\n}\nprint(double(4))"
        },
        {
          "id": "l4s2",
          "kind": "reorder",
          "title": "Build the function",
          "body": "Put the function in order.",
          "lines": [
            "func calculateTip(bill: Double, percent: Double) -> Double {",
            "    return bill * percent",
            "}"
          ]
        },
        {
          "id": "l4s3",
          "kind": "write",
          "title": "Call it",
          "body": "Create a constant `tip` by calling `calculateTip` with `billAmount` and `0.15`.",
          "answers": [
            "let tip = calculateTip(bill: billAmount, percent: 0.15)"
          ],
          "hint": "Labels: bill: and percent:"
        }
      ]
    },
    {
      "id": "l5",
      "title": "Decisions",
      "buildNote": "Your calculator now picks the tip size from a rating.",
      "steps": [
        {
          "id": "l5s1",
          "kind": "learn",
          "title": "Making decisions",
          "body": "An `if` runs code only when its condition is true. Compare values with `>`, `<`, `>=`, `<=` and `==`.",
          "code": "let rating = 5\nif rating >= 4 {\n    print(\"Great service!\")\n}"
        },
        {
          "id": "l5s2",
          "kind": "gapFill",
          "title": "Pick the condition",
          "body": "Great service (a rating of **4 or more**) earns the bigger tip. Fill in the operator.",
          "code": "if rating ___ 4 {\n    percent = 0.20\n}",
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
          "id": "l5s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write an `if` statement that sets `percent` to `0.20` when `rating` is 4 or more.",
          "answers": [
            "if rating >= 4 {\n    percent = 0.20\n}",
            "if rating >= 4 {\n    percent = 0.2\n}"
          ],
          "hint": "if condition { ... }"
        }
      ]
    },
    {
      "id": "l6",
      "title": "Arrays",
      "buildNote": "It can now hold a whole list of bills.",
      "steps": [
        {
          "id": "l6s1",
          "kind": "learn",
          "title": "Lists of values",
          "body": "An **array** holds several values in order. Use square brackets and commas. Counting starts at **0**.",
          "code": "let bills = [42.0, 84.50, 19.99]\nprint(bills[0])\nprint(bills.count)"
        },
        {
          "id": "l6s2",
          "kind": "gapFill",
          "title": "Get the first bill",
          "body": "Arrays count from 0. Fill in the blank to get the **first** bill.",
          "code": "let first = bills[___]",
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
          "id": "l6s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Create a constant named `bills` holding `42.0`, `84.50` and `19.99`.",
          "answers": [
            "let bills = [42.0, 84.50, 19.99]",
            "let bills = [42.0, 84.5, 19.99]",
            "let bills = [42, 84.50, 19.99]",
            "let bills = [42, 84.5, 19.99]"
          ],
          "hint": "let name = [a, b, c]"
        }
      ]
    },
    {
      "id": "l7",
      "title": "Loops",
      "buildNote": "It now works out a tip for every bill in the list.",
      "steps": [
        {
          "id": "l7s1",
          "kind": "learn",
          "title": "Repeating things",
          "body": "A **for loop** runs code once for each item in a collection.",
          "code": "let names = [\"Sam\", \"Alex\"]\nfor name in names {\n    print(\"Hi \\(name)\")\n}"
        },
        {
          "id": "l7s2",
          "kind": "reorder",
          "title": "Build the loop",
          "body": "Put the loop in order. The lines inside the braces run once per bill.",
          "lines": [
            "for bill in bills {",
            "    let tip = calculateTip(bill: bill, percent: percent)",
            "    print(\"Tip: $\\(tip)\")",
            "}"
          ]
        },
        {
          "id": "l7s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write a `for` loop over `bills` that prints each `bill`. Call the current item `bill`.",
          "answers": [
            "for bill in bills {\n    print(bill)\n}"
          ],
          "hint": "for item in collection { ... }"
        }
      ]
    },
    {
      "id": "l8",
      "title": "Structs",
      "buildNote": "Each bill is now a meal with a name and a price.",
      "steps": [
        {
          "id": "l8s1",
          "kind": "learn",
          "title": "Your own types",
          "body": "A **struct** bundles related values into a type of your own. Create one by calling it with a value for each property.",
          "code": "struct Meal {\n    let name: String\n    let price: Double\n}\n\nlet pasta = Meal(name: \"Pasta\", price: 24.0)\nprint(pasta.name)"
        },
        {
          "id": "l8s2",
          "kind": "reorder",
          "title": "Build the struct",
          "body": "Put the struct in order.",
          "lines": [
            "struct Meal {",
            "    let name: String",
            "    let price: Double",
            "}"
          ]
        },
        {
          "id": "l8s3",
          "kind": "write",
          "title": "Your turn",
          "body": "`Meal` is already defined. Create a `Meal` called `steak` with the name `Steak` and the price `38.5`.",
          "answers": [
            "let steak = Meal(name: \"Steak\", price: 38.5)",
            "let steak = Meal(name: \"Steak\", price: 38.50)"
          ],
          "hint": "Meal(name: ..., price: ...)"
        }
      ]
    },
    {
      "id": "l9",
      "title": "Optionals",
      "buildNote": "Missing ratings no longer break your calculator.",
      "steps": [
        {
          "id": "l9s1",
          "kind": "learn",
          "title": "Maybe a value",
          "body": "An **optional** might hold a value or be empty (`nil`). Add `?` to the type to make one. Use `??` to give it a default.",
          "code": "let rating: Int? = nil\nlet safe = rating ?? 3\nprint(safe)"
        },
        {
          "id": "l9s2",
          "kind": "gapFill",
          "title": "Give it a default",
          "body": "If `rating` is empty, use 3. Fill in the operator that provides a default.",
          "code": "let safe = rating ___ 3",
          "options": [
            "??",
            "?",
            "!",
            "||"
          ],
          "answers": [
            "??"
          ]
        },
        {
          "id": "l9s3",
          "kind": "fixBug",
          "title": "Fix the bug",
          "body": "A plain `Int` can't be empty. Make `rating` an optional.",
          "code": "let rating: Int = nil",
          "answers": [
            "let rating: Int? = nil"
          ],
          "hint": "Add a ? after the type."
        }
      ]
    },
    {
      "id": "l10",
      "title": "Formatting output",
      "buildNote": "Tips now print as tidy dollar amounts.",
      "steps": [
        {
          "id": "l10s1",
          "kind": "learn",
          "title": "Tidy numbers",
          "body": "`String(format:)` (from Foundation) formats numbers. `%.2f` means a decimal number with 2 digits after the point.",
          "code": "import Foundation\n\nlet tip = 12.675\nprint(String(format: \"%.2f\", tip))"
        },
        {
          "id": "l10s2",
          "kind": "gapFill",
          "title": "How many decimals?",
          "body": "Fill in the blank to show **2** decimal places.",
          "code": "String(format: \"%.___f\", tip)",
          "options": [
            "2",
            "0",
            "f",
            "$"
          ],
          "answers": [
            "2"
          ]
        },
        {
          "id": "l10s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Print `tip` with 2 decimal places, using `String(format:)`.",
          "answers": [
            "print(String(format: \"%.2f\", tip))"
          ],
          "hint": "String(format: \"%.2f\", value)"
        }
      ]
    }
  ]
}
"""#
