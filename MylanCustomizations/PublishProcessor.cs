using System;
using System.Data;
using System.Data.SqlClient;
using Sitecore.Data.Items;
using Sitecore.Events;
using Sitecore.Publishing.Pipelines.PublishItem;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Collections.Specialized;
using System.ServiceModel;
using MylanCustomizations.ExactTargetClient;

namespace MylanCustomizations
{
    public class PublishProcessor : PublishItemProcessor
    {
        protected void OnItemSaved(object sender, EventArgs args)
        {
            //var item = Event.ExtractParameter(args, 0) as Item;
            //string customerKey = item.Name.Replace(" ","");
            //string description =string.Format( "Sitecore Item {0} updated" , item.Name);
            //string html = ProductInfoHtml(item);

            //ETDataExtension etd = new ETDataExtension();

            //SendReturnStatus sendStatus = etd.CreateTriggeredSendEmail(customerKey, customerKey, description, description, html, Properties.Settings.Default.ApproverEmailAddress);

        }

        private string createWarningImages(string Warning)
        {           

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
        
        private string ProductInfoHtml(Item item)
        {
            Sitecore.Data.Database masterDB = Sitecore.Configuration.Factory.GetDatabase("master");

            string templatePath = "/sitecore/templates/User Defined/MylanInstitutionalProducts/Product/Data";
            Item templateItem = masterDB.GetItem(templatePath);

            Item product = item.Parent;

            string productName = product.Fields["Product Group Name"].Value.ToString();

            StringBuilder sb = new StringBuilder();

            sb.AppendLine("<html>");
            sb.AppendLine("<head>");
            sb.AppendLine("<link rel=\"stylesheet\" href='http://mylaninstitutional-usproducts.com/assets/MylanInstitutionalProducts/styles/normalize.css' />");
            sb.AppendLine("<link rel=\"stylesheet\" href='http://mylaninstitutional-usproducts.com/assets/MylanInstitutionalProducts/styles/main.css' />");
            sb.AppendLine("</head>");
            sb.AppendLine("<body>");
               
            sb.AppendLine("<div id=\"div_ProductDisplay\">");
            sb.AppendLine(  "<ul class=\"products\">");
            sb.AppendLine("     <li class=\"odd first\">");
            sb.AppendLine("         <div class=\"product-title\">");
            sb.AppendLine("             <div class=\"title\">");

            sb.AppendFormat("               <a href='#'>{0}</a>", productName);
            if (item.Fields["_xAttrWarnings"] != null)
            {
                sb.AppendFormat("               <div class=\"product-warnings\"  style=\"float:right\">{0}</div>", createWarningImages(item.Fields["_xAttrWarnings"].Value.ToString()));
            }
            
            sb.AppendLine("             </div>");
            sb.AppendLine("             <div class=\"product-info\">");
            if (item.Fields["_xInfoPrescribingInformationLink"] != null)
            {
                if (item.Fields["_xInfoPrescribingInformationLink"].Value.ToString().Length > 0)
                {
                    sb.AppendFormat("<div class='product-prescribing-info'><a href='{0}' target='_new'>Full Prescribing Information</a></div>", item.Fields["_xInfoPrescribingInformationLink"].Value.ToString());
                }
            }
            sb.AppendLine("<table class=\"product-info-table\" cellpadding=\"4\" cellspacing=\"2\">");
            sb.AppendLine("<thead>");
            sb.AppendLine("<tr>");

            foreach (Item child in templateItem.Children)
            {
                if (item.Fields[child.Name] != null)
                {
                    if (item.Fields[child.Name].Value != null && !string.IsNullOrEmpty(item.Fields[child.Name].Value.ToString()))
                    {
                        string displayName = item.Fields[child.Name].DisplayName.Replace("Attribute - ", "").Replace("Packaging - ", "").Replace("L1 - ", "").Replace("L2 - ", "");
                        sb.AppendFormat("<td class=\"product-desc-title\">{0}</td>", displayName);
                    }
                }
            }
            
            
            sb.AppendLine("</tr>");
            sb.AppendLine("</thead>");
            sb.AppendLine("<tbody>");
            sb.AppendLine("<tr class=\"grey-row\">");
            foreach (Item child in templateItem.Children)
            {
                if (item.Fields[child.Name] != null)
                {
                    if (item.Fields[child.Name].Value != null && !string.IsNullOrEmpty(item.Fields[child.Name].Value.ToString()))
                    {
                        sb.AppendFormat("<td>{0}</td>", item.Fields[child.Name].Value.ToString());
                    }
                }
            }
            sb.AppendLine("</tr>");
            sb.AppendLine("</tbody>");

            sb.AppendLine("</table>");

            sb.AppendLine("</div></div></li></ul></div>");

            sb.AppendLine("</body>");
            sb.AppendLine("</html>");

            return sb.ToString();
        }

        private int SaveItemChangeHistory(Item item, string changeType)
        {
            string html = string.Empty;
            string revision = string.Empty;
            string productName = string.Empty;
            string ConnectionString = Sitecore.Configuration.Settings.GetConnectionString("custom");
            string spName = string.Empty;
            int changeId = 0;

            Item product = item.Parent;

            if (product.Fields["Product Group Name"] == null) return changeId;

            productName = product.Fields["Product Group Name"].Value.ToString();
            string productCategory = "";
            if (product.Parent.Fields["Category"] != null)
            {
                productCategory = product.Parent.Fields["Category"].Value.ToString();
            }

            spName = "dbo.SaveItemHistory";

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                using (SqlCommand command = new SqlCommand(spName, connection))
                {
                    try
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        command.Parameters.Add(new SqlParameter("@ItemID", item.ID.ToString()));
                        command.Parameters.Add(new SqlParameter("@ItemName", item.Name.ToString()));
                        command.Parameters.Add(new SqlParameter("@ChangeType", changeType));

                        if (changeType != "Deleted")
                        {
                            html = ProductInfoHtml(item);
                            command.Parameters.Add(new SqlParameter("@ItemHtml", html));
                        }
                        if (!String.IsNullOrEmpty(item.Fields["__Revision"].Value.ToString()))
                        {
                            revision = item.Fields["__Revision"].Value.ToString();
                        }
                        else
                        {
                            revision = "";
                        }
                        command.Parameters.Add(new SqlParameter("@ProductName", productName));
                        command.Parameters.Add(new SqlParameter("@ProductCategory", productCategory));
                        command.Parameters.Add(new SqlParameter("@Revision", revision));

                        var returnParameter = command.Parameters.Add("@ReturnVal", SqlDbType.Int);
                        returnParameter.Direction = ParameterDirection.ReturnValue;

                        connection.Open();

                        command.ExecuteNonQuery();
                        var result = returnParameter.Value;

                        changeId = int.Parse(result.ToString());
                    }
                    catch (Exception ex)
                    {
                        throw;
                    }
                }
            }
            return changeId;
        }

        private void SaveItemHistoryDetails(int changeId, string fieldName, string oldValue, string newValue)
        {

            string ConnectionString = Sitecore.Configuration.Settings.GetConnectionString("custom");
            string spName = "dbo.SaveItemHistoryDetails";

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                using (SqlCommand command = new SqlCommand(spName, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add("@ItemChangeID", SqlDbType.Int).Value = changeId;
                    command.Parameters.Add(new SqlParameter("@FieldName", fieldName));
                    command.Parameters.Add(new SqlParameter("@OldValue", oldValue)); 
                    command.Parameters.Add(new SqlParameter("@NewValue", newValue));

                    connection.Open();

                    command.ExecuteNonQuery();
                }
            }
        }
        protected void OnItemSaving(object sender, EventArgs args)
        {
            if (args == null)
            {
                return;
            }

            Item newItem = Event.ExtractParameter(args, 0) as Item;
            if (newItem == null)
            {
                return;
            }

            Sitecore.Data.Database web = Sitecore.Configuration.Factory.GetDatabase("web");

            Item originalItem = web.Items.GetItem(newItem.ID);

            if (originalItem == null)
            {
                originalItem = newItem.Database.GetItem(newItem.ID, newItem.Language, newItem.Version);
            }

            var differences = FindDifferences(newItem, originalItem);


            if (differences.Count > 0){

                int changeId = SaveItemChangeHistory(newItem, "Update");
                if (changeId > 0)
                {
                    foreach (String fieldName in differences)
                    {
                        var fieldNameModified = fieldName.ToString().Replace("_x", "");
                        fieldNameModified = fieldName.ToString().Replace("_", "");

                        if (fieldNameModified.ToLower() != "updated" && fieldNameModified.ToLower() != "revision")
                        {
                            SaveItemHistoryDetails(changeId, fieldName, originalItem.Fields[fieldName].Value.ToString(), newItem.Fields[fieldName].Value.ToString());
                        }
                    }   
                }

                
            }

        }

        protected void OnItemDeleted(object sender, EventArgs args)
        {
            if (args == null)
            {
                return;
            }

            Item deletedItem = Event.ExtractParameter(args, 0) as Item;
            if (deletedItem == null)
            {
                return;
            }

            SaveItemChangeHistory(deletedItem, "Deleted");

        }

        protected void OnItemAdded(object sender, EventArgs args)
        {
            if (args == null)
            {
                return;
            }

            Item newItem = Event.ExtractParameter(args, 0) as Item;
            if ((newItem == null) || (newItem.TemplateID.ToString() != "{692169E2-B461-41B4-95F9-235D652319A8}"))
            {
                return;
            }

            SaveItemChangeHistory(newItem, "Add");
        }

        private Item GetProductGroup(Item ndc)
        {
            if (ndc != null)
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
            else
            {
                return null;
            }
        }

        private Item GetProductCategory(Item ndc)
        {
            if (ndc != null)
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
            else
            {
                return null;
            }
        }

        private  List<string> FindDifferences(Item newItem, Item originalItem)
        {
            newItem.Fields.ReadAll();

            IEnumerable<string> fieldNames = newItem.Fields.Select(f => f.Name);

            return fieldNames
                .Where(fieldName => newItem[fieldName] != originalItem[fieldName])
                .ToList();
        }

        public override void Process(PublishItemContext context)
        {
            Sitecore.Data.ID itmID = context.ItemId;

            Sitecore.Data.Database masterDB = Sitecore.Configuration.Factory.GetDatabase("master");

            Item item = masterDB.GetItem(itmID);
            if (item == null)
            {
                return;
            }

            

            //string spName = "dbo.AddToPublishLog";
            //String ConnectionString = Sitecore.Configuration.Settings.GetConnectionString("custom");
            //if (!String.IsNullOrWhiteSpace(ConnectionString))
            //{
            //    using (SqlConnection connection = new SqlConnection(ConnectionString))
            //    {
            //        using (SqlCommand command = new SqlCommand(spName, connection))
            //        {
            //            command.CommandType = CommandType.StoredProcedure;

            //            command.Parameters.Add(new SqlParameter("@Site", Sitecore.Context.Site.Name.ToString()));
            //            command.Parameters.Add(new SqlParameter("@ItemID", item.ID.ToString()));

            //            Item produdctGp = GetProductGroup(item);
            //            command.Parameters.Add(new SqlParameter("@ProductGroupItemID", produdctGp == null ? string.Empty : produdctGp.ID.ToString()));

            //            Item productCat = GetProductCategory(item);
            //            command.Parameters.Add(new SqlParameter("@ProductCategoryItemID", productCat == null ? string.Empty : productCat.ID.ToString()));
            //            command.Parameters.Add(new SqlParameter("@Language", String.Empty));
            //            command.Parameters.Add(new SqlParameter("@Mode", String.Empty));
            //            command.Parameters.Add(new SqlParameter("@RepublishAll", String.Empty));
            //            command.Parameters.Add(new SqlParameter("@SourceDatabase", String.Empty));
            //            command.Parameters.Add(new SqlParameter("@TargetDatabase", String.Empty));
            //            command.Parameters.Add(new SqlParameter("@RequestedBy", String.Empty));

            //            connection.Open();
            //            command.ExecuteNonQuery();
            //        }
            //    }
            //}
        }

        public void SaveJobInfo(object sender, EventArgs args)
        {
            if (args == null)
            {
                return;
            }
            Sitecore.Events.SitecoreEventArgs arguments = (Sitecore.Events.SitecoreEventArgs)(args);
            Sitecore.Publishing.PublishOptions options = ((Sitecore.Publishing.Publisher)((arguments).Parameters[0])).Options;
            Item item = options.RootItem;
            if (item == null)
            {
                return;
            }

            //string spName = "dbo.SaveLastPublishLog";
            //String ConnectionString = Sitecore.Configuration.Settings.GetConnectionString("custom");
            //if (!String.IsNullOrWhiteSpace(ConnectionString))
            //{
            //    using (SqlConnection connection = new SqlConnection(ConnectionString))
            //    {
            //        using (SqlCommand command = new SqlCommand(spName, connection))
            //        {
            //            command.CommandType = CommandType.StoredProcedure;

            //            connection.Open();
            //            command.ExecuteNonQuery();
            //        }
            //    }
            //}
        }
    }
}
