//3.	Write a program in C# to accept two numbers as command line argument and display all the numbers between the given two numbers.
namespace Programme_3
{
    internal class Program
    {
        static void Main(string[] args)
        {
            if (args.Length >= 2)
            {
                int num1 = int.Parse(args[0]);
                int num2 = int.Parse(args[1]);
                if (num1 > num2)
                {
                    int temp = num1;
                    num1 = num2;
                    num2 = num1;
                }
                for(int n = num1 + 1; n < num2; n++)
                {
                    Console.WriteLine(n);
                }
            }
            else
            {
                Console.WriteLine("enter valid details");
            }
        }
    }
}
