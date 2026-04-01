//19 Write a program in C# to accept a word and to find out whether the given word is a palindrome or not.
namespace Programme_19
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Enter a word: ");
            string word = Console.ReadLine();
            string reverse = "";
            for (int i = word.Length - 1; i >= 0; i--)
            {
                reverse += word[i];
            }
            if (word == reverse)
            {
                Console.WriteLine("Palindrome");
            }
            else
            {
                Console.WriteLine("Not a palindrome");
            }
        }
    }
}
