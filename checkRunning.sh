 #!/bin/bash
 
set -o xtrace
ssh root@157.245.124.180
if [ '$(docker ps -a -q -f name=current_release)' ]; then
    docker rm -vf current_release
    echo "Removing Old Containers"
fi

echo "Running New Container"
docker run -d -p 4001:4000 --name current_release $registry:$BUILD_NUMBER