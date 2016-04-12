#!/bin/bash
#
# (c) 2013 Mattias Schlenker für Heise Zeitschriftenverlag GmbH & Co KG
#
# Dieses Script wird beim Hochfahren von Desinfec't ausgeführt.
# Es dient zur Wiederherstellung gespeicherter Einstellungen.
# Passen Sie es an, um weitere Einstellungen wiederherzustellen.

#tar -C / -xvJf /opt/desinfect/signatures/persistent/userdata.tar.xz
sudo groupadd -g 1000 user
sudo useradd -g user -u 1000 user
tar -C / -xvJf /opt/desinfect/signatures/persistent/_"${USER}"_`hostname --short`.tar.xz
