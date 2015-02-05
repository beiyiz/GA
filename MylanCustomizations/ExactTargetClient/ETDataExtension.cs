using FuelSDK;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Text;

namespace MylanCustomizations.ExactTargetClient
{
    public class ETDataExtension
    {

        readonly ET_Client _etClient;

        public ETDataExtension()
        {
            NameValueCollection parameters = new NameValueCollection();
            parameters.Add("clientId", Properties.Settings.Default.ETClientId);
            parameters.Add("clientSecret", Properties.Settings.Default.ETClientSecret);

            _etClient = new ET_Client(parameters);
        }

        public PostReturnStatus CreateEmailSendDefination(string name, string customerKey, string description, string subject, string htmlBody)
        {
            try
            {
                ET_EmailSendDefinition deleteEmailSendDef = new ET_EmailSendDefinition();
                deleteEmailSendDef.CustomerKey = customerKey;
                deleteEmailSendDef.AuthStub = _etClient;
                DeleteReturn deleteResponse = deleteEmailSendDef.Delete();

                //Create SendDefinition to DataExtension
                int EmailIDForSendDefinition = 3113962;
                string SendClassificationCustomerKey = "2239";
                string SendableDataExtensionCustomerKey = "F6F3871A-D124-499B-BBF5-3EFC0E827A51";

                ET_EmailSendDefinition postEmailSendDef = new ET_EmailSendDefinition();
                postEmailSendDef.AuthStub = _etClient;
                postEmailSendDef.Name = name;
                postEmailSendDef.CustomerKey = customerKey;
                postEmailSendDef.Description = description;

                ET_SendClassification sc = new ET_SendClassification();
                sc.AuthStub = _etClient;
                sc.Name = name;
                sc.Description = description;
                sc.CustomerKey = customerKey;
                sc.SenderProfile = new SenderProfile() { 
                    CustomerKey = customerKey, 
                    Name = customerKey, 
                    Description=description,
                    FromAddress="",
                    FromName = "",
                    
                };
                //"SenderProfile.CustomerKey",
                //"SenderProfile.FromName",
                //"SenderProfile.FromAddress",
                //"DeliveryProfile.CustomerKey",
                //"DeliveryProfile.SourceAddressType",
                //"DeliveryProfile.PrivateIP",
                //"DeliveryProfile.DomainType",
                //"DeliveryProfile.PrivateDomain",
                //"DeliveryProfile.HeaderSalutationSource",
                //"DeliveryProfile.FooterSalutationSource",
                //"SuppressTracking","IsSendLogging","Email.ID","BccEmail","AutoBccEmail","TestEmailAddr","EmailSubject","DynamicEmailSubject","IsMultipart","IsWrapped","SendLimit","SendWindowOpen","SendWindowClose","DeduplicateByEmail","ExclusionFilter","Additional"};


                sc.DeliveryProfile = new DeliveryProfile() { AuthStub = _etClient, CustomerKey = customerKey, Name=customerKey, Description=description };
                //set the classification type (default = Marketing/Commercial)
                //Marketing = Commercial
                //Operational = Transactional
                sc.SendClassificationType = SendClassificationTypeEnum.Marketing;
                sc.SendClassificationTypeSpecified = true;

                postEmailSendDef.SendClassification = sc;

                //postEmailSendDef.SendClassification = new ET_SendClassification() { CustomerKey = SendClassificationCustomerKey };
                //postEmailSendDef.SendDefinitionList = new ET_SendDefinitionList[] { new ET_SendDefinitionList() { CustomerKey = SendableDataExtensionCustomerKey, DataSourceTypeID = DataSourceTypeEnum.CustomObject } };
                    
                ET_Email email = new ET_Email();
                email.ID = EmailIDForSendDefinition;
                email.AuthStub = _etClient;
                email.Name = name;
                email.CustomerKey = customerKey;
                email.Subject = subject;
                email.HTMLBody = htmlBody;
                email.EmailType = "HTML";
                email.IsHTMLPaste = true;

                postEmailSendDef.Email = email;

                PostReturn postResponse = postEmailSendDef.Post();

                return
                    new PostReturnStatus()
                    {
                        Status = postResponse.Status.ToString(),
                        Message = postResponse.Message.ToString(),
                        Code = postResponse.Code.ToString(),
                        ResultsLength = postResponse.Results.Length
                    };
                
            }
            catch (Exception ex)
            {
                throw;
            }

        }
        
        public SendReturnStatus CreateTriggeredSendEmail(string name, string customerKey, string emailAddress)
        {

            try
            {
                //Send using new definition
                ET_TriggeredSend tsdSendNew = new ET_TriggeredSend();
                tsdSendNew.AuthStub = _etClient;
                tsdSendNew.Name = name;
                tsdSendNew.CustomerKey = customerKey;
                tsdSendNew.Subscribers = new ET_Subscriber[] { new ET_Subscriber() { EmailAddress = emailAddress, SubscriberKey = emailAddress } };
                SendReturn srSendnew = tsdSendNew.Send();

                SendReturnStatus status = new SendReturnStatus()
                {
                    Status = srSendnew.Status.ToString(),
                    Message = srSendnew.Message.ToString(),
                    Code = srSendnew.Code.ToString(),
                    ResultsLength = srSendnew.Results.Length
                };
                return status;
            }
            catch (Exception ex)
            {
                throw;
            }
        }
        public PostReturnStatus CreateDataExtension(string name, string customerKey, string primaryColumnName)
        {
            ET_DataExtension postDataExtension = new ET_DataExtension();
            postDataExtension.AuthStub = _etClient;
            postDataExtension.Name = name;
            postDataExtension.CustomerKey = customerKey;
            ET_DataExtensionColumn nameColumn = new ET_DataExtensionColumn() { Name = primaryColumnName, FieldType = DataExtensionFieldType.Text, IsPrimaryKey = true, MaxLength = 100, IsRequired = true };
            postDataExtension.Columns = new ET_DataExtensionColumn[] { nameColumn };
            PostReturn postResponse = postDataExtension.Post();

            PostReturnStatus status = new PostReturnStatus()
            {
                Status = postResponse.Status.ToString(),
                Message = postResponse.Message.ToString(),
                Code = postResponse.Code.ToString(),
                ResultsLength = postResponse.Results.Length
            };
            return status;
        }
        public PatchReturnStatus AddColumnToDataExtension(string customerKey, string addFieldName, DataExtensionFieldType fieldType)
        {
            ET_DataExtension patchDataExtension = new ET_DataExtension();
            patchDataExtension.AuthStub = _etClient;
            patchDataExtension.CustomerKey = customerKey;
            ET_DataExtensionColumn addedField = new ET_DataExtensionColumn() { Name = addFieldName, FieldType = fieldType };
            patchDataExtension.Columns = new ET_DataExtensionColumn[] { addedField };
            PatchReturn patchFR = patchDataExtension.Patch();
            PatchReturnStatus status = new PatchReturnStatus()
            {
                Status = patchFR.Status.ToString(),
                Message = patchFR.Message.ToString(),
                Code = patchFR.Code.ToString(),
                ResultsLength = patchFR.Results.Length
            };
            return status;
        }
        public List<ET_DataExtensionColumn> RetrieveAllColumnsOfDataExtension(string customerKey)
        {
            List<ET_DataExtensionColumn> columnList = new List<ET_DataExtensionColumn>();

            ET_DataExtensionColumn getColumn = new ET_DataExtensionColumn();
            getColumn.AuthStub = _etClient;
            getColumn.Props = new string[] { "Name", "FieldType" };
            getColumn.SearchFilter = new SimpleFilterPart() { Property = "DataExtension.CustomerKey", SimpleOperator = SimpleOperators.equals, Value = new string[] { customerKey } };
            GetReturn getColumnResponse = getColumn.Get();            

            if (getColumnResponse.Status)
            {
                foreach (ET_DataExtensionColumn column in getColumnResponse.Results)
                {
                    columnList.Add(column);
                }
            }
            return columnList;
        }
        public PostReturnStatus AddDataRowToDataExtension(string customerKey, List<KeyValuePair<string, string>> columnValues)
        {
            ET_DataExtensionRow deRowPost = new ET_DataExtensionRow();
            deRowPost.AuthStub = _etClient;
            deRowPost.DataExtensionCustomerKey = customerKey;

            foreach (KeyValuePair<string, string> kv in columnValues)
            {
                deRowPost.ColumnValues.Add(kv.Key, kv.Value);
            }
            
            PostReturn prRowResponse = deRowPost.Post();
            return 
                new PostReturnStatus()
                {
                    Status = prRowResponse.Status.ToString(),
                    Message = prRowResponse.Message.ToString(),
                    Code = prRowResponse.Code.ToString(),
                    ResultsLength = prRowResponse.Results.Length
                };
        }
        public List<GetReturnStatus> RetrieveAllDataExtensions()
        {
            List<GetReturnStatus> statusList = new List<GetReturnStatus>();

            //Get all of the DataExtensions in an Account
            ET_DataExtension getAllDataExtension = new ET_DataExtension();
            getAllDataExtension.AuthStub = _etClient;
            getAllDataExtension.Props = new string[] { "CustomerKey", "Name" };
            GetReturn grAllDataExtension = getAllDataExtension.Get();

            statusList.Add(new GetReturnStatus() {
                Status = grAllDataExtension.Status.ToString(),
                Message = grAllDataExtension.Message.ToString(),
                Code = grAllDataExtension.Code.ToString(),
                ResultsLength = grAllDataExtension.Results.Length
            });
           
            //Continue Retrieve All DataExtension with GetMoreResults
            while (grAllDataExtension.MoreResults)
            {                
                grAllDataExtension = getAllDataExtension.GetMoreResults();
                statusList.Add(new GetReturnStatus()
                {
                    Status = grAllDataExtension.Status.ToString(),
                    Message = grAllDataExtension.Message.ToString(),
                    Code = grAllDataExtension.Code.ToString(),
                    ResultsLength = grAllDataExtension.Results.Length
                });
           
            }

            return statusList;
        }
    }
}
