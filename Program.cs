using System;

namespace ConsoleApp1
{
    class Program
    {
        static void Main(string[] args)
        {
            //Console.WriteLine("Hello World!");
            Program prom = new Program();
            Console.WriteLine(prom.FindFactorial(6));
            Console.WriteLine(prom.isPrime(12));
            Console.WriteLine(prom.isLeap(2001));
            Console.WriteLine(prom.LCM(200, 200));
        }
        // Find the factorial of a number
        public long FindFactorial(int a)
        {
            long res = 1;
            while(a > 0)
            {
                res *= a;
                a--;
            }
            return res;
        }
        // if a number is prime or not
        public bool isPrime(int a)
        {
            for (int i = 2; i < a/2; i++)
            {
                if(a%i == 0)
                {
                    return false;
                }
            }
            return true;
        }
        // if a year is leap or not
        public bool isLeap(int year)
        {
            return (year % 100 != 0 && year % 4 == 0) || year % 400 == 0;
        }

        public int LCM(int a, int b)
        {
            return a * b / GCD(a, b);


        }
        private int GCD(int a, int b)
        {
            if(b == 0){
                return a;
            }
            return GCD(b, a % b);
        }
        /
    }
}
