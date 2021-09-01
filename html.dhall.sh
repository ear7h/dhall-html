cat <<EOF
let Prelude = https://prelude.dhall-lang.org/package.dhall
let XML = Prelude.XML
let XML/render = XML.render
let XML/element = XML.element
let text = XML.text
let emptyAttributes = XML.emptyAttributes
let XML = XML.Type
let Map = Prelude.Map.Type
let Attrs = Map Text Text

let mkOpen = \(tag : Text) ->
	\(attributes : Attrs) ->
	\(content : List XML) -> XML/element { name = tag, attributes, content }

let mkClosed = \(tag : Text) ->
	\(attributes : Attrs) -> XML/element { name = tag, attributes, content = [] : List XML }
let render = \(doc : XML) -> Prelude.Text.concat [ "<!DOCTYPE html>", XML/render doc ]

in
	{ render
	, text
	, Attrs
	, noattr = emptyAttributes
EOF

awk -c '/^[a-z].*/ { print "\t, " $1 " = mkOpen \""$1 "\""; next } { print "\t" $0 } ' <<EOF
-- open tags

html
head
title
style
body


-- headings
h1
h2
h3
h4
h5
h6

-- content
p
span
div

form
textarea


EOF


awk -c '/^[a-z].*/ { print "\t, " $1 " = mkClosed \""$1 "\""; next } { print "\t" $0 } ' <<EOF
-- self closing tags
img
input
meta
EOF

cat <<EOF
	}
EOF

