// 10.	Write a program in C# to generate a Fibonacci series till 40.
namespace Programme_10
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int num1 = 0;
            int num2 = 0;
            int num3 =1;
            Console.WriteLine(num1);
            Console.WriteLine(num2);
            while (num3 < 40)
            {
                Console.WriteLine(num3);
               
                num1 = num2;
                num2 = num3;
                num3 = num1 + num2;
            }
        }
    }
}
