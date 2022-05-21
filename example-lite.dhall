let Pkg = ./package.dhall
let L   = Pkg.Lite
let H   = Pkg.HTML
let il  = L.inline
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
		, L.p "${il.a "top" "#Hello World"}"
		, L.p
			-- nested string interpolation makes messes up
			-- vim's syntax highlighting
			(  "and he said, \""
			++ (il.strong "what ${il.em "is"} this?")
			++ "\""
			)
		-- , L.script "alert(\"script!!\");"
		, L.codeBlock ''
			alert("script");
			''
		, L.blockquote "what is this?"
		]
	]

in H.render doc
