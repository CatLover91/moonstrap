argparse = require "argparse"

parser = argparse "strap", "A boilerplate generator"

html = parser\command "html"
html\argument "output", "Output file", "index.html"
html\option("-s --script", "Add a script tag")\args("+")
html\option("-c --css", "Add a link to a css file")\args("+")
html\option("-l --library", "Add a common library cdn")\args("+")
args = parser\parse!

out = ""
if args.html
  out ..= "<!DOCTYPE html>
<html>
<head>
  <meta charset=\"UTF-8\">
  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge,chrome=1\">
  <meta name=\"viewport\" content=\"width=device-width,initial-scale=1\">
  <title>title</title>
  "
  if args.css then for l in *args.css
    out ..= "<link rel=\"stylesheet\" href=\"#{l}\">\n"
  out ..= "
</head>
<body>

"
  if args.script then for s in *args.script
    out ..= "<script type=\"text/javascript\" src=\"#{s}\"></script\n"
  out ..= "</body>
</html>"

for k, v in pairs args
  print k,v

print out

if io.open("./"..args.output, "r") == nil
  file = io.open("./"..args.output, "w")
  file\write(out)
  file\close()
else
  print "wont write"
