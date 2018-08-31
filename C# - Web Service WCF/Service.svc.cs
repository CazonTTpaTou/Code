using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using Connection_ODBC;

namespace WebServiceJQuery
{
    [ServiceContract(Namespace = "")]
    [AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
    public class Service
    {
        // Pour utiliser HTTP GET, ajoutez l'attribut [WebGet]. (ResponseFormat par défaut=WebMessageFormat.Json)
        // Pour créer une opération qui renvoie du code XML,
        //     ajoutez [WebGet(ResponseFormat=WebMessageFormat.Xml)],
        //     et incluez la ligne suivante dans le corps de l'opération :
        //         WebOperationContext.Current.OutgoingResponse.ContentType = "text/xml";
        [OperationContract]
        public string GetUser()
    { //return new User().GetUser(Convert.ToInt32(Id));
        return string.Format("Hello croc of the world !! ");
    }

        [OperationContract]
        public string GetData()
        {
            return Connection_ODBC.Data.RetrieveData();
        }

 }





        // Ajoutez des opérations supplémentaires ici et marquez-les avec [OperationContract

public class User
{

    Dictionary<int, string> users = null;
    public User()
    {
        users = new Dictionary<int, string>();
        users.Add(1, "pranay");
        users.Add(2, "Krunal");
        users.Add(3, "Aditya");
        users.Add(4, "Samir");
    }

    public string[] GetUser(int Id)
    {
        var user = from u in users
                   where u.Key == Id
                   select u.Value;

        return user.ToArray<string>();
    }

}

}

