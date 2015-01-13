cfi:
	@wget https://www.df.lth.se/~triad/book/files/cfi.html.zip --no-check-certificate
	@unzip cfi.html.zip

check:
	@echo '6116c2129e2c1cf11de92afb0bb44c7954e5f47be3acecc638010d9514916b10  cfi.html.zip' | sha256sum -c

epub:
	@pandoc -o cfi.md -f html -t markdown+inline_notes cfi.html
	@# [^1^](#1) -> [^1]
	@# ^1^ -> [^1]:
	@cat cfi.md | sed -e 's/\[\^\([0-9]*\)\^\](\#\([0-9]*\))/\[\^\1\]/g' | sed -e 's/\^\([0-9]*\)\^/\[\^\1\]: /g' > cfi_footnotes.md
	@pandoc -o cfi.epub -f markdown+inline_notes -t epub info.txt metadata.yaml cfi_footnotes.md

mobi:
	@ebook-convert cfi.epub cfi.mobi

clean:
	@rm -f *.gif cfi.html.zip cfi.html cfi.md cfi_footnotes.md cfi.epub cfi.mobi
