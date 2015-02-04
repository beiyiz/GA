
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace mylan_institutional_products.Admin
{
    public partial class ViewHtml : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["changeId"] != null)
            {
                int changeId = int.Parse(Request.QueryString["changeId"].ToString());

                ItemChangeHistoryData data = new ItemChangeHistoryData();

                var changeList = data.GetItemChangeHistory(changeId);

                string html = changeList[0].ItemHtml;

                divHtml.InnerHtml = html;

                hdnItemId.Value = changeList[0].ItemId.Replace("{", "").Replace("}", "");
            }
            
        }

       

        
    }
}