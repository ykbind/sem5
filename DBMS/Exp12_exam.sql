use ZipcodeDB;

db.zipcode.insertMany([
  { _id: "10280", city: "NEW YORK", state: "NY", pop: 5574 },
  { _id: "10282", city: "NEW YORK", state: "NY", pop: 12000 },
  { _id: "90001", city: "LOS ANGELES", state: "CA", pop: 40000 },
  { _id: "90002", city: "SAN DIEGO", state: "CA", pop: 12000 },
  { _id: "73301", city: "AUSTIN", state: "TX", pop: 85000 },
  { _id: "77001", city: "HOUSTON", state: "TX", pop: 95000 },
  { _id: "60601", city: "CHICAGO", state: "IL", pop: 50000 },
  { _id: "60602", city: "CHICAGO", state: "IL", pop: 70000 }
]);

// Q1. Return States with Populations above 1 Lakh.
db.zipcode.aggregate([
  {
    $group: {
      _id: "$state",
      total_pop: { $sum: "$pop" }
    }
  },
  {
    $match: { total_pop: { $gt: 100000 } }
  }
]);

// Q2. Create a single-field index on the city field.
db.zipcode.createIndex({ city: 1 });

// Q3. Create a compound index on the state and city fields.
db.zipcode.createIndex({ state: 1, city: 1 });

// Q4. Find the total population for each state.
db.zipcode.aggregate([
  {
    $group: {
      _id: "$state",
      total_population: { $sum: "$pop" }
    }
  }
]);

// Q5. Find the average population per city within each state.
db.zipcode.aggregate([
  {
    $group: {
      _id: { state: "$state", city: "$city" },
      avg_pop: { $avg: "$pop" }
    }
  }
]);

// Q6. List the states having total population greater than 20,000.
db.zipcode.aggregate([
  {
    $group: {
      _id: "$state",
      total_population: { $sum: "$pop" }
    }
  },
  {
    $match: { total_population: { $gte: 20000 } }
  }
]);

// Q7. Retrieve all cities in California (state = 'CA') with a population greater than 10,000.
db.zipcode.find(
  { state: "CA", pop: { $gt: 10000 } },
  { city: 1, pop: 1, _id: 0 }
);

// Show all the indexes created on the zipcode collection.
db.zipcode.getIndexes();
