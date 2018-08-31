using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.Data.Odbc;
using System.Web.Script.Serialization;

namespace Connection_ODBC
{
    public class Data
    {
        public static string RetrieveData()
        {
            OdbcConnection connection = new OdbcConnection("DSN=PostgreSQL35W-32bits");
            connection.Open();
            System.Console.WriteLine("State: " + connection.State.ToString());

            //string query = "SELECT \"TimeStamp_Flash\",\"Voc\" FROM results";
            string query = "SELECT * FROM results_cel";

            OdbcCommand command = new OdbcCommand(query, connection);

            // Execute the SQL command and return a reader for navigating the results.
            OdbcDataReader reader = command.ExecuteReader();
           
            List<Mesure> mesure = new List<Mesure>();

            while (reader.Read() == true)
            {
                Mesure mes = new Mesure();
                Frequence fre = new Frequence();

                mes.State = reader.GetString(0);

                fre.low = (int) reader.GetDouble(1);
                fre.mid = (int) reader.GetDouble(2);
                fre.high = (int)reader.GetDouble(3);

                mes.freq = fre;

                mesure.Add(mes);

                /*
                if (!(reader.IsDBNull(reader.GetOrdinal(reader.GetName(1)))))
                {
                    try { voc = reader.GetDouble(1);
                          }
                    catch (Exception) { }
                }*/
                //Tableau[ligne,0] = dateM.ToString();
                //Tableau[ligne] = voc.ToString().Replace(",",".");

                /*Mesure mes = new Mesure();
                mes.Numero = ligne;
                mes.DateHeure = dateM;
                mes.VOC = voc;
                mesure.Add(mes);*/
            }

            reader.Close();
            connection.Close();
            //string[] json = mesure.ToArray();
            var json = new JavaScriptSerializer().Serialize(mesure);            
            return json; 
        }
    }
}

public class Mesure
{
    public string State { get; set; }
    public Frequence freq { get; set; }
}

public class Frequence
{
    public int low { get; set; }
    public int mid { get; set; }
    public int high { get; set; }

}



