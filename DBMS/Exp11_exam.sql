use ICEM
switched to db ICEM

db.Teachers.insertMany([
{ Tname: "Praveen", dno: 1, dname: "Computer", experience: 5, salary: 12000, date_of_joining: "2019-06-10" },
{ Tname: "Meena", dno: 2, dname: "IT", experience: 7, salary: 15000, date_of_joining: "2018-05-15" },
{ Tname: "Ravi", dno: 3, dname: "E&TC", experience: 4, salary: 9500, date_of_joining: "2020-03-12" },
{ Tname: "Anita", dno: 4, dname: "Mechanical", experience: 6, salary: 13000, date_of_joining: "2017-08-20" }
])

{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('690a44386dda139e99cebea4'),
    '1': ObjectId('690a44386dda139e99cebea5'),
    '2': ObjectId('690a44386dda139e99cebea6'),
    '3': ObjectId('690a44386dda139e99cebea7')
  }
}

db.Students.insertMany([
  { Sname: "Rohit", roll_no: 1, class: "FE" },
  { Sname: "xyz", roll_no: 2, class: "SE" },
  { Sname: "Sonal", roll_no: 3, class: "TE" }
])
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId('690a44406dda139e99cebea8'),
    '1': ObjectId('690a44406dda139e99cebea9'),
    '2': ObjectId('690a44406dda139e99cebeaa')
  }
}

// Q1. Find the information of all teachers.

db.Teachers.find()
[
  {
    _id: ObjectId('690a44386dda139e99cebea4'),
    Tname: 'Praveen',
    dno: 1,
    dname: 'Computer',
    experience: 5,
    salary: 12000,
    date_of_joining: '2019-06-10'
  },
  {
    _id: ObjectId('690a44386dda139e99cebea5'),
    Tname: 'Meena',
    dno: 2,
    dname: 'IT',
    experience: 7,
    salary: 15000,
    date_of_joining: '2018-05-15'
  },
  {
    _id: ObjectId('690a44386dda139e99cebea6'),
    Tname: 'Ravi',
    dno: 3,
    dname: 'E&TC',
    experience: 4,
    salary: 9500,
    date_of_joining: '2020-03-12'
  },
  {
    _id: ObjectId('690a44386dda139e99cebea7'),
    Tname: 'Anita',
    dno: 4,
    dname: 'Mechanical',
    experience: 6,
    salary: 13000,
    date_of_joining: '2017-08-20'
  }
]

// Q2. Find the details of teachers working in 'Computer' department.

db.Teachers.find({ dname: "Computer" })
[
  {
    _id: ObjectId('690a44386dda139e99cebea4'),
    Tname: 'Praveen',
    dno: 1,
    dname: 'Computer',
    experience: 5,
    salary: 12000,
    date_of_joining: '2019-06-10'
  }
]

// Q3. Find the details of teachers working in 'Computer', 'IT' and 'E&TC' departments.

db.Teachers.find({ dname: { $in: ["Computer", "IT", "E&TC"] } })
[
  {
    _id: ObjectId('690a44386dda139e99cebea4'),
    Tname: 'Praveen',
    dno: 1,
    dname: 'Computer',
    experience: 5,
    salary: 12000,
    date_of_joining: '2019-06-10'
  },
  {
    _id: ObjectId('690a44386dda139e99cebea5'),
    Tname: 'Meena',
    dno: 2,
    dname: 'IT',
    experience: 7,
    salary: 15000,
    date_of_joining: '2018-05-15'
  },
  {
    _id: ObjectId('690a44386dda139e99cebea6'),
    Tname: 'Ravi',
    dno: 3,
    dname: 'E&TC',
    experience: 4,
    salary: 9500,
    date_of_joining: '2020-03-12'
  }
]

// Q4. Find the information about all teachers of computer,IT,and E&TC department having salary greater than or equal to 10000/-

db.Teachers.find({
  dname: { $in: ["Computer", "IT", "E&TC"] },
  salary: { $gte: 10000 }
})

[
  {
    _id: ObjectId('690a44386dda139e99cebea4'),
    Tname: 'Praveen',
    dno: 1,
    dname: 'Computer',
    experience: 5,
    salary: 12000,
    date_of_joining: '2019-06-10'
  },
  {
    _id: ObjectId('690a44386dda139e99cebea5'),
    Tname: 'Meena',
    dno: 2,
    dname: 'IT',
    experience: 7,
    salary: 15000,
    date_of_joining: '2018-05-15'
  }
]

// Q5. Find the student information having roll_no = 2 or Sname=xyz.

db.Students.find({
  $or: [
    { roll_no: 2 },
    { Sname: "xyz" }
  ]
})

[
  {
    _id: ObjectId('690a44406dda139e99cebea9'),
    Sname: 'xyz',
    roll_no: 2,
    class: 'SE'
  }
]

// Q6. Update the experience of teacher-praveen to 10years, if the entry is not available in database onsider the entry as new entry


db.Teachers.updateOne(
  { Tname: "Praveen" },
  {
    $set: {
      experience: 10,
      dno: 1,
      dname: "Computer",
      salary: 12000,
      date_of_joining: "2019-06-10"
    }
  },
  { upsert: true }   // inserts new if not exists
)

{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}

// Q7. Update the department name from 'IT' to 'COMP' for all teachers working in 'IT' department.

db.Teachers.updateMany(
  { dname: "IT" },
  { $set: { dname: "COMP" } }
)

{
  acknowledged: true,
  insertedId: null,
  matchedCount: 1,
  modifiedCount: 1,
  upsertedCount: 0
}

// Q8. Find the teachers name and their experience from teachers collection

db.Teachers.find({}, { Tname: 1, experience: 1, _id: 0 })
[
  { Tname: 'Praveen', experience: 10 },
  { Tname: 'Meena', experience: 7 },
  { Tname: 'Ravi', experience: 4 },
  { Tname: 'Anita', experience: 6 }
]

// Q9. using save() insert one entry in department collection.

db.department.updateOne(
  { dno: 5 }, // search by primary key or unique field
  {
    $set: {
      dname: "Civil",
      HOD: "Mr. Ajay"
    }
  },
  { upsert: true } // same as save()
)

{
  acknowledged: true,
  insertedId: ObjectId('690a44ba311733ee8e9f2eae'),
  matchedCount: 0,
  modifiedCount: 0,
  upsertedCount: 1
}
I