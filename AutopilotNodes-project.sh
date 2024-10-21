################AUTOMATE THE NODE DESCRIBE FOR ALL NODES IN ONE PROJECT (Useful for Autopilot invisible VMs) ##########################


for CLUSTER in $(gcloud container clusters list --format="value(NAME)");
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
done > report.csv