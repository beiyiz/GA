
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
            
            ItemChangeHistoryData data = new ItemChangeHistoryData();

            var changeList = data.GetItemChangeHistory();

            int changeId = 0;
            foreach (var change in changeList)
            {
                if (changeId != change.ItemChangeId)
                {
                    divHtml.InnerHtml += "<p/>" + change.ItemHtml;
                    changeId = change.ItemChangeId;
                }
            }
            hdnItemId.Value = DateTime.Now.ToShortDateString() + DateTime.Now.ToShortTimeString();
            
            
        }

       

        
    }
}