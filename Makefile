PREFIX ?= /usr/local

install:
	install -Dm755 taverner $(DESTDIR)$(PREFIX)/bin/taverner
	install -Dm755 barkeep $(DESTDIR)$(PREFIX)/bin/barkeep
