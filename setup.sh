#!/usr/bin/env bash

#cleanup
curl -s -X DELETE http://localhost:9200/catalog | json_xs
# create index
curl -s -X PUT http://localhost:9200/catalog | json_xs
# mapping
curl -s -X PUT -H "Content-Type: application/json" --data @product_mapping.json http://localhost:9200/catalog/_mapping/product | json_xs
# feed sample data
curl -s -X PUT -H "Content-Type: application/json" --data @sample_data/OM163A.json http://localhost:9200/catalog/product/OM163A/_create | json_xs
curl -s -X PUT -H "Content-Type: application/json" --data @sample_data/OM163B.json http://localhost:9200/catalog/product/OM163B/_create | json_xs
curl -s -X PUT -H "Content-Type: application/json" --data @sample_data/DVS001.json http://localhost:9200/catalog/product/DVS001/_create | json_xs
# test get
curl -s http://localhost:9200/catalog/product/OM163A | json_xs



