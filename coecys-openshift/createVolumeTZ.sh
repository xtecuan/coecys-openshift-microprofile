#!/bin/bash
oc create configmap tz-el-salvador --from-file=localtime=/usr/share/zoneinfo/America/El_Salvador
oc set volumes dc/coecys-openshift --add \
    --type=configmap --name=tz --configmap-name=tz-el-salvador \
    --mount-path=/etc/localtime --sub-path=localtime