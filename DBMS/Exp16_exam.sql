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

// Q1. •	Calculate average marks per department using aggregation.

db.students.aggregate([
  {
    $group: {
      _id: "$department",
      avg_marks: { $avg: "$marks" }
    }
  }
]);



// Q2. •	Find the highest marks in each department. 
db.students.aggregate([
  {
    $group: {
      _id: "$department",
      highest_marks: { $max: "$marks" }
    }
  }
]);


// Q3. Find the sum of  marks in each department
db.students.aggregate([
  {
    $group: {
      _id: "$department",
      total_marks: { $sum: "$marks" }
    }
  }
]);



// Q4. Count the number of students from each city
db.students.aggregate([
  {
    $group: {
      _id: "$city",
      student_count: { $sum: 1 }
    }
  }
]);


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


// Q6. Create single and composite index on the department field to optimize queries
db.students.createIndex({ department: 1 });

db.students.createIndex({ department: 1, city: 1 });


db.students.getIndexes();



