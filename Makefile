html.dhall : html.dhall.sh
	sh html.dhall.sh > html.dhall

example.html : example.dhall html.dhall
	dhall text --file example.dhall > example.html

