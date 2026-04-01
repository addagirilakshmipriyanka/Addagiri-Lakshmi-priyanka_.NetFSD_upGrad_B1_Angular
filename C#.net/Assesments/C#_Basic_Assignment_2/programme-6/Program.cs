//6.	Write a program in C# to display temperature in Celsius. Accept the temperature in Fahrenheit.
namespace programme_6
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.Write("enter the temperature into celcius =");
            double f  =Convert.ToDouble(Console.ReadLine());
            double c = (f - 32) * 5 / 9;
            Console.WriteLine("Temperature in celsius = " + c);

        }
    }
}
