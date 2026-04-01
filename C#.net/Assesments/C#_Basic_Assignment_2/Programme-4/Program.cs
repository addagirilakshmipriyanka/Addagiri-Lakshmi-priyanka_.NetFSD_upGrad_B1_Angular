//4.	Accept a number from the user and display whether the given number is an odd number or even number.
namespace Programme_4
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int num = int.Parse(Console.ReadLine());
            if (num % 2 != 0)
            {
                Console.WriteLine(num+"is odd");
            }
            else
            {
                Console.WriteLine(num + "is even ");
            }
        }
        
    }
}

