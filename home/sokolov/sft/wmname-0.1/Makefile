# wmname - prints/sets the WM name

include config.mk

SRC = wmname.c
OBJ = ${SRC:.c=.o}

all: options wmname

options:
	@echo wmname build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"
	@echo "LD       = ${LD}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.mk

wmname: ${OBJ}
	@echo LD $@
	@${LD} -o $@ ${OBJ} ${LDFLAGS}
	@strip $@

clean:
	@echo cleaning
	@rm -f wmname ${OBJ} wmname-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p wmname-${VERSION}
	@cp -R LICENSE Makefile README config.mk ${SRC} wmname-${VERSION}
	@tar -cf wmname-${VERSION}.tar wmname-${VERSION}
	@gzip wmname-${VERSION}.tar
	@rm -rf wmname-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@cp -f wmname ${DESTDIR}${PREFIX}/bin
	@chmod 755 ${DESTDIR}${PREFIX}/bin/wmname

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/wmname

.PHONY: all options clean dist install uninstall
