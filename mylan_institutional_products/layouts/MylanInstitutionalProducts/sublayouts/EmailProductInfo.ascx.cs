using System;
using System.Collections.Generic;
using System.Data;
using System.Net;
using System.Net.Mail;
using System.Text.RegularExpressions;
using System.Web.UI.WebControls;
using Sitecore.Data.Fields;
using Sitecore.Data.Items;
using System.Text;
using System.Web;

namespace Layouts.Emailproductinfo
{

    /// <summary>
    /// Reads cookies for the site, queries db for rest of info about NDCs, and creates a table on the page
    /// </summary>
    public partial class EmailproductinfoSublayout : System.Web.UI.UserControl
    {
        #region Configs
        Sitecore.Data.Database masterDB;
        //TODO: This config info should be read from a config file, not from source code
        private string SmtpAddress = "mail.ga-it.com";
        private string SmtpUser = "scanner@ga-it.com";
        private string SmtpPassword = "smile3200";
        private string strEmailFrom = "scanner@ga-it.com";
        private string URLHost = string.Empty;
        #endregion

        private void Page_Load(object sender, EventArgs e)
        {
            URLHost = HttpContext.Current.Request.Url.Host.ToString();
            masterDB = Sitecore.Configuration.Factory.GetDatabase("master");
            if (!IsPostBack)
            {
                if (Request.Cookies != null)
                {
                    if (Request.Cookies["ProductCatalog"] != null)
                    {
                        if (Request.Cookies["ProductCatalog"].Value.Trim() != "")
                        {
                            rp_products.DataSource = DisplayCookieData();
                            rp_products.DataBind();
                        }
                    }
                }
            }
        }

        #region UserActions

        protected void btn_Send_Click(object sender, EventArgs e)
        {
            bool InputDataValid = true;
            //Your Name Field
            if (!isValid(tbx_YourName.Text, 1, 75, "Name"))
            {
                //Throw Error Message
                InputDataValid = false;
            }

            //Your Email Field
            if (!isValid(tbx_YourEmail.Text, 7, 75, "Email"))
            {
                //Throw Error Message
                InputDataValid = false;
            }

            //Recipient Email Field
            if (!isValid(tbx_RecipientEmail.Text, 7, 75, "Email"))
            {
                //Throw Error Message
                InputDataValid = false;
            }

            //Subject Line
            if (!isValid(tbx_SubjectLine.Text, 1, 75, "Subject"))
            {
                //Throw Error Message
                InputDataValid = false;
            }

            //If Input Data is Valid Send the email. 
            if (InputDataValid)
            {
                string recip_body = html_to_recipient_email_body();
                if (recip_body == "false")
                {
                    Messages.Text = "No Products Selected";
                    Messages.Visible = true;
                    Messages.CssClass = "error";
                    pn_MsgContainer.Visible = true;
                }
                else
                {
                    SendEmail(tbx_YourName.Text, recip_body, this.tbx_YourEmail.Text.Trim(), this.tbx_RecipientEmail.Text.Trim());
                }

                string sender_body = html_to_sender_email_body();
                if (sender_body == "false")
                {
                    Messages.Text = "No Products Selected";
                    Messages.Visible = true;
                    Messages.CssClass = "error";
                    pn_MsgContainer.Visible = true;
                }
                else
                {
                    SendEmail(tbx_YourName.Text, sender_body, this.tbx_YourEmail.Text.Trim(), this.tbx_YourEmail.Text.Trim());
                }
                // SendEmail(html_to_sender_email_body);
            }
            else
            {
                Messages.Text = "Email fields not properly filled out";
                Messages.Visible = true;
                Messages.CssClass = "error";
                pn_MsgContainer.Visible = true;
            }
        }

        #endregion

        #region UtilityFunctions
        private string createWarningImages(string Warning)
        {
            string newWarning = "";
            if (Warning != null && Warning != "")
            {
                string[] b = Warning.Split(new Char[] { ' ', '/', });
                foreach (string i in b)
                {
                    if (i.Trim() != "" && i.Trim() != null && i.Trim() != "/")
                    {
                        newWarning += "<img src='/assets/MylanInstitutionalProducts/images/" + i.Trim() + ".png'> ";
                    }
                }
            }
            return newWarning;
        }
        private string createRemoteWarningImages(string Warning)
        {
            string newWarning = "";
            if (Warning != null && Warning != "")
            {
                string[] b = Warning.Split(new Char[] { ' ', '/', });
                foreach (string i in b)
                {
                    if (i.Trim() != "" && i.Trim() != null && i.Trim() != "/")
                    {
                        newWarning += "<img src='http://" + URLHost + "/assets/MylanInstitutionalProducts/images/" + i.Trim() + ".png'> ";
                    }
                }
            }
            return newWarning;
        }
        private bool isValid(string input_value, int min_char_count, int max_char_count, string char_type)
        {
            bool valid = true;
            Regex DigitCheck = new Regex(@"\d");

            switch (char_type)
            {
                case "Name":
                    if (DigitCheck.IsMatch(input_value))
                    {
                        valid = false;
                    }
                    break;

                case "Subject":
                    break;

                case "Email":
                    try
                    {
                        if (input_value != null && input_value != "")
                        {
                            MailAddress m = new MailAddress(input_value);
                            valid = true;
                        }
                        else
                        {
                            valid = false;
                        }
                    }
                    catch (FormatException fe)
                    {
                        valid = false;
                    }

                    break;

                default:
                    break;
            }

            //Meets Minimum AND Maximum requirements
            if (input_value.Length < min_char_count || input_value.Length > max_char_count)
            {
                valid = false;
            }


            return valid;

        }

        private string[] getValuesFromCookies(string cookie)
        {
            string input = cookie;
            string pattern = "(?i)%2C";
            string replacement = ",";
            Regex rgx = new Regex(pattern);
            string result = rgx.Replace(input, replacement);
            string[] CookieArray = result.Split(new Char[] { ',' });
            return CookieArray;
        }
        #endregion

        private DataTable DisplayCookieData()
        {
            string[] CookieArray = getValuesFromCookies(Request.Cookies["ProductCatalog"].Value.ToString());
            DataTable dt = new DataTable();
            dt.Columns.Add("ProductID");
            dt.Columns.Add("ProductName");
            dt.Columns.Add("InfoPrescribingInformationLink");
            dt.Columns.Add("AttrWarnings");
            dt.Columns.Add("RowCount");
            int productCount = 0;
            HashSet<string> prodNames = new HashSet<string>();

            foreach (string a in CookieArray)
            {
                string[] ProdArray = a.Split(new Char[] { '_' });
                if (ProdArray[0] == "ndc")
                {
                    Item[] productNDC = masterDB.SelectItems(String.Format("fast://*[@@name='{0}']", ProdArray[1]));
                    foreach (Item ndc in productNDC)
                    {
                        prodNames.Add(ndc.Parent.ID.ToString());
                    }
                }
            }
            foreach (string prod in prodNames)
            {
                DataRow dr = dt.NewRow();
                productCount++;
                bool itemInTable = false;

                Item fullProduct = masterDB.SelectSingleItem(String.Format("fast://*[@@id='{0}']", prod));
                if (fullProduct != null)
                {
                    dr["ProductID"] = fullProduct.ID;
                    if (fullProduct.Fields["PrescribingInformationLink"] != null)
                    {
                        dr["ProductName"] = fullProduct.Fields["Product Group Name"].Value.ToString();
                    }
                    if (fullProduct.Fields["PrescribingInformationLink"] != null)
                    {
                        dr["InfoPrescribingInformationLink"] = fullProduct.Fields["PrescribingInformationLink"].Value.ToString();
                    }

                    foreach (Item child in fullProduct.Children)
                    {
                        if (child.Fields["_xAttrWarnings"] != null)
                        {
                            dr["AttrWarnings"] = createWarningImages(child.Fields["_xAttrWarnings"].Value.ToString());
                        }
                    }
                    dr["RowCount"] = productCount;

                    for (int q = 0; q < dt.Rows.Count; q++)
                    {
                        if (dt.Rows[q]["ProductName"] == dr["ProductName"])
                        {
                            itemInTable = true;
                        }
                    }
                    if (!itemInTable)
                    {
                        dt.Rows.Add(dr);
                    }
                }
            }
            for (int i = 0; i < dt.Rows.Count; i++)
            {
                dt.Rows[i]["RowCount"] = productCount;
            }

            return dt;
        }

        #region EmailFunctions

        private string html_to_recipient_email_body()
        {
            String retVal = "false";

            try
            {
                if (Request.Cookies["ProductCatalog"].Value.ToString().Length > 0)
                {
                    string str = "";
                    StringBuilder sb = new StringBuilder();

                    string senderName = this.tbx_YourName.Text;
                    //Create Message String and Add Section 1 of Body (Includes header and opening Paragraph)
                    sb.Append("<div><style type='text/css'><!-- h3 { color: #00bbe7; font-size: 1.3em; } a { color: #00BBE7; cursor: pointer; text-decoration: none; } --></style></div>");
                    sb.Append("<div id='div_EmailBody_Section1'>\n");
                    sb.AppendFormat("<p>{0} sent you product ordering information from Mylan, Inc.<br />", senderName);
                    sb.AppendFormat("<p>with the following message:<br/>{0}</p>\n", tbx_Message.Text.Trim());
                    sb.Append("<strong>Call 1-800-848-0462 to order Mylan products</strong><p />");
                    sb.AppendFormat("<p><strong>See <a href='http://{0}/MylanInstitutionalProducts/index' style='color: #00BBE7;'>Mylan Institutional Products site</a> for more information on all of Mylan's Products</strong></p>", URLHost);

                    string product_data = "<table width='100%' style='vertical-align: top; display: block; list-style=none; width: 100%;'><tr><td style='padding: 10px; vertical-align: top; font-weight: bold;' width='200'>NDC</td><td style='padding: 10px; vertical-align: top; font-weight: bold;' width='200'>Product Name</td><td style='padding: 10px; vertical-align: top; font-weight: bold;' width='200'>Product Data</td></tr>";

                    string[] CookieArray = getValuesFromCookies(Request.Cookies["ProductCatalog"].Value.ToString());
                    string NDC = "";
                    string Products = "";
                    int i = 0;
                    bool itemInList = false;
                    bool hasProd = false;
                    HashSet<string> prodNames = new HashSet<string>();
                    HashSet<string> ndcNames = new HashSet<string>();

                    foreach (string a in CookieArray)
                    {
                        string[] ProdArray = a.Split(new Char[] { '_' });
                        if (ProdArray[0] == "ndc")
                        {
                            Item[] productNDC = masterDB.SelectItems(String.Format("fast://*[@@name='{0}']", ProdArray[1]));

                            foreach (Item ndc in productNDC)
                            {
                                prodNames.Add(ndc.Parent.ID.ToString());
                            }
                        }
                    }

                    foreach (string prod in prodNames)
                    {
                        Item fullProduct = masterDB.SelectSingleItem(String.Format("fast://*[@@id='{0}']", prod));
                        if (fullProduct != null)
                        {
                            i++;
                            string str_productData = "";
                            string ProductName = fullProduct.Fields["Product Group Name"].Value.ToString();
                            string InfoPrescribingInformationLink = string.Format("http://{0}/assets/MylanInstitutionalProducts/pdfs/{1}", URLHost, fullProduct.Fields["PrescribingInformationLink"].Value.ToString());
                            string AttrWarnings = "";
                            foreach (Item child in fullProduct.Children)
                            {
                                ndcNames.Add(child.Fields["_NDC"].Value.ToString());
                                if (child.Fields["_xAttrWarnings"].Value != null)
                                {
                                    if (child.Fields["_xAttrWarnings"].Value.ToString().Trim() != "")
                                    {
                                        AttrWarnings = "<br/>" + createRemoteWarningImages(child.Fields["_xAttrWarnings"].Value.ToString());
                                    }
                                }
                                if (child.Fields["_ProductDescription"].Value != null)
                                {
                                    if (child.Fields["_ProductDescription"].Value.ToString().Trim() != "")
                                    {
                                        str_productData += "Description: " + child.Fields["_ProductDescription"].Value.ToString() + "<br/>\n";
                                    }
                                }
                                if (child.Fields["_xAttrStrength"].Value != null)
                                {
                                    if (child.Fields["_xAttrStrength"].Value.ToString().Trim() != "")
                                    {
                                        str_productData += "Strength: " + child.Fields["_xAttrStrength"].Value.ToString() + "<br/>\n";
                                    }
                                }
                                if (child.Fields["_xAttrDose"].Value != null)
                                {
                                    if (child.Fields["_xAttrDose"].Value.ToString().Trim() != "")
                                    {
                                        str_productData += "Dose: " + child.Fields["_xAttrDose"].Value.ToString() + "<br/>\n";
                                    }
                                }
                                if (child.Fields["_xAttrClosureSize"].Value != null)
                                {
                                    if (child.Fields["_xAttrClosureSize"].Value.ToString().Trim() != "")
                                    {
                                        str_productData += "Closure Size: " + child.Fields["_xAttrClosureSize"].Value.ToString() + "<br/>\n";
                                    }
                                }
                                if (child.Fields["_xAttrFillVolume"].Value != null)
                                {
                                    if (child.Fields["_xAttrFillVolume"].Value.ToString().Trim() != "")
                                    {
                                        str_productData += "Fill Volume: " + child.Fields["_xAttrFillVolume"].Value.ToString() + "<br/>\n";
                                    }
                                }
                                if (child.Fields["_xAttrVialSize"].Value != null)
                                {
                                    if (child.Fields["_xAttrVialSize"].Value.ToString().Trim() != "")
                                    {
                                        str_productData += "Vial Size: " + child.Fields["_xAttrVialSize"].Value.ToString() + "<br/>\n";
                                    }
                                }
                                if (child.Fields["_xPkgPackage"].Value != null)
                                {
                                    if (child.Fields["_xPkgPackage"].Value.ToString().Trim() != "")
                                    {
                                        str_productData += "Package: " + child.Fields["_xPkgPackage"].Value.ToString() + "<br/>\n";
                                    }
                                }
                                if (child.Fields["_xPkgPackSize"].Value != null)
                                {
                                    if (child.Fields["_xPkgPackSize"].Value.ToString().Trim() != "")
                                    {
                                        str_productData += "Pack Size: " + child.Fields["_xPkgPackSize"].Value.ToString() + "<br/>\n";
                                    }
                                }
                                if (child.Fields["_xPkgBoxesPerCase"].Value != null)
                                {
                                    if (child.Fields["_xPkgBoxesPerCase"].Value.ToString().Trim() != "")
                                    {
                                        str_productData += "Boxed Per Case: " + child.Fields["_xPkgBoxesPerCase"].Value.ToString() + "<br/>\n";
                                    }
                                }
                                if (child.Fields["_xPkgOrderingMultiple"].Value != null)
                                {
                                    if (child.Fields["_xPkgOrderingMultiple"].Value.ToString().Trim() != "")
                                    {
                                        str_productData += "Ordering Multiple: " + child.Fields["_xPkgOrderingMultiple"].Value.ToString() + "<br/>\n";
                                    }
                                }
                                if (i % 2 == 0)
                                {
                                    product_data += "<tr style='background-color: #CCF1FA'>";
                                }
                                else
                                {
                                    product_data += "<tr style='background-color: #EBEBEB'>";
                                }
                                foreach (string ndc in ndcNames)
                                {
                                    if (ndc.ToString() == child.Fields["_NDC"].Value.ToString())
                                    {
                                        child.Fields["_NDC"].Value.ToString();
                                        product_data
                                            += "<td style='padding: 10px; vertical-align: top;' width='200'>" + child.Fields["_NDC"].Value.ToString() + "</td>\n"
                                            + "<td style='padding: 10px; vertical-align: top;' width='200'>" + ProductName + AttrWarnings + "</td>\n"
                                            + "<td style='padding: 10px; vertical-align: top;' width='200'>" + str_productData + "</td></tr>\n";
                                    }
                                }
                            }
                        }
                    }

                    product_data += "</table>";

                    //Build ProductData
                    product_data += "</table>\n\n";

                    //Add Section 2 to Message String (Product Data)
                    sb.AppendFormat("<div id='div_EmailBody_Section2'>\n {0} </div>", product_data);

                    //Product Warnings

                    sb.Append("<div id='product-warnings'><ul style='font-weight: bolder; padding: 0;'>");
                    sb.AppendFormat("<li style=\"display:inline-block; background-image: url('http://{0}/assets/MylanInstitutionalProducts/images/c.png'); margin-right: 15px; background-repeat: no-repeat; padding-bottom: 10px; padding-left: 30px; vertical-align: top;\" >Controlled Substance</li>", URLHost);
                    sb.AppendFormat("<li style=\"display:inline-block; background-image: url('http://{0}/assets/MylanInstitutionalProducts/images/lf.png'); margin-right: 15px; background-repeat: no-repeat; padding-bottom: 10px; padding-left: 30px; vertical-align: top;\">Not Made With Natural Rubber Latex</li>", URLHost);
                    sb.AppendFormat("<li style=\"display:inline-block; background-image: url('http://{0}/assets/MylanInstitutionalProducts/images/pf.png'); margin-right: 15px; background-repeat: no-repeat; padding-bottom: 10px; padding-left: 30px; vertical-align: top;\">Preservative Free</li>", URLHost);
                    sb.AppendFormat("<li style=\"display:inline-block; background-image: url('http://{0}/assets/MylanInstitutionalProducts/images/bw.png'); margin-right: 15px; background-repeat: no-repeat; padding-bottom: 10px; padding-left: 30px; vertical-align: top;\">Boxed Warning</li></ul></div>", URLHost);
                    //Add Section 3 to Message String (the Footer)
                    sb.Append("<div style='background-color: #000000; color: #FFFFFF; padding: 5px 15px; '>\n");
                    sb.Append("<p>Copyright&copy; 2013 Mylan, Inc. All Rights Reserved.</p>");
                    sb.Append("<p><a href='http://www.mylan.com/disclaimer.aspx' style='color: #FFFFFF; text-decoration: none;'>Legal Disclaimer</a> &nbsp;|&nbsp; ");
                    sb.Append("<a href='http://www.mylan.com/privacy.aspx' style='color: #FFFFFF; text-decoration: none;'>Privacy Policy</a> &nbsp;|&nbsp;");
                    sb.AppendFormat("<a href='http://{0}/MylanInstitutionalProducts/help' style='color: #FFFFFF; text-decoration: none;'>Help</a> </p>", HttpContext.Current.Request.Url.Host.ToString());
                    sb.Append("</div>"); //close div_EmailBody_Section3

                    sb.AppendFormat("<p>This email was sent to: {0}</p>", tbx_RecipientEmail.Text);
                    sb.AppendFormat("<p>This email was sent by: {0}</p>", tbx_YourEmail.Text);

                    retVal = sb.ToString();
                }
                else
                {
                    retVal = "false";
                }
            }
            catch (Exception ex)
            {
            }
            return retVal;
        }

        private string html_to_sender_email_body()
        {
            String retVal = "false";

            try
            {
                StringBuilder str = new StringBuilder();
                string sender = this.tbx_YourName.Text;
                //Create Message String and Add Section 1 of Body (Includes header and opening Paragraph)
                str.Append("<div><style type='text/css'><!-- h3 { color: #00bbe7; font-size: 1.3em; } a { color: #00BBE7; cursor: pointer; text-decoration: none; } --></style></div>");
                str.Append("<div id='div_EmailBody_Section1'>\n");
                str.Append("<p>You sent product ordering information from Mylan, Inc. to " + tbx_RecipientEmail.Text + "<br />");
                str.Append("<p>with the following message:<br/>" + tbx_Message.Text.Trim() + "</p>\n");
                str.Append("<strong>Call 1-800-848-0462 to order Mylan products</strong><p />");
                str.AppendFormat("<p><strong>See <a href='http://{0}/MylanInstitutionalProducts/index' style='color: #00BBE7;'>Mylan Institutional Products site</a> for more information on all of Mylan's Products</strong></p>", URLHost);

                string product_data = "<table width='100%' style='vertical-align: top; display: block; list-style=none; width: 100%;'><tr><td style='padding: 10px; vertical-align: top; font-weight: bold;' width='200'>NDC</td><td style='padding: 10px; vertical-align: top; font-weight: bold;' width='200'>Product Name</td><td style='padding: 10px; vertical-align: top; font-weight: bold;' width='200'>Product Data</td></tr>";

                string[] CookieArray = getValuesFromCookies(Request.Cookies["ProductCatalog"].Value.ToString());
                string NDC = "";
                string Products = "";
                int i = 0;
                bool itemInList = false;
                bool hasProd = false;
                HashSet<string> prodNames = new HashSet<string>();
                HashSet<string> ndcNames = new HashSet<string>();

                foreach (string a in CookieArray)
                {
                    string[] ProdArray = a.Split(new Char[] { '_' });
                    if (ProdArray[0] == "ndc")
                    {
                        Item[] productNDC = masterDB.SelectItems(String.Format("fast://*[@@name='{0}']", ProdArray[1]));

                        foreach (Item ndc in productNDC)
                        {
                            prodNames.Add(ndc.Parent.ID.ToString());
                        }
                    }
                }

                foreach (string prod in prodNames)
                {
                    Item fullProduct = masterDB.SelectSingleItem(String.Format("fast://*[@@id='{0}']", prod));
                    if (fullProduct != null)
                    {
                        i++;
                        string str_productData = "";
                        string ProductName = fullProduct.Fields["Product Group Name"].Value.ToString();
                        string InfoPrescribingInformationLink = fullProduct.Fields["PrescribingInformationLink"].Value.ToString();
                        string AttrWarnings = "";
                        foreach (Item child in fullProduct.Children)
                        {
                            ndcNames.Add(child.Fields["_NDC"].Value.ToString());
                            if (child.Fields["_xAttrWarnings"].Value != null)
                            {
                                if (child.Fields["_xAttrWarnings"].Value.ToString().Trim() != "")
                                {
                                    AttrWarnings = "<br/>" + createRemoteWarningImages(child.Fields["_xAttrWarnings"].Value.ToString());
                                }
                            }
                            if (child.Fields["_ProductDescription"].Value != null)
                            {
                                if (child.Fields["_ProductDescription"].Value.ToString().Trim() != "")
                                {
                                    str_productData += "Description: " + child.Fields["_ProductDescription"].Value.ToString() + "<br/>\n";
                                }
                            }
                            if (child.Fields["_xAttrStrength"].Value != null)
                            {
                                if (child.Fields["_xAttrStrength"].Value.ToString().Trim() != "")
                                {
                                    str_productData += "Strength: " + child.Fields["_xAttrStrength"].Value.ToString() + "<br/>\n";
                                }
                            }
                            if (child.Fields["_xAttrDose"].Value != null)
                            {
                                if (child.Fields["_xAttrDose"].Value.ToString().Trim() != "")
                                {
                                    str_productData += "Dose: " + child.Fields["_xAttrDose"].Value.ToString() + "<br/>\n";
                                }
                            }
                            if (child.Fields["_xAttrClosureSize"].Value != null)
                            {
                                if (child.Fields["_xAttrClosureSize"].Value.ToString().Trim() != "")
                                {
                                    str_productData += "Closure Size: " + child.Fields["_xAttrClosureSize"].Value.ToString() + "<br/>\n";
                                }
                            }
                            if (child.Fields["_xAttrFillVolume"].Value != null)
                            {
                                if (child.Fields["_xAttrFillVolume"].Value.ToString().Trim() != "")
                                {
                                    str_productData += "Fill Volume: " + child.Fields["_xAttrFillVolume"].Value.ToString() + "<br/>\n";
                                }
                            }
                            if (child.Fields["_xAttrVialSize"].Value != null)
                            {
                                if (child.Fields["_xAttrVialSize"].Value.ToString().Trim() != "")
                                {
                                    str_productData += "Vial Size: " + child.Fields["_xAttrVialSize"].Value.ToString() + "<br/>\n";
                                }
                            }
                            if (child.Fields["_xPkgPackage"].Value != null)
                            {
                                if (child.Fields["_xPkgPackage"].Value.ToString().Trim() != "")
                                {
                                    str_productData += "Package: " + child.Fields["_xPkgPackage"].Value.ToString() + "<br/>\n";
                                }
                            }
                            if (child.Fields["_xPkgPackSize"].Value != null)
                            {
                                if (child.Fields["_xPkgPackSize"].Value.ToString().Trim() != "")
                                {
                                    str_productData += "Pack Size: " + child.Fields["_xPkgPackSize"].Value.ToString() + "<br/>\n";
                                }
                            }
                            if (child.Fields["_xPkgBoxesPerCase"].Value != null)
                            {
                                if (child.Fields["_xPkgBoxesPerCase"].Value.ToString().Trim() != "")
                                {
                                    str_productData += "Boxed Per Case: " + child.Fields["_xPkgBoxesPerCase"].Value.ToString() + "<br/>\n";
                                }
                            }
                            if (child.Fields["_xPkgOrderingMultiple"].Value != null)
                            {
                                if (child.Fields["_xPkgOrderingMultiple"].Value.ToString().Trim() != "")
                                {
                                    str_productData += "Ordering Multiple: " + child.Fields["_xPkgOrderingMultiple"].Value.ToString() + "<br/>\n";
                                }
                            }
                            if (i % 2 == 0)
                            {
                                product_data += "<tr style='background-color: #CCF1FA'>";
                            }
                            else
                            {
                                product_data += "<tr style='background-color: #EBEBEB'>";
                            }
                            foreach (string ndc in ndcNames)
                            {
                                if (ndc.ToString() == child.Fields["_NDC"].Value.ToString())
                                {
                                    child.Fields["_NDC"].Value.ToString();
                                    product_data
                                        += "<td style='padding: 10px; vertical-align: top;' width='200'>" + child.Fields["_NDC"].Value.ToString() + "</td>\n"
                                        + "<td style='padding: 10px; vertical-align: top;' width='200'>" + ProductName + AttrWarnings + "</td>\n"
                                        + "<td style='padding: 10px; vertical-align: top;' width='200'>" + str_productData + "</td></tr>\n";
                                }
                            }
                        }
                    }
                }

                product_data += "</table>";

                //Build ProductData
                product_data += "</table>\n\n";

                //Add Section 2 to Message String (Product Data)
                str.AppendFormat("<div id='div_EmailBody_Section2'>\n</div>", product_data); //close div_EmailBody_Section2

                str.Append("<div id='product-warnings'><ul style='font-weight: bolder'>");
                str.AppendFormat("<li style=\"display:inline-block; background-image: url('http://{0}/assets/MylanInstitutionalProducts/images/c.png'); margin-right: 15px; background-repeat: no-repeat; padding-bottom: 10px; padding-left: 30px; vertical-align: top;\" >Controlled Substance</li>", URLHost);
                str.AppendFormat("<li style=\"display:inline-block; background-image: url('http://{0}/assets/MylanInstitutionalProducts/images/lf.png'); margin-right: 15px; background-repeat: no-repeat; padding-bottom: 10px; padding-left: 30px; vertical-align: top;\">Not Made With Natural Rubber Latex</li>", URLHost);
                str.AppendFormat("<li style=\"display:inline-block; background-image: url('http://{0}/assets/MylanInstitutionalProducts/images/pf.png'); margin-right: 15px; background-repeat: no-repeat; padding-bottom: 10px; padding-left: 30px; vertical-align: top;\">Preservative Free</li>", URLHost);
                str.AppendFormat("<li style=\"display:inline-block; background-image: url('http://{0}/assets/MylanInstitutionalProducts/images/bw.png'); margin-right: 15px; background-repeat: no-repeat; padding-bottom: 10px; padding-left: 30px; vertical-align: top;\">Boxed Warning</li></ul></div>", URLHost);
                //Add Section 3 to Message String (the Footer)
                str.Append("<div id='div_EmailBody_Section3'>\n");
                str.Append("<p>Copyright&copy; 2013 Mylan, Inc. All Rights Reserved.</p>");
                str.Append("<p><a href='http://www.mylan.com/disclaimer.aspx'>Legal Disclaimer</a> &nbsp;|&nbsp;");
                str.Append("<a href='http://www.mylan.com/privacy.aspx'>Privacy Policy</a> &nbsp;|&nbsp;");
                str.AppendFormat("<a href='http://{0}/MylanInstitutionalProducts/help'>Help</a> </p>", URLHost);
                str.Append("</div>"); //close div_EmailBody_Section3


                str.AppendFormat("<p>This email was sent to: {0}</p>", tbx_RecipientEmail.Text);
                str.AppendFormat("<p>This email was sent by: {0} </p>", tbx_YourEmail.Text);

                retVal = str.ToString();
                Response.Cookies.Remove("ProductCatalog");
            }
            catch (Exception)
            {
            }
            return retVal;
        }

        private void SendEmail(string sender_name, string email_body, string email_from, string email_to)
        {
            try
            {
                SmtpClient EmailClient = new SmtpClient(SmtpAddress, 25);
                EmailClient.Credentials = new NetworkCredential(SmtpUser, SmtpPassword);

                MailAddress Message_From = new MailAddress(email_from);
                MailAddress Message_To = new MailAddress(email_to);

                MailMessage theMessage = new MailMessage(Message_From, Message_To);
                theMessage.CC.Add(Message_From);
                theMessage.Body = email_body;
                theMessage.BodyEncoding = System.Text.Encoding.UTF8;
                theMessage.Subject = this.tbx_SubjectLine.Text.Trim();
                theMessage.SubjectEncoding = System.Text.Encoding.UTF8;
                theMessage.IsBodyHtml = true;
                EmailClient.Send(theMessage);
                theMessage.Dispose();
                Messages.Text = "Your Email has been sent";
                Messages.Visible = true;
                Messages.CssClass = "error";
                this.pn_MsgContainer.Visible = true;

            }
            catch (Exception ex)
            {
            }
        }

        #endregion

        #region DataCalls

        private void BindAllData()
        {
            //Unit Dose Binding
        }

        #region Protected DataCalls

        protected DataTable GetProductDetailsByID(string ProductID)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("NDC");
            dt.Columns.Add("ProductCategory");
            dt.Columns.Add("ProductID");
            dt.Columns.Add("ProductLine");
            dt.Columns.Add("ProductName");
            dt.Columns.Add("ProductDescription");
            dt.Columns.Add("AttrClosureSize");
            dt.Columns.Add("AttrDose");
            dt.Columns.Add("AttrFillVolume");
            dt.Columns.Add("AttrStrength");
            dt.Columns.Add("AttrVialSize");
            dt.Columns.Add("AttrWarnings");
            dt.Columns.Add("PkgPackage");
            dt.Columns.Add("PkgPackageDetails");
            dt.Columns.Add("PkgPackSize");
            dt.Columns.Add("PkgBoxesPerCase");
            dt.Columns.Add("PkgOrderingMultiple");
            dt.Columns.Add("InfoPrescrbingInformationLink");
            Item[] productGroup = masterDB.SelectItems(String.Format("fast://*[@@id ='{0}']", ProductID));
            foreach (Item product in productGroup)
            {
                foreach (Item ndc in product.Children)
                {
                    DataRow dr = dt.NewRow();
                    dr["ProductID"] = ndc.ID;
                    foreach (Field f in ndc.Fields)
                    {
                        switch (f.DisplayName)
                        {
                            case "NDC":
                                dr["NDC"] = f.Value.ToString();
                                break;
                            case "L3 - Product Name":
                                dr["ProductName"] = f.Value.ToString();
                                break;
                            case "Product Description":
                                dr["ProductDescription"] = f.Value.ToString();
                                break;
                            case "Attribute - Closure Size ( For Injectables Only)":
                                dr["AttrClosureSize"] = f.Value.ToString();
                                break;
                            case "Attribute - Dose":
                                dr["AttrDose"] = f.Value.ToString();
                                break;
                            case "Attribute - Fill Volume ( For Injectables Only )":
                                dr["AttrFillVolume"] = f.Value.ToString();
                                break;
                            case "Attribute - Strength":
                                dr["AttrStrength"] = f.Value.ToString().Trim();
                                break;
                            case "Attribute - Vial Size  ( For Injectables Only )":
                                dr["AttrVialSize"] = f.Value.ToString().Trim();
                                break;
                            case "Packaging - Package":
                                dr["PkgPackage"] = f.Value.ToString();
                                break;
                            case "Packaging - Package Details":
                                dr["PkgPackageDetails"] = f.Value.ToString();
                                break;
                            case "Packaging - Pack Size":
                                dr["PkgPackSize"] = f.Value.ToString();
                                break;
                            case "Packaging - Boxes Per Case":
                                dr["PkgBoxesPerCase"] = f.Value.ToString();
                                break;
                            case "Packaging - Ordering Multiple":
                                dr["PkgOrderingMultiple"] = f.Value.ToString();
                                break;
                            default:
                                break;
                        }
                    }
                    string[] cookieArray = getValuesFromCookies(Request.Cookies["ProductCatalog"].Value.ToString());
                    foreach (string a in cookieArray)
                    {
                        string[] ndcArray = a.Split(new Char[] { '_' });
                        if (ndcArray[0] == "ndc")
                        {
                            if (ndcArray[1] == dr["NDC"].ToString())
                            {
                                dt.Rows.Add(dr);
                            }
                        }
                    }
                }
            }
            if (dt.Rows.Count == 0)
            {
                Messages.Text = "No NDC Selected";
                Messages.Visible = true;
                Messages.CssClass = "error";
                pn_MsgContainer.Visible = true;
            }
            return dt;
        }

        #endregion

        #endregion

        protected void rp_products_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "RemoveProduct")
            {
            }
        }
    }
}