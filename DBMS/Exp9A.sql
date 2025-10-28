test> use ani
switched to db ani
ani> db.student.insertOne({name:"anisha"},{age:20},{address:"pune"})
{
 acknowledged: true,
 insertedId: ObjectId('68e757af8703af4ba389b03d')
}
ani>
db.student.insertMany([{name:"garima",age:20,address:"nasik"},{name:"shivai",age:21,address:"na
gar"}])
{
 acknowledged: true,
 insertedIds: {
 '0': ObjectId('68e757da8703af4ba389b03e'),
 '1': ObjectId('68e757da8703af4ba389b03f')
 }
}
ani> db.student.find()
[
 { _id: ObjectId('68e757af8703af4ba389b03d'), name: 'anisha' },
 {
 _id: ObjectId('68e757da8703af4ba389b03e'),
 name: 'garima',
 age: 20,
 address: 'nasik'
 },
 {
 _id: ObjectId('68e757da8703af4ba389b03f'),
 name: 'shivai',
 age: 21,
 address: 'nagar'
 }
]
ani> db.student.find({age:21})
[
 {
 _id: ObjectId('68e757da8703af4ba389b03f'),
 name: 'shivai',
 age: 21,
 address: 'nagar'
 }
]
ani> db.student.find({age:{$gt:20}})
[
 {
 _id: ObjectId('68e757da8703af4ba389b03f'),
 name: 'shivai',
 age: 21,
 address: 'nagar'
 }
]
ani> db.student.find({age:{$lt:20}})
ani> db.student.find({age:{$lte:20}})
[
 {
 _id: ObjectId('68e757da8703af4ba389b03e'),
 name: 'garima',
 age: 20,
 address: 'nasik'
 }
]
ani> db.student.find({$and:[{age:{$lt:21}},{address:"nagar"}]})
...
ani> db.student.find({$and:[{age:{$gte:21}},{address:"nagar"}]})
[
 {
 _id: ObjectId('68e757da8703af4ba389b03f'),
 name: 'shivai',
 age: 21,
 address: 'nagar'
 }
]
ani> db.student.find({age:[{$not:{$lt:20}}]})
ani> db.student.find({age:[{$not:{$gte:20}}]})
ani> db.student.find({$nor:[{age:{$not:{$lt:21}}},{address:"nagar"}]})
...
[
 {
 _id: ObjectId('68e757da8703af4ba389b03e'),
 name: 'garima',
 age: 20,
 address: 'nasik'
 }
]
SyntaxError: Unexpected token, expected "," (1:52)
> 1 | db.student.find({$or:[{age:{$not:{$lt:21}}}, address:"nagar"}]})
 | ^
 2 | db.student.find({$or:[{age:{$not:{$lt:21}}}, {address:"nagar"}]})
 3 |
ani> db.student.find({$or:[{age:{$not:{$lt:21}}}, {address:"nagar"}]})
[
 { _id: ObjectId('68e757af8703af4ba389b03d'), name: 'anisha' },
 {
 _id: ObjectId('68e757da8703af4ba389b03f'),
 name: 'shivai',
 age: 21,
 address: 'nagar'
 }
]
ani> db.student.updateOne({name:"anisha"},{$set:{age:19}})
{
 acknowledged: true,
 insertedId: null,
 matchedCount: 1,
 modifiedCount: 1,
 upsertedCount: 0
}
ani> db.student.find()
[
 {
 _id: ObjectId('68e757af8703af4ba389b03d'),
 name: 'anisha',
 age: 19
 },
 {
 _id: ObjectId('68e757da8703af4ba389b03e'),
 name: 'garima',
 age: 20,
 address: 'nasik'
 },
 {
 _id: ObjectId('68e757da8703af4ba389b03f'),
 name: 'shivai',
 age: 21,
 address: 'nagar'
 }
]
ani> db.collection.updateOne(
... { _id: 123 }, // query filter
... { $set: { name: "Alice" } }, // update operation
... { upsert: true } // options: upsert enabled
... { $set: { name: "Alice" } }, // update operation
Uncaught:
SyntaxError: Unexpected token, expected "," (5:2)
 3 | { $set: { name: "Alice" } }, // update operation
 4 | { upsert: true } // options: upsert enabled
> 5 | { $set: { name: "Alice" } }, // update operation
 | ^
 6 |
ani> db.student.updateOne(
... {
... name:"mana",
...
... })
ani> db.student.find()
[
 {
 _id: ObjectId('68e757af8703af4ba389b03d'),
 name: 'anisha',
 age: 19
 },
 {
 _id: ObjectId('68e757da8703af4ba389b03e'),
 name: 'garima',
 age: 20,
 address: 'nasik'
 }
]
ani> db.student.updateOne(
... {name:"mana"},
... {$set:{name:"mana"}},
... {upsert:true},
... );
{
 acknowledged: true,
 insertedId: ObjectId('68e75c247721033c07bd3465'),
 matchedCount: 0,
 modifiedCount: 0,
 upsertedCount: 1
}
ani> db.student.find()
[
 {
 _id: ObjectId('68e757af8703af4ba389b03d'),
 name: 'anisha',
 age: 19
 },
 {
 _id: ObjectId('68e757da8703af4ba389b03e'),
 name: 'garima',
 age: 20,
 address: 'nasik'
 },
 { _id: ObjectId('68e75c247721033c07bd3465'), name: 'mana' }
]
ani>