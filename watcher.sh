#/bin/bash
export NAMESPACE_NAME=sre
export DEPLOYMENT_NAME=swype-app
MAX_RESTARTS_ALLOWED=3
while [ true  ]
do  
    result=$(kubectl get pods -n $NAMESPACE_NAME --no-headers | grep $DEPLOYMENT_NAME | awk '{print $4}')
    echo "Restart Counter for deployment $DEPLOYMENT_NAME - $result"
    if [ $result -le $MAX_RESTARTS_ALLOWED ]
    then
        sleep 1m
    else
        kubectl scale --replicas=0 deployment/$DEPLOYMENT_NAME -n $NAMESPACE_NAME
        break
    fi
done
