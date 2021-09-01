# dhall-html

A dhall library for generating HTML documents. This simply defines
helper functions over [the XML package in Prelude](https://store.dhall-lang.org/Prelude-v20.2.0/XML/index.html)

## example

```dhall
-- ./example.dhall
let H = ./html.dhall
let doc = H.html H.noattr
	[ H.head H.noattr
		[ H.meta (toMap { charset = "utf-8" })
		, H.title H.noattr [ H.text "Hello" ]
		]
	, H.body H.noattr
		[ H.h1 H.noattr [H.text "Hello, World!"]
		, H.p H.noattr [H.text "How about this weather?"]
		]
	]

in H.render doc
```

```
$ dhall text --file example.dhall > example.html
$ open example.html
```

