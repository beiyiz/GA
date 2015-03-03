using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sitecore;
using Sitecore.Data;
using Sitecore.Data.Items;
using System.Text;

namespace MylanProducts
{
    public partial class ProductVerification : System.Web.UI.Page
    {

        //Default comparision : Dev site on left and Live(prod) siute on right.
        String strLeftDB = "web";
        String strLeftDBTitle = "Dev";

        String strRightDB = "prod";
        String strRightDBTitle = "Live";

        protected void Page_Load(object sender, EventArgs e)
        {
            String strHomeItemPath = "/sitecore/content/MylanInstitutionalProducts/Products";

            strLeftDB = ddlDBLeft.SelectedValue.ToString();
            if (strLeftDB == "prod")
            {
                strRightDB = "web";
                strRightDBTitle = "Dev";
                strLeftDBTitle = "Live";
            }

            Database LeftDB = Sitecore.Configuration.Factory.GetDatabase(strLeftDB);

            StringBuilder sb = new StringBuilder();
            Item HomeItem = null;
            if (LeftDB != null)
            {
                HomeItem = LeftDB.GetItem(strHomeItemPath);
                if (HomeItem != null)
                {
                    List<Item> lstProducts = new List<Item>();
                    Item[] products = HomeItem.Axes.SelectItems("descendant::*[@@templatename='Product']");

                    if (products.Length <= 0)
                    {
                        sb.Append("Error!!");
                    }
                    else
                    {
                        lstProducts = products.ToList<Item>();
                        sb.Append("<table border='1' cellpadding='1' cellspacing='0'>");
                        sb.Append("<tr>");
                        sb.Append("<td style=\"vertical-align:top;\"><table border='1' cellpadding='1' cellspacing='0' width='100%'>");
                        sb.Append("<td style=\"vertical-align:top;\">Item ID</td>");
                        sb.Append("<th style=\"vertical-align:top;\">Product Category</th>");
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "Product Group", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "NDC", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "Product Description", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "Closure Size", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "Dose", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "Fill Volume", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "Strength", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "VialSize", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "Warnings", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "Package", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "Package Details", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "PackSize", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "Boxes Per Case", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\"><table border=\"1\" width=\"100%\"><tr><th colspan=\"2\" nowrap>{0}</th></tr><tr><th>{1}</th><th>{2}</th></tr></table></th>", "Ordering Multiple", strLeftDBTitle, strRightDBTitle);
                        sb.Append("</tr>");

                        foreach (Item LeftProduct in lstProducts)
                        {
                            Item RightProduct = GetThisItemFromRight(LeftProduct.ID);
                            if (RightProduct == null)
                            {
                                sb.Append("<tr style=\"background-color:yellow;\">");
                            }
                            else
                            {
                                sb.Append("<tr>");
                            }

                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.ID.ToString());
                            foreach (Item productGroup in LeftProduct.Axes.GetAncestors())
                            {
                                if (productGroup.TemplateName.ToString().ToLower() == "productgroup")
                                {
                                    try
                                    {
                                        foreach (Item ancestor in productGroup.Axes.GetAncestors())
                                        {
                                            if (ancestor.TemplateName.ToString().ToLower() == "productcategory")
                                            {
                                                sb.AppendFormat("<td nowrap>{0}</td>", ancestor.Fields["Category"].Value.ToString());
                                                //sb.AppendFormat("<td nowrap>{0}</td>", productGroup.Fields["Product Group Name"].Value.ToString());
                                                Item LiveGroup = GetThisItemFromRight(productGroup.ID);
                                                sb.AppendFormat(GetDisplayString(productGroup, LiveGroup, "Product Group Name"));
                                            }
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        sb.Append("<td><strong><font color='red'></font></strong></td>");
                                        sb.Append("<td width='50%'><strong><font color='red'> 2 " + ex.ToString() + "</font></strong></td>");
                                    }
                                }
                            }

                            sb.Append(GetDisplayString(LeftProduct, RightProduct, "_NDC"));
                            sb.Append(GetDisplayString(LeftProduct, RightProduct, "_ProductDescription"));
                            sb.Append(GetDisplayString(LeftProduct, RightProduct, "_xAttrClosureSize"));
                            sb.Append(GetDisplayString(LeftProduct, RightProduct, "_xAttrDose"));
                            sb.Append(GetDisplayString(LeftProduct, RightProduct, "_xAttrFillVolume"));
                            sb.Append(GetDisplayString(LeftProduct, RightProduct, "_xAttrStrength"));
                            sb.Append(GetDisplayString(LeftProduct, RightProduct, "_xAttrVialSize"));
                            sb.Append(GetDisplayString(LeftProduct, RightProduct, "_xAttrWarnings"));
                            sb.Append(GetDisplayString(LeftProduct, RightProduct, "_xPkgPackage"));
                            sb.Append(GetDisplayString(LeftProduct, RightProduct, "_xPkgPackageDetails"));
                            sb.Append(GetDisplayString(LeftProduct, RightProduct, "_xPkgPackSize"));
                            sb.Append(GetDisplayString(LeftProduct, RightProduct, "_xPkgBoxesPerCase"));
                            sb.Append(GetDisplayString(LeftProduct, RightProduct, "_xPkgOrderingMultiple"));
                            sb.Append("</tr>");
                        }
                        sb.Append("</table>");
                    }
                    dvTest.InnerHtml = sb.ToString();
                }
            }
        }
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

        private Item GetThisItemFromRight(Sitecore.Data.ID theItemID)
        {
            Item itm = null;
            Item retVal = null;
            try
            {
                Database RightDB = Sitecore.Configuration.Factory.GetDatabase(strRightDB);
                if (RightDB != null)
                    itm = RightDB.GetItem(theItemID);
                if (itm != null)
                {
                    Sitecore.Data.Fields.TextField tf = null;
                    if (itm.TemplateName.ToString().ToLower() == "product")
                    {
                        tf = itm.Fields["_NDC"];
                    }
                    else if (itm.TemplateName.ToString().ToLower() == "productgroup")
                    {
                        tf = itm.Fields["Product Group Name"];
                    }

                    if ((tf != null) && (!String.IsNullOrWhiteSpace(tf.Value)))
                        retVal = itm;
                }
            }
            catch (Exception ex)
            {
            }
            return (retVal);
        }

        private String GetDisplayString(Item LeftItem, Item RightItem, String FieldName)
        {
            String retVal = String.Empty;
            try
            {
                String strSimpleFormat = "<td style=\"vertical-align:top;\" nowrap><table border=\"1\" width=\"100%\"><tr><td width=\"50%\">{0}</td><td width=\"50%\">{1}</td></table>";
                String strFormatMisMatch = "<td style=\"vertical-align:top;\" nowrap><table border=\"1\" width=\"100%\"><tr style=\"background-color:red;\"><td width=\"50%\">{0}</td><td width=\"50%\">{1}</td></table>";

                String strFormat = String.Empty;

                String LeftValue = String.Empty;
                String RightValue = String.Empty;

                if (LeftItem != null)
                    LeftValue = LeftItem.Fields[FieldName].Value.ToString();
                if (RightItem != null)
                    RightValue = RightItem.Fields[FieldName].Value.ToString();


                strFormat = strSimpleFormat;
                if ((RightItem != null) && (LeftValue != RightValue))
                {
                    strFormat = strFormatMisMatch;
                }

                if ((String.IsNullOrWhiteSpace(LeftValue)) && (String.IsNullOrWhiteSpace(RightValue)))
                {
                    LeftValue = "Empty";
                    RightValue = "Empty";
                }
                LeftValue = LeftValue.Replace("<br/>", " ").Replace("<br />", " ").Trim();
                RightValue = RightValue.Replace("<br/>", " ").Replace("<br />", " ").Trim();
                retVal = string.Format(strFormat, LeftValue, RightValue);

            }
            catch (Exception ex)
            {
            }
            return retVal;
        }

    }
}