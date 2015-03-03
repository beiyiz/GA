using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sitecore.Data.Fields;
using Sitecore.Data.Items;
using System.Text;

namespace Layouts.Productcatalog
{
    /// <summary>
    /// Summary description for ProductcatalogSublayout
    /// </summary>
    public partial class ProductcatalogSublayout : System.Web.UI.UserControl
    {
        Sitecore.Data.Database masterDB;
        String strWholeSalerSelectedValue = String.Empty;
        String strWholeSalerDisplayName = String.Empty;
        string str = String.Empty;
        bool isMobile = false;
        bool isPhone = false;
        bool isIpad = false;

        protected void Page_Load(object sender, EventArgs e)
        {
            masterDB = Sitecore.Configuration.Factory.GetDatabase("master");
            if (!IsPostBack)
            {
                str = Request.UserAgent.ToString();
                isMobile = str.ToLower().Contains("mobile");
                isPhone = str.ToLower().Contains("phone");
                isIpad = str.ToLower().Contains("ipad");

                FillWholesalers();
                FillData();
            }
        }

        private void FillData()
        {
            this.pan_desktop.Visible = false;
            this.pan_mobile.Visible = false;

            if ((isMobile == true || isPhone == true) && isIpad == false)
            {
                this.pan_mobile.Visible = true;
                BindAllData_mobile();
            }
            else
            {
                this.pan_desktop.Visible = true;
                BindAllData_desktop();
            }
            //BindAllData_mobile();
        }

        private void FillWholesalers()
        {
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
        }

        private DataTable ApplyAlphaFilter(DataTable dt, String AlphaFilter)
        {
            DataView dv = new DataView(dt);
            try
            {
                switch (AlphaFilter)
                {
                    case "A-G":
                        dv.RowFilter = "ProductName Like 'A*' "
                            + " OR ProductName Like 'B*'"
                            + " OR ProductName Like 'C*'"
                            + " OR ProductName Like 'D*'"
                            + " OR ProductName Like 'E*'"
                            + " OR ProductName Like 'F*'"
                            + " OR ProductName Like 'G*'";
                        break;

                    case "H-N":
                        dv.RowFilter = "ProductName Like 'H*' "
                            + " OR ProductName Like 'I*'"
                            + " OR ProductName Like 'J*'"
                            + " OR ProductName Like 'K*'"
                            + " OR ProductName Like 'L*'"
                            + " OR ProductName Like 'M*'"
                            + " OR ProductName Like 'N*'";
                        break;

                    case "O-U":
                        dv.RowFilter = "ProductName Like 'O*' "
                            + " OR ProductName Like 'P*'"
                            + " OR ProductName Like 'Q*'"
                            + " OR ProductName Like 'R*'"
                            + " OR ProductName Like 'S*'"
                            + " OR ProductName Like 'T*'"
                            + " OR ProductName Like 'U*'";
                        break;

                    case "V-Z":
                        dv.RowFilter = "ProductName Like 'V*' "
                            + " OR ProductName Like 'W*'"
                            + " OR ProductName Like 'X*'"
                            + " OR ProductName Like 'Y*'"
                            + " OR ProductName Like 'Z*'";
                        break;

                    default:
                        break;
                }
            }
            catch (Exception ex)
            {
                Sitecore.Diagnostics.Log.Error("Error: Failed applying Alpha Filter at ApplyAlphaFilter : " + AlphaFilter, ex, ex.Source);
            }
            DataTable newDT = dv.ToTable();
            try
            {
                foreach (DataRow dr in newDT.Rows)
                {
                    dr["RowCount"] = newDT.Rows.Count;
                }
            }
            catch (Exception ex)
            {

            }
            return newDT;
        }

        private void BindDetails(System.Data.DataRowView dr, String detailRepeaterName, RepeaterItem rptItem)
        {
            try
            {
                Repeater detailRepeater = (Repeater)rptItem.FindControl(detailRepeaterName);
                //Response.Write(detailRepeaterName);
                if (detailRepeater != null)
                {
                    if (dr != null)
                    {
                        String productCat = dr["ProductCategory"].ToString();
                        String productLine = dr["ProductLine"].ToString();
                        String ProductName = dr["ProductName"].ToString();
                        String ProductID = dr["ProductID"].ToString();
                        DataTable dt = GetProductDetails(productCat, productLine, ProductName, ProductID);
                        if (dt.Rows.Count > 0)
                        {
                            DataView dv = new DataView(dt);
                            dv.Sort = "NumericStrength ASC, AttrStrength ASC";
                            detailRepeater.DataSource = dv.ToTable();
                            detailRepeater.DataBind();
                        }
                    }
                }
            }
            catch (System.Threading.ThreadAbortException tex)
            {
            }
            catch (Exception ex)
            {
            }
        }

        private void BindAllData_desktop()
        {
            Item[] Categories = masterDB.SelectItems("fast:/sitecore/content//*[@@templatename = 'ProductCategory']");

            int i = 0;
            unitdose_product_panel.Visible = false;
            injectables_product_panel.Visible = false;
            burn_wound_care_product_panel.Visible = false;
            veterinary_product_panel.Visible = false;
            foreach (Item category in Categories)
            {
                i++;
                String categoryName = category.Name.ToString();
                DataTable products = new DataTable();
                if (category.HasChildren)
                {
                    DataTable dt = null;
                    try
                    {
                        switch (categoryName.ToString().ToLower())
                        {
                            case "unitdose":
                                // Fill the Products datatable once and reuse for each filter:
                                products = getProductsByCategories(categoryName.ToString(), "", "UnitDoseDrugs");
                                if (products.Rows.Count > 0)
                                {
                                    if (!unitdose_product_panel.Visible)
                                    {
                                        unitdose_product_panel.Visible = true;
                                    }
                                    dt = null;
                                    dt = ApplyAlphaFilter(products, "A-G");
                                    if (dt.Rows.Count > 0)
                                    {
                                        this.product_name_unitdosedrug_a2g.DataSource = dt;
                                        this.product_name_unitdosedrug_a2g.DataBind();
                                    }
                                    dt = null;
                                    dt = ApplyAlphaFilter(products, "H-N");
                                    if (dt.Rows.Count > 0)
                                    {
                                        this.product_name_unitdosedrug_h2n.DataSource = dt;
                                        this.product_name_unitdosedrug_h2n.DataBind();
                                    }
                                    dt = null;
                                    dt = ApplyAlphaFilter(products, "O-U");
                                    if (dt.Rows.Count > 0)
                                    {
                                        this.product_name_unitdosedrug_o2u.DataSource = dt;
                                        this.product_name_unitdosedrug_o2u.DataBind();
                                    }
                                    dt = null;
                                    dt = ApplyAlphaFilter(products, "V-Z");
                                    if (dt.Rows.Count > 0)
                                    {
                                        DataView dv = new DataView(dt);
                                        this.product_name_unitdosedrug_v2z.DataSource = dt;
                                        this.product_name_unitdosedrug_v2z.DataBind();
                                    }
                                }

                                products = getProductsByCategories(categoryName.ToString(), "", "ControlADose");
                                if (products.Rows.Count > 0)
                                {
                                    if (!unitdose_product_panel.Visible)
                                    {
                                        unitdose_product_panel.Visible = true;
                                    }
                                    DataView dv = new DataView(products);
                                    dv.Sort = "AttrStrength ASC";
                                    this.product_name_unitdosedrug_a2g.DataSource = dv.ToTable();
                                    this.product_name_controladose_all.DataSource = products;
                                    this.product_name_controladose_all.DataBind();
                                }
                                products = getProductsByCategories(categoryName.ToString(), "", "RobotRxReadyDrugs");
                                if (products.Rows.Count > 0)
                                {
                                    if (!unitdose_product_panel.Visible)
                                    {
                                        unitdose_product_panel.Visible = true;
                                    }
                                    this.product_name_robotrxready_all.DataSource = products;
                                    this.product_name_robotrxready_all.DataBind();
                                }
                                products = getProductsByCategories(categoryName.ToString(), "", "PunchCardDrugs");
                                if (products.Rows.Count > 0)
                                {
                                    if (!unitdose_product_panel.Visible)
                                    {
                                        unitdose_product_panel.Visible = true;
                                    }
                                    this.product_name_punchcard_all.DataSource = products;
                                    this.product_name_punchcard_all.DataBind();
                                }
                                products = getProductsByCategories(categoryName.ToString(), "", "EmergiScript");
                                if (products.Rows.Count > 0)
                                {
                                    if (!unitdose_product_panel.Visible)
                                    {
                                        unitdose_product_panel.Visible = true;
                                    }
                                    this.product_name_emergiscript_all.DataSource = products;
                                    this.product_name_emergiscript_all.DataBind();
                                }
                                break;

                            case "injectables":
                                #region Fill the Products datatable once and reuse for each filter below:
                                products = getProductsByCategories(categoryName.ToString(), "");
                                dt = null;
                                dt = ApplyAlphaFilter(products, "A-G");
                                if (dt.Rows.Count > 0)
                                {
                                    if (!injectables_product_panel.Visible)
                                    {
                                        injectables_product_panel.Visible = true;
                                    }
                                    this.product_name_Injectables_a2g.DataSource = dt;
                                    this.product_name_Injectables_a2g.DataBind();
                                }
                                dt = null;
                                dt = ApplyAlphaFilter(products, "H-N");
                                if (dt.Rows.Count > 0)
                                {
                                    if (!injectables_product_panel.Visible)
                                    {
                                        injectables_product_panel.Visible = true;
                                    }
                                    this.product_name_Injectables_h2n.DataSource = dt;
                                    this.product_name_Injectables_h2n.DataBind();
                                }
                                dt = null;
                                dt = ApplyAlphaFilter(products, "O-U");
                                if (dt.Rows.Count > 0)
                                {
                                    if (!injectables_product_panel.Visible)
                                    {
                                        injectables_product_panel.Visible = true;
                                    }
                                    this.product_name_Injectables_o2u.DataSource = dt;
                                    this.product_name_Injectables_o2u.DataBind();
                                }
                                dt = null;
                                dt = ApplyAlphaFilter(products, "V-Z");
                                if (dt.Rows.Count > 0)
                                {
                                    if (!injectables_product_panel.Visible)
                                    {
                                        this.injectables_product_panel.Visible = true;
                                    }
                                    this.product_name_Injectables_v2z.DataSource = dt;
                                    this.product_name_Injectables_v2z.DataBind();
                                }
                                break;
                                #endregion

                            case "burnandwoundcare":
                                products = getProductsByCategories(categoryName.ToString(), "");
                                this.burn_wound_care_product_panel.Visible = true;
                                //Response.Write(this.burn_wound_care_product_panel.Visible);
                                if (products.Rows.Count > 0)
                                {
                                    this.product_name_BurnWoundCare_all.DataSource = products;
                                    this.product_name_BurnWoundCare_all.DataBind();
                                }
                                break;
                            case "veterinary":
                                products = getProductsByCategories(categoryName.ToString(), "");
                                if (products.Rows.Count > 0)
                                {
                                    this.veterinary_product_panel.Visible = true;
                                    this.product_name_Veterinary_all.DataSource = products;
                                    this.product_name_Veterinary_all.DataBind();
                                }
                                break;
                            case "cryopreserveagent":
                                products = getProductsByCategories(categoryName.ToString(), "");
                                if (products.Rows.Count > 0)
                                {
                                    this.cryopreserve_panel.Visible = true;
                                    this.product_name_cryopreserve_all.DataSource = products;
                                    this.product_name_cryopreserve_all.DataBind();
                                }
                                break;
                            default:
                                break;
                        }
                    }
                    catch (Exception ex)
                    {
                        Sitecore.Diagnostics.Log.Error("Error: Failed at BindAllData_desktop for Category " + category.Paths.FullPath.ToString(), ex, ex.Source);
                    }
                }

            }
        }

        private void BindAllData_mobile()
        {
            //Unit Dose Binding
            Item[] Categories = masterDB.SelectItems("fast:/sitecore/content//*[@@templatename = 'ProductCategory']");

            int i = 0;
            foreach (Item category in Categories)
            {
                i++;
                String categoryName = category.Name.ToString();
                DataTable products = new DataTable();
                if (category.HasChildren)
                {
                    DataTable dt = null;
                    try
                    {
                        switch (categoryName.ToString().ToLower())
                        {
                            case "unitdose":

                                #region Fill the Products datatable once and reuse for each filter:
                                products = getProductsByCategories(categoryName.ToString(), "", "UnitDoseDrugs");
                                if (products.Rows.Count > 0)
                                {
                                    dt = null;
                                    dt = ApplyAlphaFilter(products, "A-G");
                                    if (dt.Rows.Count > 0)
                                    {
                                        this.product_name_unitdosedrug_a2g_mobile.DataSource = dt;
                                        this.product_name_unitdosedrug_a2g_mobile.DataBind();
                                    }
                                    dt = null;
                                    dt = ApplyAlphaFilter(products, "H-N");
                                    if (dt.Rows.Count > 0)
                                    {
                                        this.product_name_unitdosedrug_h2n_mobile.DataSource = dt;
                                        this.product_name_unitdosedrug_h2n_mobile.DataBind();
                                    }
                                    dt = null;
                                    dt = ApplyAlphaFilter(products, "O-U");
                                    if (dt.Rows.Count > 0)
                                    {
                                        this.product_name_unitdosedrug_o2u_mobile.DataSource = dt;
                                        this.product_name_unitdosedrug_o2u_mobile.DataBind();
                                    }
                                    dt = null;
                                    dt = ApplyAlphaFilter(products, "V-Z");
                                    if (dt.Rows.Count > 0)
                                    {
                                        this.product_name_unitdosedrug_v2z_mobile.DataSource = dt;
                                        this.product_name_unitdosedrug_v2z_mobile.DataBind();
                                    }
                                }
                                #endregion

                                products = getProductsByCategories(categoryName.ToString(), "", "ControlADose");
                                if (products.Rows.Count > 0)
                                {
                                    this.product_name_controladose_all_mobile.DataSource = products;
                                    this.product_name_controladose_all_mobile.DataBind();
                                }
                                products = getProductsByCategories(categoryName.ToString(), "", "RobotRxReadyDrugs");
                                if (products.Rows.Count > 0)
                                {
                                    this.product_name_robotrxready_all_mobile.DataSource = products;
                                    this.product_name_robotrxready_all_mobile.DataBind();
                                }
                                products = getProductsByCategories(categoryName.ToString(), "", "PunchCardDrugs");
                                if (products.Rows.Count > 0)
                                {
                                    this.product_name_punchcard_all_mobile.DataSource = products;
                                    this.product_name_punchcard_all_mobile.DataBind();
                                }
                                products = getProductsByCategories(categoryName.ToString(), "", "EmergiScript");
                                if (products.Rows.Count > 0)
                                {
                                    this.product_name_emergiscript_all_mobile.DataSource = products;
                                    this.product_name_emergiscript_all_mobile.DataBind();
                                }
                                break;

                            case "injectables":
                                #region Fill the Products datatable once and reuse for each filter below:
                                products = getProductsByCategories(categoryName.ToString(), "");
                                dt = null;
                                dt = ApplyAlphaFilter(products, "A-G");
                                if (dt.Rows.Count > 0)
                                {
                                    this.product_name_Injectables_a2g_mobile.DataSource = dt;
                                    this.product_name_Injectables_a2g_mobile.DataBind();
                                }
                                dt = null;
                                dt = ApplyAlphaFilter(products, "H-N");
                                if (dt.Rows.Count > 0)
                                {
                                    this.product_name_Injectables_h2n_mobile.DataSource = dt;
                                    this.product_name_Injectables_h2n_mobile.DataBind();
                                }
                                dt = null;
                                dt = ApplyAlphaFilter(products, "O-U");
                                if (dt.Rows.Count > 0)
                                {
                                    this.product_name_Injectables_o2u_mobile.DataSource = dt;
                                    this.product_name_Injectables_o2u_mobile.DataBind();
                                }
                                dt = null;
                                dt = ApplyAlphaFilter(products, "V-Z");
                                if (dt.Rows.Count > 0)
                                {
                                    this.product_name_Injectables_v2z_mobile.DataSource = dt;
                                    this.product_name_Injectables_v2z_mobile.DataBind();
                                }
                                break;
                                #endregion

                            case "burnandwoundcare":
                                products = getProductsByCategories(categoryName.ToString(), "");
                                if (products.Rows.Count > 0)
                                {
                                    this.product_name_BurnWoundCare_all_mobile.DataSource = products;
                                    this.product_name_BurnWoundCare_all_mobile.DataBind();
                                }
                                break;
                            case "veterinary":
                                products = getProductsByCategories(categoryName.ToString(), "");
                                if (products.Rows.Count > 0)
                                {
                                    this.product_name_Veterinary_all_mobile.DataSource = products;
                                    this.product_name_Veterinary_all_mobile.DataBind();
                                }
                                break;
                            case "cryopreserveagent":
                                products = getProductsByCategories(categoryName.ToString(), "");
                                if (products.Rows.Count > 0)
                                {
                                    this.product_name_cryopreserve_all_mobile.DataSource = products;
                                    this.product_name_cryopreserve_all_mobile.DataBind();
                                }
                                break;
                            default:
                                break;
                        }
                    }
                    catch (Exception ex)
                    {
                        Sitecore.Diagnostics.Log.Error("Error: Failed at BindAllData_desktop for Category " + category.Paths.FullPath.ToString(), ex, ex.Source);
                    }
                }

            }
        }

        #region Utility Functions

        public string stripSpecialChars(string input)
        {
            string output = input.Trim();
            output = input.Replace(" ", "");
            output = output.Replace("®", "");
            output = output.Replace("%", "");
            output = output.Replace("@", "");
            output = output.Replace("&", "");
            output = output.Replace("*", "");
            return output;
        }

        public string replaceSpecialChars(string input)
        {
            string output = input.Trim();
            output = output.Replace(".", "");
            output = output.Replace(",", "");
            output = output.Replace("(", "");
            output = output.Replace("sup", "");
            output = output.Replace(">", "");
            output = output.Replace("<", "");
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

        private string createWarningImages(string Warning)
        {
            //string newWarning = "";
            //if (Warning != null && Warning != "")
            //{
            //    string[] b = Warning.Split(new Char[] { ' ', '/', });
            //    foreach (string i in b)
            //    {
            //        if (i.Trim() != "" && i.Trim() != null && i.Trim() != "/")
            //        {
            //            newWarning += "<img src='/assets/MylanInstitutionalProducts/images/" + i.Trim() + ".png'> ";
            //        }
            //    }
            //}
            //return newWarning;

            String[] CWarnings = { "CII", "CIII", "CIV" };
            String[] Warnings = { "LF", "PF", "BW" };

            StringBuilder newWarning = new StringBuilder();

            string strCTemp = String.Empty;
            foreach (String aWarning in CWarnings)
            {
                foreach (String aDefinedWarning in Warning.Split(new Char[] { ' ', '/', }))
                {
                    if (aWarning.ToLower() == aDefinedWarning.ToLower())
                    {
                        strCTemp = aWarning.ToString();
                        break;
                    }
                }
            }

            if (!String.IsNullOrWhiteSpace(strCTemp))
            {
                newWarning.AppendFormat("<img src='/assets/MylanInstitutionalProducts/images/{0}.png' style='width:25px; padding-right:1px; padding-left:1px;' /> ", strCTemp.Trim());
            }
            else
            {
                newWarning.AppendFormat("<img src='/assets/MylanInstitutionalProducts/images/{0}.png' style='visibility:hidden; width:25px; padding-right:1px; padding-left:1px;' /> ", strCTemp.Trim());
            }

            foreach (String aWarning in Warnings)
            {
                string strTemp = String.Empty;
                foreach (String aDefinedWarning in Warning.Split(new Char[] { ' ', '/', }))
                {
                    if (aWarning.ToLower() == aDefinedWarning.ToLower())
                    {
                        strTemp = aWarning.ToString();
                        break;
                    }
                }
                if (!String.IsNullOrWhiteSpace(strTemp))
                {
                    newWarning.AppendFormat("<img src='/assets/MylanInstitutionalProducts/images/{0}.png' style='width:25px; padding-right:1px; padding-left:1px;' /> ", strTemp.Trim());
                }
                else
                {
                    newWarning.AppendFormat("<img src='/assets/MylanInstitutionalProducts/images/{0}.png' style='visibility:hidden; width:25px; padding-right:1px; padding-left:1px;' /> ", strTemp.Trim());
                }
            }

            return newWarning.ToString();
        }

        private string replaceEmptyWithNA(string input)
        {
            if (input != null)
            {
                if (input.Length < 1 || input == "")
                {
                    input = "N/A";
                }
            }
            else
            {
                input = "N/A";
            }
            return input;
        }
        #endregion

        #region DataCalls

        #region Protected DataCalls

        protected DataTable getProductsByCategories(string Category, string AlphaFilter, string SubCategory)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("ProductCategory");
            dt.Columns.Add("ProductLine");
            dt.Columns.Add("ProductName");
            dt.Columns.Add("ProductID");
            dt.Columns.Add("AlternateTitle");
            dt.Columns.Add("AttrStrength");
            dt.Columns.Add("AttrWarnings");
            dt.Columns.Add("InfoPrescribingInformationLink");
            dt.Columns.Add("RowCount");
            dt.Columns.Add("cbValue");
            dt.Columns.Add("WholeSaler");
            dt.Columns.Add("WholeSalerName");

            Item[] productGroup = masterDB.SelectItems("fast:/sitecore/content//*[@@name='" + Category + "']");
            foreach (Item productCategory in productGroup)
            {
                if (productCategory.HasChildren)
                {
                    foreach (Item productSubCategory in productCategory.Children)
                    {
                        if (productSubCategory.Name.ToString() == SubCategory)
                        {
                            if (productSubCategory.HasChildren)
                            {
                                int i = productSubCategory.Children.Count;
                                foreach (Item product in productSubCategory.Children)
                                {
                                    DataRow dr = dt.NewRow();
                                    dr["ProductLine"] = productSubCategory.Fields["Product Group Name"].Value.ToString();
                                    dr["ProductCategory"] = productCategory.Fields["Category"].Value.ToString();
                                    dr["ProductID"] = product.ID;
                                    dr["ProductName"] = product.Fields["Product Group Name"].Value.ToString();
                                    dr["cbValue"] = "prod_" + replaceSpecialChars(product.ID.ToString());
                                    dr["RowCount"] = i;
                                    dr["AlternateTitle"] = product.Fields["AlternateNDCTitle"].Value;
                                    dr["InfoPrescribingInformationLink"] = product.Fields["PrescribingInformationLink"].Value.ToString();

                                    dr["AttrWarnings"] = createWarningImages(product.Children[0].Fields["_xAttrWarnings"].Value.ToString());
                                    dt.Rows.Add(dr);
                                }
                            }
                        }
                    }
                }
            }
            DataView dv = new DataView(dt);
            dv.Sort = "ProductName, AttrStrength ASC";
            return dv.ToTable();
        }

        protected DataTable getProductsByCategories(string Category, string AlphaFilter)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("NDC");
            dt.Columns.Add("AlternateTitle");
            dt.Columns.Add("ProductCategory");
            dt.Columns.Add("ProductLine");
            dt.Columns.Add("ProductName");
            dt.Columns.Add("ProductID");
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
            dt.Columns.Add("ShortIdentifier");
            dt.Columns.Add("InfoPrescribingInformationLink");
            dt.Columns.Add("RowCount");
            dt.Columns.Add("cbValue");
            dt.Columns.Add("WholeSaler");
            dt.Columns.Add("WholeSalerName");

            Item[] productGroup = Sitecore.Context.Database.SelectItems("fast:/sitecore/content//*[@@name='" + Category + "']");
            foreach (Item productCategory in productGroup)
            {
                if (productCategory.HasChildren)
                {
                    foreach (Item product in productCategory.Children)
                    {
                        DataRow dr = dt.NewRow();
                        try
                        {
                            if ((productCategory != null) && (productCategory.Fields["Category"] != null))
                            {
                                dr["ProductCategory"] = productCategory.Fields["Category"].Value.ToString();
                                dr["ProductName"] = product.Fields["Product Group Name"].Value.ToString();
                                dr["ProductID"] = product.ID;
                                //dr["cbValue"] = "prod_" + product.ID.ToString().Replace("{", "%7B").Replace("}", "%7D");
                                dr["cbValue"] = "prod_" + replaceSpecialChars(product.ID.ToString());
                                dr["InfoPrescribingInformationLink"] = product.Fields["PrescribingInformationLink"].Value;
                                dr["AlternateTitle"] = product.Fields["AlternateNDCTitle"].Value;

                                int i = productCategory.Children.Count;
                                foreach (Item ndc in product.Children)
                                {
                                    //string strWholesalerName = "NA";
                                    string strWholesalerNumber = "NA";

                                    try
                                    {
                                        TextField tf = ndc.Fields[strWholeSalerSelectedValue];

                                        if ((tf != null) && (!String.IsNullOrWhiteSpace(tf.Value.ToString())))
                                        {
                                            if (!tf.Value.ToString().ToLower().Contains("select"))
                                                strWholesalerNumber = tf.Value.ToString();
                                            //strWholesalerName = strWholeSalerSelectedValue;
                                        }
                                    }
                                    catch (Exception ex)
                                    {
                                    }

                                    dr["WholeSalerName"] = strWholeSalerDisplayName;
                                    dr["WholeSaler"] = strWholesalerNumber;

                                    foreach (Field f in ndc.Fields)
                                    {
                                        try
                                        {
                                            switch (f.DisplayName)
                                            {
                                                case "NDC":
                                                    dr["NDC"] = f.Value.ToString();
                                                    break;
                                                case "Attribute - Warnings":
                                                    dr["AttrWarnings"] = createWarningImages(f.Value.ToString());
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
                                                    dr["AttrStrength"] = f.Value.ToString();
                                                    break;
                                                case "Attribute - Vial Size  ( For Injectables Only )":
                                                    dr["AttrVialSize"] = f.Value.ToString();
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
                                        catch (Exception ex)
                                        {
                                            Sitecore.Diagnostics.Log.Error("Nested Error: Failed at getProductsByCategories for Product : " + product.Paths.FullPath.ToString(), ex, ex.Source);
                                            Sitecore.Diagnostics.Log.Error("Nested Error: Field : " + f.Name.ToString(), ex, ex.Source);
                                        }
                                    }
                                }
                                dr["RowCount"] = i;
                                dt.Rows.Add(dr);
                            }
                        }
                        catch (Exception ex)
                        {
                            Sitecore.Diagnostics.Log.Error("Error: Failed at getProductsByCategories for Product : " + product.Paths.FullPath.ToString(), ex, ex.Source);
                        }
                    }
                }
            }

            DataTable dtNew = new DataTable();
            try
            {
                dtNew = ApplyAlphaFilter(dt, AlphaFilter);
            }
            catch
            {
                dtNew = dt;
            }

            DataView dv = new DataView(dtNew);
            dv.Sort = "ProductName, AttrStrength ASC";
            return dv.ToTable();
        }

        protected DataTable GetProductDetails(string Category, string ProductLine, string ProductName, string ProductID)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("NDC");
            dt.Columns.Add("ProductCategory");
            dt.Columns.Add("ProductLine");
            dt.Columns.Add("ProductName");
            dt.Columns.Add("ProductID");
            dt.Columns.Add("ProductDescription");
            dt.Columns.Add("AlternateTitle");
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
            dt.Columns.Add("InfoPrescribingInformationLink");
            dt.Columns.Add("RowCount");
            dt.Columns.Add("cbValue");
            dt.Columns.Add("NumericStrength"); //will be used to sort
            dt.Columns.Add("WholeSaler");
            dt.Columns.Add("WholeSalerName");

            dt.Columns["NumericStrength"].DataType = Type.GetType("System.Decimal");
            dt.Columns.Add("NumericFillVolume"); //will be used to sort
            dt.Columns["NumericFillVolume"].DataType = Type.GetType("System.Decimal");


            try
            {
                Item[] products = masterDB.SelectItems("fast://*[@@id='" + ProductID + "']");
                foreach (Item product in products)
                {
                    //dr["AlternateTitle"] = product.Fields["alternateNDCTitle"].Value;
                    foreach (Item ndc in product.Children)
                    {
                        //Response.Write(product.Fields["Product Group Name"].Value.ToString());
                        try
                        {
                            DataRow dr = dt.NewRow();
                            dr["AlternateTitle"] = product.Fields["alternateNDCTitle"].Value;
                            dr["ProductName"] = "prod_" + replaceSpecialChars(product.ID.ToString());

                            //string strWholesalerName = "NA";
                            string strWholesalerNumber = "NA";

                            try
                            {
                                TextField tf = ndc.Fields[strWholeSalerSelectedValue];

                                if ((tf != null) && (!String.IsNullOrWhiteSpace(tf.Value.ToString())))
                                {
                                    strWholesalerNumber = tf.Value.ToString();
                                    //strWholesalerName = strWholeSalerSelectedValue;
                                }
                            }
                            catch (Exception ex)
                            {
                            }


                            dr["WholeSalerName"] = strWholeSalerDisplayName;
                            dr["WholeSaler"] = strWholesalerNumber;

                            foreach (Field f in ndc.Fields)
                            {
                                switch (f.DisplayName)
                                {
                                    case "NDC":
                                        dr["NDC"] = f.Value.ToString();
                                        break;
                                    case "L3 - Product Name":
                                        //dr["ProductName"] = replaceSpecialChars(product.Fields["Product Group Name"].Value.ToString());
                                        //dr["ProductName"] = replaceSpecialChars(product.ID.ToString());
                                        //dr["cbValue"] = replaceSpecialChars(dr["ProductName"].ToString().ToLower());
                                        break;
                                    case "Product Description":
                                        dr["ProductDescription"] = replaceEmptyWithNA(f.Value.ToString());
                                        break;
                                    case "Attribute - Closure Size ( For Injectables Only)":
                                        dr["AttrClosureSize"] = replaceEmptyWithNA(f.Value.ToString());
                                        break;
                                    case "Attribute - Dose":
                                        dr["AttrDose"] = replaceEmptyWithNA(f.Value.ToString());
                                        break;
                                    case "Attribute - Fill Volume ( For Injectables Only )":
                                        dr["AttrFillVolume"] = replaceEmptyWithNA(f.Value.ToString());
                                        break;
                                    case "Attribute - Strength":
                                        dr["AttrStrength"] = replaceEmptyWithNA(f.Value.ToString().Trim());
                                        break;
                                    case "Attribute - Vial Size  ( For Injectables Only )":
                                        dr["AttrVialSize"] = replaceEmptyWithNA(f.Value.ToString().Trim());
                                        break;
                                    case "Packaging - Package":
                                        dr["PkgPackage"] = replaceEmptyWithNA(f.Value.ToString());
                                        break;
                                    case "Packaging - Package Details":
                                        dr["PkgPackageDetails"] = replaceEmptyWithNA(f.Value.ToString());
                                        break;
                                    case "Packaging - Pack Size":
                                        dr["PkgPackSize"] = replaceEmptyWithNA(f.Value.ToString());
                                        break;
                                    case "Packaging - Boxes Per Case":
                                        dr["PkgBoxesPerCase"] = replaceEmptyWithNA(f.Value.ToString());
                                        break;
                                    case "Packaging - Ordering Multiple":
                                        dr["PkgOrderingMultiple"] = replaceEmptyWithNA(f.Value.ToString());
                                        break;
                                    default:
                                        break;
                                }
                            }

                            try
                            {
                                dr["NumericStrength"] = GetNumericChars(dr["AttrStrength"].ToString());

                            }
                            catch (Exception ex)
                            {
                                Sitecore.Diagnostics.Log.Error("Failed while getting product details", ex, ex.Source);
                                //ignore.  by ignoring this error, at least, the product will be displayed.
                            }

                            try
                            {
                                dr["NumericFillVolume"] = GetNumericChars(dr["AttrFillVolume"].ToString());

                            }
                            catch (Exception ex)
                            {
                                Sitecore.Diagnostics.Log.Error("Failed while getting product details", ex, ex.Source);
                                //ignore.  by ignoring this error, at least, the product will be displayed.
                            }

                            dr["RowCount"] = product.Children.Count.ToString();
                            dt.Rows.Add(dr);
                        }
                        catch (Exception ex)
                        {
                            Sitecore.Diagnostics.Log.Error("Failed while getting product details", ex, ex.Source);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                Response.Write("Test: " + ex.ToString() + "<BR />");
                throw;
            }
            DataView dv = new DataView(dt);
            //dv.Sort = "AttrStrength ASC, NDC, ProductName, ProductDescription, AttrClosureSize, AttrDose, AttrFillVolume, AttrVialSize, PkgPackage, PkgPackageDetails, PkgPackSize, PkgBoxesPerCase, PkgOrderingMultiple ASC";
            dv.Sort = "NumericStrength ASC, NumericFillVolume, NDC, ProductName, ProductDescription, AttrClosureSize, AttrDose, AttrVialSize, PkgPackage, PkgPackageDetails, PkgPackSize, PkgBoxesPerCase, PkgOrderingMultiple ASC";
            return dv.ToTable();
        }

        #endregion

        #endregion

        #region Event Handlers for detail repeater controls

        #region Desktop

        protected void unitdosedrug_a2g_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_unitdosedrug_a2g_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_unitdosedrug_a2g_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_unitdosedrug_h2n_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_unitdosedrug_h2n_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_unitdosedrug_h2n_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "product_name_unitdosedrug_h2n_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_unitdosedrug_o2u_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_unitdosedrug_o2u_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_unitdosedrug_o2u_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_unitdosedrug_v2z_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_unitdosedrug_v2z_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_unitdosedrug_v2z_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_controladose_all_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_controladose_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_controladose_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_robotrxready_all_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_robotrxready_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_robotrxready_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_punchcard_all_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_punchcard_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_punchcard_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_emergiscript_all_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_emergiscript_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_emergiscript_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_Injectables_a2g_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_Injectables_h2n_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_Injectables_o2u_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_Injectables_v2z_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_BurnWoundCare_all_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_BurnWoundCare_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_BurnWoundCare_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_Veterinary_all_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_Veterinary_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_Veterinary_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Veterinary!", "Veterinary_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_Cryoserv_all_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_Cryoserv_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_Cryoserv_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Cryopreserve Agents!", "product_name_Cryoserv_all_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }

        #endregion

        #region Mobile

        protected void unitdosedrug_a2g_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_unitdosedrug_a2g_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_unitdosedrug_a2g_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;

                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_mobile_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_unitdosedrug_h2n_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_unitdosedrug_h2n_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_unitdosedrug_h2n_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "product_name_unitdosedrug_h2n_mobile_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_unitdosedrug_o2u_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_unitdosedrug_o2u_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_unitdosedrug_o2u_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_mobile_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_unitdosedrug_v2z_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_unitdosedrug_v2z_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_unitdosedrug_v2z_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_mobile_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_controladose_all_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_controladose_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_controladose_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_mobile_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_robotrxready_all_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_robotrxready_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_robotrxready_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_mobile_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_punchcard_all_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_punchcard_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_punchcard_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_mobile_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_emergiscript_all_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_emergiscript_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_emergiscript_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_mobile_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_Injectables_a2g_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_mobile_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_Injectables_h2n_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_mobile_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_Injectables_o2u_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_mobile_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_Injectables_v2z_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_Injectables_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_mobile_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_BurnWoundCare_all_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_BurnWoundCare_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_BurnWoundCare_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Unit Dose Drugs!", "unitdosedrug_a2g_mobile_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_Veterinary_all_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_Veterinary_all_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_Veterinary_all_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Veterinary!", "Veterinary_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }
        protected void product_name_Cryoserv_all_mobile_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            if ((rptItm.ItemType == ListItemType.Item) || (rptItm.ItemType == ListItemType.AlternatingItem))
            {
                String detailRepeaterName = String.Empty;
                if (rptItm.ItemType == ListItemType.Item)
                {
                    detailRepeaterName = "product_name_Cryoserv_all_mobile_inner_odd";
                }
                else if (rptItm.ItemType == ListItemType.AlternatingItem)
                {
                    detailRepeaterName = "product_name_Cryoserv_all_mobile_inner_even";
                }
                DataRowView dr = (DataRowView)rptItm.DataItem;
                if (dr != null)
                {
                    BindDetails(dr, detailRepeaterName, rptItm);
                }
                else
                {
                    Sitecore.Diagnostics.Log.Error("Details could not be found for Cryoserv!", "Cryoserv_ItemDataBound");
                }
            }
            //if (rptItm.ItemType == ListItemType.Header)
            SetWholeSalerTitle(sender, e);
        }


        #endregion

        protected void ddlWholesaler_SelectedIndexChanged(object sender, EventArgs e)
        {
            strWholeSalerSelectedValue = ddlWholesaler.SelectedValue.ToString();
            strWholeSalerDisplayName = ddlWholesaler.SelectedItem.Text.ToString();
            FillData();

            ScriptManager.RegisterClientScriptBlock(pnWholeSaler, pnWholeSaler.GetType(), "ToggleDisplay", "ToggleDisplay();", true);
        }

        #endregion

        protected void SetWholeSalerTitle(object sender, RepeaterItemEventArgs e)
        {
            RepeaterItem rptItm = e.Item;
            try
            {
                Label lblWSName = (Label)(rptItm.FindControl("lblWholesalerName"));
                if ((lblWSName != null) && (!String.IsNullOrWhiteSpace(strWholeSalerSelectedValue)))
                {
                    lblWSName.Text = strWholeSalerDisplayName.ToString();
                }
            }
            catch (Exception ex)
            {
            }
        }
    }
}
