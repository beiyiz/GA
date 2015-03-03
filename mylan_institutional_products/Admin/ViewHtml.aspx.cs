
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
                foreach (var change in changeList)
                {
                    divHtml.InnerHtml += "<p/>" + change.ItemHtml;
                }
                hdnItemId.Value = DateTime.Now.ToShortDateString() + DateTime.Now.ToShortTimeString();
            
            
        }

       

        
    }
}