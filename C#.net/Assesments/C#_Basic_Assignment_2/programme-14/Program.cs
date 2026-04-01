//14 Write a program in C# to find the smallest of five numbers accepted from the user.

namespace programme_14
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("enter the  5 numbers");
            int num1 = int.Parse(Console.ReadLine());
            int num2 = int.Parse(Console.ReadLine());
            int num3 = int.Parse(Console.ReadLine());
            int num4 = int.Parse(Console.ReadLine());
            int num5 = int.Parse(Console.ReadLine());
            if(num1<num2 && num1<num3 && num1<num4 && num1 < num5)
            {
                Console.WriteLine("smallest number is " + num1);
            }
            else if (num2 < num1 && num2 < num3 && num2 < num4 && num2 < num5)
            {
                Console.WriteLine("smallest number is " + num2);
            }
            else if (num3 < num1 && num3 < num2 && num3 < num4 && num3 < num5)
            {
                Console.WriteLine("smallest number is " + num3);
            }
            else if (num4 < num1 && num4 < num2 && num4 < num3 && num4 < num5)
            {
                Console.WriteLine("smallest number is " + num4);
            }
            else
            {
                Console.WriteLine("smallest number is"+num5);            }
        }
    }
}
