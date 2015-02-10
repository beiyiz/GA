using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace mylan_institutional_products.Admin
{
    public class ItemChangeHistory
    {
        public int ItemChangeId { get; set; }
        public string ItemId { get; set; }
        public string ItemName { get; set; }
        public string Revision { get; set; }

        public string ProductName { get; set; }
        public string ProductCategory { get; set; }

        public string ItemHtml { get; set; }
        public string ChangeType { get; set; }
        public DateTime ChangeDate { get; set; }

        public string FieldName { get; set; }

        public string DisplayFieldName { get; set; }
        public string OldValue { get; set; }
        public string NewValue { get; set; }

    }
}