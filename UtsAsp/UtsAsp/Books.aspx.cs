using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace UtsAsp
{
    public partial class Books : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                string connectionString = ConfigurationManager.
                    ConnectionStrings["ASPNETConnectionString"].ConnectionString;
                DataTable dt = new DataTable();
                SqlConnection conn = new SqlConnection(connectionString);
                using (conn)
                {
                    SqlDataAdapter ad = new SqlDataAdapter("SELECT * FROM Master_Buku", conn);
                    ad.Fill(dt);
                }
                DataList1.DataSource = dt;
                DataList1.DataBind();
            }
        }
    }
}