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

namespace MylanProducts.layouts
{
    public partial class SimpleProductListing : System.Web.UI.Page
    {

        //Default comparision : Dev site on left and Live(prod) siute on right.
        String strLeftDB = "web";
        String strLeftDBTitle = "Dev";

        String strRightDB = "prod";
        String strRightDBTitle = "Live";

        protected void Page_Load(object sender, EventArgs e)
        {
            String strHomeItemPath = "/sitecore/content/MylanInstitutionalProducts/Products";

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
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "Product Group", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "NDC", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "Product Description", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "Closure Size", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "Dose", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "Fill Volume", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "Strength", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "VialSize", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "Warnings", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "Package", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "Package Details", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "PackSize", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "Boxes Per Case", strLeftDBTitle, strRightDBTitle);
                        sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "Ordering Multiple", strLeftDBTitle, strRightDBTitle);

                        try {sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "AmerisourceBergen", strLeftDBTitle, strRightDBTitle); } catch {}
                        try {sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "AmerisourceBergen STAR", strLeftDBTitle, strRightDBTitle); } catch {}
                        try {sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "Cardinal", strLeftDBTitle, strRightDBTitle); } catch {}
                        try {sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "HD Smith", strLeftDBTitle, strRightDBTitle); } catch {}
                        try {sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "McKesson", strLeftDBTitle, strRightDBTitle); } catch {}
                        try {sb.AppendFormat("<th style=\"vertical-align:top;\">{0}</th>", "Morris and Dickson", strLeftDBTitle, strRightDBTitle); } catch {}
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
                            Boolean pgAdded = false;
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
                                                pgAdded = true;
                                                break;
                                            }
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                        sb.Append("<td><strong><font color='red'></font></strong></td>");
                                        pgAdded = true;
                                        break;
                                    }


                                    sb.AppendFormat("<td nowrap>{0}</td>", productGroup.Fields["Product Group Name"].Value.ToString());
                                }
                            }



                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["_NDC"].Value.ToString());
                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["_ProductDescription"].Value.ToString());
                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["_xAttrClosureSize"].Value.ToString());
                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["_xAttrDose"].Value.ToString());
                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["_xAttrFillVolume"].Value.ToString());
                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["_xAttrStrength"].Value.ToString());
                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["_xAttrVialSize"].Value.ToString());
                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["_xAttrWarnings"].Value.ToString());
                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["_xPkgPackage"].Value.ToString());
                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["_xPkgPackageDetails"].Value.ToString());
                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["_xPkgPackSize"].Value.ToString());
                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["_xPkgBoxesPerCase"].Value.ToString());
                            sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["_xPkgOrderingMultiple"].Value.ToString());

                            try {sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["AmerisourceBergen"].Value.ToString()); } catch {}
                            try {sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["AmerisourceBergen STAR"].Value.ToString()); } catch {}
                            try {sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["Cardinal"].Value.ToString()); } catch {}
                            try {sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["HD Smith"].Value.ToString()); } catch {}
                            try {sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["McKesson"].Value.ToString()); } catch {}
                            try {sb.AppendFormat("<td nowrap>{0}</td>", LeftProduct.Fields["Morris and Dickson"].Value.ToString()); } catch {}


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