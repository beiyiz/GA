using Sitecore;
using Sitecore.Data;
using Sitecore.Data.Items;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Text;

namespace MylanProducts.layouts.MylanInstitutionalProducts.sublayouts
{
    public partial class DailyUpdates : System.Web.UI.UserControl
    {
        Database webDB = Sitecore.Configuration.Factory.GetDatabase("web");
        DataTable dt = new DataTable();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                RefreshGrid();
            }
        }

        private void RefreshGrid()
        {
            string spName = "prcSelectDailyList";
            String ConnectionString = Sitecore.Configuration.Settings.GetConnectionString("custom");
            if (!String.IsNullOrWhiteSpace(ConnectionString))
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    using (SqlCommand command = new SqlCommand(spName, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add(new SqlParameter("@Date", System.DateTime.Today));
                        connection.Open();
                        SqlDataAdapter da = new SqlDataAdapter(command);

                        da.Fill(dt);

                        DataTable distinctTable = dt.DefaultView.ToTable(true, "ProductCategoryItemID");
                        rptCategories.DataSource = distinctTable;
                        rptCategories.DataBind();
                    }
                }
            }
        }

        private Item GetProductGroup(Item ndc)
        {
            if (ndc.TemplateID.ToString() == "{A47497B6-472C-4E19-ADC4-A93C3BC80860}")
            {
                return (ndc);
            }
            else
            {
                return GetProductGroup(ndc.Parent);
            }
        }

        private Item GetProductCategory(Item ndc)
        {
            if (ndc.TemplateID.ToString() == "{2066F399-EC60-4F97-8758-5F89D39381F1}")
            {
                return (ndc);
            }
            else
            {
                return GetProductCategory(ndc.Parent);
            }
        }

        protected void lbView_Click(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string spName = "dbo.updItemHistory";
            String ConnectionString = Sitecore.Configuration.Settings.GetConnectionString("custom");
            String ApprovedItems = hfItemIDs.Value.ToString().TrimEnd(',');

            if (!String.IsNullOrWhiteSpace(ApprovedItems))
            {
                if (!String.IsNullOrWhiteSpace(ConnectionString))
                {
                    using (SqlConnection connection = new SqlConnection(ConnectionString))
                    {
                        using (SqlCommand command = new SqlCommand(spName, connection))
                        {
                            command.CommandType = CommandType.StoredProcedure;
                            connection.Open();

                            foreach (String s in ApprovedItems.Split(','))
                            {
                                command.Parameters.Clear();
                                command.Parameters.Add(new SqlParameter("@ItemID", s.ToString()));
                                command.Parameters.Add(new SqlParameter("@Mode", "Daily"));

                                command.ExecuteNonQuery();
                            }
                        }
                    }
                }
            }

            RefreshGrid();
        }

        protected void rptGroups_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if ((e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.AlternatingItem))
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;
                Sitecore.Data.ID itmID = (Sitecore.Data.ID.Parse(dr["ProductGroupItemID"].ToString()));
                if (itmID != Sitecore.Data.ID.Null)
                {
                    Sitecore.Data.Items.Item itm = webDB.GetItem(itmID);
                    if (itm != null)
                    {
                        Label lblName = (Label)e.Item.FindControl("lblGroup");
                        if (lblName != null)
                        {
                            lblName.Text = itm.Fields["Product Group Name"].Value.ToString();
                        }
                    }
                }

                DataTable dtNew = new DataTable();
                dtNew.Columns.Add("ID");
                dtNew.Columns.Add("ItemID");
                dtNew.Columns.Add("NDC");
                dtNew.Columns.Add("ProductDescription");
                dtNew.Columns.Add("AttrStrength");
                dtNew.Columns.Add("PkgPackage");
                dtNew.Columns.Add("PkgPackageDetails");
                dtNew.Columns.Add("WholeSaler");

                if (itmID != Sitecore.Data.ID.Null)
                {

                    DataView dv = dt.DefaultView;
                    String[] ColumnsToFilter = { "ProductCategoryItemID", "ProductGroupItemID", "ItemID" };
                    DataTable distinctGroups = dv.ToTable(true, ColumnsToFilter);

                    foreach (DataRow dRow in distinctGroups.Rows)
                    {
                        if (dRow["ProductGroupItemID"].ToString() == itmID.ToString())
                        {
                            Sitecore.Data.ID ndcID = (Sitecore.Data.ID.Parse(dRow["ItemID"].ToString()));
                            DataRow detailRow = dtNew.NewRow();
                            Item ndc = webDB.GetItem(ndcID);
                            //detailRow["ID"] = dRow["ID"].ToString();
                            detailRow["ItemID"] = ndcID.ToString();
                            detailRow["NDC"] = ndc.Fields["_NDC"].Value.ToString();
                            detailRow["ProductDescription"] = ndc.Fields["_ProductDescription"].Value.ToString();
                            detailRow["AttrStrength"] = ndc.Fields["_xAttrStrength"].Value.ToString();
                            detailRow["PkgPackage"] = ndc.Fields["_xPkgPackage"].Value.ToString();
                            detailRow["PkgPackageDetails"] = ndc.Fields["_xPkgPackageDetails"].Value.ToString();
                            detailRow["WholeSaler"] = "";

                            dtNew.Rows.Add(detailRow);
                        }
                    }
                    Repeater rptDetails = (Repeater)e.Item.FindControl("rptDailyDetails");
                    if (rptDetails != null)
                    {
                        rptDetails.DataSource = dtNew;
                        rptDetails.DataBind();
                    }
                }
            }
        }

        protected void rptDailyDetails_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if ((e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.AlternatingItem))
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;
                Sitecore.Data.ID itmID = (Sitecore.Data.ID.Parse(dr[1].ToString()));
                if (itmID != Sitecore.Data.ID.Null)
                {
                    Sitecore.Data.Items.Item itm = webDB.GetItem(itmID);
                    if (itm != null)
                    {
                        Label lblName = (Label)e.Item.FindControl("lblProductName");
                        if (lblName != null)
                        {
                            Item product = GetProductGroup(itm);
                            if (product == null)
                            {
                                product = GetProductCategory(itm);
                            }
                            if (product != null)
                            {
                                lblName.Text = product.Fields["Product Group Name"].Value.ToString();
                            }
                        }

                        HtmlInputCheckBox cbItm = (HtmlInputCheckBox)e.Item.FindControl("cbItmID");
                        if (cbItm != null)
                        {
                            cbItm.Attributes.Add("onclick", String.Format("trackItemsToApprove('{0}', this);", itm.ID.ToString()));
                        }
                    }
                }
            }
        }

        protected void rptCategories_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if ((e.Item.ItemType == ListItemType.Item) || (e.Item.ItemType == ListItemType.AlternatingItem))
            {
                DataRowView dr = (DataRowView)e.Item.DataItem;
                Sitecore.Data.ID itmID = (Sitecore.Data.ID.Parse(dr["ProductCategoryItemID"].ToString()));
                if (itmID != Sitecore.Data.ID.Null)
                {
                    Sitecore.Data.Items.Item itm = webDB.GetItem(itmID);
                    if (itm != null)
                    {
                        Sitecore.Data.Fields.TextField catField = itm.Fields["Category"];
                        if ((catField != null) && (!String.IsNullOrWhiteSpace(catField.Value.ToString())))
                        {
                            String category = catField.Value.ToString();
                            HtmlGenericControl lblName = (HtmlGenericControl)e.Item.FindControl("lblCategory");
                            if (lblName != null)
                            {
                                lblName.InnerHtml = itm.Fields["Category"].Value.ToString();
                            }
                            HtmlAnchor anchr = (HtmlAnchor)e.Item.FindControl("CatAnch");
                            if (anchr != null)
                                anchr.Attributes.Add("href", String.Format("#{0}", category.ToLower().Replace(" ", "")));
                        }
                    }
                }
                DataView dv = dt.DefaultView;
                dv.RowFilter = String.Format("ProductCategoryItemID = '{0}'", itmID.ToString());

                String[] ColumnsToFilter = { "ProductCategoryItemID", "ProductGroupItemID", "ItemID" };
                DataTable distinctGroups = dv.ToTable(true, ColumnsToFilter);

                Repeater Groups = (Repeater)e.Item.FindControl("rptGroups");
                if (Groups != null)
                {
                    DataTable dtNew = distinctGroups;
                    distinctGroups.Columns.Add("AttrWarnings");
                    foreach (DataRow drNew in dtNew.Rows)
                    {
                        ID ndcItemID = Sitecore.Data.ID.Parse(drNew["ItemID"]);
                        if (ndcItemID != Sitecore.Data.ID.Null)
                        {
                            Item NDC = webDB.GetItem(ndcItemID);
                            if (NDC != null)
                            {
                                drNew["AttrWarnings"] += NDC.Fields["_xAttrWarnings"].Value.ToString();
                            }
                        }
                    }
                    Groups.DataSource = dtNew;
                    Groups.DataBind();
                }
            }
        }

    }
}