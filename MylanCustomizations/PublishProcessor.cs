﻿using System;
using System.Data;
using System.Data.SqlClient;
using Sitecore.Data.Items;
using Sitecore.Events;
using Sitecore.Publishing.Pipelines.PublishItem;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using FuelSDK;
using System.Collections.Specialized;
using System.ServiceModel;

namespace MylanCustomizations
{
    public class PublishProcessor : PublishItemProcessor
    {
        private void CreateEmailSendDefination(Item item){
            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("clientId", Properties.Settings.Default.ETClientId);
            parameters.Add("clientSecret", Properties.Settings.Default.ETClientSecret);

            try
            {
                ET_Client etClient = new ET_Client(parameters);
                string newSendDefinitionName = "SitecoreItemUpdates" + item.ID.ToString();
                string sendableDataExtensionCustomerKey = item.ID.ToString();
                int emailIDForSendDefinition = 3113962;
                int listIDForSendDefinition = 1729515;
                string sendClassificationCustomerKey = "2239";
                string tsNameForCreateThenDelete = Guid.NewGuid().ToString();

                //Retrieve All TriggeredSend Definitions
                ET_TriggeredSend tsdGetAll = new ET_TriggeredSend();
                tsdGetAll.AuthStub = etClient;
                tsdGetAll.Props = new string[] { "CustomerKey", "Name", "TriggeredSendStatus" };
                tsdGetAll.SearchFilter = new SimpleFilterPart() { Property = "CustomerKey", SimpleOperator = SimpleOperators.equals, Value = new string[] { tsNameForCreateThenDelete } };
                GetReturn grAllTSD = tsdGetAll.Get();

                bool customKeyExists = false;
                foreach (ET_TriggeredSend result in grAllTSD.Results)
                {
                    if (result.CustomerKey == sendableDataExtensionCustomerKey)
                    {
                        customKeyExists = true;
                        break;
                    }
                }
                if (!customKeyExists)
                {
                    //Create SendDefinition to DataExtension
                    ET_EmailSendDefinition postESDDE = new ET_EmailSendDefinition();
                    postESDDE.AuthStub = etClient;
                    postESDDE.Name = newSendDefinitionName;
                    postESDDE.CustomerKey = newSendDefinitionName;
                    postESDDE.Description = "Sitecore Item updated or added";
                    postESDDE.SendClassification = new ET_SendClassification() { CustomerKey = sendClassificationCustomerKey };
                    postESDDE.SendDefinitionList = new ET_SendDefinitionList[] { new ET_SendDefinitionList() { CustomerKey = sendableDataExtensionCustomerKey, DataSourceTypeID = DataSourceTypeEnum.CustomObject } };
                    postESDDE.Email = new ET_Email() { ID = emailIDForSendDefinition };
                    PostReturn postResponse = postESDDE.Post();
                }


            }
            catch (Exception ex)
            {
                string msg = ex.Message + ex.Source + ex.StackTrace.ToString();
            }   
            
        }
        private void CreateTriggeredSendEmail(Item item)
        {
            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("clientId", Properties.Settings.Default.ETClientId);
            parameters.Add("clientSecret", Properties.Settings.Default.ETClientSecret);

            try
            {
                ET_Client etclient = new ET_Client(parameters);

                ET_TriggeredSend tsdSend = new ET_TriggeredSend();
                tsdSend.AuthStub = etclient;
                tsdSend.CustomerKey = item.ID.ToString();
                tsdSend.Subscribers = new ET_Subscriber[] { new ET_Subscriber() { EmailAddress = "beiyi.zheng@gmail.com", SubscriberKey = "beiyi.zheng@gmail.com" } };
                SendReturn srSend = tsdSend.Send();
            }
            catch (Exception ex)
            {
                string msg = ex.Message + ex.Source + ex.StackTrace.ToString();
            }            
        }
        protected void OnItemSaved(object sender, EventArgs args)
        {
            var item = Event.ExtractParameter(args, 0) as Item;

            CreateEmailSendDefination(item);
            CreateTriggeredSendEmail(item);

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
            sb.AppendFormat("               <div class=\"product-warnings\"  style=\"float:right\">{0}</div>",createWarningImages(item.Fields["_xAttrWarnings"].Value.ToString()));
            sb.AppendLine("             </div>");
            sb.AppendLine("             <div class=\"product-info\">");
            if (item.Fields["_xInfoPrescribingInformationLink"].Value.ToString().Length > 0)
            {
                sb.AppendFormat("<div class='product-prescribing-info'><a href='{0}' target='_new'>Full Prescribing Information</a></div>", item.Fields["_xInfoPrescribingInformationLink"].Value.ToString());
            }
            sb.AppendLine("<table class=\"product-info-table\" cellpadding=\"4\" cellspacing=\"2\">");
            sb.AppendLine("<thead>");
            sb.AppendLine("<tr>");
            sb.AppendLine("<td class=\"product-desc-title\">NDC</td>");
            sb.AppendLine("<td class=\"product-desc-title\">Form</td>");
            sb.AppendLine("<td class=\"product-desc-title\">Strength</td>");
            switch (item.Fields["_ProductCategory"].Value.ToString())
            {
                case "BurnAndWoundCare":
                    sb.AppendLine("<td class=\"product-desc-title\">Package</td>");
                    sb.AppendLine("<td class=\"product-desc-title\">Boxes Per Case</td>");
                    sb.AppendLine("<td class=\"product-desc-title\">Ordering Multiple</td>");
                    break;
                case "Cryopreserve Agent":
                    sb.AppendLine("<td class=\"product-desc-title\">Fill Volume</td>");
                    sb.AppendLine("<td class=\"product-desc-title\">Vial Size</td>");
                    sb.AppendLine("<td class=\"product-desc-title\">Closure Size</td>");                   
                    sb.AppendLine("<td class=\"product-desc-title\">Pack Size</td>"); 
                    break;
                case "Injectables":
                    sb.AppendLine("<td class=\"product-desc-title\">Fill Volume</td>");
                    sb.AppendLine("<td class=\"product-desc-title\">Vial Size</td>");
                    sb.AppendLine("<td class=\"product-desc-title\">Closure Size</td>");
                    sb.AppendLine("<td class=\"product-desc-title\">Pack Size</td>");
                    break;
                default:
                    sb.AppendLine("<td class=\"product-desc-title\">Package</td>");
                    break;
               
            }
            sb.AppendLine("</tr>");
            sb.AppendLine("</thead>");
            sb.AppendLine("<tbody>");
            sb.AppendLine("<tr class=\"grey-row\">");
            sb.AppendFormat("<td nowrap>{0}</td>", item.Fields["_NDC"].Value.ToString());
            sb.AppendFormat("<td>{0}</td>", item.Fields["_ProductDescription"].Value.ToString());
            sb.AppendFormat("<td>{0}</td>", item.Fields["_xAttrStrength"].Value.ToString());
            
            switch (item.Fields["_ProductCategory"].Value.ToString())
            {
                case "BurnAndWoundCare":
                    sb.AppendFormat("<td>{0}</td>", item.Fields["_xPkgPackage"].Value.ToString());
                    sb.AppendFormat("<td>{0}</td>", item.Fields["_xPkgBoxesPerCase"].Value.ToString());
                    sb.AppendFormat("<td>{0}</td>", item.Fields["_xPkgOrderingMultiple"].Value.ToString());
                    break;
                case "Cryopreserve Agent":
                    sb.AppendFormat("<td>{0}</td>", item.Fields["_xAttrFillVolume"].Value.ToString());
                    sb.AppendFormat("<td>{0}</td>", item.Fields["_xAttrVialSize"].Value.ToString());
                    sb.AppendFormat("<td>{0}</td>", item.Fields["_xAttrClosureSize"].Value.ToString());
                    sb.AppendFormat("<td>{0}</td>", item.Fields["_xPkgPackSize"].Value.ToString());
                    break;
                case "Injectables":
                    sb.AppendFormat("<td>{0}</td>", item.Fields["_xAttrFillVolume"].Value.ToString());
                    sb.AppendFormat("<td>{0}</td>", item.Fields["_xAttrVialSize"].Value.ToString());
                    sb.AppendFormat("<td>{0}</td>", item.Fields["_xAttrClosureSize"].Value.ToString());
                    sb.AppendFormat("<td>{0}</td>", item.Fields["_xPkgPackSize"].Value.ToString());
                    break;
                default:
                    sb.AppendFormat("<td>{0}</td>", item.Fields["_xPkgPackage"].Value.ToString());
                    break;

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
            productName = product.Fields["Product Group Name"].Value.ToString();

            spName = "dbo.SaveItemHistory";

            using (SqlConnection connection = new SqlConnection(ConnectionString))
            {
                using (SqlCommand command = new SqlCommand(spName, connection))
                {
                    command.CommandType = CommandType.StoredProcedure;

                    command.Parameters.Add(new SqlParameter("@ItemID", item.ID.ToString()));
                    command.Parameters.Add(new SqlParameter("@ItemName", item.Name.ToString()));
                    command.Parameters.Add(new SqlParameter("@ChangeType", changeType));

                    if (changeType != "Deleted")
                    {
                        html = ProductInfoHtml(item);
                        revision = item.Fields["__Revision"].Value.ToString();
                        command.Parameters.Add(new SqlParameter("@ItemHtml", html));
                        command.Parameters.Add(new SqlParameter("@Revision", revision));
                    }
                    command.Parameters.Add(new SqlParameter("@ProductName", productName));
                    var returnParameter = command.Parameters.Add("@ReturnVal", SqlDbType.Int);
                    returnParameter.Direction = ParameterDirection.ReturnValue;

                    connection.Open();

                    command.ExecuteNonQuery();
                    var result = returnParameter.Value;

                    changeId = int.Parse(result.ToString());

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
                string ConnectionString = Sitecore.Configuration.Settings.GetConnectionString("custom");

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

            string spName = "dbo.SaveLastPublishLog";
            String ConnectionString = Sitecore.Configuration.Settings.GetConnectionString("custom");
            if (!String.IsNullOrWhiteSpace(ConnectionString))
            {
                using (SqlConnection connection = new SqlConnection(ConnectionString))
                {
                    using (SqlCommand command = new SqlCommand(spName, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;

                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }
        }
    }
}