##################################Automation at organization level####################################3
#This will describe every cluster at every project at your organization
for PROJECT in $(gcloud projects list --format="value(projectId)")
do
  echo "The project being scanned is: " $PROJECT
    for CLUSTER in $(gcloud container clusters list --project $PROJECT --format="value(NAME)");
    do
        echo "The cluster being scanned is: " $CLUSTER
        LOCATION=$(gcloud container clusters list --format="value(location)" --filter="$CLUSTER")
        gcloud container clusters get-credentials $CLUSTER --location $LOCATION
        kubectl get nodes
        echo "Description for the nodes listed:"
        for NODE in $(kubectl get nodes -o jsonpath="{.items[*].metadata.name}")
        do
            kubectl describe node $NODE 
            echo "#########################NEXTNODE#########################"
        done
done > $PROJECT-report.csv