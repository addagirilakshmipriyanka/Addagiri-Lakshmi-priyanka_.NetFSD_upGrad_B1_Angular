//11.	Write a program in C# to find the multiplication table of the given number till 20.
namespace Programme_11
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter the number");
            int num = int.Parse(Console.ReadLine());
            if (num > 20)
            {
                Console.WriteLine("enter  a number less than 20");
            }
            else
            {   
                int i = 1;
                while (i <= 10)
                {
                    Console.WriteLine(num  + "X" + i + "="+num * i);
                    i++;
                }
            }
        }
    }
}
