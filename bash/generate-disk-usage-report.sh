#!/bin/sh
#
# Script to generate an overview of disk usage per studies in OpenClinica. It is required that the
# user running this script also can run psql and access the openclinica DB.
#


du -sh /opt/tomcat/openclinica.data/attached_files/* | grep -v ./study-name-overview.log | grep '/S_' | awk '{print $2"\t"$1}' | sort | rev | cut -f1 -d '/' | rev > ./disk-usage.log

