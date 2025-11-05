/*
Terminal

mongosh

*/

from pymongo import MongoClient

# Connect to MongoDB
client = MongoClient('mongodb://localhost:27017/')
db = client['school']  # Database name
collection = db['student']  # Collection name


def add_student(roll_number, name, age, department):
    """Add a new student with a manually entered roll number."""
    # Check if roll number already exists
    if collection.find_one({"roll_number": roll_number}):
        print("A student with this roll number already exists.")
        return

    student = {
        "roll_number": roll_number,
        "name": name,
        "age": age,
        "department": department
    }
    collection.insert_one(student)
    print(f"Student added successfully! Roll No: {roll_number}")


def list_students():
    """Display all students in the database."""
    students = list(collection.find())
    if not students:
        print("No students found.")
        return

    print("\nStudents in the database:")
    for s in students:
        roll_no = s.get('roll_number', 'N/A')
        name = s.get('name', 'N/A')
        age = s.get('age', 'N/A')
        dept = s.get('department', 'N/A')
        print(f"Roll No: {roll_no} | Name: {name} | Age: {age} | Department: {dept}")


def edit_student(roll_number, new_name, new_age, new_department):
    """Edit student details using roll number."""
    result = collection.update_one(
        {"roll_number": roll_number},
        {"$set": {"name": new_name, "age": new_age, "department": new_department}}
    )
    if result.matched_count:
        print("Student updated successfully.")
    else:
        print("No student found with that roll number.")


def delete_student(roll_number):
    """Delete a student using roll number."""
    result = collection.delete_one({"roll_number": roll_number})
    if result.deleted_count:
        print("Student deleted successfully.")
    else:
        print("No student found with that roll number.")


def main():
    while True:
        print("\n===== Student Management Menu =====")
        print("1. Add student")
        print("2. List students")
        print("3. Edit student")
        print("4. Delete student")
        print("5. Exit")

        choice = input("Enter your choice: ").strip()

        if choice == '1':
            roll_number = input("Enter roll number: ").strip()
            name = input("Enter name: ").strip()
            age = input("Enter age: ").strip()
            department = input("Enter department: ").strip()

            if not roll_number.isdigit():
                print("Roll number must be a number.")
                continue
            if not age.isdigit():
                print("Age must be a number.")
                continue

            add_student(int(roll_number), name, int(age), department)

        elif choice == '2':
            list_students()

        elif choice == '3':
            roll_number = input("Enter roll number to edit: ").strip()
            if not roll_number.isdigit():
                print("Roll number must be a number.")
                continue

            new_name = input("Enter new name: ").strip()
            new_age = input("Enter new age: ").strip()
            new_department = input("Enter new department: ").strip()

            if not new_age.isdigit():
                print("Age must be a number.")
                continue

            edit_student(int(roll_number), new_name, int(new_age), new_department)

        elif choice == '4':
            roll_number = input("Enter roll number to delete: ").strip()
            if not roll_number.isdigit():
                print("Roll number must be a number.")
                continue

            delete_student(int(roll_number))

        elif choice == '5':
            print("Exiting program.")
            break

        else:
            print("Invalid choice. Please try again.")


if __name__ == '__main__':
    main()
