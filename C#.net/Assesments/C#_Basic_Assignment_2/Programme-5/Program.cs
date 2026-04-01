// 5.	Write a program in C# to find the total number of odd and even numbers accepted from the user.

namespace Programme_5
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("eneter the number");
            int n = int.Parse(Console.ReadLine());
            int evencount = 0;
            int oddcount = 0;
            for(int i = 1; i <= n; i++)
            {
                Console.Write($"enter the number{i}=");
                int num = int.Parse(Console.ReadLine());
                if (num % 2 == 0)
                {
                    evencount++;
                }
                else
                {
                    oddcount++;
                }
            }
            Console.Write($"\n number of even={evencount}");
            Console.Write($"\n number of odds ={oddcount}");
        }
    }
}
