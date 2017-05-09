# catalog-elasticsearch

Summary model for searching to be created:

```
Product [...multiple flat attributes...]
    |---[0..*]---> Category [order, ]
    |---[0..*]---> Price [pricelist, finalPrice, originalPrice]
    |---[0..*]---> StockInfo [inventory, stockCount]
    |---[0..*]---> Tag [type, value]
```

Filtering:

* always products in category
* just "onStock" product - stockInfo is defined as sum over some of the inventories
* products with tags, e.g. sizes L, XL and colors RED, BLUE
* price range from-to in predefined procelist

Ordering:

* default by 'order' attribute of selected category

Product catalog per language will be created.

