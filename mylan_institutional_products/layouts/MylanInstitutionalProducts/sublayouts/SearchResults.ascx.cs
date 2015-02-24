using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;
using Sitecore.Data.Fields;
using Sitecore.Data.Items;

namespace layouts.Searchresults
{

    /// <summary>
    /// Summary description for SearchresultsSublayout
    /// </summary>
    public partial class SearchresultsSublayout : System.Web.UI.UserControl
    {

        #region Configs & Reuse Objects

        private string str_SearchTerm = String.Empty;
        private string str_Wholesaler = String.Empty;
        private DataTable dt_SearchResults = new DataTable();
        private bool isMobileOrPhone = false;
        Sitecore.Data.Database masterDB;

        #endregion

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string str = Request.UserAgent.ToString();
                bool isMobile = str.ToLower().Contains("mobile");
                bool isPhone = str.ToLower().Contains("phone");
                bool isIpad = str.ToLower().Contains("ipad");

                this.pn_Desktop.Visible = false;
                this.pn_Mobile.Visible = false;


                if ((isMobile == true || isPhone == true) && isIpad == false)
                    isMobileOrPhone = true;

                if (Request.QueryString["SearchTerm"] != null && Request.QueryString["SearchTerm"].Trim() != "")
                {
                    str_SearchTerm = EncodeString(Request.QueryString["SearchTerm"].ToString());
                }
                else
                {
                    this.Label1.Text = "There are 0 results for your search ( " + Request.QueryString["SearchTerm"].ToString() + " ) ";
                }
                if (Request.QueryString["wholesaler"] != null && Request.QueryString["wholesaler"].Trim() != "")
                {
                    str_Wholesaler = EncodeString(Request.QueryString["wholesaler"].ToString());
                }

                FillWholesalers();

                if (!string.IsNullOrWhiteSpace(str_SearchTerm))
                    Load_Search_Results(str_SearchTerm, str_Wholesaler);

            }
        }

        protected void btn_search_clicked(object sender, EventArgs e)
        {
            Response.Redirect(String.Format("ProductSearch?SearchTerm={0}&wholesaler={1}", this.SearchTermField.Text.ToString().Trim(), str_Wholesaler));
        }

        private void Load_Search_Results(String term, String wholesaler)
        {
            //Search by Product Name 
            term = term.Replace("®", "<sup>&reg;</sup>");
            DataTable dt = getProductDetailsByName(term, wholesaler);
            if (dt.Rows.Count > 0)
            {
                int RecordCount = dt.Rows.Count;
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    dt.Rows[i]["RowCount"] = RecordCount;
                }
                this.Label1.Text = "There are " + RecordCount + " results for your search of ( " + term + " ) ";

                if (this.isMobileOrPhone)
                {
                    this.rp_products_mobile.DataSource = dt;
                    this.rp_products_mobile.DataBind();
                    this.pn_Mobile.Visible = true;
                }
                else
                {
                    if (dt != null)
                    {
                        this.pn_Desktop.Visible = true;
                        this.rp_products_desktop.DataSource = dt;
                        this.rp_products_desktop.DataBind();
                    }
                }
            }
            else
            {
                this.Label1.Text = "There are 0 results for your search of ( " + term + " ) ";
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

        protected string replaceSpecialChars(string input)
        {
            string output = input.Trim();
            output = output.Replace(".", "");
            output = output.Replace(",", "");
            output = output.Replace("(", "");
            output = output.Replace(")", "");
            output = output.Replace(" ", "-");
            output = output.Replace("®", "-");
            output = output.Replace("@", "-");
            output = output.Replace("*", "-");
            output = output.Replace("/", "-");
            output = output.Replace("%", "pc");
            output = output.Replace("&", "and");
            output = output.Replace("----", "-");
            output = output.Replace("---", "-");
            output = output.Replace("--", "-");
            return output;
        }

        #region DataCalls

        private void BindAllData()
        {
        }

        #region Private DataCalls

        private DataTable getProductDetailsByName(string ProductName, string WholeSaler)
        {
            masterDB = Sitecore.Configuration.Factory.GetDatabase("web");
            DataTable dt = new DataTable();
            dt.Columns.Add("AttrWarnings");
            dt.Columns.Add("InfoPrescribingInformationLink");
            dt.Columns.Add("NDC");
            dt.Columns.Add("NumericNDC");
            dt.Columns.Add("ProductID");
            dt.Columns.Add("ProductName");
            dt.Columns.Add("ProductNameNoSpaces");
            dt.Columns.Add("RowCount");
            dt.Columns.Add("ShortIdentifier");
            dt.Columns.Add("WholeSaler");
            dt.Columns.Add("WholeSalerName");

            double intQuery = -1;
            String productGroupTemplateID = "{A47497B6-472C-4E19-ADC4-A93C3BC80860}";
            String productQuery = String.Format("/sitecore/content//*[@@templateid='{0}']", productGroupTemplateID.ToString());
            Boolean filterByNDC = false;
            if (double.TryParse(ProductName.Replace("-", ""), out intQuery))
            {
                filterByNDC = true;
                if (!ProductName.Contains("-"))
                {
                    String formattedProductName = String.Format("{0}-{1}-{2}", ProductName.Substring(0, 5), ProductName.Substring(5, 3), ProductName.Substring(8, 2));
                    if (!String.IsNullOrWhiteSpace(formattedProductName))
                    {
                        ProductName = formattedProductName;
                    }
                }
                productQuery = String.Format("/sitecore/content//*[contains(@_NDC, '{0}')]/ancestor::*", ProductName.ToString());
            }
            List<Item> lstProductGroup = new List<Item>();
            List<Item> lstProductGroupNew = new List<Item>();
            Item[] productGroup = masterDB.SelectItems(productQuery);

            foreach (Item productGrp in productGroup)
            {
                if (productGrp.TemplateID.ToString() == productGroupTemplateID.ToString())
                {
                    lstProductGroup.Add(productGrp);
                }
            }

            foreach (Item product in lstProductGroup)
            {
                string value = string.Empty;
                if (!filterByNDC)
                {
                    if (product.Fields["Product Group Name"].Value.ToLower().StartsWith(ProductName.Replace("[", "").Replace("]", "").ToLower()))
                        value = product.Fields["Product Group Name"].Value.ToString().Trim().Replace("<sup>", "").Replace("</sup>", "");
                }
                else
                {
                    if (filterByNDC)
                    {
                        foreach (Item ndc in product.Children)
                        {
                            if (ndc.Fields["_NDC"].Value.ToString().StartsWith(ProductName.ToString()))
                            {
                                //value = ndc.Fields["_NDC"].Value.ToString().Trim().Replace("<sup>", "").Replace("</sup>", "");
                                value = product.Fields["Product Group Name"].Value.ToString().Trim().Replace("<sup>", "").Replace("</sup>", "");
                                break;
                            }
                        }
                    }
                }

                if (!String.IsNullOrWhiteSpace(value))
                {
                    lstProductGroupNew.Add(product);
                }
            }

            foreach (Item product in lstProductGroupNew)
            {
                foreach (Item ndc in product.Children)
                {
                    DataRow dRow = dt.NewRow();
                    dRow["NDC"] = ndc.Fields["_NDC"];
                    dRow["NumericNDC"] = GetNumericChars(ndc.Fields["_NDC"].Value.ToString());
                    if (ndc.Fields["_xAttrWarnings"] != null)
                    {
                        dRow["AttrWarnings"] = createWarningImages(ndc.Fields["_xAttrWarnings"].Value.ToString());
                    }
                    if (product.Fields["PrescribingInformationLink"] != null)
                    {
                        dRow["InfoPrescribingInformationLink"] = product.Fields["PrescribingInformationLink"].Value.ToString();
                    }
                    if (product.Fields["Product Group Name"] != null)
                    {
                        dRow["ShortIdentifier"] = "prod_" + replaceSpecialChars(product.ID.ToString());
                    }
                    if (product.Fields["Product Group Name"] != null)
                    {
                        dRow["ProductName"] = product.Fields["Product Group Name"].Value.ToString();
                        dRow["ProductNameNoSpaces"] = product.Fields["Product Group Name"].Value.ToString().Replace(" ", "").ToLower();
                    }
                    if (ndc != null)
                    {
                        dRow["ProductID"] = ndc.ID.ToString();
                    }

                    dRow["WholeSaler"] = String.Empty;
                    dRow["WholeSalerName"] = String.Empty;

                    if (!String.IsNullOrWhiteSpace(WholeSaler))
                    {
                        dRow["WholeSalerName"] = WholeSaler;
                        if ((ndc.Fields[WholeSaler] != null) && (!String.IsNullOrWhiteSpace(ndc.Fields[WholeSaler].Value.ToString())))
                        {
                            dRow["WholeSaler"] = ndc.Fields[WholeSaler].Value.ToString();
                        }
                    }

                    dt.Rows.Add(dRow);
                }
            }
            DataView dv = new DataView(dt);


            dv.Sort = "NumericNDC ASC, ProductNameNoSpaces ASC, NumericNDC ASC";

            return dv.ToTable(true);
        }

        /// <summary>
        /// Overloaded method - converts all units to their lowest representation before returning the numeric value.
        /// </summary>
        /// <param name="value"></param>
        /// <returns></returns>
        private decimal GetNumericChars(String value)
        {
            decimal numericValue = -1;
            String unitValue = String.Empty;

            try
            {
                if ((value.Contains(" ")) && (decimal.TryParse(value.Split(' ')[0].ToString(), out numericValue)))
                {
                    //handle any strength specified as "100 mcg" with a space before mcg
                    unitValue = value.Split(' ')[1].ToString();
                }
                else
                {
                    //handle any strength specified as "100mcg" without a space before mcg
                    String numVal = String.Empty;
                    String uniVal = String.Empty;

                    for (int i = 0; i < value.Length; i++)
                    {
                        decimal temp = -1;
                        if (decimal.TryParse(value[i].ToString(), out temp))
                        {
                            if (temp >= 0)
                                numVal = numVal + value[i];
                        }
                        else
                        {
                            if (!String.IsNullOrEmpty(value[i].ToString()))
                                uniVal = uniVal + value[i];
                        }
                        //handle any overflow exceptions 
                        if (i > 10) //this will cover a large value expressed in mcg as well, such as 1000 mcg
                            break;
                    }
                    numericValue = System.Convert.ToInt32(numVal);
                    unitValue = uniVal.Trim();
                }
                //convert to the lowest unit representation.  (Convert g to mcg, l to ml)
                switch (unitValue)
                {
                    case "g":
                        //convert grams to microgram
                        numericValue = (numericValue * 1000 * 1000);
                        break;
                    case "mg":
                        //convert milligrams to micrograms
                        numericValue = numericValue * 1000;
                        break;
                    case "l":
                        //convert liter to milli liter
                        numericValue = numericValue * 1000;
                        break;
                    default:
                        break;
                }
            }
            catch (Exception)
            {
                //Ignore
            }

            if (string.IsNullOrEmpty(numericValue.ToString()))
                numericValue = GetNumericChars(value, string.Empty);

            return numericValue;
        }

        /// <summary>
        /// Overloaded method.  Created to preserve the simple "GetNumericChars" method which returns just the numeric part of a string.  
        /// This method will be used if the "convert and compare" method above fails to convert the value correctly
        /// </summary>
        /// <param name="value"></param>
        /// <param name="UnusedParameter"></param>
        /// <returns></returns>
        private decimal GetNumericChars(String value, String UnusedParameter)
        {
            decimal temp = -1;
            String retVal = "0";
            if ((value.Contains(" ")) && (decimal.TryParse(value.Split(' ')[0].ToString(), out temp)))
            {
                //handle any strength specified as "100 mcg" with a space before mcg
                return temp;
            }
            else
            {
                //handle any strength specified as "100mcg" without a space before mcg
                for (int i = 0; i < value.Length; i++)
                {
                    temp = -1;
                    if (decimal.TryParse(value[i].ToString(), out temp))
                    {
                        if (temp >= 0)
                            retVal = retVal + value[i];
                    }
                    //handle any overflow exceptions 
                    if (i > 5)
                        break;
                }
                return System.Convert.ToInt32(retVal);
            }
        }

        protected DataTable getNdcDetailById(string theNDCId)
        {
            Sitecore.Data.ID NDC_ID = Sitecore.Data.ID.Null;
            DataTable dt = new DataTable();

            if (Sitecore.Data.ID.TryParse(theNDCId, out NDC_ID))
            {
                try
                {
                    //Response.Write(ndcId);
                    Sitecore.Data.Database masterDB = Sitecore.Configuration.Factory.GetDatabase("web");

                    dt.Columns.Add("AttrClosureSize");
                    dt.Columns.Add("AttrDose");
                    dt.Columns.Add("AttrFillVolume");
                    dt.Columns.Add("AttrStrength");
                    dt.Columns.Add("AttrVialSize");
                    dt.Columns.Add("AttrWarnings");
                    dt.Columns.Add("NDC");
                    dt.Columns.Add("PkgPackage");
                    dt.Columns.Add("PkgPackageDetails");
                    dt.Columns.Add("PkgPackSize");
                    dt.Columns.Add("PkgBoxesPerCase");
                    dt.Columns.Add("PkgOrderingMultiple");
                    dt.Columns.Add("ProductCategory");
                    dt.Columns.Add("ProductID");
                    dt.Columns.Add("ProductDescription");
                    dt.Columns.Add("ProductCode");
                    dt.Columns.Add("ProductName");
                    dt.Columns.Add("ShortIdentifier");
                    dt.Columns.Add("WholeSaler");
                    dt.Columns.Add("WholeSalerName");

                    //columns for sorting
                    dt.Columns.Add("NumericNDC");
                    dt.Columns.Add("NumericStrength");
                    dt.Columns.Add("NumericFillVolume");
                    dt.Columns.Add("NumericVialSize");
                    dt.Columns.Add("NumericClosureSize");
                    dt.Columns.Add("NumericPackSize");
                    //columns for sorting

                    Item[] productGroup = null;
                    productGroup = masterDB.SelectItems(String.Format("fast://*[@@id='{0}']", NDC_ID.ToString()));

                    foreach (Item product in productGroup)
                    {
                        DataRow dr = dt.NewRow();
                        if (product.Fields["_xAttrClosureSize"] != null)
                        {
                            String strTemp = product.Fields["_xAttrClosureSize"].Value.ToString();
                            dr["AttrClosureSize"] = strTemp;
                            dr["NumericClosureSize"] = GetNumericChars(strTemp);
                        }
                        if (product.Fields["_xAttrDose"] != null)
                        {
                            dr["AttrDose"] = product.Fields["_xAttrDose"].Value.ToString();
                        }
                        if (product.Fields["_xAttrFillVolume"] != null)
                        {
                            String strTemp = product.Fields["_xAttrFillVolume"].Value.ToString();
                            dr["AttrFillVolume"] = strTemp;
                            dr["NumericFillVolume"] = GetNumericChars(strTemp);
                        }
                        if (product.Fields["_xAttrStrength"] != null)
                        {
                            String strTemp = product.Fields["_xAttrStrength"].Value.ToString();
                            dr["AttrStrength"] = strTemp;
                            dr["NumericStrength"] = GetNumericChars(strTemp);
                        }
                        if (product.Fields["_xAttrVialSize"] != null)
                        {
                            String strTemp = product.Fields["_xAttrVialSize"].Value.ToString();
                            dr["AttrVialSize"] = strTemp;
                            dr["NumericVialSize"] = GetNumericChars(strTemp);
                        }
                        if (product.Fields["_xAttrWarnings"] != null)
                        {
                            dr["AttrWarnings"] = product.Fields["_xAttrWarnings"].Value.ToString();
                        }
                        if (product.Fields["_NDC"] != null)
                        {
                            String strTemp = product.Fields["_NDC"].Value.ToString();
                            dr["NDC"] = strTemp;
                            dr["NumericNDC"] = GetNumericChars(strTemp);
                        }
                        if (product.Fields["_xPkgPackage"] != null)
                        {
                            dr["PkgPackage"] = product.Fields["_xPkgPackage"].Value.ToString();
                        }
                        if (product.Fields["_xPkgPackageDetails"] != null)
                        {
                            dr["PkgPackageDetails"] = product.Fields["_xPkgPackageDetails"].Value.ToString();
                        }
                        if (product.Fields["_xPkgBoxesPerCase"] != null)
                        {
                            dr["PkgBoxesPerCase"] = product.Fields["_xPkgBoxesPerCase"].Value.ToString();
                        }
                        if (product.Fields["_xPkgPackSize"] != null)
                        {
                            String strTemp = product.Fields["_xPkgPackSize"].Value.ToString();
                            dr["PkgPackSize"] = strTemp;
                            dr["NumericPackSize"] = replaceSpecialChars(strTemp);
                        }
                        if (product.Fields["_xPkgOrderingMultiple"] != null)
                        {
                            dr["PkgOrderingMultiple"] = product.Fields["_xPkgOrderingMultiple"].Value.ToString();
                        }
                        if (product.Fields["_ProductCategory"] != null)
                        {
                            dr["ProductCategory"] = product.Fields["_ProductCategory"].Value.ToString();
                        }
                        if (product.Fields["_ProductDescription"] != null)
                        {
                            dr["ProductDescription"] = product.Fields["_ProductDescription"].Value.ToString();
                        }
                        if (product.Parent.Fields["Product Group Name"] != null)
                        {
                            dr["ProductName"] = product.Parent.Fields["Product Group Name"].Value.ToString();
                            dr["ShortIdentifier"] = "ndc_" + replaceSpecialChars(product.Parent.Fields["Product Group Name"].Value.ToString());
                            dr["ShortIdentifier"] = "prod_" + replaceSpecialChars(product.ID.ToString());
                        }
                        if (product.Parent != null)
                        {
                            dr["ProductID"] = product.Parent.ID.ToString();
                        }


                        dr["WholeSaler"] = String.Empty;
                        dr["WholeSalerName"] = String.Empty;

                        if (!String.IsNullOrWhiteSpace(str_Wholesaler))
                        {
                            dr["WholeSalerName"] = str_Wholesaler;
                            if ((product.Fields[str_Wholesaler] != null) && (!String.IsNullOrWhiteSpace(product.Fields[str_Wholesaler].Value.ToString())))
                            {
                                dr["WholeSaler"] = product.Fields[str_Wholesaler].Value.ToString();
                            }
                        }
                        /*
                        dr["ProductCode"] = product.Parent.Fields["alternateNDCTitle"].Value.ToString();
                         */
                        dt.Rows.Add(dr);
                    }
                }
                catch (Exception e)
                {
                    //TODO: Log the exception
                }
            }
            DataView dv = new DataView(dt);

            dv.Sort = "NumericNDC Asc, NumericStrength Asc, NumericFillVolume Asc,  NumericVialSize Asc,  NumericClosureSize Asc,  NumericPackSize Asc,  WholeSalerName Asc";
            return dv.ToTable(true);
        }

        private string EncodeString(string s)
        {
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < s.Length; i++)
            {
                char c = s[i];
                if (c == '*' || c == '%' || c == '[' || c == ']')
                    sb.Append("[").Append(c).Append("]");
                else if (c == '\'')
                    sb.Append("''");
                else
                    sb.Append(c);
            }
            return sb.ToString();
        }

        private void FillWholesalers()
        {
            masterDB = Sitecore.Configuration.Factory.GetDatabase("web");
            ddlWholesaler.Items.Clear();
            String lookupItemsPath = "/sitecore/content/MylanInstitutionalProducts/Lookup";
            String query = String.Format("fast:{0}//*[@@templateid='{1}']", lookupItemsPath, "{A4981929-872A-4EAD-8408-2C13AD6D6D95}");
            Item[] lookupItems = masterDB.SelectItems(query);
            ListItem li = null;
            foreach (Item itm in lookupItems)
            {
                CheckboxField isDisabled = itm.Fields["Disabled"];
                if ((isDisabled != null) && (!isDisabled.Checked))
                {
                    li = null;
                    li = new ListItem(itm.Fields["Display"].Value.ToString(), itm.Fields["Value"].Value.ToString());
                }
                if (li != null)
                {
                    ddlWholesaler.Items.Add(li);
                }
            }

            List<ListItem> list = new List<ListItem>(ddlWholesaler.Items.Cast<ListItem>());
            list = list.OrderBy(li1 => li1.Text).ToList<ListItem>();
            ddlWholesaler.Items.Clear();
            ddlWholesaler.Items.AddRange(list.ToArray<ListItem>());

            ddlWholesaler.Items.Insert(0, new ListItem("Select a wholesaler", ""));
            if (!String.IsNullOrWhiteSpace(str_Wholesaler))
            {
                foreach (ListItem lItm in ddlWholesaler.Items)
                {
                    if (lItm.Value == str_Wholesaler)
                    {
                        lItm.Selected = true;
                    }
                }
            }
            else
            {
                ddlWholesaler.Items[0].Selected = true;
            }
        }

        #endregion

        protected void ddlWholesaler_SelectedIndexChanged(object sender, EventArgs e)
        {

            if (Request.QueryString["SearchTerm"] != null && Request.QueryString["SearchTerm"].Trim() != "")
            {
                str_SearchTerm = EncodeString(Request.QueryString["SearchTerm"].ToString());
            }

            if (!string.IsNullOrWhiteSpace(str_SearchTerm))
            {
                if (ddlWholesaler.SelectedIndex > 0)
                {
                    str_Wholesaler = ddlWholesaler.SelectedValue.ToString();
                }
                Response.Redirect(String.Format("ProductSearch?SearchTerm={0}&wholesaler={1}", str_SearchTerm, str_Wholesaler));
            }
        }


        #endregion
    }
}