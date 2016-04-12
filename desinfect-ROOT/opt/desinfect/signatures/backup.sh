#!/bin/bash
#
# (c) 2013 Mattias Schlenker für Heise Zeitschriftenverlag GmbH & Co KG
#
# Dieses Script wird beim Herunterfahren von Desinfec't ausgeführt.
# Passen Sie es an, um weitere Einstellungen oder Protokolle zu
# sichern.

mkdir -p /opt/desinfect/signatures/persistent
tar --exclude='signons*' --exclude='Cache' -cvJf /opt/desinfect/signatures/persistent/_"${USER}"_`hostname --short`.tar.xz \
	/home/"${USER}"

