using MylanCustomizations.ExactTargetClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace mylan_institutional_products.layouts.MylanInstitutionalProducts.sublayouts
{
    public partial class EmailSignup : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                AddSubscriber();
            }
           
        }

        protected void AddSubscriber()
        {
            string email = tbx_YourEmail.Value;
            string firstName = tbx_FirstName.Value;
            string lastName = tbx_LastName.Value;
            List<string> productCategories = categories.Value.Split(';').ToList();
            
            ETDataExtension etd = new ETDataExtension();
            etd.InsertSubscribers(productCategories, firstName, lastName, email);
        }
    }
}