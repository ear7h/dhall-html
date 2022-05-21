let L = ./lite.dhall
let H = L.H
let doc = H.html H.noattr
	[ H.head H.noattr
		[ H.meta (toMap { charset = "utf-8" })
		, H.title H.noattr [ H.text "Hello" ]
		]
	, H.body H.noattr
		[ L.h1 "Hello World"
		, L.p  "How about this weather?"
		, L.ol
			[ L.li "sunny"
			, L.li "cloudy"
			, L.li "rainy"
			]
		, L.p "${L.inline.a "top" "#hello-world"}"
		, L.script "alert(\"script!!\")"
		]
	]

in H.render doc
