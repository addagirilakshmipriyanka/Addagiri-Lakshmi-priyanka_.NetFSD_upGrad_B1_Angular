using System;
using Microsoft.Data.SqlClient;

namespace SchoolManagement
{
    internal class Program
    {
        static string connectionString = @"Data Source=.\SQLEXPRESS;Initial Catalog=SchoolDB;Integrated Security=True;Encrypt=True;TrustServerCertificate=True";

        static void Main(string[] args)
        {
            while (true)
            {
                Console.WriteLine("\n==== Student Management System ====");
                Console.WriteLine("1. Insert Student");
                Console.WriteLine("2. View Students");
                Console.WriteLine("3. Update Student");
                Console.WriteLine("4. Delete Student");
                Console.WriteLine("5. Exit");
                Console.Write("Enter your choice: ");

                int choice = int.Parse(Console.ReadLine()!);

                try
                {
                    switch (choice)
                    {
                        case 1:
                            Console.Write("Enter Name: ");
                            string name = Console.ReadLine();
                            if (name == null)
                            {
                                name = "";
                            }

                            Console.Write("Enter Age: ");
                            int age = int.Parse(Console.ReadLine()!);

                            Console.Write("Enter Grade: ");
                            string grade = Console.ReadLine();
                            if (grade == null)
                            {
                                grade = "";
                            }

                            InsertStudent(name, age, grade);
                            break;

                        case 2:
                            GetAllStudents();
                            break;

                        case 3:
                            Console.Write("Enter Student Id: ");
                            int uid = int.Parse(Console.ReadLine()!);

                            Console.Write("Enter New Grade: ");
                            string newGrade = Console.ReadLine();
                            if (newGrade == null)
                            {
                                newGrade = "";
                            }

                            UpdateStudentGrade(uid, newGrade);
                            break;

                        case 4:
                            Console.Write("Enter Student Id: ");
                            int did = int.Parse(Console.ReadLine()!);

                            DeleteStudent(did);
                            break;

                        case 5:
                            Console.WriteLine("Exiting...");
                            return;

                        default:
                            Console.WriteLine("Invalid Choice");
                            break;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error: " + ex.Message);
                }
            }
        }

        // 🔹 INSERT
        static void InsertStudent(string name, int age, string grade)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Student (Name, Age, Grade) VALUES (@Name, @Age, @Grade)";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Name", name);
                    cmd.Parameters.AddWithValue("@Age", age);
                    cmd.Parameters.AddWithValue("@Grade", grade);

                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();
                    Console.WriteLine(rows + " Student Inserted");
                }
            }
        }

        // 🔹 READ
        static void GetAllStudents()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Student";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    Console.WriteLine("\nStudent List:");

                    while (reader.Read())
                    {
                        Console.WriteLine(
                            reader["Id"] + " | " +
                            reader["Name"] + " | " +
                            reader["Age"] + " | " +
                            reader["Grade"]
                        );
                    }
                }
            }
        }

        // 🔹 UPDATE
        static void UpdateStudentGrade(int id, string grade)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Student SET Grade=@Grade WHERE Id=@Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Grade", grade);
                    cmd.Parameters.AddWithValue("@Id", id);

                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();
                    Console.WriteLine(rows + " Student Updated");
                }
            }
        }

        // 🔹 DELETE
        static void DeleteStudent(int id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Student WHERE Id=@Id";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Id", id);

                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();
                    Console.WriteLine(rows + " Student Deleted");
                }
            }
        }
    }
}