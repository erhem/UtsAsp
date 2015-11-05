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
    public partial class GetImageDatafromDB : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string KodeBuku = Request.QueryString["KodeBuku"];

                string constr = ConfigurationManager.ConnectionStrings["ASPNETConnectionString"].ConnectionString;
                string sQuery = "SELECT Gambar FROM Master_Buku WHERE KodeBuku = @KodeBuku";

                SqlConnection con = new SqlConnection(constr);
                SqlCommand cmd = new SqlCommand(sQuery, con);

                cmd.Parameters.Add("@KodeBuku", SqlDbType.VarChar).Value = KodeBuku;

                using (con)
                {
                    con.Open();
                    SqlDataReader DR = cmd.ExecuteReader();

                    if (DR.Read())
                    {
                        byte[] imgData = (byte[])DR["Gambar"];
                        Response.BinaryWrite(imgData);
                    }
                }
            }
        }
    }
}