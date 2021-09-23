using System;
using System.Collections.Generic;
using System.Text;

namespace AssignmentDay2
{
    class BaseAccount
    {
        public int Number { get; set; }
        public string HolderName { get; set; }

        protected void CreateBaseAccount()
        {
            Console.Write("Enter Account Number:");
            Number = Convert.ToInt32(Console.ReadLine());
            Console.Write("Enter the Holder name: ");
            HolderName = Console.ReadLine();
            
        }
        protected void PrintBaseAccount()
        {
            Console.WriteLine($"Account Number: {Number}");
            Console.WriteLine($"Hoder Name: {HolderName}");
        }

    }
    class SavingAccount : BaseAccount
    {
        public decimal Interest  { get; set; }
        protected void CreateSavingAccount()
        {
            CreateBaseAccount();
            Console.Write("Enter the Interest: ");
            Interest = Convert.ToInt32(Console.ReadLine());
            
        }
        protected void PrintSavingAccount()
        {
            PrintBaseAccount();
            Console.WriteLine($"Interest: {Interest}");

        }

    }
    class CheckingAccount: BaseAccount
    {
        public decimal Balence { get; set; }
        protected void CreateCheckingAccount()
        {
            CreateBaseAccount();
            Console.Write("Enter the Balence: ");
            Balence = Convert.ToInt32(Console.ReadLine());
            
        }
        protected void PrintCheckingAccount()
        {
            PrintBaseAccount();
            Console.WriteLine($"Balence: {Balence}");

        }
    }
}
