#!/bin/sh
echo "Creating image to build from source"
docker build -t sentilo-compiler ./compiler/
echo "Running container for copy into temp directory"
docker run -v /tmp/sentilo:/tmp sentilo-compiler

echo "Copying sentilo-platform-server jar and building docker image..."
cp -R /tmp/sentilo/sentilo/sentilo-platform/sentilo-platform-server/target/appassembler ./sentilo-platform-server/
docker build -t sentilo-platform-server ./sentilo-platform-server/

echo "Copying sentilo-catalog-web war and building docker image..."
cp /tmp/sentilo/sentilo/sentilo-catalog-web/target/sentilo-catalog-web.war ./sentilo-catalog-web/
docker build -t sentilo-catalog-web ./sentilo-catalog-web/

echo "Creating mongodb init script..."
cp ./mongo-init/mongo-init.js.bak ./mongo-init/mongo-init.js
cat /tmp/sentilo/sentilo/scripts/mongodb/init_data.js >> ./mongo-init/mongo-init.js
cat /tmp/sentilo/sentilo/scripts/mongodb/init_test_data.js >> ./mongo-init/mongo-init.js

echo "Running docker-compose..."
docker-compose up -d
