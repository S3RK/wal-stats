#!/bin/sh

TIME=`date +%s`
DIR=/tmp/wals/${TIME}
mkdir -p $DIR
cd $DIR
kubectl get po --all-namespaces -l "node=node1,name=database" --no-headers | awk '{print $2" -n"$1}' | xargs -I {} sh -c 'kubectl exec {} -- ls -l --full-time /var/lib/postgresql/data/pg_xlog > "{}.txt"'
