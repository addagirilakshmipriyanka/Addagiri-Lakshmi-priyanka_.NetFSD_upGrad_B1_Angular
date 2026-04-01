//9.Write a program in C# to find the factorial of the given number.

namespace Programme_9
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int fact = 1;
            Console.WriteLine("Enter the  number");
            int num = int.Parse(Console.ReadLine());
            int i = 1;
            while (i <= num)
            {
                fact = fact * i;
                i++;
            }
            Console.WriteLine($"fcatorial of the given number={fact}");
           
        }
    }
}
