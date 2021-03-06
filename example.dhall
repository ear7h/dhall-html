let H = (./package.dhall).HTML
let doc = H.html H.noattr
	[ H.head H.noattr
		[ H.meta (toMap { charset = "utf-8" })
		, H.title H.noattr [ H.text "Hello" ]
		]
	, H.body H.noattr
		[ H.h1     H.noattr [H.text "Hello, World!"]
		, H.p      H.noattr [H.text "How about this weather?"]
		, H.script H.noattr [H.text "alert(\"script!!\")"]
		]
	]

in H.render doc
