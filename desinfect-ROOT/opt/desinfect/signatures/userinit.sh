#!/bin/bash
#
# (c) 2013 Mattias Schlenker für Heise Zeitschriftenverlag GmbH & Co KG
#
# Dieses Script wird beim Start von Desinfec't ausgeführt. Passen 
# Sie es an, um eigene Änderungen vorzunehmen, beispielsweise 
# Software mit dem Kommando dpkg -i ... nachzuinstallieren oder 
# weitere Dienste zu starten.
# 
# Die Partition, auf der sich dieses Script, persistente Signaturen
# und gespeicherte Einstellungen befinden wird im laufenden 
# Desinfec't-System nach /opt/desinfect/signatures gemountet.
# #####################################################################
#
# Matthias Kahlenberger, Berlin 2016
URL=https://github.com/kahlenberger-production-tethys/Configuration/archive/PRODUCTION.RUNNING.tar.gz
HTTPS_PROXY=http://10.0.0.1:1080/
#
wget "${URL}" || (export https_proxy=$HTTPS_PROXY ; wget $URL ) 
[ "${?}" -eq 0 ] && tar -xzf PRODUCTION.RUNNING.tar.gz
exit 0
