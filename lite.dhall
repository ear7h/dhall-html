let Prelude = ./prelude.dhall
let XML = Prelude.XML.Type
let H = ./html.dhall
let Tag = H.Attrs -> List XML -> XML

let lite = λ(tag : Tag) → λ(body : Text) →
	tag H.noattr [ H.text body ]

let liteHeader = λ(tag : Tag) → λ(body : Text) →
	tag (toMap { id = body }) [ H.text body ]

let textHack = λ(tag : Tag) → λ(body : Text) →
	let rendered = Prelude.XML.render (tag H.noattr [ H.text body ])
	let r = Prelude.Text.replace
	let unescaped =
		r "_DH_LT_" "<" (r "_DH_GT_" ">" (r "_DH_DQ_" "\"" rendered))
	in H.rawText unescaped
in
	{ script = lite H.script
	, scriptSrc = λ(src : Text) →
		H.script (toMap { src }) ([] : List XML)

	, h1 = liteHeader H.h1
	, h2 = liteHeader H.h2
	, h3 = liteHeader H.h3
	, h4 = liteHeader H.h4
	, h5 = liteHeader H.h5
	, h6 = liteHeader H.h6

	, p = textHack H.p
	, blockquote = textHack H.blockquote

	, code = lite H.code
	, codeBlock = λ(body : Text) →
		H.pre H.noattr [ H.code H.noattr [ H.text body ] ]

	, pre = lite H.pre
	, img = λ(src : Text) → λ(alt : Text) →
		H.img (toMap { src, alt })

	, ul = λ(items : List XML) → H.ul H.noattr items
	, ol = λ(items : List XML) → H.ol H.noattr items
	, li = textHack H.li

	-- inline inline hacks
	, inline =
		{ a = λ(text : Text) → λ(href : Text) ->
			"_DH_LT_a href=_DH_DQ_${href}_DH_DQ__DH_GT_" ++
			text ++
			"_DH_LT_/a_DH_GT_"
		, strong = λ(body : Text) →
			"_DH_LT_strong_DH_GT_" ++
			body ++
			"_DH_LT_/strong_DH_GT_"
		, em = λ(body : Text) →
			"_DH_LT_em_DH_GT_" ++
			body ++
			"_DH_LT_/em_DH_GT_"
		, sub = λ(body : Text) →
			"_DH_LT_sub_DH_GT_" ++
			body ++
			"_DH_LT_/sup_DH_GT_"
		, sup = λ(body : Text) →
			"_DH_LT_sup_DH_GT_" ++
			body ++
			"_DH_LT_/sup_DH_GT_"
		}
	}

