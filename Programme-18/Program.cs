//18.	Write a program in C# to accept two words from user and find out if they are same.
namespace Programme_18
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Enter first word: ");
            string word1 = Console.ReadLine();

            Console.Write("Enter second word: ");
            string word2 = Console.ReadLine();

            if (word1 == word2)
            {
                Console.WriteLine("Both words are same");
            }
            else
            {
                Console.WriteLine("Words are different");
            }
        }
    }
}
