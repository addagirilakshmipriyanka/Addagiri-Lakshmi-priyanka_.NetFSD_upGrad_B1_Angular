using System;
using Microsoft.Data.SqlClient;
using System.Data;

namespace Employee_Management_with_Stored_Procedures
{
    internal class Program
    {
        static string connectionString = @"Data Source=.\SQLEXPRESS;Initial Catalog=EmployeeDb;Integrated Security=True;Encrypt=True;TrustServerCertificate=True";

        static void Main(string[] args)
        {
            while (true)
            {
                Console.WriteLine("\n==== Employee Management System ====");
                Console.WriteLine("1. Insert Employee");
                Console.WriteLine("2. View Employees by Department");
                Console.WriteLine("3. Update Salary");
                Console.WriteLine("4. Delete Employee");
                Console.WriteLine("5. Exit");
                Console.Write("Enter choice: ");

                string inputChoice = Console.ReadLine();
                if (inputChoice == null) inputChoice = "0";
                int choice = int.Parse(inputChoice);

                try
                {
                    switch (choice)
                    {
                        case 1:
                            Console.Write("Enter Name: ");
                            string name = Console.ReadLine();
                            if (name == null) name = "";

                            Console.Write("Enter Salary: ");
                            string salInput = Console.ReadLine();
                            if (salInput == null) salInput = "0";
                            decimal salary = decimal.Parse(salInput);

                            Console.Write("Enter Department: ");
                            string dept = Console.ReadLine();
                            if (dept == null) dept = "";

                            InsertEmployee(name, salary, dept);
                            break;

                        case 2:
                            Console.Write("Enter Department: ");
                            string d = Console.ReadLine();
                            if (d == null) d = "";

                            GetEmployeesByDepartment(d);
                            break;

                        case 3:
                            Console.Write("Enter EmpId: ");
                            string idInput = Console.ReadLine();
                            if (idInput == null) idInput = "0";
                            int id = int.Parse(idInput);

                            Console.Write("Enter New Salary: ");
                            string newSalInput = Console.ReadLine();
                            if (newSalInput == null) newSalInput = "0";
                            decimal newSalary = decimal.Parse(newSalInput);

                            UpdateSalary(id, newSalary);
                            break;

                        case 4:
                            Console.Write("Enter EmpId: ");
                            string delInput = Console.ReadLine();
                            if (delInput == null) delInput = "0";
                            int did = int.Parse(delInput);

                            DeleteEmployee(did);
                            break;

                        case 5:
                            Console.WriteLine("Exiting...");
                            return;

                        default:
                            Console.WriteLine("Invalid choice");
                            break;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine("Error: " + ex.Message);
                }
            }
        }

        // 🔹 INSERT USING STORED PROCEDURE
        static void InsertEmployee(string name, decimal salary, string dept)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("dbo.InsertEmployee", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Name", name);
                cmd.Parameters.AddWithValue("@Salary", salary);
                cmd.Parameters.AddWithValue("@Department", dept);

                conn.Open();
                cmd.ExecuteNonQuery();

                Console.WriteLine("Employee Inserted");
            }
        }

        // 🔹 FETCH BY DEPARTMENT
        static void GetEmployeesByDepartment(string dept)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("dbo.GetEmployeesByDepartment", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@Department", dept);

                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();

                Console.WriteLine("\nEmployees:");

                while (reader.Read())
                {
                    Console.WriteLine(
                        reader["EmpId"] + " | " +
                        reader["Name"] + " | " +
                        reader["Salary"] + " | " +
                        reader["Department"]
                    );
                }
            }
        }

        // 🔹 UPDATE SALARY USING STORED PROCEDURE
        static void UpdateSalary(int id, decimal salary)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                SqlCommand cmd = new SqlCommand("dbo.UpdateEmployeeSalary", conn);
                cmd.CommandType = CommandType.StoredProcedure;

                cmd.Parameters.AddWithValue("@EmpId", id);
                cmd.Parameters.AddWithValue("@Salary", salary);

                conn.Open();
                cmd.ExecuteNonQuery();

                Console.WriteLine("Salary Updated");
            }
        }

        // 🔹 DELETE USING PARAMETERIZED QUERY
        static void DeleteEmployee(int id)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Employees WHERE EmpId=@EmpId";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@EmpId", id);

                conn.Open();
                cmd.ExecuteNonQuery();

                Console.WriteLine("Employee Deleted");
            }
        }
    }
}