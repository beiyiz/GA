using Sitecore.Data;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace mylan_institutional_products.Admin
{
    public partial class Admin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["ValidLogin"] == null)
                {
                    Response.Redirect("login.aspx");
                }
            }
            if (IsPostBack)
            {
                var approvedIds = hdnApprovedIds.Value.Split(';');
                var deletedIds = hdnDeletedIds.Value.Split(';');

                ItemChangeHistoryData data = new ItemChangeHistoryData();

                foreach (var changeId in approvedIds)
                {
                    if (!string.IsNullOrEmpty(changeId))
                    {
                        data.UpdateItemApprovalStatus(int.Parse(changeId), "Approved");

                        data.PublishItem(int.Parse(changeId), "Approved");
                    }
                }

                foreach (var changeId in deletedIds)
                {
                    if (!string.IsNullOrEmpty(changeId))
                    {
                        data.UpdateItemApprovalStatus(int.Parse(changeId), "Deleted");

                        data.ResetItem(int.Parse(changeId), "Deleted");
                    }                    
                }
            }
            PopulateItemChangeList();
        }

        private void PopulateItemChangeList()
        {
            ItemChangeHistoryData data = new ItemChangeHistoryData();

            var changeList = data.GetItemChangeHistory();

            StringBuilder sb = new StringBuilder();
            StringBuilder sbDetails = new StringBuilder();
            StringBuilder sbDetailTable = new StringBuilder();

            string itemId = string.Empty;
            string revision = string.Empty;
            string productName = string.Empty;
            int changeId = 0;
            foreach (var change in changeList)
            {
                if (change.ItemId != itemId && revision != change.Revision)
                {
                    if (changeId > 0)
                    {
                        sbDetailTable = new StringBuilder();
                        sbDetailTable.AppendFormat("<table class='table'><thead><tr><th>Field Name</th><th>Old Value</th><th>New Value</th></tr></thead><tbody>{0}</tbody></table>", sbDetails.ToString());
                        sb.AppendFormat("<tr id='tblDetails{0}' class='changeDetails'><td colspan='8'><div class='row well'>{1}</div></td></tr>", changeId, sbDetailTable.ToString());

                       
                   }
                    itemId = change.ItemId;
                    revision = change.Revision;
                    changeId = change.ItemChangeId;

                    //divHtml.InnerHtml += "<p />" + change.ItemHtml;

                    //string viewHtml = string.Format("<input type='button' value=' View Html ' onclick='displayHtml({0})' />", change.ItemChangeId);
                    //string viewPDF = string.Format("<input type='button' value=' Download PDF ' onclick='viewPdf({0})' />", change.ItemChangeId);
                    string viewDetails = string.Format("<input type='button' value=' Change Details ' onclick='viewDetails({0})' />", change.ItemChangeId);

                    string actionApprove = string.Format("<input type=\"radio\" class=\"actionApprove\" name=\"action{0}\" value=\"{0}\" /> Approve", changeId);
                    string actionDelete = string.Format("<input type=\"radio\" class=\"actionDelete\" name=\"action{0}\" value=\"{0}\" /> Delete", changeId);

                    sb.AppendFormat("<tr><td>{7}</td><td>{1}</td><td>{0}</td><td>{2}</td><td>{3}</td><td>{4}</td><td>{5}</td><td>{6}</td></tr>", change.ItemName, change.ProductName, change.ChangeType, change.ChangeDate, viewDetails, actionApprove, actionDelete, change.ProductCategory);
                    sbDetails = new StringBuilder();
                }

                sbDetails.AppendFormat("<tr><td>{0}</td><td>{1}</td><td>{2}</td></tr>", change.DisplayFieldName, change.OldValue, change.NewValue);

            }
            if (changeId > 0)
            {
                sbDetailTable = new StringBuilder();
                sbDetailTable.AppendFormat("<table class='table'><thead><tr><th>Field Name</th><th>Old Value</th><th>New Value</th></tr></thead><tbody>{0}</tbody></table>", sbDetails.ToString());
                sb.AppendFormat("<tr id='tblDetails{0}' class='changeDetails'><td colspan='8'><div class='row well'>{1}</div></td></tr>", changeId, sbDetailTable.ToString());

                
            }
            tbChangeList.InnerHtml = sb.ToString();

        }

        public object Clone(object target, object source)
        {
            if (source == null)
                throw new ArgumentNullException("Source");
            if (source.GetType() != target.GetType())
                throw new ArgumentException("Type Mismatch");
            foreach (PropertyInfo p in source.GetType().GetProperties())
            {
                if (p.CanRead && p.CanWrite)
                    p.SetValue(target, p.GetValue(source, p.GetIndexParameters()), p.GetIndexParameters());
            }
            return target;
        }
    }
}