/*15.	Write a program in C# to accept ten marks and display the following
a.Total
b.Average
c.Minimum marks
d.Maximum marks
e.	Display marks in ascending order
f.	Display marks in descending order */
using System;
namespace Programme_15
{
    internal class Program
    {
        static void Main(string[] args)
        {
            int[] marks = new int[10];
            int total = 0;

            // Input marks
            Console.WriteLine("Enter 10 marks:");
            for (int i = 0; i < 10; i++)
            {
                marks[i] = int.Parse(Console.ReadLine());
                total += marks[i];
            }

            // Average
            double average = total / 10.0;

            // Min & Max
            int min = marks[0];
            int max = marks[0];

            for (int i = 1; i < 10; i++)
            {
                if (marks[i] < min)
                    min = marks[i];

                if (marks[i] > max)
                    max = marks[i];
            }

            // Ascending Order (Bubble Sort)
            int[] asc = (int[])marks.Clone();
            for (int i = 0; i < asc.Length - 1; i++)
            {
                for (int j = 0; j < asc.Length - i - 1; j++)
                {
                    if (asc[j] > asc[j + 1])
                    {
                        int temp = asc[j];
                        asc[j] = asc[j + 1];
                        asc[j + 1] = temp;
                    }
                }
            }

            // Descending Order
            int[] desc = (int[])asc.Clone();
            Array.Reverse(desc);

            // Output
            Console.WriteLine("\nTotal = " + total);
            Console.WriteLine("Average = " + average);
            Console.WriteLine("Minimum = " + min);
            Console.WriteLine("Maximum = " + max);

            Console.WriteLine("\nAscending Order:");
            foreach (int m in asc)
            {
                Console.Write(m + " ");
            }

            Console.WriteLine("\nDescending Order:");
            foreach (int m in desc)
            {
                Console.Write(m + " ");
            }
        }
    }
}