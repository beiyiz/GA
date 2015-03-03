using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MylanProducts.layouts.MylanInstitutionalProducts.sublayouts
{
    public partial class EmailSignUpResponse : System.Web.UI.UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            String strError = String.Empty;
            String errorCode = String.Empty;
            String errorControl = String.Empty;

            errorCode = Request.QueryString["errorcode"];
            errorControl = Request.QueryString["errorControl"];

            switch (errorCode)
            {
                case "1":
                case "6":
                case "7":
                case "9":
                case "10":
                    strError = "An error has occurred while attempting to save your subscriber information.";
                    break;
                case "2":
                    strError = "The list provided does not exist.";
                    break;
                case "3":
                    strError = String.Format("Information was not provided for a mandatory field. ({0})", errorControl);
                    break;
                case "4":
                    strError = String.Format("Invalid information was provided. ({0})", errorControl);
                    break;
                case "5":
                    strError = String.Format("Information provided is not unique. ({0})", errorControl);
                    break;
                case "8":
                    strError = "You have already subscribed to this list.";
                    break;
                case "12":
                    strError = "The email address is already unsubscribed.";
                    break;
                default:
                    strError = String.Empty;  //"An error occurred subscribing you to our email list, please try again later";
                    break;
            }

            if (!string.IsNullOrEmpty(strError))
            {
                spnResponse.InnerHtml = string.Format("</ br><strong> {0} </strong></ br>", strError);
            }
        }
    }
}