using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Data;
using System.Data.SqlClient;
using FuelSDK;


namespace MylanCustomizations.Tasks
{

    public class EmailJob
    {
        DataTable dtSubscribers = new DataTable();

        List<Subscriber> lstSubscribers = new List<Subscriber>();

        public void Run()
        {
        }

        public void ProcessDailyAdditions()
        {
            String strTimeToRun = Sitecore.Configuration.Settings.GetAppSetting("CronJob.TimeToRun");
            if (!String.IsNullOrWhiteSpace(strTimeToRun))
            {
                TimeSpan TimeToRun = DateTime.Parse(strTimeToRun).TimeOfDay;
                Boolean IsItTime = DateTime.Now.TimeOfDay.Subtract(TimeToRun).Ticks > 0;
                if (IsItTime)
                {

                }
            }
            string spName = "prcSelectDailyList";
            DataTable dt = GetApprovedItems(spName);

            foreach (DataRow dr in dt.Rows)
            {

                NameValueCollection parameters = new NameValueCollection();
                parameters.Add("clientId", "3uqagf2nrt2mm27q3rt45ett");
                parameters.Add("clientSecret", "D5wxtEx6UGNVxgkbyrruJhQV");

                ET_Client myclient = new ET_Client(parameters);

                ET_TriggeredSend triggeredsend = new ET_TriggeredSend();
                triggeredsend.AuthStub = myclient;
                triggeredsend.Name = "SDKTriggeredSend";
                triggeredsend.CustomerKey = "test_email_ram_mip";
                triggeredsend.Subscribers = new ET_Subscriber[1];
                triggeredsend.Subscribers[0] = new ET_Subscriber();
                triggeredsend.Subscribers[0].EmailAddress = "pendyalark@gmail.com";
                triggeredsend.Subscribers[0].SubscriberKey = "pendyalark@gmail.com";

                //triggeredsend.Email = new ET_Email() { ID = 1111111 };
                //triggeredsend.SendClassification = new ET_SendClassification() { CustomerKey = "2222" };
                //PostReturn prtriggeredsend = triggeredsend.Post();
                SendReturn srSend = triggeredsend.Send();

                //Sitecore.Diagnostics.Log.Info("Send Status: " + srSend.Status.ToString(), this);
                //Sitecore.Diagnostics.Log.Info("Message: " + srSend.Message.ToString(), this);
                //Sitecore.Diagnostics.Log.Info("Code: " + srSend.Code.ToString(), this);

//                ET_TriggeredSend triggeredsend = new ET_TriggeredSend();
//                triggeredsend.AuthStub = myclient;
//                triggeredsend.Name = "SDKTriggeredSend";
//                triggeredsend.CustomerKey = "test_email_ram_mip11";
//                triggeredsend.Email = new ET_Email() { ID = 1111111 };
                //triggeredsend.SendClassification = new ET_SendClassification() { CustomerKey = "test_email_ram_mip11" };
//                PostReturn prtriggeredsend = triggeredsend.Post();
//                Console.WriteLine("Post Status: " + prtriggeredsend.Status.ToString());

//                Sitecore.Diagnostics.Log.Info("Results Length: " + prtriggeredsend.Results.Length, this);


            }

        }

        public void ProcessMonthlyChanges()
        {
            String s = string.Empty;
        }

        private DataTable GetApprovedItems(String spName)
        {
            DataTable distinctTable = new DataTable();

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

                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        distinctTable = dt.DefaultView.ToTable(true);
                    }
                }
            }

            return distinctTable;
        }

        private void RetrieveSubscribers()
        {
            List<int> lstListIDs = new List<int>();
            lstListIDs.Add(17942355);
            lstListIDs.Add(17942350);
            lstListIDs.Add(17942353);
            lstListIDs.Add(17942356);
            lstListIDs.Add(17942359);
            lstListIDs.Add(17942361);

            dtSubscribers = new DataTable();
            dtSubscribers.Columns.Add("SubscriberID");
            dtSubscribers.Columns.Add("EmailAddress");
            dtSubscribers.Columns.Add("ListID");
            dtSubscribers.Columns.Add("DateAdded");
            dtSubscribers.Columns.Add("DateModified");

            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("clientId", "3uqagf2nrt2mm27q3rt45ett");
            parameters.Add("clientSecret", "D5wxtEx6UGNVxgkbyrruJhQV");

            ET_Client myclient = new ET_Client(parameters);
            ET_List postList = new ET_List();


            postList.AuthStub = myclient;
            PostReturn prList = postList.Post();
            if (prList.Status && prList.Results.Length > 0)
            {
                ET_List_Subscriber getListSub = new ET_List_Subscriber();
                getListSub.AuthStub = myclient;
                //getListSub.Props = new string[] { "ObjectID", "SubscriberKey", "CreatedDate", "Client.ID", "Client.PartnerClientKey", "ListID", "Status" };
                //getListSub.SearchFilter = new SimpleFilterPart() { Property = "ListID", SimpleOperator = SimpleOperators.equals, Value = new string[] { newListID.ToString() } };
                GetReturn getResponse = getListSub.Get();
                foreach (int newListID in lstListIDs)
                {
                    try
                    {
                        getListSub.SearchFilter = new SimpleFilterPart() { Property = "ListID", SimpleOperator = SimpleOperators.equals, Value = new string[] { newListID.ToString() } };
                        GetReturn response = getListSub.Get();
                        foreach (ET_List_Subscriber subscriber in response.Results)
                        {
                            try
                            {
                                DataRow dr = dtSubscribers.NewRow();
                                dr["SubscriberID"] = subscriber.ID.ToString();
                                dr["ListID"] = subscriber.ListID.ToString();
                                dr["EmailAddress"] = subscriber.SubscriberKey.ToString();
                                dr["DateAdded"] = subscriber.CreatedDate.ToString();
                                dr["DateModified"] = subscriber.ModifiedDate.ToString();
                                dtSubscribers.Rows.Add(dr);
                            }
                            catch (Exception)
                            {
                            }
                        }
                    }
                    catch (Exception)
                    {
                    }
                }
            }

            if (dtSubscribers.Rows.Count > 0)
            {
                //Save All Subscribers to the database
                foreach (DataRow scribe in dtSubscribers.Rows)
                {
                    try
                    {
                        string spName = "dbo.AddETSubscriber";
                        String ConnectionString = Sitecore.Configuration.Settings.GetConnectionString("custom");
                        if (!String.IsNullOrWhiteSpace(ConnectionString))
                        {
                            using (SqlConnection connection = new SqlConnection(ConnectionString))
                            {
                                using (SqlCommand command = new SqlCommand(spName, connection))
                                {
                                    command.CommandType = CommandType.StoredProcedure;
                                    connection.Open();

                                    command.Parameters.Add(new SqlParameter("@SubscriberID", scribe["SubscriberID"].ToString()));
                                    command.Parameters.Add(new SqlParameter("@ListID", scribe["ListID"].ToString()));
                                    command.Parameters.Add(new SqlParameter("@EmailAddress", scribe["EmailAddress"].ToString()));
                                    command.Parameters.Add(new SqlParameter("@DateSubscriptionAdded", scribe["DateAdded"].ToString()));
                                    command.Parameters.Add(new SqlParameter("@DateSubscriptionUpdated", scribe["DateModified"].ToString()));
                                    command.ExecuteNonQuery();
                                }
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                    }
                }
            }
        }

    }
}
