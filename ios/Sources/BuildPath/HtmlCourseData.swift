// HTML course content, embedded as a Swift string.
let htmlFoundationsJSON = #"""
{
  "id": "html-foundations",
  "language": "html",
  "title": "HTML Foundations",
  "subtitle": "Learn the basics by building your own web page, one piece at a time.",
  "capstone": "Personal Web Page",
  "capstoneCode": "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n  <meta charset=\"utf-8\">\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">\n  <title>My Page</title>\n  <style>\n    h1 {\n      color: royalblue;\n    }\n  </style>\n</head>\n<body>\n  <header>\n    <h1>Hi, I'm Sam</h1>\n  </header>\n  <main>\n    <p>I am learning to <strong>build</strong> things.</p>\n    <img src=\"me.jpg\" alt=\"A photo of me\">\n    <h2>My favourites</h2>\n    <ul>\n      <li>Coding</li>\n      <li>Coffee</li>\n    </ul>\n    <table>\n      <tr>\n        <th>Skill</th>\n        <th>Level</th>\n      </tr>\n      <tr>\n        <td>HTML</td>\n        <td>Learning</td>\n      </tr>\n    </table>\n    <a href=\"https://example.com\">My site</a>\n    <form>\n      <input type=\"email\" placeholder=\"Your email\">\n      <button>Say hi</button>\n    </form>\n  </main>\n  <footer>\n    <p>Made with BuildPath</p>\n  </footer>\n</body>\n</html>",
  "lessons": [
    {
      "id": "h1",
      "title": "Page skeleton",
      "buildNote": "Your page now has a proper structure.",
      "steps": [
        {
          "id": "h1s1",
          "kind": "learn",
          "title": "Every page has a skeleton",
          "body": "HTML is made of **tags** like `<html>`. Most come in pairs: an opening tag and a closing tag with a `/`. `<head>` holds info about the page, and `<body>` holds what people see.",
          "code": "<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n  <title>My Page</title>\n</head>\n<body>\n</body>\n</html>"
        },
        {
          "id": "h1s2",
          "kind": "reorder",
          "title": "Build the skeleton",
          "body": "Put the lines in order. Opening tags come before the things inside them.",
          "lines": [
            "<!DOCTYPE html>",
            "<html lang=\"en\">",
            "<head>",
            "  <title>My Page</title>",
            "</head>",
            "<body>",
            "</body>",
            "</html>"
          ]
        },
        {
          "id": "h1s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write the `<title>` tag for a page called `My Page`.",
          "answers": [
            "<title>My Page</title>"
          ],
          "hint": "Opening tag, the text, then the closing tag with a /."
        }
      ]
    },
    {
      "id": "h2",
      "title": "Headings & paragraphs",
      "buildNote": "Your page now has a heading and some text.",
      "steps": [
        {
          "id": "h2s1",
          "kind": "learn",
          "title": "Headings and text",
          "body": "`<h1>` is the main heading, and `<h2>` to `<h6>` are smaller ones. `<p>` is a paragraph, and `<strong>` makes text bold.",
          "code": "<h1>Hi, I'm Sam</h1>\n<p>I am learning to <strong>build</strong> things.</p>"
        },
        {
          "id": "h2s2",
          "kind": "gapFill",
          "title": "Pick the tag",
          "body": "Fill both blanks with the tag for the **main heading**.",
          "code": "<___>Hi, I'm Sam</___>",
          "options": [
            "h1",
            "p",
            "title",
            "strong"
          ],
          "answers": [
            "h1",
            "h1"
          ]
        },
        {
          "id": "h2s3",
          "kind": "fixBug",
          "title": "Fix the bug",
          "body": "Two closing tags are missing their `/`. Fix them.",
          "code": "<h1>Hi, I'm Sam<h1>\n<p>I am learning to build things.<p>",
          "answers": [
            "<h1>Hi, I'm Sam</h1>\n<p>I am learning to build things.</p>"
          ],
          "hint": "Closing tags start with </"
        }
      ]
    },
    {
      "id": "h3",
      "title": "Links",
      "buildNote": "Your page can now link to other sites.",
      "steps": [
        {
          "id": "h3s1",
          "kind": "learn",
          "title": "Links",
          "body": "`<a>` makes a link. The `href` attribute says where it goes, and the text between the tags is what people click.",
          "code": "<a href=\"https://example.com\">My site</a>"
        },
        {
          "id": "h3s2",
          "kind": "gapFill",
          "title": "Where does it go?",
          "body": "Fill in the attribute that says where the link goes.",
          "code": "<a ___=\"https://example.com\">My site</a>",
          "options": [
            "href",
            "src",
            "link",
            "url"
          ],
          "answers": [
            "href"
          ]
        },
        {
          "id": "h3s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write a link to `https://example.com` with the text `My site`.",
          "answers": [
            "<a href=\"https://example.com\">My site</a>"
          ],
          "hint": "<a href=\"...\">text</a>"
        }
      ]
    },
    {
      "id": "h4",
      "title": "Lists",
      "buildNote": "Your page now has a list of favourites.",
      "steps": [
        {
          "id": "h4s1",
          "kind": "learn",
          "title": "Lists",
          "body": "`<ul>` makes a bulleted list and `<ol>` a numbered one. Each item goes in its own `<li>`.",
          "code": "<ul>\n  <li>Coding</li>\n  <li>Coffee</li>\n</ul>"
        },
        {
          "id": "h4s2",
          "kind": "reorder",
          "title": "Build the list",
          "body": "Put the list in order.",
          "lines": [
            "<ul>",
            "  <li>Coding</li>",
            "  <li>Coffee</li>",
            "</ul>"
          ]
        },
        {
          "id": "h4s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write a bulleted list with two items: `Coding` and `Coffee`.",
          "answers": [
            "<ul>\n  <li>Coding</li>\n  <li>Coffee</li>\n</ul>"
          ],
          "hint": "The <ul> wraps the <li> items."
        }
      ]
    },
    {
      "id": "h5",
      "title": "Images",
      "buildNote": "Your page can now show a picture.",
      "steps": [
        {
          "id": "h5s1",
          "kind": "learn",
          "title": "Images",
          "body": "`<img>` shows a picture. `src` is the file's location, and `alt` describes the picture for screen readers and for when it fails to load. It has no closing tag.",
          "code": "<img src=\"me.jpg\" alt=\"A photo of me\">"
        },
        {
          "id": "h5s2",
          "kind": "gapFill",
          "title": "Describe it",
          "body": "Which attribute describes the image for people who can't see it?",
          "code": "<img src=\"me.jpg\" ___=\"A photo of me\">",
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
          "id": "h5s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write an image tag with `src` set to `me.jpg` and `alt` set to `A photo of me`.",
          "answers": [
            "<img src=\"me.jpg\" alt=\"A photo of me\">",
            "<img alt=\"A photo of me\" src=\"me.jpg\">"
          ],
          "hint": "No closing tag needed."
        }
      ]
    },
    {
      "id": "h6",
      "title": "Page layout",
      "buildNote": "Your page is now organised into header, main and footer.",
      "steps": [
        {
          "id": "h6s1",
          "kind": "learn",
          "title": "Describing the layout",
          "body": "`<header>`, `<main>` and `<footer>` don't change how a page looks, but they describe its layout to screen readers and search engines.",
          "code": "<header>\n  <h1>Hi, I'm Sam</h1>\n</header>\n<main>\n  <p>Welcome!</p>\n</main>"
        },
        {
          "id": "h6s2",
          "kind": "reorder",
          "title": "Build the layout",
          "body": "Put the lines in order.",
          "lines": [
            "<header>",
            "  <h1>Hi, I'm Sam</h1>",
            "</header>",
            "<main>",
            "  <p>Welcome!</p>",
            "</main>"
          ]
        },
        {
          "id": "h6s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Wrap the paragraph in a `<footer>` tag.",
          "code": "<p>Made with BuildPath</p>",
          "answers": [
            "<footer>\n  <p>Made with BuildPath</p>\n</footer>"
          ],
          "hint": "Put <footer> before it and </footer> after it."
        }
      ]
    },
    {
      "id": "h7",
      "title": "Forms & buttons",
      "buildNote": "Visitors can now type their email and say hi.",
      "steps": [
        {
          "id": "h7s1",
          "kind": "learn",
          "title": "Forms",
          "body": "`<form>` groups inputs together. `<input type=\"email\">` is an email box (`placeholder` shows a hint), and `<button>` makes a button.",
          "code": "<form>\n  <input type=\"email\" placeholder=\"Your email\">\n  <button>Say hi</button>\n</form>"
        },
        {
          "id": "h7s2",
          "kind": "gapFill",
          "title": "Pick the input type",
          "body": "Which type gives you an email box?",
          "code": "<input type=\"___\" placeholder=\"Your email\">",
          "options": [
            "email",
            "text",
            "submit",
            "button"
          ],
          "answers": [
            "email"
          ]
        },
        {
          "id": "h7s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write a form containing one email input (placeholder `Your email`) and a button that says `Say hi`.",
          "answers": [
            "<form>\n  <input type=\"email\" placeholder=\"Your email\">\n  <button>Say hi</button>\n</form>",
            "<form>\n  <input placeholder=\"Your email\" type=\"email\">\n  <button>Say hi</button>\n</form>"
          ],
          "hint": "The form wraps both the input and the button."
        }
      ]
    },
    {
      "id": "h8",
      "title": "Tables",
      "buildNote": "Your page now shows a small table of skills.",
      "steps": [
        {
          "id": "h8s1",
          "kind": "learn",
          "title": "Tables",
          "body": "`<table>` makes a grid. Each row is a `<tr>`. Use `<th>` for a header cell and `<td>` for a normal cell.",
          "code": "<table>\n  <tr>\n    <th>Skill</th>\n    <th>Level</th>\n  </tr>\n  <tr>\n    <td>HTML</td>\n    <td>Learning</td>\n  </tr>\n</table>"
        },
        {
          "id": "h8s2",
          "kind": "reorder",
          "title": "Build the header row",
          "body": "Put the table in order.",
          "lines": [
            "<table>",
            "  <tr>",
            "    <th>Skill</th>",
            "    <th>Level</th>",
            "  </tr>",
            "</table>"
          ]
        },
        {
          "id": "h8s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write one table row (`<tr>`) with two normal cells: `HTML` and `Learning`.",
          "answers": [
            "<tr>\n  <td>HTML</td>\n  <td>Learning</td>\n</tr>"
          ],
          "hint": "Normal cells use <td>."
        }
      ]
    },
    {
      "id": "h9",
      "title": "Styling with CSS",
      "buildNote": "Your heading now has a colour.",
      "steps": [
        {
          "id": "h9s1",
          "kind": "learn",
          "title": "CSS",
          "body": "**CSS** controls how things look. Put it in a `<style>` tag in the `<head>`. A rule names what to style, then lists properties in `{ }`, each ending with `;`.",
          "code": "<style>\n  h1 {\n    color: royalblue;\n  }\n</style>"
        },
        {
          "id": "h9s2",
          "kind": "gapFill",
          "title": "Pick the property",
          "body": "Fill in the property that changes the text colour.",
          "code": "h1 {\n  ___: royalblue;\n}",
          "options": [
            "color",
            "font",
            "tag",
            "href"
          ],
          "answers": [
            "color"
          ]
        },
        {
          "id": "h9s3",
          "kind": "fixBug",
          "title": "Fix the bug",
          "body": "Two things are missing from this rule: a colon and a semicolon. Fix it.",
          "code": "h1 {\n  color royalblue\n}",
          "answers": [
            "h1 {\n  color: royalblue;\n}"
          ],
          "hint": "property: value;"
        }
      ]
    },
    {
      "id": "h10",
      "title": "A real-world head",
      "buildNote": "Your page now works properly on phones.",
      "steps": [
        {
          "id": "h10s1",
          "kind": "learn",
          "title": "Two useful meta tags",
          "body": "Almost every page's `<head>` has two `<meta>` tags: `charset` makes special characters display correctly, and `viewport` makes the page fit phone screens.",
          "code": "<meta charset=\"utf-8\">\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
        },
        {
          "id": "h10s2",
          "kind": "gapFill",
          "title": "Fit the screen",
          "body": "Which name makes the page fit phone screens?",
          "code": "<meta name=\"___\" content=\"width=device-width, initial-scale=1\">",
          "options": [
            "viewport",
            "charset",
            "title",
            "author"
          ],
          "answers": [
            "viewport"
          ]
        },
        {
          "id": "h10s3",
          "kind": "write",
          "title": "Your turn",
          "body": "Write the `<meta>` tag that sets the character set to `utf-8`.",
          "answers": [
            "<meta charset=\"utf-8\">"
          ],
          "hint": "The attribute is called charset."
        }
      ]
    }
  ]
}
"""#
