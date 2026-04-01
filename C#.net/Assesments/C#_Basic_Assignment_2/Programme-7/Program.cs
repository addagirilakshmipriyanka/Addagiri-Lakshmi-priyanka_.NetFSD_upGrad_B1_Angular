/*7.	A shopkeeper sells three products whose retail prices are as follows: Product 1, 22.5; product 2, 44.50; and product 3, 9.98. Write an application that reads a series of pairs of numbers as follows:
a)product number
b)quantity sold
and calculate the total price.*/

using System;
namespace Programme_7
{
    internal class Program
    {
        static void Main(string[] args)
        {
            double total = 0;
            int productNumber;
            int quantity;
            double price = 0;
            while (true)
            {
                Console.WriteLine("Enter the product Number(1-3)");
                productNumber = int.Parse(Console.ReadLine());
                if (productNumber == 0)
                    break;
                Console.WriteLine("Enter the quantity");
                quantity = int.Parse(Console.ReadLine());
                switch (productNumber)
                {

                    case 1:
                        price = 22.5;
                        break;
                    case 2:
                        price = 44.50;
                        break;
                    case 3:
                        price = 9.98;
                        break;
                    default:
                        Console.WriteLine("Invalid product number!");
                        continue;
                }
                total = total + price * quantity;
                Console.WriteLine("Total Retail Value: " + total);
            }
            Console.WriteLine("Final  Retail Value: " + total);

        }
    }
}
