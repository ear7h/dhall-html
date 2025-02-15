let Prelude = ./prelude.dhall
let XML = Prelude.XML -- https://raw.githubusercontent.com/ear7h/dhall-lang/issue-1224-raw-xml/Prelude/XML/package.dhall
let XML/render = XML.render
let XML/element = XML.element
let rawText = XML.rawText
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
	{ Prelude
	, render
	, text
	, rawText
	, Attrs
	, noattr = emptyAttributes

	-- open tags
	, html = mkOpen "html"
	, head = mkOpen "head"
	, title = mkOpen "title"
	, style = mkOpen "style"
	, body = mkOpen "body"
	, script = mkOpen "script"


	-- headings
	, h1 = mkOpen "h1"
	, h2 = mkOpen "h2"
	, h3 = mkOpen "h3"
	, h4 = mkOpen "h4"
	, h5 = mkOpen "h5"
	, h6 = mkOpen "h6"

	-- content
	, p = mkOpen "p"
	, span = mkOpen "span"
	, a = mkOpen "a"
	, div = mkOpen "div"
	, nav = mkOpen "nav"
	, ul = mkOpen "ul"
	, ol = mkOpen "ol"
	, li = mkOpen "li"
	, pre = mkOpen "pre"
	, code = mkOpen "code"
	, figure = mkOpen "figure"
	, figcaption = mkOpen "figcaption"
	, cite = mkOpen "cite"
	, blockquote = mkOpen "blockquote"

	, details = mkOpen "details"
	, summary = mkOpen "summary"

	, form = mkOpen "form"
	, label = mkOpen "label"
	, textarea = mkOpen "textarea"

	, iframe = mkOpen "iframe"

	-- self closing tags
	, br = mkClosed "br"
	, img = mkClosed "img"
	, input = mkClosed "input"
	, meta = mkClosed "meta"
	, link = mkClosed "link"
	}
