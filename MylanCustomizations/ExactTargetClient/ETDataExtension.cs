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
        private ET_EmailSendDefinition RetrieveEmailSendDefinition()
        {
            ET_EmailSendDefinition getAllESD = new ET_EmailSendDefinition();
            getAllESD.AuthStub = _etClient;
            getAllESD.Props = new string[] { "Client.ID", "CreatedDate", "ModifiedDate", "ObjectID", "CustomerKey", "Name", "CategoryID", "Description", "SendClassification.CustomerKey", "SenderProfile.CustomerKey", "SenderProfile.FromName", "SenderProfile.FromAddress", "DeliveryProfile.CustomerKey", "DeliveryProfile.SourceAddressType", "DeliveryProfile.PrivateIP", "DeliveryProfile.DomainType", "DeliveryProfile.PrivateDomain", "DeliveryProfile.HeaderSalutationSource", "DeliveryProfile.FooterSalutationSource", "SuppressTracking", "IsSendLogging", "Email.ID", "BccEmail", "AutoBccEmail", "TestEmailAddr", "EmailSubject", "DynamicEmailSubject", "IsMultipart", "IsWrapped", "SendLimit", "SendWindowOpen", "SendWindowClose", "DeduplicateByEmail", "ExclusionFilter", "Additional" };
            GetReturn grAllEmail = getAllESD.Get();

            ET_EmailSendDefinition sendDefinition = new ET_EmailSendDefinition();

            if (grAllEmail.Results.Length > 0)
            {
                sendDefinition = (ET_EmailSendDefinition)grAllEmail.Results[1];
            }
            return sendDefinition;
            
        }

        private APIObject[] RetrieveTriggerSendDefinition()
        {
            ET_TriggeredSend tsdGetAll = new ET_TriggeredSend();
            tsdGetAll.AuthStub = _etClient;
            tsdGetAll.Props = new string[] { "CustomerKey", "Name", "TriggeredSendStatus", "SendClassification.CustomerKey"};

            GetReturn grAllTSD = tsdGetAll.Get();

            return grAllTSD.Results;

        }
        private APIObject[] RetrieveSendProfile()
        {
            ET_SenderProfile spGetAll = new ET_SenderProfile();
            spGetAll.AuthStub = _etClient;
            spGetAll.Props = new string[] { "CustomerKey", "Name" };

            GetReturn grAllSP = spGetAll.Get();

            return grAllSP.Results;

        }
        private APIObject[] RetrieveDeliveryProfile()
        {
            ET_DeliveryProfile dpGetAll = new ET_DeliveryProfile();
            dpGetAll.AuthStub = _etClient;
            dpGetAll.Props = new string[] { "CustomerKey", "Name" };

            GetReturn grAllDP = dpGetAll.Get();

            return grAllDP.Results;

        }
        private APIObject[] RetrieveSendClassification()
        {
            ET_SendClassification scGetAll = new ET_SendClassification();
            scGetAll.AuthStub = _etClient;
            scGetAll.Props = new string[] { "CustomerKey", "Name" };

            GetReturn grAllSC = scGetAll.Get();

            return grAllSC.Results;

        }
        private DeleteReturnStatus DeleteSendClassification(string customerKey)
        {
            FuelSDK.ET_SendClassification scDelete = new FuelSDK.ET_SendClassification();
            scDelete.AuthStub = _etClient;

            var allSC = RetrieveSendClassification();
            foreach (var o in allSC)
            {
                FuelSDK.ET_SendClassification scf = (FuelSDK.ET_SendClassification)o;                
               
                if (scf.CustomerKey == customerKey)
                {
                    scDelete.CustomerKey = ((ET_SendClassification)o).CustomerKey;
                    DeleteReturn drTSD = scDelete.Delete();

                    return
                        new DeleteReturnStatus()
                        {
                            Status = drTSD.Status.ToString(),
                            Message = drTSD.Message.ToString(),
                            Code = drTSD.Code.ToString(),
                            ResultsLength = drTSD.Results.Length
                        };
                }
                    
                
            }
            return
                new DeleteReturnStatus()
                {
                    Status = "OK"
                };
        }
        public string CreateTriggeredSendDefinition(string name, string customerKey, string description, string subject, string htmlBody)
        {
            try
            {
                DeleteSendClassification(customerKey);

                string emailCustomerKey = CreateEmail(name, customerKey, description, subject, htmlBody);

                //var sp = RetrieveSendProfile();
                //var dp = RetrieveDeliveryProfile();

                ET_SendClassification sendClassification = new ET_SendClassification();

                sendClassification.Name = name;
                sendClassification.CustomerKey = customerKey;
                sendClassification.SendClassificationType = SendClassificationTypeEnum.Marketing;
                sendClassification.SendClassificationTypeSpecified = true;

                sendClassification.SenderProfile = new ET_SenderProfile() { CustomerKey = "Default" };
                sendClassification.DeliveryProfile = new ET_DeliveryProfile() { CustomerKey = "Default" };

                sendClassification.AuthStub = _etClient;
                PostReturn status = sendClassification.Post();

                string sendDefinitionCustomerKey = Guid.NewGuid().ToString();

                FuelSDK.ET_TriggeredSend postEmailSendDef = new FuelSDK.ET_TriggeredSend();
                postEmailSendDef.AuthStub = _etClient;
                postEmailSendDef.Name = name;
                postEmailSendDef.CustomerKey = sendDefinitionCustomerKey;
                postEmailSendDef.Description = description;

                postEmailSendDef.SendClassification = (SendClassification)sendClassification; // new ET_SendClassification() { CustomerKey = sendClassification.CustomerKey };
                postEmailSendDef.TriggeredSendStatus = TriggeredSendStatusEnum.Active;

                FuelSDK.ET_Email email = new FuelSDK.ET_Email();
                email.Name = name;
                email.AuthStub = _etClient;
                email.CustomerKey = emailCustomerKey;

                postEmailSendDef.Email = email;

                PostReturn postResponse = postEmailSendDef.Post();

                if (postResponse.Status)
                {
                    return sendDefinitionCustomerKey;

                }
                else
                {
                    return string.Empty;
                }

                //return
                //    new PostReturnStatus()
                //    {
                //        Status = postResponse.Status.ToString(),
                //        Message = postResponse.Message.ToString(),
                //        Code = postResponse.Code.ToString(),
                //        ResultsLength = postResponse.Results.Length
                    //};
                
            }
            catch (Exception ex)
            {
                throw;
            }

        }
        public string CreateEmail(string name, string customerKey, string description, string subject, string htmlBody)
        {
            try
            {
                string emailCustomerKey = Guid.NewGuid().ToString();
                //ET_Email delEmail = new ET_Email();
                //delEmail.CustomerKey = emailCustomerKey;
                //delEmail.AuthStub = _etClient;
                //DeleteReturn deleteResponse = delEmail.Delete();

                ET_Email email = new ET_Email();
                //email.ID = emailIDForSendDefinition;
                email.AuthStub = _etClient;
                email.Name = name;
                email.CustomerKey = emailCustomerKey;
                email.Subject = subject;
                email.HTMLBody = htmlBody;
                email.EmailType = "HTML";
                email.IsHTMLPaste = true;

                PostReturn postResponse = email.Post();

                if (postResponse.Status)
                {
                    return emailCustomerKey;
                }
                else
                {
                    return string.Empty;
                }

                //return
                //    new PostReturnStatus()
                //    {
                //        Status = postResponse.Status.ToString(),
                //        Message = postResponse.Message.ToString(),
                //        Code = postResponse.Code.ToString(),
                //        ResultsLength = postResponse.Results.Length
                //    };

            }
            catch (Exception ex)
            {
                throw;
            }

        }

        public SendReturnStatus CreateTriggeredSendEmail(string name, string customerKey, string description, string subject, string htmlBody, string emailAddress)
        {

            try
            {

                string triggeredEndCustomerKey = CreateTriggeredSendDefinition(name, customerKey, description, subject, htmlBody);

                //string triggeredEndCustomerKey = CreateTriggeredSendDefinition(name, customerKey, description, subject, htmlBody);
                ET_TriggeredSend tsdSendNew = new ET_TriggeredSend();
                tsdSendNew.AuthStub = _etClient;
                tsdSendNew.CustomerKey = triggeredEndCustomerKey;

                //ET_Email email = new ET_Email();
                //email.AuthStub = _etClient;
                //email.CustomerKey = emailCustomerKey;

                //tsdSendNew.Email = email;

                tsdSendNew.Subscribers = new ET_Subscriber[] { new ET_Subscriber() { EmailAddress = emailAddress, SubscriberKey = emailAddress } };
                SendReturn srSendnew = tsdSendNew.Send();

                return new SendReturnStatus()
                {
                    Status = srSendnew.Status.ToString(),
                    Message = srSendnew.Message.ToString(),
                    Code = srSendnew.Code.ToString(),
                    ResultsLength = srSendnew.Results.Length
                };
                
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
