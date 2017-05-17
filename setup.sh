#!/usr/bin/env bash

#cleanup
curl -s -X DELETE http://localhost:9200/catalog_en
# create index
curl -s -X PUT http://localhost:9200/catalog_en
# mapping
curl -s -X PUT -H "Content-Type: application/json" --data @product_mapping.json http://localhost:9200/catalog_en/_mapping/product
# feed sample data
curl -s -X PUT -H "Content-Type: application/json" --data @sample_data/OM163A.json http://localhost:9200/catalog_en/product/OM163A/_create
curl -s -X PUT -H "Content-Type: application/json" --data @sample_data/OM163B.json http://localhost:9200/catalog_en/product/OM163B/_create
curl -s -X PUT -H "Content-Type: application/json" --data @sample_data/DVS001.json http://localhost:9200/catalog_en/product/DVS001/_create
# test get
curl -s http://localhost:9200/catalog_en/product/OM163A?pretty



