using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Reflection;
using System.Web.Http;
using log4net;

namespace PriceSharePlatform.Controllers
{
    public class BillController : ApiController
    {
        static ILog logger = LogManager.GetLogger(MethodInfo.GetCurrentMethod().DeclaringType);

        // GET: api/Bill
        public IEnumerable<string> Get()
        {
            return new string[] { "value1", "value2" };
        }

        // GET: api/Bill/5
        public string Get(int id)
        {
            logger.Debug("cccdddd");
            return "value";
        }

        // POST: api/Bill
        public void Post([FromBody]string value)
        {
        }

        // PUT: api/Bill/5
        public void Put(int id, [FromBody]string value)
        {
        }

        //public IHttpActionResult GetBill(int id)
        //{
        //    return NotFound();
        //}

        // DELETE: api/Bill/5
        public void Delete(int id)
        {
        }
    }
}
