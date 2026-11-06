// Swift project: a SwiftUI habit counter.
let swiftProjectJSON = #"""
{
  "id": "swift-project-habit",
  "language": "swift",
  "kind": "project",
  "title": "Project: Habit Counter",
  "subtitle": "Build a real SwiftUI screen with a tappable counter. You can paste the finished code straight into your own app.",
  "capstone": "Habit Counter",
  "capstoneCode": "import SwiftUI\n\nstruct HabitCounter: View {\n    @State private var count = 0\n    let habit = \"Drink water\"\n\n    var body: some View {\n        VStack(spacing: 16) {\n            Text(habit)\n                .font(.title)\n            Text(\"\\(count) today\")\n                .font(.largeTitle)\n            Button(\"Done!\") {\n                count += 1\n            }\n            .buttonStyle(.borderedProminent)\n        }\n        .padding()\n    }\n}",
  "lessons": [
    {
      "id": "sp1",
      "title": "Your first view",
      "buildNote": "You have a SwiftUI screen that shows some text.",
      "steps": [
        {
          "id": "sp1s1",
          "kind": "learn",
          "title": "A screen is a struct",
          "body": "In SwiftUI, a screen is a **struct** that follows `View` and describes what to show in `body`.",
          "code": "import SwiftUI\n\nstruct HabitCounter: View {\n    var body: some View {\n        Text(\"Drink water\")\n    }\n}"
        },
        {
          "id": "sp1s2",
          "kind": "reorder",
          "title": "Build the view",
          "body": "Put the view in order.",
          "lines": [
            "struct HabitCounter: View {",
            "    var body: some View {",
            "        Text(\"Drink water\")",
            "    }",
            "}"
          ]
        },
        {
          "id": "sp1s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write a `Text` view that shows `Drink water`.",
          "answers": [
            "Text(\"Drink water\")"
          ],
          "hint": "Text(\"...\")"
        }
      ]
    },
    {
      "id": "sp2",
      "title": "Stacking views",
      "buildNote": "Your screen now stacks two pieces of text.",
      "steps": [
        {
          "id": "sp2s1",
          "kind": "learn",
          "title": "Stacks",
          "body": "A `VStack` stacks views vertically, and `spacing` sets the gap between them.",
          "code": "VStack(spacing: 16) {\n    Text(\"Drink water\")\n    Text(\"0 today\")\n}"
        },
        {
          "id": "sp2s2",
          "kind": "gapFill",
          "title": "Stack them",
          "body": "Fill in the container that stacks views **vertically**.",
          "code": "___(spacing: 16) {\n    Text(\"Drink water\")\n    Text(\"0 today\")\n}",
          "options": [
            "VStack",
            "HStack",
            "Text",
            "List"
          ],
          "answers": [
            "VStack"
          ]
        },
        {
          "id": "sp2s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Wrap `Text(\"Drink water\")` in a `VStack` with a `spacing` of `16`.",
          "answers": [
            "VStack(spacing: 16) {\n    Text(\"Drink water\")\n}"
          ],
          "hint": "VStack(spacing: ...) { ... }"
        }
      ]
    },
    {
      "id": "sp3",
      "title": "Remembering a number",
      "buildNote": "Your screen can now remember a count.",
      "steps": [
        {
          "id": "sp3s1",
          "kind": "learn",
          "title": "State",
          "body": "`@State` lets a view remember a value and redraw itself whenever it changes. Inside text, `\\( )` drops a value into a string.",
          "code": "@State private var count = 0\n\nText(\"\\(count) today\")"
        },
        {
          "id": "sp3s2",
          "kind": "gapFill",
          "title": "Remember it",
          "body": "Fill in the attribute that lets a view remember a changing value.",
          "code": "@___ private var count = 0",
          "options": [
            "State",
            "Binding",
            "Published",
            "Environment"
          ],
          "answers": [
            "State"
          ]
        },
        {
          "id": "sp3s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Create a state property called `count` that starts at `0`.",
          "answers": [
            "@State private var count = 0"
          ],
          "hint": "Start with @State"
        }
      ]
    },
    {
      "id": "sp4",
      "title": "A button",
      "buildNote": "Tapping the button now adds to the count.",
      "steps": [
        {
          "id": "sp4s1",
          "kind": "learn",
          "title": "Buttons",
          "body": "A `Button` takes a title and some code to run when it's tapped. Changing a `@State` value redraws the screen automatically.",
          "code": "Button(\"Done!\") {\n    count += 1\n}"
        },
        {
          "id": "sp4s2",
          "kind": "fixBug",
          "title": "Fix the bug",
          "body": "The button should add 1 to `count`, but this only calculates a number and throws it away. Fix it.",
          "code": "Button(\"Done!\") {\n    count + 1\n}",
          "answers": [
            "Button(\"Done!\") {\n    count += 1\n}"
          ],
          "hint": "Use += to change the value."
        },
        {
          "id": "sp4s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write a `Text` that shows the count like `3 today`, using `count` inside the string.",
          "answers": [
            "Text(\"\\(count) today\")"
          ],
          "hint": "Text(\"\\(value) today\")"
        }
      ]
    },
    {
      "id": "sp5",
      "title": "Make it look good",
      "buildNote": "Your habit counter is finished and looks great.",
      "steps": [
        {
          "id": "sp5s1",
          "kind": "learn",
          "title": "Modifiers",
          "body": "**Modifiers** change how a view looks. Add them after the view with a dot, like `.font(.title)`. Your finished screen is ready to paste into your own app.",
          "code": "Text(\"Drink water\")\n    .font(.title)\n\nButton(\"Done!\") { count += 1 }\n    .buttonStyle(.borderedProminent)"
        },
        {
          "id": "sp5s2",
          "kind": "gapFill",
          "title": "Change the font",
          "body": "Fill in the modifier that changes the text size and style.",
          "code": "Text(\"Drink water\")\n    .___(.title)",
          "options": [
            "font",
            "padding",
            "style",
            "size"
          ],
          "answers": [
            "font"
          ]
        },
        {
          "id": "sp5s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write the modifier that adds space around a view.",
          "answers": [
            ".padding()"
          ],
          "hint": "It has no arguments."
        }
      ]
    }
  ]
}
"""#

// Python project: a terminal quiz game.
let pythonProjectJSON = #"""
{
  "id": "python-project-quiz",
  "language": "python",
  "kind": "project",
  "title": "Project: Quiz Game",
  "subtitle": "Build a real quiz that runs in the terminal. Save the finished code as quiz.py and run it with python quiz.py.",
  "capstone": "Quiz Game",
  "capstoneCode": "questions = [\n    {\"question\": \"What is 7 x 8?\", \"answer\": \"56\"},\n    {\"question\": \"What is the capital of Australia?\", \"answer\": \"canberra\"},\n    {\"question\": \"How many days are in a leap year?\", \"answer\": \"366\"},\n]\n\ndef ask(question, answer):\n    reply = input(question + \" \").strip().lower()\n    return reply == answer\n\nscore = 0\nfor item in questions:\n    if ask(item[\"question\"], item[\"answer\"]):\n        print(\"Correct!\")\n        score += 1\n    else:\n        print(\"Not quite. The answer was \" + item[\"answer\"])\n\nprint(f\"You scored {score} out of {len(questions)}\")",
  "lessons": [
    {
      "id": "pp1",
      "title": "The questions",
      "buildNote": "Your quiz has questions stored as data.",
      "steps": [
        {
          "id": "pp1s1",
          "kind": "learn",
          "title": "Questions as data",
          "body": "A quiz is just a **list** of questions, and each question is a **dictionary** with a `question` and an `answer`. Keeping questions as data means you can add more without changing any logic.",
          "code": "questions = [\n    {\"question\": \"What is 7 x 8?\", \"answer\": \"56\"},\n    {\"question\": \"What is the capital of Australia?\", \"answer\": \"canberra\"},\n]\nprint(questions[0][\"question\"])"
        },
        {
          "id": "pp1s2",
          "kind": "gapFill",
          "title": "Get the first question",
          "body": "Lists count from 0. Fill in the blank to get the **first** question.",
          "code": "print(questions[___][\"question\"])",
          "options": [
            "0",
            "1",
            "question",
            "answer"
          ],
          "answers": [
            "0"
          ]
        },
        {
          "id": "pp1s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Create a list named `questions` holding one dictionary: the question `What is 7 x 8?` and the answer `56`.",
          "answers": [
            "questions = [{\"question\": \"What is 7 x 8?\", \"answer\": \"56\"}]",
            "questions = [{'question': 'What is 7 x 8?', 'answer': '56'}]"
          ],
          "hint": "A list of dictionaries: [{\"key\": \"value\"}]"
        }
      ]
    },
    {
      "id": "pp2",
      "title": "Ask a question",
      "buildNote": "Your quiz can ask a question and read the answer.",
      "steps": [
        {
          "id": "pp2s1",
          "kind": "learn",
          "title": "Asking the player",
          "body": "`input()` shows a prompt and returns what the player typed, as text. `.strip()` removes extra spaces and `.lower()` makes it lowercase, so `Canberra ` still matches `canberra`.",
          "code": "reply = input(\"What is 7 x 8? \").strip().lower()\nprint(reply)"
        },
        {
          "id": "pp2s2",
          "kind": "fixBug",
          "title": "Fix the bug",
          "body": "Methods need parentheses to run. Fix the two methods.",
          "code": "reply = input(\"What is 7 x 8? \").strip.lower",
          "answers": [
            "reply = input(\"What is 7 x 8? \").strip().lower()",
            "reply = input('What is 7 x 8? ').strip().lower()"
          ],
          "hint": "Methods need parentheses ()"
        },
        {
          "id": "pp2s3",
          "kind": "reorder",
          "title": "Wrap it in a function",
          "body": "Put the function in order. It asks the question, then returns whether the reply matches.",
          "lines": [
            "def ask(question, answer):",
            "    reply = input(question + \" \").strip().lower()",
            "    return reply == answer"
          ]
        }
      ]
    },
    {
      "id": "pp3",
      "title": "Right or wrong?",
      "buildNote": "Your quiz now tells the player if they got it right.",
      "steps": [
        {
          "id": "pp3s1",
          "kind": "learn",
          "title": "Comparing answers",
          "body": "`==` compares two values and gives `True` or `False`. An `if` / `else` then picks what to do.",
          "code": "if reply == answer:\n    print(\"Correct!\")\nelse:\n    print(\"Not quite.\")"
        },
        {
          "id": "pp3s2",
          "kind": "gapFill",
          "title": "Compare them",
          "body": "Fill in the operator that checks whether two values are **equal**.",
          "code": "if reply ___ answer:",
          "options": [
            "==",
            "=",
            "!=",
            ">"
          ],
          "answers": [
            "=="
          ]
        },
        {
          "id": "pp3s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write an `if`/`else` that prints `Correct!` when `reply == answer`, and `Not quite.` otherwise.",
          "answers": [
            "if reply == answer:\n    print(\"Correct!\")\nelse:\n    print(\"Not quite.\")",
            "if reply == answer:\n    print('Correct!')\nelse:\n    print('Not quite.')"
          ],
          "hint": "Don't forget the colons and the indents."
        }
      ]
    },
    {
      "id": "pp4",
      "title": "Keep score",
      "buildNote": "Your quiz now counts the player's points.",
      "steps": [
        {
          "id": "pp4s1",
          "kind": "learn",
          "title": "Looping with a score",
          "body": "`score = 0` starts the count, and `score += 1` adds 1 to it. A `for` loop asks every question in the list.",
          "code": "score = 0\nfor item in questions:\n    if ask(item[\"question\"], item[\"answer\"]):\n        score += 1"
        },
        {
          "id": "pp4s2",
          "kind": "reorder",
          "title": "Build the loop",
          "body": "Put the lines in order.",
          "lines": [
            "score = 0",
            "for item in questions:",
            "    if ask(item[\"question\"], item[\"answer\"]):",
            "        print(\"Correct!\")",
            "        score += 1"
          ]
        },
        {
          "id": "pp4s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Add `1` to `score` using `+=`.",
          "answers": [
            "score += 1"
          ],
          "hint": "score += 1"
        }
      ]
    },
    {
      "id": "pp5",
      "title": "Show the result",
      "buildNote": "Your quiz is finished. Run it and play!",
      "steps": [
        {
          "id": "pp5s1",
          "kind": "learn",
          "title": "The final score",
          "body": "`len()` counts how many items are in a list, and an f-string drops values into text. Save the finished program as `quiz.py` and run it with `python quiz.py`.",
          "code": "print(f\"You scored {score} out of {len(questions)}\")"
        },
        {
          "id": "pp5s2",
          "kind": "gapFill",
          "title": "Count the questions",
          "body": "Fill in the function that counts the items in a list.",
          "code": "print(f\"You scored {score} out of {___(questions)}\")",
          "options": [
            "len",
            "count",
            "size",
            "sum"
          ],
          "answers": [
            "len"
          ]
        },
        {
          "id": "pp5s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Print the score and the number of questions as `You scored 2 out of 3`, using an f-string with `score` and `len(questions)`.",
          "answers": [
            "print(f\"You scored {score} out of {len(questions)}\")",
            "print(f'You scored {score} out of {len(questions)}')"
          ],
          "hint": "print(f\"... {score} ... {len(questions)}\")"
        }
      ]
    }
  ]
}
"""#

// HTML project: a link-in-bio page.
let htmlProjectJSON = #"""
{
  "id": "html-project-linktree",
  "language": "html",
  "kind": "project",
  "title": "Project: Link-in-bio Page",
  "subtitle": "Build a Linktree-style page: your photo, your name and big buttons to your links. Save the finished code as index.html and open it in a browser.",
  "capstone": "Link-in-bio Page",
  "capstoneCode": "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n  <meta charset=\"utf-8\">\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n  <title>Sam's Links</title>\n  <style>\n    body {\n      font-family: sans-serif;\n      background: #f4f1ea;\n      margin: 0;\n    }\n    .card {\n      max-width: 400px;\n      margin: 0 auto;\n      padding: 32px 16px;\n      text-align: center;\n    }\n    .avatar {\n      width: 96px;\n      height: 96px;\n      border-radius: 50%;\n    }\n    .link {\n      display: block;\n      padding: 14px;\n      margin: 12px 0;\n      background: #1d3557;\n      color: white;\n      border-radius: 10px;\n      text-decoration: none;\n    }\n    .link:hover {\n      background: #457b9d;\n    }\n  </style>\n</head>\n<body>\n  <main class=\"card\">\n    <img class=\"avatar\" src=\"avatar.jpg\" alt=\"Photo of Sam\">\n    <h1>Sam Rivera</h1>\n    <p>Learning to build things, one project at a time.</p>\n    <nav>\n      <a class=\"link\" href=\"https://github.com/sam\" target=\"_blank\" rel=\"noopener\">GitHub</a>\n      <a class=\"link\" href=\"https://example.com/blog\" target=\"_blank\" rel=\"noopener\">My blog</a>\n      <a class=\"link\" href=\"mailto:sam@example.com\">Email me</a>\n    </nav>\n  </main>\n</body>\n</html>",
  "lessons": [
    {
      "id": "hp1",
      "title": "Start the page",
      "buildNote": "You have an empty page that works on phones.",
      "steps": [
        {
          "id": "hp1s1",
          "kind": "learn",
          "title": "The starting point",
          "body": "A link-in-bio page is one small page with your photo, your name and big buttons to your links. Start with the skeleton, plus the two meta tags every real page needs.",
          "code": "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n  <meta charset=\"utf-8\">\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n  <title>Sam's Links</title>\n</head>\n<body>\n</body>\n</html>"
        },
        {
          "id": "hp1s2",
          "kind": "reorder",
          "title": "Build the head",
          "body": "Put the `<head>` in order.",
          "lines": [
            "<head>",
            "  <meta charset=\"utf-8\">",
            "  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">",
            "  <title>Sam's Links</title>",
            "</head>"
          ]
        },
        {
          "id": "hp1s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write the `<title>` tag for the page: `Sam's Links`.",
          "answers": [
            "<title>Sam's Links</title>"
          ],
          "hint": "Opening tag, the text, then the closing tag."
        }
      ]
    },
    {
      "id": "hp2",
      "title": "Profile header",
      "buildNote": "Your page now shows a photo, a name and a short bio.",
      "steps": [
        {
          "id": "hp2s1",
          "kind": "learn",
          "title": "Photo, name and bio",
          "body": "Put everything in a `<main>` with a `class`. A **class** is a label you can style later. Then add your photo, your name as the `<h1>` and a short bio.",
          "code": "<main class=\"card\">\n  <img class=\"avatar\" src=\"avatar.jpg\" alt=\"Photo of Sam\">\n  <h1>Sam Rivera</h1>\n  <p>Learning to build things, one project at a time.</p>\n</main>"
        },
        {
          "id": "hp2s2",
          "kind": "gapFill",
          "title": "Describe the photo",
          "body": "Fill in the attribute that describes the photo for people who can't see it.",
          "code": "<img class=\"avatar\" src=\"avatar.jpg\" ___=\"Photo of Sam\">",
          "options": [
            "alt",
            "href",
            "title",
            "name"
          ],
          "answers": [
            "alt"
          ]
        },
        {
          "id": "hp2s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write the `<h1>` with the name `Sam Rivera`, then a `<p>` with the bio `Learning to build things, one project at a time.`",
          "answers": [
            "<h1>Sam Rivera</h1>\n<p>Learning to build things, one project at a time.</p>"
          ],
          "hint": "Two tags, one after the other."
        }
      ]
    },
    {
      "id": "hp3",
      "title": "The links",
      "buildNote": "Your page has three real links.",
      "steps": [
        {
          "id": "hp3s1",
          "kind": "learn",
          "title": "Links as buttons",
          "body": "Each link is an `<a>` with a `class` so you can style it as a button. They live in a `<nav>`. A link starting with `mailto:` opens the visitor's email app.",
          "code": "<nav>\n  <a class=\"link\" href=\"https://github.com/sam\">GitHub</a>\n  <a class=\"link\" href=\"mailto:sam@example.com\">Email me</a>\n</nav>"
        },
        {
          "id": "hp3s2",
          "kind": "fixBug",
          "title": "Fix the bug",
          "body": "Two bugs: the `href` value needs quotes, and the closing tag is missing its `/`. Fix the link.",
          "code": "<a class=\"link\" href=https://github.com/sam>GitHub<a>",
          "answers": [
            "<a class=\"link\" href=\"https://github.com/sam\">GitHub</a>"
          ],
          "hint": "Attribute values go in quotes."
        },
        {
          "id": "hp3s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write a link with the class `link` that opens an email to `sam@example.com`. Its text is `Email me`.",
          "answers": [
            "<a class=\"link\" href=\"mailto:sam@example.com\">Email me</a>"
          ],
          "hint": "href=\"mailto:...\""
        }
      ]
    },
    {
      "id": "hp4",
      "title": "Style it",
      "buildNote": "Your page is centred, with big tappable buttons.",
      "steps": [
        {
          "id": "hp4s1",
          "kind": "learn",
          "title": "Styling by class",
          "body": "In CSS, a class is written with a dot. `max-width` plus `margin: 0 auto` centres a column on the page, and `text-align: center` centres the text inside it.",
          "code": ".card {\n  max-width: 400px;\n  margin: 0 auto;\n  text-align: center;\n}"
        },
        {
          "id": "hp4s2",
          "kind": "gapFill",
          "title": "Centre the column",
          "body": "Fill in the value that centres the column sideways.",
          "code": ".card {\n  max-width: 400px;\n  margin: 0 ___;\n}",
          "options": [
            "auto",
            "center",
            "middle",
            "100%"
          ],
          "answers": [
            "auto"
          ]
        },
        {
          "id": "hp4s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write a CSS rule for `.link` that sets `display: block;` and `padding: 14px;`.",
          "answers": [
            ".link {\n  display: block;\n  padding: 14px;\n}",
            ".link {\n  padding: 14px;\n  display: block;\n}"
          ],
          "hint": "A rule is: .name { property: value; }"
        }
      ]
    },
    {
      "id": "hp5",
      "title": "Finishing touches",
      "buildNote": "Hover effects, safe external links and your finished page.",
      "steps": [
        {
          "id": "hp5s1",
          "kind": "learn",
          "title": "Hover and new tabs",
          "body": "`:hover` styles something while the mouse is over it. `target=\"_blank\"` opens a link in a new tab, and `rel=\"noopener\"` keeps that new tab safe.",
          "code": ".link:hover {\n  background: #457b9d;\n}\n\n<a class=\"link\" href=\"https://github.com/sam\" target=\"_blank\" rel=\"noopener\">GitHub</a>"
        },
        {
          "id": "hp5s2",
          "kind": "gapFill",
          "title": "Open in a new tab",
          "body": "Fill in the value that opens a link in a new tab.",
          "code": "<a href=\"https://github.com/sam\" target=\"___\" rel=\"noopener\">GitHub</a>",
          "options": [
            "_blank",
            "_self",
            "new",
            "tab"
          ],
          "answers": [
            "_blank"
          ]
        },
        {
          "id": "hp5s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write a hover rule for `.link` that sets the `background` to `#457b9d`.",
          "answers": [
            ".link:hover {\n  background: #457b9d;\n}"
          ],
          "hint": "The selector is .link:hover"
        }
      ]
    }
  ]
}
"""#
