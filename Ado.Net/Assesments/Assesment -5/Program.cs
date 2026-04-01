using System;
using Microsoft.Data.SqlClient;
namespace Library_Management_System
{
    internal class Program
    {
        static string connectionString = @"Data Source=.\SQLEXPRESS;Initial Catalog=EmployeeDb;Integrated Security=True;Encrypt=True;TrustServerCertificate=True";
        static void Main(string[] args)
        {
            while (true)
            {
                Console.WriteLine("\n==== Library Management System ====");
                Console.WriteLine("1. Add Book");
                Console.WriteLine("2. View Books");
                Console.WriteLine("3. Update Book");
                Console.WriteLine("4. Delete Book");
                Console.WriteLine("5. Search Book by Name");
                Console.WriteLine("6. Exit");
                Console.Write("Enter choice: ");

                string input = Console.ReadLine();
                if (input == null) input = "0";
                int choice = int.Parse(input);

                try
                {
                    switch (choice)
                    {
                        case 1:
                            AddBook();
                            break;
                        case 2:
                            ViewBooks();
                            break;
                        case 3:
                            UpdateBook();
                            break;
                        case 4:
                            DeleteBook();
                            break;
                        case 5:
                            SearchBook();
                            break;
                        case 6:
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
        static void AddBook()
        {
            Console.Write("Enter Title: ");
            string title = Console.ReadLine();
            if (title == null) title = "";
            Console.Write("Enter Author: ");
            string author = Console.ReadLine();
            if (author == null) author = "";
            Console.Write("Enter Price: ");
            string p = Console.ReadLine();
            if (p == null) p = "0";
            decimal price = decimal.Parse(p);
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "INSERT INTO Books (Title, Author, Price) VALUES (@Title, @Author, @Price)";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Title", title);
                cmd.Parameters.AddWithValue("@Author", author);
                cmd.Parameters.AddWithValue("@Price", price);
                conn.Open();
                cmd.ExecuteNonQuery();

                Console.WriteLine("Book Added ✅");
            }
        }
        static void ViewBooks()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Books";
                SqlCommand cmd = new SqlCommand(query, conn);
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                Console.WriteLine("\nBooks List:");
                while (reader.Read())
                {
                    Console.WriteLine(
                        reader["BookId"] + " | " +
                        reader["Title"] + " | " +
                        reader["Author"] + " | " +
                        reader["Price"]
                    );
                }
            }
        }
        static void UpdateBook()
        {
            Console.Write("Enter BookId: ");
            string idInput = Console.ReadLine();
            if (idInput == null) idInput = "0";
            int id = int.Parse(idInput);
            Console.Write("Enter New Price: ");
            string p = Console.ReadLine();
            if (p == null) p = "0";
            decimal price = decimal.Parse(p);
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "UPDATE Books SET Price=@Price WHERE BookId=@Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Price", price);
                cmd.Parameters.AddWithValue("@Id", id);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                Console.WriteLine(rows > 0 ? "Book Updated ✅" : "Book Not Found");
            }
        }
        static void DeleteBook()
        {
            Console.Write("Enter BookId: ");
            string idInput = Console.ReadLine();
            if (idInput == null) idInput = "0";
            int id = int.Parse(idInput);
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "DELETE FROM Books WHERE BookId=@Id";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Id", id);
                conn.Open();
                int rows = cmd.ExecuteNonQuery();
                Console.WriteLine(rows > 0 ? "Book Deleted ✅" : "Book Not Found");
            }
        }
        static void SearchBook()
        {
            Console.Write("Enter Book Name: ");
            string name = Console.ReadLine();
            if (name == null) name = "";
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT * FROM Books WHERE Title LIKE @Name";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Name", "%" + name + "%");
                conn.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                Console.WriteLine("\nSearch Results:");
                while (reader.Read())
                {
                    Console.WriteLine(
                        reader["BookId"] + " | " +
                        reader["Title"] + " | " +
                        reader["Author"] + " | " +
                        reader["Price"]
                    );
                }
            }
        }
    }
}