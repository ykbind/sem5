// Insert sample data into zipcode and employee collections

db.zipcode.insertMany([
{ _id: "10280", city: "NEW YORK", state: "NY", pop: 5574 },
{ _id: "20101", city: "LOS ANGELES", state: "CA", pop: 180000 },
{ _id: "30301", city: "CHICAGO", state: "IL", pop: 220000 },
{ _id: "40001", city: "HOUSTON", state: "TX", pop: 85000 },
{ _id: "50001", city: "DALLAS", state: "TX", pop: 125000 }
])
{
  acknowledged: true,
  insertedIds: {
    '0': '10280',
    '1': '20101',
    '2': '30301',
    '3': '40001',
    '4': '50001'
  }
}

// Insert sample data into employee collection

db.employee.insertMany([
  { emp_no: 1, name: "Amit", dept: "IT", salary: 20000 },
  { emp_no: 2, name: "Ravi", dept: "HR", salary: 15000 },
  { emp_no: 3, name: "Sonal", dept: "IT", salary: 30000 },
  { emp_no: 4, name: "Meena", dept: "Finance", salary: 18000 },
  { emp_no: 5, name: "Raj", dept: "HR", salary: 20000 }
])

{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('690a48226dda139e99cebeab'),
    '1': ObjectId('690a48226dda139e99cebeac'),
    '2': ObjectId('690a48226dda139e99cebead'),
    '3': ObjectId('690a48226dda139e99cebeae'),
    '4': ObjectId('690a48226dda139e99cebeaf')
  }
}

// Q1. Return States with Populations above 1 Lakh.

db.zipcode.find({ pop: { $gt: 100000 } })
[
  { _id: '20101', city: 'LOS ANGELES', state: 'CA', pop: 180000 },
  { _id: '30301', city: 'CHICAGO', state: 'IL', pop: 220000 },
  { _id: '50001', city: 'DALLAS', state: 'TX', pop: 125000 }
]

// Q2. . Display the department wise average salary

db.employee.aggregate([
  { $group: { _id: "$dept", avg_salary: { $avg: "$salary" } } }
])

[
  { _id: 'HR', avg_salary: 17500 },
  { _id: 'IT', avg_salary: 25000 },
  { _id: 'Finance', avg_salary: 18000 }
]

// Q3. Display the no. Of employees working in each department

db.employee.aggregate([
  { $group: { _id: "$dept", no_of_employees: { $sum: 1 } } }
])

[
  { _id: 'Finance', no_of_employees: 1 },
  { _id: 'IT', no_of_employees: 2 },
  { _id: 'HR', no_of_employees: 2 }
]

// Q4. Display the department wise total salary of departments having total salary greater than or equals to 50000/-

db.employee.aggregate([
  { $group: { _id: "$dept", total_salary: { $sum: "$salary" } } },
  { $match: { total_salary: { $gte: 50000 } } }
])

[ { _id: 'IT', total_salary: 50000 } ]

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

[
  {
    _id: 'Finance',
    max_salary: 18000,
    min_salary: 18000,
    total_salary: 18000
  },
  {
    _id: 'IT',
    max_salary: 30000,
    min_salary: 20000,
    total_salary: 50000
  },
  {
    _id: 'HR',
    max_salary: 20000,
    min_salary: 15000,
    total_salary: 35000
  }
]

// Q6. Create the simple index on roll_no field

db.students.createIndex({ roll_no: 1 })
roll_no_1

// Q7. create unique index on any field for above given collections

db.employee.createIndex({ emp_no: 1 }, { unique: true })
emp_no_1

// Q8. create compound index on any fields for above given collections

db.employee.createIndex({ dept: 1, salary: -1 })
dept_1_salary_-1

show collections
department
employee
students
Students
Teachers
zipcode

// Q9 Show all the indexes created in the database 

db.employee.getIndexes()
[
  { v: 2, key: { _id: 1 }, name: '_id_' },
  { v: 2, key: { emp_no: 1 }, name: 'emp_no_1', unique: true },
  { v: 2, key: { dept: 1, salary: -1 }, name: 'dept_1_salary_-1' }
]

//Q10 Show all the indexes created above collections

db.students.getIndexes()
[
  { v: 2, key: { _id: 1 }, name: '_id_' },
  { v: 2, key: { roll_no: 1 }, name: 'roll_no_1' }
]
ICEM>