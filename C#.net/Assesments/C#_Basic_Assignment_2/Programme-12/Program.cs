//12.Write a program to print the numbers divisible by 7 between 200 and 300.
namespace Programme_12
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int start = 200;
            int end = 300;
            while (start < end)
            {
                if (start % 7 == 0)
                {
                    Console.Write(start+" ");
                }
                start++;
            }
        }
    }
}
