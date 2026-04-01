//17.Write a program in C# to accept a word from the user and display the reverse of it.

namespace Programme_17
{
    internal class Program
    {
        static void Main(string[] args)
        {
            String word = Console.ReadLine();
            string rev = " ";
            for(int i = word.Length-1; i >= 0; i--)
            {
                rev = rev + word[i];
            }
            Console.WriteLine("Reverse String =" + rev);
        }
    }
}
