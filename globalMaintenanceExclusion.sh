#########################AUTOMATE MAINTENANCE EXCLUSIONS FOR ALL CLUSTERS AT THE PROJECT################################
#Useful to create a global maintenance exlcusion for every cluster in your project
for CLUSTER in $(gcloud container clusters list --format="value(NAME)");
do
  LOCATION=$(gcloud container clusters list --format="value(location)" --filter="$CLUSTER")
  gcloud container clusters update $CLUSTER --location $LOCATION \
    --add-maintenance-exclusion-name temporalTest \
    --add-maintenance-exclusion-start 2024-10-11 \
    --add-maintenance-exclusion-end 2024-10-12 \
    --add-maintenance-exclusion-scope no_minor_or_node_upgrades
done