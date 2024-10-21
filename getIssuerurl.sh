#Helpful if you have more than 2 clusters and want to get the issuer uri

for CLUSTER in $(gcloud container clusters list --format="value(NAME)");
do
  LOCATION=$(gcloud container clusters list --format="value(location)" --filter="$CLUSTER")
  gcloud container clusters get-credentials $CLUSTER --location $LOCATION
  kubectl get --raw /.well-known/openid-configuration | jq -r .issuer
done