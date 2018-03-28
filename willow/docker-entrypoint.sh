#!/bin/bash

echo "Creating log folder"
mkdir -p $APP_WORKDIR/log

# Copy in the version file created during the image build. 
cp /version_info/version.rb $APP_WORKDIR/config/initializers/

if [ "$RAILS_ENV" = "production" ]; then
    # Verify all the production gems are installed
    bundle check
else
    # install any missing development gems (as we can tweak the development container without rebuilding it)
    bundle check || bundle install --without production
fi

## Run any pending migrations
bundle exec rake db:migrate

# Load workflows
bundle exec rake hyrax:workflow:load

# check that Solr is running
SOLR=$(curl --silent --connect-timeout 45 "http://${SOLR_HOST:-solr}:${SOLR_PORT:-8983}/solr/" | grep "Apache SOLR")
if [ -n "$SOLR" ] ; then
    echo "Solr is running..."
else
    echo "ERROR: Solr is not running"
    exit 1
fi

# check that Fedora is running
FEDORA=$(curl --silent --connect-timeout 45 "http://${FEDORA_HOST:-fedora}:${FEDORA_PORT:-8080}/" | grep "Fedora Commons Repository")
if [ -n "$FEDORA" ] ; then
    echo "Fedora is running..."
else
    echo "ERROR: Fedora is not running"
    exit 1
fi

if [ "$WILLOW_SEED" = "true" ] ; then
    echo "(Re)seeding Willow test data... (this can take a few minutes)"
    bundle exec rake willow:seed_test_data["$WILLOW_SEED_FILE"]
fi

echo "--------- Starting Willow in $RAILS_ENV mode ---------"
rm -f /tmp/willow.pid
bundle exec rails server -p 3000 -b '0.0.0.0' --pid /tmp/willow.pid
