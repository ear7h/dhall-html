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
	-- open tags
	
	, html = mkOpen "html"
	, head = mkOpen "head"
	, title = mkOpen "title"
	, style = mkOpen "style"
	, body = mkOpen "body"
	
	
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
	, div = mkOpen "div"
	
	, form = mkOpen "form"
	, textarea = mkOpen "textarea"
	
	
	-- self closing tags
	, img = mkClosed "img"
	, input = mkClosed "input"
	, meta = mkClosed "meta"
	}
