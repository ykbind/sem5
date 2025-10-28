*******************************************************************
INSERT
use employeedb2
switched to db employeedb2
employeedb2>
db.employeedb2.insertMany([{id:106,name:"Anjali",age:19,address:"Pune",Salary:300000,department:"Marketing"},{id:105,name:"Anushka",
age:20,address:"Sangli",Salary:35000,department:"HR"},{id:104,name:"Apurva",age:21,address:"Sangvi",Salary:40000,department:"Engineerin
g"},{id:103,name:"Jyotsna",age:19,address:"Pimpri",Salary:20000,department:"HR"},{id:102,name:"Raj",age:21,address:"Pimpri",Salary:25000,
department:"Marketing"}])
{
*******************************************************************
*******************************************************************
SHOW
db.employeedb2.find()
[
 {
 _id: ObjectId('68e73e092d57d70cb5ba482d'),
 id: 106,
 name: 'Anjali',
 age: 19,
 address: 'Pune',
 Salary: 300000,
 department: 'Marketing'
 },
 {
 _id: ObjectId('68e73e092d57d70cb5ba482e'),
 id: 105,
 name: 'Anushka',
 age: 20,
 address: 'Sangli',
 Salary: 35000,
 department: 'HR'
 },
 {
 _id: ObjectId('68e73e092d57d70cb5ba482f'),
 id: 104,
 name: 'Apurva',
 age: 21,
 address: 'Sangvi',
 Salary: 40000,
 department: 'Engineering'
 },
 {
 _id: ObjectId('68e73e092d57d70cb5ba4830'),
 id: 103,
 name: 'Jyotsna',
 age: 19,
 address: 'Pimpri',
 Salary: 20000,
 department: 'HR'
 },
 {
 _id: ObjectId('68e73e092d57d70cb5ba4831'),
 id: 102,
 name: 'Raj',
 age: 21,
 address: 'Pimpri',
 Salary: 25000,
 department: 'Marketing'
 }
]
*******************************************************************
*******************************************************************
SUM
db.employeedb2.aggregate([{$group:{_id:"$department",totalSalary:{$sum:"$Salary"}}}])
[
 { _id: 'Marketing', totalSalary: 325000 },
 { _id: 'HR', totalSalary: 55000 },
 { _id: 'Engineering', totalSalary: 40000 }
]
*******************************************************************
*******************************************************************
MAX SALARY
employeedb2> db.employeedb2.aggregate([ { $group: { _id: null, MaxSalary: { $max: "$Salary" } } }] )
[ { _id: null, MaxSalary: 300000 } ]
*******************************************************************
*******************************************************************
MIN SALARY
employeedb2> db.employeedb2.aggregate([ { $group: { _id: null, MinSalary: { $min: "$Salary" } } }] )
[ { _id: null, MinSalary: 20000 } ]
*******************************************************************
*******************************************************************
AVERAGE SALARY
employeedb2> db.employeedb2.aggregate([ { $group: { _id: null, averageSalary: { $avg: "$Salary" } } },{$sort:{totalSalary:1}}] )
[ { _id: null, averageSalary: 84000 } ]
*******************************************************************
*******************************************************************
AVG SALARY ON BASIS OF DEPARTMENT
employeedb2> db.employeedb2.aggregate([ { $group: { _id: "$department", totalSalary: { $sum: "$Salary" } } },{$sort:{totalSalary:1}}] )
[
 { _id: 'Engineering', totalSalary: 40000 },
 { _id: 'HR', totalSalary: 55000 },
 { _id: 'Marketing', totalSalary: 325000 }
]
*******************************************************************
*******************************************************************
COUNT
employeedb2> db.employeedb2.aggregate([{$count:"totalemployee"}])
[ { totalemployee: 5 } ]
*******************************************************************
*******************************************************************
SORTING BY AGE
db.employeedb2.find().sort({age:1})
[
 {
 _id: ObjectId('68e73e092d57d70cb5ba482d'),
 id: 106,
 name: 'Anjali',
 age: 19,
 address: 'Pune',
 Salary: 300000,
 department: 'Marketing'
 },
 {
 _id: ObjectId('68e73e092d57d70cb5ba4830'),
 id: 103,
 name: 'Jyotsna',
 age: 19,
 address: 'Pimpri',
 Salary: 20000,
 department: 'HR'
 },
 {
 _id: ObjectId('68e73e092d57d70cb5ba482e'),
 id: 105,
 name: 'Anushka',
 age: 20,
 address: 'Sangli',
 Salary: 35000,
 department: 'HR'
 },
 {
 _id: ObjectId('68e73e092d57d70cb5ba482f'),
 id: 104,
 name: 'Apurva',
 age: 21,
 address: 'Sangvi',
 Salary: 40000,
 department: 'Engineering'
 },
 {
 _id: ObjectId('68e73e092d57d70cb5ba4831'),
 id: 102,
 name: 'Raj',
 age: 21,
 address: 'Pimpri',
 Salary: 25000,
 department: 'Marketing'
 }
]
*******************************************************
********************************************************
INDEX
SINGLE INDEX
employeedb2> db.employeedb2.createIndex({ category: 1 })
category_1
employeedb2> db.employeedb2.getIndexes();
[
 { v: 2, key: { _id: 1 }, name: '_id_' },
 { v: 2, key: { category: 1 }, name: 'category_1' }
]
********************************************************
********************************************************
COMPOUND INDEX
employeedb2> db.employeedb2.createIndex({category:1,Salary:-1})
category_1_Salary_-1
employeedb2> db.employeedb2.getIndexes();
[
 { v: 2, key: { _id: 1 }, name: '_id_' },
 { v: 2, key: { category: 1 }, name: 'category_1' },
 {
 v: 2,
 key: { category: 1, Salary: -1 },
 name: 'category_1_Salary_-1'
 }
]
********************************************************