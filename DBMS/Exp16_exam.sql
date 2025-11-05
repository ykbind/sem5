use CollegeDB
switched to db CollegeDB

// Create and insert sample data
db.students.insertMany([
  { name: "Riya", department: "Computer", marks: 85, city: "Pune" },
  { name: "Aarav", department: "IT", marks: 78, city: "Mumbai" },
  { name: "Neha", department: "Computer", marks: 92, city: "Nashik" },
  { name: "Karan", department: "Mechanical", marks: 88, city: "Pune" },
  { name: "Sneha", department: "IT", marks: 69, city: "Mumbai" },
  { name: "Rohan", department: "Computer", marks: 75, city: "Pune" },
  { name: "Tina", department: "Mechanical", marks: 95, city: "Nashik" }
]);
/*{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('690a4f616dda139e99cebeb7'),
    '1': ObjectId('690a4f616dda139e99cebeb8'),
    '2': ObjectId('690a4f616dda139e99cebeb9'),
    '3': ObjectId('690a4f616dda139e99cebeba'),
    '4': ObjectId('690a4f616dda139e99cebebb'),
    '5': ObjectId('690a4f616dda139e99cebebc'),
    '6': ObjectId('690a4f616dda139e99cebebd')
  }
}*/

// Q1. •	Calculate average marks per department using aggregation.

db.students.aggregate([
  {
    $group: {
      _id: "$department",
      avg_marks: { $avg: "$marks" }
    }
  }
]);

/*[
  { _id: 'Mechanical', avg_marks: 91.5 },
  { _id: 'Computer', avg_marks: 84 },
  { _id: 'IT', avg_marks: 73.5 }
]*/

// Q2. •	Find the highest marks in each department. 
db.students.aggregate([
  {
    $group: {
      _id: "$department",
      highest_marks: { $max: "$marks" }
    }
  }
]);

/*[
  { _id: 'IT', highest_marks: 78 },
  { _id: 'Computer', highest_marks: 92 },
  { _id: 'Mechanical', highest_marks: 95 }
]*/

// Q3. Find the sum of  marks in each department
db.students.aggregate([
  {
    $group: {
      _id: "$department",
      total_marks: { $sum: "$marks" }
    }
  }
]);

/*[
  { _id: 'Mechanical', total_marks: 183 },
  { _id: 'Computer', total_marks: 252 },
  { _id: 'IT', total_marks: 147 }
]*/

// Q4. Count the number of students from each city
db.students.aggregate([
  {
    $group: {
      _id: "$city",
      student_count: { $sum: 1 }
    }
  }
]);
/*[
[
  { _id: 'Mumbai', student_count: 2 },
  { _id: 'Pune', student_count: 3 },
  { _id: 'Nashik', student_count: 2 }
]*/

// Q5. Calculate sum of  marks per department using aggregation arrange result in ascending order.
db.students.aggregate([
  {
    $group: {
      _id: "$department",
      total_marks: { $sum: "$marks" }
    }
  },
  { $sort: { total_marks: 1 } }
]);

/*[
  { _id: 'IT', total_marks: 147 },
  { _id: 'Mechanical', total_marks: 183 },
  { _id: 'Computer', total_marks: 252 }
]*/

// Q6. Create single and composite index on the department field to optimize queries
db.students.createIndex({ department: 1 });
department_1

db.students.createIndex({ department: 1, city: 1 });
department_1_city_1

db.students.getIndexes();
[
  { v: 2, key: { _id: 1 }, name: '_id_' },
  { v: 2, key: { department: 1 }, name: 'department_1' },
  {
    v: 2,
    key: { department: 1, city: 1 },
    name: 'department_1_city_1'
  }
]
