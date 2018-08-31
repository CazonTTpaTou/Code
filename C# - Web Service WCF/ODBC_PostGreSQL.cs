using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.Data.Odbc;

namespace WebServiceJQuery
{
    public class ODBC_PostGreSQL
    {

        // Create the ODBC connection using the unique name you specified when 
// creating your DSN. If desired you may input less information at the
// DSN entry stage and put more in the "DSN=" line below.

// "DSN=MyDSN;UID=Admin;PWD=Test" (UID = User name, PWD = password.)


        // Open the ODBC connection to the PostgreSQL database and display
        // the connection state (status).
        public static void Main() {
                OdbcConnection connection = new OdbcConnection("DSN=PostgreSQL35W");
                connection.Open();
                System.Console.WriteLine("State: " + connection.State.ToString());
    
                // Create an ODBC SQL command that will be executed below. Any SQL 
                // command that is valid with PostgreSQL is valid here (I think, 
                // but am not 100 percent sure. Every SQL command I've tried works).
                string query = "SELECT * FROM results";
                OdbcCommand command = new OdbcCommand(query, connection);

               // Execute the SQL command and return a reader for navigating the results.
               OdbcDataReader reader = command.ExecuteReader();

                // This loop will output the entire contents of the results, iterating
                // through each row and through each field of the row.
                while(reader.Read() == true) 
                {
                    Console.WriteLine("New Row:");
                    for (int i = 0; i < reader.FieldCount; i++)
                    {
                        Console.WriteLine(reader.GetString(i));
                    }
                }

                // Close the reader and connection (commands are not closed).
                reader.Close();
                connection.Close();
                }
    }
}