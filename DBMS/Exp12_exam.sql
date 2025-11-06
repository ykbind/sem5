// Insert sample data into zipcode and employee collections

db.zipcode.insertMany([
{ _id: "10280", city: "NEW YORK", state: "NY", pop: 5574 },
{ _id: "20101", city: "LOS ANGELES", state: "CA", pop: 180000 },
{ _id: "30301", city: "CHICAGO", state: "IL", pop: 220000 },
{ _id: "40001", city: "HOUSTON", state: "TX", pop: 85000 },
{ _id: "50001", city: "DALLAS", state: "TX", pop: 125000 }
])

// Insert sample data into employee collection

db.employee.insertMany([
  { emp_no: 1, name: "Amit", dept: "IT", salary: 20000 },
  { emp_no: 2, name: "Ravi", dept: "HR", salary: 15000 },
  { emp_no: 3, name: "Sonal", dept: "IT", salary: 30000 },
  { emp_no: 4, name: "Meena", dept: "Finance", salary: 18000 },
  { emp_no: 5, name: "Raj", dept: "HR", salary: 20000 }
])

// Q1. Return States with Populations above 1 Lakh.

db.zipcode.find({ pop: { $gt: 100000 } })

// Q2. . Display the department wise average salary

db.employee.aggregate([
  { $group: { _id: "$dept", avg_salary: { $avg: "$salary" } } }
])



// Q3. Display the no. Of employees working in each department

db.employee.aggregate([
  { $group: { _id: "$dept", no_of_employees: { $sum: 1 } } }
])



// Q4. Display the department wise total salary of departments having total salary greater than or equals to 50000/-

db.employee.aggregate([
  { $group: { _id: "$dept", total_salary: { $sum: "$salary" } } },
  { $match: { total_salary: { $gte: 50000 } } }
])



// Q5. Write the queries using the different operators like max, min. Etc.
db.employee.aggregate([
  {
    $group: {
      _id: "$dept",
      max_salary: { $max: "$salary" },
      min_salary: { $min: "$salary" },
      total_salary: { $sum: "$salary" }
    }
  }
])


// Q6. Create the simple index on roll_no field

db.students.createIndex({ roll_no: 1 })

// Q7. create unique index on any field for above given collections

db.employee.createIndex({ emp_no: 1 }, { unique: true })

  
// Q8. create compound index on any fields for above given collections

db.employee.createIndex({ dept: 1, salary: -1 })

// Q9 Show all the indexes created in the database 

db.employee.getIndexes()

//Q10 Show all the indexes created above collections

db.students.getIndexes()

ICEM>
