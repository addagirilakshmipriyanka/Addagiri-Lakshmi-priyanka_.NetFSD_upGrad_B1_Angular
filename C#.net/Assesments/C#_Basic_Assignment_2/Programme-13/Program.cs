//13.	Write a program in C# to find the largest of the given three numbers. Accept the numbers from the users.
namespace Programme_13
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Enter number 1=");
            int num1 = int.Parse(Console.ReadLine());
            Console.Write("Enter number 2=");
            int num2 = int.Parse(Console.ReadLine());
            Console.Write("Enter number 3=");
            int num3 = int.Parse(Console.ReadLine());
            if (num1 >= num2 && num1 >= num3)
            {
                Console.WriteLine(num1 + " is largest");
            }
            else if (num2 >= num1 && num2 >= num3)
            {
                Console.WriteLine(num2 + " is largest");
            }
            else
            {
                Console.WriteLine(num3 + " is largest");
            }
        }
    }
        }