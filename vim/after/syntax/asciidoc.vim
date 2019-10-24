syntax match myurl /\(http\|https\|ftp\):\/\/[-0-9a-zA-Z_?&=+#%\/.!':;@~]\+/ contains=@NoSpell
syntax match mylinkurl /link:\(http\|https\|ftp\):\/\/[-0-9a-zA-Z_?&=+#%\/.!':;@~]\+/ contains=@NoSpell
syntax match mylinkpath /link:[-0-9a-zA-Z_?&=+#%\/.!':;@~]\+/ contains=@NoSpell
syntax match myasciidocinlinecode "`[^`]\+`" containedin=asciidocQuotedMonospaced2 contains=@NoSpell
syntax region myasciidocblock start='----' end='----' contains=@NoSpell
