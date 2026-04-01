using System;
using Microsoft.Data.SqlClient;
namespace Order_Management_System
{
    internal class Program
    {
        static string connectionString = @"Data Source=.\SQLEXPRESS;Initial Catalog=EmployeeDb;Integrated Security=True;Encrypt=True;TrustServerCertificate=True";

        static void Main(string[] args)
        {
            Console.Write("Enter Customer Name: ");
            string customer = Console.ReadLine();
            if (customer == null) customer = "";

            Console.Write("Enter Total Amount: ");
            string amtInput = Console.ReadLine();
            if (amtInput == null) amtInput = "0";
            decimal total = decimal.Parse(amtInput);

            try
            {
                InsertOrderWithItems(customer, total);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: " + ex.Message);
            }

            Console.ReadLine();
        }
        static void InsertOrderWithItems(string customer, decimal total)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                SqlTransaction transaction = conn.BeginTransaction();

                try
                {
                    string orderQuery = "INSERT INTO Orders (CustomerName, TotalAmount) OUTPUT INSERTED.OrderId VALUES (@Name, @Total)";
                    SqlCommand orderCmd = new SqlCommand(orderQuery, conn, transaction);
                    orderCmd.Parameters.AddWithValue("@Name", customer);
                    orderCmd.Parameters.AddWithValue("@Total", total);
                    int orderId = (int)orderCmd.ExecuteScalar();
                    Console.Write("How many items? ");
                    string countInput = Console.ReadLine();
                    if (countInput == null) countInput = "0";
                    int count = int.Parse(countInput);
                    for (int i = 1; i <= count; i++)
                    {
                        Console.WriteLine($"\nItem {i}");
                        Console.Write("Product Name: ");
                        string pname = Console.ReadLine();
                        if (pname == null) pname = "";
                        Console.Write("Quantity: ");
                        string qInput = Console.ReadLine();
                        if (qInput == null) qInput = "0";
                        int qty = int.Parse(qInput);
                        string itemQuery = "INSERT INTO OrderItems (OrderId, ProductName, Quantity) VALUES (@OrderId, @Pname, @Qty)";
                        SqlCommand itemCmd = new SqlCommand(itemQuery, conn, transaction);
                        itemCmd.Parameters.AddWithValue("@OrderId", orderId);
                        itemCmd.Parameters.AddWithValue("@Pname", pname);
                        itemCmd.Parameters.AddWithValue("@Qty", qty);
                        itemCmd.ExecuteNonQuery();
                    }
                    transaction.Commit();
                    Console.WriteLine("\nOrder Saved Successfully ✅");
                }
                catch (Exception)
                {
                    transaction.Rollback();
                    Console.WriteLine("\nTransaction Failed ❌ (All data reverted)");
                }
            }
        }
    }
}