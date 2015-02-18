using MylanCustomizations.ExactTargetClient;
using Sitecore.Data.Fields;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace mylan_institutional_products.Admin
{
    public class ItemChangeHistoryData
    {
        readonly string _connString = string.Empty;

        public ItemChangeHistoryData()
        {
            _connString = Sitecore.Configuration.Settings.GetConnectionString("custom");
        }

        public void UpdateItemApprovalStatus(int changeId, string approvalStatus)
        {
            string spName = "dbo.UpdateItemHistoryApprovalStatus";

            if (!String.IsNullOrWhiteSpace(_connString))
            {
                using (SqlConnection connection = new SqlConnection(_connString))
                {
                    using (SqlCommand command = new SqlCommand(spName, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        command.Parameters.Add("@ChangeId", SqlDbType.Int).Value = changeId;
                        command.Parameters.Add("@ApprovalStatus", SqlDbType.VarChar, 10).Value = approvalStatus;                        
                       
                        connection.Open();
                        command.ExecuteNonQuery();
                    }
                }
            }

        }
        public void PublishItem(int changeId, string approvalStatus)
        {
            List<ItemChangeHistory> changeList = GetItemChangeHistory(changeId, approvalStatus);

            if (changeList.Count > 0)
            {

                ItemChangeHistory change = GetItemChangeHistory(changeId, approvalStatus)[0];

                string itemId = change.ItemId;
                string changeType = change.ChangeType;


                ETDataExtension etd = new ETDataExtension();

                etd.InsertIntoDataExtension(change.ItemHtml, change.ChangeType, change.ProductCategory);

                Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");
                Sitecore.Data.Database web = Sitecore.Configuration.Factory.GetDatabase("web");

                Sitecore.Data.Items.Item item = master.Items.GetItem(itemId);
                Sitecore.Publishing.PublishOptions publishOptions =
                  new Sitecore.Publishing.PublishOptions(item.Database,
                                                         web,
                                                         Sitecore.Publishing.PublishMode.SingleItem,
                                                         item.Language,
                                                         System.DateTime.Now);
                Sitecore.Publishing.Publisher publisher = new Sitecore.Publishing.Publisher(publishOptions);

                publisher.Options.RootItem = item;
                publisher.Options.Deep = true;

                publisher.Publish();
            }
        }

        public void ResetItem(int changeId, string approvalStatus)
        {
            //Use a security disabler to allow changes
            using (new Sitecore.SecurityModel.SecurityDisabler())
            {
                List<ItemChangeHistory> changeList = GetItemChangeHistory(changeId, approvalStatus);

                if (changeList.Count > 0)
                {
                    string itemId = changeList[0].ItemId;

                    Sitecore.Data.Database master = Sitecore.Configuration.Factory.GetDatabase("master");
                    Sitecore.Data.Database web = Sitecore.Configuration.Factory.GetDatabase("web");

                    Sitecore.Data.Items.Item item = master.Items.GetItem(itemId);
                    Sitecore.Data.Items.Item originalItem = web.Items.GetItem(itemId);


                    //Begin editing
                    item.Editing.BeginEdit();
                    try
                    {
                        foreach (ItemChangeHistory change in changeList)
                        {
                            string fieldName = change.FieldName;
                            item.Fields[fieldName].Value = originalItem.Fields[fieldName].Value;
                        }
                    }
                    finally
                    {
                        //Close the editing state
                        item.Editing.EndEdit();
                    }
                }

                
            }
        }
        public List<ItemChangeHistory> GetItemChangeHistory(int? itemChangeId = null, string approvalStatus = null)
        {
            List<ItemChangeHistory> changeList = new List<ItemChangeHistory>();

            string spName = "dbo.GetItemChangeHistory";

            if (!String.IsNullOrWhiteSpace(_connString))
            {
                using (SqlConnection connection = new SqlConnection(_connString))
                {
                    using (SqlCommand command = new SqlCommand(spName, connection))
                    {
                        command.CommandType = CommandType.StoredProcedure;
                        if (itemChangeId.HasValue)
                        {
                            command.Parameters.Add("@ChangeId", SqlDbType.Int).Value = itemChangeId.Value;
                        }
                        if (!string.IsNullOrEmpty(approvalStatus))
                        {
                            command.Parameters.Add("@ApprovalStatus", SqlDbType.VarChar,10).Value = approvalStatus;
                        }
                        connection.Open();
                        SqlDataReader rdr = command.ExecuteReader();

                       
                        while (rdr.Read())
                        {
                            var change = new ItemChangeHistory()
                            {
                                ItemId = rdr["ItemId"].ToString(),
                                ItemChangeId = int.Parse(rdr["ItemChangeId"].ToString()),
                                ItemHtml = rdr["ItemHtml"].ToString(),
                                Revision = rdr["Revision"].ToString(),
                                ChangeType = rdr["ChangeType"].ToString(),
                                ChangeDate = DateTime.Parse(rdr["ChangeDate"].ToString()),
                                OldValue = rdr["OldValue"].ToString(),
                                NewValue = rdr["NewValue"].ToString(),
                                FieldName = rdr["FieldName"].ToString(),
                                ProductName = rdr["ProductName"].ToString(),
                                ItemName = rdr["ItemName"].ToString(),
                                ProductCategory = rdr["ProductCategory"].ToString(),
                                DisplayFieldName = rdr["DisplayFieldName"].ToString(),
                            };
                            changeList.Add(change);
                        }
                        return changeList;
                    }
                }
            }
            return changeList;

        }
    }
}