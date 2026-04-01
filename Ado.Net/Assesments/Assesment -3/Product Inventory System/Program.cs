using System;
using Microsoft.Data.SqlClient;
using System.Data;
namespace Product_Inventory_System
{
    internal class Program
    {
        static string connectionString = @"Data Source=.\SQLEXPRESS;Initial Catalog=EmployeeDb;Integrated Security=True;Encrypt=True;TrustServerCertificate=True";

        static SqlDataAdapter adapter;
        static DataSet ds = new DataSet();
        static string tableName = "Products";

        static void Main(string[] args)
        {
            LoadData();

            while (true)
            {
                Console.WriteLine("\n==== Product Inventory System ====");
                Console.WriteLine("1. Display Products");
                Console.WriteLine("2. Add Product (Offline)");
                Console.WriteLine("3. Update Price (Offline)");
                Console.WriteLine("4. Delete Product (Offline)");
                Console.WriteLine("5. Save Changes to DB");
                Console.WriteLine("6. Exit");
                Console.Write("Enter choice: ");

                string input = Console.ReadLine();
                if (input == null) input = "0";
                int choice = int.Parse(input);

                switch (choice)
                {
                    case 1:
                        DisplayProducts();
                        break;
                    case 2:
                        AddProduct();
                        break;
                    case 3:
                        UpdateProduct();
                        break;
                    case 4:
                        DeleteProduct();
                        break;
                    case 5:
                        SaveChanges();
                        break;
                    case 6:
                        return;
                }
            }
        }

        // 🔹 LOAD DATA INTO DATASET
        static void LoadData()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                adapter = new SqlDataAdapter("SELECT * FROM Products", conn);

                SqlCommandBuilder builder = new SqlCommandBuilder(adapter);

                adapter.Fill(ds, tableName);
            }
        }

        // 🔹 DISPLAY DATA
        static void DisplayProducts()
        {
            DataTable dt = ds.Tables[tableName];

            Console.WriteLine("\nProducts:");

            foreach (DataRow row in dt.Rows)
            {
                Console.WriteLine(
                    row["ProductId"] + " | " +
                    row["ProductName"] + " | " +
                    row["Price"] + " | " +
                    row["Stock"]
                );
            }
        }

        // 🔹 ADD PRODUCT (OFFLINE)
        static void AddProduct()
        {
            DataTable dt = ds.Tables[tableName];

            Console.Write("Enter Product Name: ");
            string name = Console.ReadLine();
            if (name == null) name = "";

            Console.Write("Enter Price: ");
            string p = Console.ReadLine();
            if (p == null) p = "0";
            decimal price = decimal.Parse(p);

            Console.Write("Enter Stock: ");
            string s = Console.ReadLine();
            if (s == null) s = "0";
            int stock = int.Parse(s);

            DataRow newRow = dt.NewRow();
            newRow["ProductName"] = name;
            newRow["Price"] = price;
            newRow["Stock"] = stock;

            dt.Rows.Add(newRow);

            Console.WriteLine("Product added (offline)");
        }

        // 🔹 UPDATE PRODUCT (OFFLINE)
        static void UpdateProduct()
        {
            DataTable dt = ds.Tables[tableName];

            Console.Write("Enter ProductId: ");
            string idInput = Console.ReadLine();
            if (idInput == null) idInput = "0";
            int id = int.Parse(idInput);

            foreach (DataRow row in dt.Rows)
            {
                if ((int)row["ProductId"] == id)
                {
                    Console.Write("Enter New Price: ");
                    string p = Console.ReadLine();
                    if (p == null) p = "0";

                    row["Price"] = decimal.Parse(p);

                    Console.WriteLine("Updated (offline)");
                    return;
                }
            }

            Console.WriteLine("Product not found");
        }

        // 🔹 DELETE PRODUCT (OFFLINE)
        static void DeleteProduct()
        {
            DataTable dt = ds.Tables[tableName];

            Console.Write("Enter ProductId: ");
            string idInput = Console.ReadLine();
            if (idInput == null) idInput = "0";
            int id = int.Parse(idInput);

            foreach (DataRow row in dt.Rows)
            {
                if ((int)row["ProductId"] == id)
                {
                    row.Delete();
                    Console.WriteLine("Deleted (offline)");
                    return;
                }
            }

            Console.WriteLine("Product not found");
        }

        // 🔹 SAVE CHANGES TO DATABASE
        static void SaveChanges()
        {
            adapter.Update(ds, tableName);
            Console.WriteLine("Changes saved to database ✅");
        }
    }
}