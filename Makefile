PREFIX ?= /usr/local

install: taverner
	install -Dm755 taverner $(DESTDIR)$(PREFIX)/bin/taverner

.PHONY: install
