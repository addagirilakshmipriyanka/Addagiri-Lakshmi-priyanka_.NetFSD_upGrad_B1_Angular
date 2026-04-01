/*2.	Write a program in C# to accept the name of the user as a command line argument and greet the user as:
	“Hi! username 
	Welcome to the world of C#”*/
namespace programme_2
{
   
    internal class Program
    {
        static void Main(string[] args)
        {
            if (args.Length > 0)
            {
                string username = args[0];
                Console.WriteLine($"Hi! {username}");
                Console.WriteLine("Welcome to the world of C#");

            }
            else
            {
                Console.WriteLine("Please provide your name as a command-line argument.");
            }
        }
    }
}