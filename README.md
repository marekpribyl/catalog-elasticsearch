# catalog-elasticsearch

This is PoC of summary model of products catalog for e-commerce applications. 
The model is not general purpose but specific to catalog domain model. 

### High level summary model for searching

```
Product [...multiple flat attributes...]
    |---[0..*]---> Category [order, ]
    |---[0..*]---> Price [pricelist, finalPrice, originalPrice]
    |---[0..*]---> StockInfo [inventory, stockCount]
    |---[0..*]---> Tag [type, value]
```


### Indexes

Product catalog in multiple languages is required, so index per language to be created:

* catalog_en
* catalog_de
* catalog_cs
* catalog_sk


### Filtering:

* always products in category
* just "onStock" product - stockInfo is defined as sum over some of the inventories
* products with tags, e.g. sizes L, XL and colors RED, BLUE
* price range from-to for prices in given pricelist


### Searching

* Fulltext search
* Search for autocomplete
* Faceted search using the filter


#### Fulltext

Fields: title, description, brand

```
"query": { 
    "multi_match": { 
        "query": "---the text---",
        "fields": ["title", "description", "state"]
    }
}    
```


#### Faceted search

* Buckets: brand, color, size
* Categories/subcategories
* Ranges: price, discount


### Ordering

* default by 'order' attribute of selected category


## ETL

All catalog entries are currently stored in MySQL database

* get product (product, SKUs, categories, prices, tags)
* get stock info across inventories for the product SKUs
* map to summary JSON
* push to Elasticsearch


### Updating

Catalog entries in MySQL DB are periodically updated from backoffice which is source of data.

Two main updates happen:

* Products data update - frequency is once a day
* Inventory update - frequency is every 2 minutes

Elasticsearch indexes must be updated accordingly - frequent small updates of the stock status, and one bigger update once a day.


#### Notes

Specific search for specific value - use "term"
Search on "text" field - use "match" or "multi_match"
Range queries work over number and date fields