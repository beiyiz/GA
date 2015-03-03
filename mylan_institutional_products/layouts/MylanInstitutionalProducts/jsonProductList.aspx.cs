using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Sitecore;
using Sitecore.Data;
using Sitecore.Data.Items;
using Sitecore.Data.Fields;
using Sitecore.Data.Query;

public partial class jsonProductList : System.Web.UI.Page
{

    #region Configs & Reuse Objects
    private DataTable dt_SearchResults = new DataTable();
    #endregion

    protected void Page_Load(object sender, EventArgs e)
    {
        this.rpt_DistinctProductNames.DataSource = getProductData();
        this.rpt_DistinctProductNames.DataBind();
    }

    #region DataCalls

    private void BindAllData() { }

    #region Database Calls

    private DataTable getProductDataOld()
    {
        Sitecore.Data.Database masterDB = Sitecore.Configuration.Factory.GetDatabase("web");
        DataTable dt = new DataTable();
        dt.Columns.Add("ProductName");
        Item[] productGroup = masterDB.SelectItems("fast://*[@@templatekey='ProductGroup']");
        foreach (Item product in productGroup)
        {
            DataRow dr = dt.NewRow();
            string value = product.Fields["Product Group Name"].Value.ToString().Trim().Replace("<sup>", "").Replace("</sup>", "");
            dr["ProductName"] = value;
            dt.Rows.Add(dr);
        }
        DataView dv = new DataView(dt);
        return dv.ToTable(true, "ProductName");
    }


    private DataTable getProductData()
    {
        String ProductName = Request.QueryString["q"];
        Sitecore.Data.Database masterDB = Sitecore.Configuration.Factory.GetDatabase("web");
        DataTable dt = new DataTable();
        dt.Columns.Add("ProductName");

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
                if (product.Fields["Product Group Name"].Value.ToLower().StartsWith(ProductName.ToLower()))
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
                DataRow dr = dt.NewRow();
                dr["ProductName"] = value;
                dt.Rows.Add(dr);
            }
        }
        DataView dv = new DataView(dt);
        dv.Sort = "ProductName ASC";
        return dv.ToTable(true);
    }

    #endregion

    #endregion
}