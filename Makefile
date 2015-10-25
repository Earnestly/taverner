PREFIX ?= /usr/local

install: taverner barkeep
	install -Dm755 taverner $(DESTDIR)$(PREFIX)/bin/taverner
	install -Dm755 barkeep $(DESTDIR)$(PREFIX)/bin/barkeep

.PHONY: install
