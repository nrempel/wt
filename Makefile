PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

.PHONY: install uninstall lint format test release

install:
	install -d "$(DESTDIR)$(BINDIR)"
	install -m 0755 wt "$(DESTDIR)$(BINDIR)/wt"

uninstall:
	rm -f "$(DESTDIR)$(BINDIR)/wt"

lint:
	shellcheck wt

format:
	shfmt -w wt

test:
	./tests/smoke.sh

release:
	./scripts/package.sh "$(VERSION)"
