using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace mylan_institutional_products.Admin
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (IsPostBack)
            {
                string userName = loginName.Value;
                string password = loginPassword.Value;

                if (!isValidLogin(userName, password))
                {
                    errorMsg.InnerHtml = "Invalid User ID/Password.";
                }
                else
                {
                    Session["ValidLogin"] = userName;

                    Response.Redirect("Admin.aspx");
                }
            }
        }

        private bool isValidLogin(string userName, string password)
        {
            return true;
        }
    }
}