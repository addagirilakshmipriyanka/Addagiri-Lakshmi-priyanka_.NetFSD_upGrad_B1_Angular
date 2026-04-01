//8.Write a program to print the series: 0,1,4,9,16,.....625

namespace Programme_8
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int total = 0;
            int last = 625;
            int i = 1;
            while (total < last)
            {
                if (i % 2 == 1)
                {
                    total = total + i;
                    Console.WriteLine(total);
                }
                i++;

            }
        }
    }
}
