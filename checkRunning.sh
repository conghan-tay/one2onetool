ssh root@157.245.124.180
if [ '$(docker ps -a -q -f name=current_staging)' ]; then
    docker rm current_staging
    echo "Removing Old Containers"
fi

echo "Running New Container"
docker run -d -p 4000:4000 --name current_staging $registry:$BUILD_NUMBER