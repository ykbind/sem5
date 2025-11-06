//use GroceryStore;
//switched to db GroceryStore

// Insert sample data into grocery_sales collection

db.grocery_sales.insertMany([
  { product_name: "Apple", category: "Fruit", quantity_sold: 50 },
  { product_name: "Banana", category: "Fruit", quantity_sold: 30 },
  { product_name: "Carrot", category: "Vegetable", quantity_sold: 20 },
  { product_name: "Tomato", category: "Vegetable", quantity_sold: 40 },
  { product_name: "Apple", category: "Fruit", quantity_sold: 25 },
  { product_name: "Banana", category: "Fruit", quantity_sold: 15 },
  { product_name: "Carrot", category: "Vegetable", quantity_sold: 10 },
]);



// Map Function: Emit key-value pairs of (product_name, quantity_sold)
var mapFunction = function () {
  emit(this.product_name, this.quantity_sold);
};

 // Reduce Function: Sum up the quantities for each product
var reduceFunction = function (key, values) {
  return Array.sum(values);
};


// Execute MapReduce

db.grocery_sales.mapReduce(mapFunction, reduceFunction, {
  out: "total_sales", // Output collection name
});

// View the results from the output collection

db.total_sales.find().pretty();
