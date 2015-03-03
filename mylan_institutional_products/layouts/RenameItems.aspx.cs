using System;
using System.Data;
using System.Data.SqlClient;
using System.Text;
using Sitecore.Data.Fields;
using Sitecore.Data.Items;
using Sitecore.Security;

namespace MylanProducts.layouts
{
    public partial class RenameItems : System.Web.UI.Page
    {
        StringBuilder sb = new StringBuilder();
        Sitecore.Data.Database masterDB = Sitecore.Configuration.Factory.GetDatabase("master");

        protected void Page_Load(object sender, EventArgs e)
        {
            BuildUIFromCustom();
        }

        private void BuildUIFromCustom2()
        {
            SqlDataReader dr = GetDatabase();
            sb = new StringBuilder();
            sb.Append("<table border=\"1\" cellpadding=\"1\" cellspacing=\"5\">");
            sb.Append("<tr>");
            sb.AppendFormat("<th>Row Number</th><th>{0}</th><th>{1}</th><th>{2}</th><th>{3}</th>", "DB NDC", "Item Path", "Current PI", "Modified To");

            sb.Append("</tr>");
            while (dr.Read())
            {
                String RowID = dr[0].ToString();
                String NDC = dr[1].ToString();
                String NewPI = dr[3].ToString();

                String CurrentPI = String.Empty;
                Item product = null;
                Item itm = null;

                String query = "/sitecore/content/MylanInstitutionalProducts/Products//*[@@templateid='{692169E2-B461-41B4-95F9-235D652319A8}' and @ _NDC='" + NDC + "']";
                itm = masterDB.SelectSingleItem(query);
                try
                {
                    if (itm != null)
                    {
                        product = null;
                        product = getProductforNDC(itm);
                        if (product != null)
                        {
                            TextField tf = product.Fields["PrescribingInformationLink"];
                            if ((tf != null) && (!string.IsNullOrWhiteSpace(tf.Value)))
                            {
                                CurrentPI = tf.Value.ToString();
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    product = null;
                }
                sb.Append(BuildDisplayStringCustom(RowID, NDC, itm, product, CurrentPI, NewPI));
            }
            sb.Append("</table>");
            lblRenamedItems.Text = sb.ToString();
        }


        private void BuildUIFromCustom()
        {
            SqlDataReader dr = GetDatabase();
            sb = new StringBuilder();
            sb.Append("<table border=\"1\" cellpadding=\"1\" cellspacing=\"5\">");
            sb.Append("<tr>");
            sb.AppendFormat("<th>Row Number</th><th>{0}</th><th>{1}</th><th>{2}</th><th>{3}</th><th>{4}</th><th>{5}</th><th>{6}</th><th>{7}</th><th>{8}</th><th>{9}</th>", "DB NDC", "Item Path", "Current PI", "Modified To", "Amerisource Bergen", "Amerisource Bergen STAR", "Cardinal", "HD Smith", "McKesson", "Morris and Dickson");

            sb.Append("</tr>");
            while (dr.Read())
            {
                String RowID = dr[0].ToString();
                String NDC = dr[2].ToString();
                String NewPI = dr[3].ToString();
                String ABSAP = dr[4].ToString();
                String ABSTAR = dr[5].ToString();
                String Cardinal = dr[6].ToString();
                String HDSmith = dr[7].ToString();
                String McKesson = dr[8].ToString();
                String MorrisDickson = dr[9].ToString();

                String CurrentPI = String.Empty;
                Item product = null;
                Item itm = null;

                String query = "/sitecore/content/MylanInstitutionalProducts/Products//*[@@templateid='{692169E2-B461-41B4-95F9-235D652319A8}' and @ _NDC='" + NDC + "']";
                itm = masterDB.SelectSingleItem(query);
                try
                {
                    if (itm != null)
                    {
                        product = null;
                        product = getProductforNDC(itm);
                        if (product != null)
                        {
                            TextField tf = product.Fields["PrescribingInformationLink"];
                            if ((tf != null) && (!string.IsNullOrWhiteSpace(tf.Value)))
                            {
                                CurrentPI = tf.Value.ToString();
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    product = null;
                }
                sb.Append(BuildDisplayStringCustom(RowID, NDC, itm, product, CurrentPI, NewPI, ABSAP, ABSTAR, Cardinal, HDSmith, McKesson, MorrisDickson));
            }
            sb.Append("</table>");
            lblRenamedItems.Text = sb.ToString();
        }

        private Item getProductforNDC(Item itm)
        {
            if (itm.Parent.TemplateID == Sitecore.Data.ID.Parse("{A47497B6-472C-4E19-ADC4-A93C3BC80860}"))
            {
                return itm.Parent;
            }
            else
            {
                return getProductforNDC(itm.Parent);
            }
        }

        private string BuildDisplayStringCustom(String RowID, String NDC, Item NDCItem, Item Product, String CurrentPI, String NewPI, String ABSAP, String ABSTAR, String Cardinal, String HDSmith, String McKesson, String MorrisDickson)
        {
            StringBuilder sb = new StringBuilder();
            if (Product != null)
            {
                if (string.IsNullOrWhiteSpace(NewPI))
                {
                    sb.Append("<tr  style=\"background-color:gray;\">");
                }
                else
                {
                    sb.Append("<tr>");
                }
            }
            else
            {
                sb.Append("<tr  style=\"background-color:red;\">");
            }

            sb.AppendFormat("<td>{0}</td>", RowID);
            sb.AppendFormat("<td>{0}</td>", NDC);
            if (Product != null)
            {
                sb.AppendFormat("<td onclick=\"alert('{0}')\">{1}</td>", Product.Paths.FullPath.ToString(), Product.Name.ToString());
            }
            else
            {
                sb.Append("<td>&nbsp;</td>");
            }
            sb.AppendFormat("<td nowrap>{0}</td>", CurrentPI);
            sb.AppendFormat("<td nowrap>{0}</td>", NewPI);

            if (Product != null)
            {
                using (new Sitecore.SecurityModel.SecurityDisabler())
                {
                    Product.Editing.BeginEdit();
                    if ((!String.IsNullOrWhiteSpace(NewPI)))
                    {
                        TextField tf = Product.Fields["PrescribingInformationLink"];
                        if ((tf != null))
                        {
                            tf.Value = NewPI.ToString();
                        }
                    }
                    Product.Editing.EndEdit();
                }
            }

            if (NDCItem != null)
            {
                using (new Sitecore.SecurityModel.SecurityDisabler())
                {
                    NDCItem.Editing.BeginEdit();
                    if (!String.IsNullOrWhiteSpace(ABSAP))
                    {
                        TextField tf1 = NDCItem.Fields["Amerisource Bergen"];
                        if ((tf1 != null))
                        {
                            tf1.Value = ABSAP;
                        }
                    }
                    if (!String.IsNullOrWhiteSpace(ABSTAR))
                    {
                        TextField tf2 = NDCItem.Fields["Amerisource Bergen STAR"];
                        if ((tf2 != null))
                        {
                            tf2.Value = ABSTAR;
                        }
                    }
                    if (!String.IsNullOrWhiteSpace(Cardinal))
                    {
                        TextField tf3 = NDCItem.Fields["Cardinal"];
                        if ((tf3 != null))
                        {
                            tf3.Value = Cardinal;
                        }
                    }
                    if (!String.IsNullOrWhiteSpace(HDSmith))
                    {
                        TextField tf4 = NDCItem.Fields["HD Smith"];
                        if ((tf4 != null))
                        {
                            tf4.Value = HDSmith;
                        }
                    }
                    if (!String.IsNullOrWhiteSpace(McKesson))
                    {
                        TextField tf5 = NDCItem.Fields["McKesson"];
                        if ((tf5 != null))
                        {
                            tf5.Value = McKesson;
                        }
                    }
                    if (!String.IsNullOrWhiteSpace(MorrisDickson))
                    {
                        TextField tf6 = NDCItem.Fields["Morris and Dickson"];
                        if ((tf6 != null))
                        {
                            tf6.Value = MorrisDickson;
                        }
                    }
                    NDCItem.Editing.EndEdit();
                }
            }

            sb.AppendFormat("<td nowrap>{0}</td>", ABSAP);
            sb.AppendFormat("<td nowrap>{0}</td>", ABSTAR);
            sb.AppendFormat("<td nowrap>{0}</td>", Cardinal);
            sb.AppendFormat("<td nowrap>{0}</td>", HDSmith);
            sb.AppendFormat("<td nowrap>{0}</td>", McKesson);
            sb.AppendFormat("<td nowrap>{0}</td>", MorrisDickson);
            sb.Append("</tr>");

            return sb.ToString();
        }

        private string BuildDisplayStringCustom(String RowID, String NDC, Item NDCItem, Item Product, String CurrentPI, String NewPI)
        {
            StringBuilder sb = new StringBuilder();
            if (Product != null)
            {
                if (string.IsNullOrWhiteSpace(NewPI))
                {
                    sb.Append("<tr  style=\"background-color:gray;\">");
                }
                else
                {
                    sb.Append("<tr>");
                }
            }
            else
            {
                sb.Append("<tr  style=\"background-color:red;\">");
            }

            sb.AppendFormat("<td>{0}</td>", RowID);
            sb.AppendFormat("<td>{0}</td>", NDC);
            if (Product != null)
            {
                sb.AppendFormat("<td onclick=\"alert('{0}')\">{1}</td>", Product.Paths.FullPath.ToString(), Product.Name.ToString());
            }
            else
            {
                sb.Append("<td>&nbsp;</td>");
            }
            sb.AppendFormat("<td nowrap>{0}</td>", CurrentPI);
            sb.AppendFormat("<td nowrap>{0}</td>", NewPI);

            if (Product != null)
            {
                using (new Sitecore.SecurityModel.SecurityDisabler())
                {
                    Product.Editing.BeginEdit();
                    if ((!String.IsNullOrWhiteSpace(NewPI)))
                    {
                        TextField tf = Product.Fields["PrescribingInformationLink"];
                        if ((tf != null))
                        {
                            tf.Value = NewPI.ToString();
                        }
                    }
                    Product.Editing.EndEdit();
                }
            }

            sb.Append("</tr>");

            return sb.ToString();
        }

        private SqlDataReader GetDatabase()
        {
            SqlConnection conn = null;
            SqlDataReader rdr = null;


            conn = new SqlConnection("user id=WCMS;password=Sitecore;Data Source=(local);Database=Custom2");
            conn.Open();
            SqlCommand cmd = new SqlCommand("dbo.GetAllProducts", conn);
            cmd.CommandType = CommandType.StoredProcedure;
            rdr = cmd.ExecuteReader();
            return rdr;
        }

        private void DisplayAllItems()
        {
            Item[] items = Sitecore.Context.Database.SelectItems("/sitecore/content/MylanInstitutionalProducts/Products//*[@@templateid='{A47497B6-472C-4E19-ADC4-A93C3BC80860}']");
            sb.Append("<table>");
            sb.Append("<tr>");
            sb.AppendFormat("<th>{0}</th><th>{1}</th>", "Item Path", "Field Value");
            sb.Append("</tr>");
            foreach (Item itm in items)
            {
                TextField tf = itm.Fields["Product Group Name"];
                if ((tf != null) && (!string.IsNullOrWhiteSpace(tf.Value)))
                {
                    String s = tf.Value;
                    if (s.ToLower().Contains("extended-release"))
                    {
                        sb.Append("<tr>");
                        sb.AppendFormat("<td>{0}</td><td>{1}</td>", itm.Paths.FullPath.ToString(), s.ToString());
                        sb.Append("</tr>");
                    }
                }
            }
            sb.Append("</table>");
            lblRenamedItems.Text = sb.ToString();
        }
    }
}