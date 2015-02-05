using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace MylanCustomizations.ExactTargetClient
{
    public class ReturnStatus
    {
        public string Status { get; set; }
        public string Message { get; set; }
        public string Code { get; set; }
        public int ResultsLength { get; set; }
    }
    public class GetReturnStatus : ReturnStatus
    {
    }
    public class PostReturnStatus : ReturnStatus
    {

    }
    public class SendReturnStatus : ReturnStatus
    {
    }

    public class PatchReturnStatus : ReturnStatus
    { }
    public class DeleteReturnStatus : ReturnStatus
    { }
}
