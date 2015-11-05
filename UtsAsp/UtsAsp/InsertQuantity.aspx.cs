using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
namespace UtsAsp
{
    public partial class InsertQuantity: System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        SqlConnection conn = new SqlConnection(ConfigurationManager
           .ConnectionStrings["ASPNETConnectionString"]
           .ConnectionString);

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            string KodeBuku = BookCode.Text;
            string Jumlah = Quantity.Text;

            if (KodeBuku == "" || Jumlah == "")
            {
                lbl_error.ForeColor = System.Drawing.Color.Red;
                lbl_error.Text = "Please input all the required fields correctly";
                return;
            }
            else
            {
                int Total = getTotal(KodeBuku) + Convert.ToInt32(Jumlah);
                int result = insertQuantity(KodeBuku, Total);
                if (result == 0)
                {
                    lbl_error.ForeColor = System.Drawing.Color.Red;
                    lbl_error.Text = "Failed to insert";
                }
                else
                {
                    Response.Redirect("InsertQuantity.aspx");
                }
            }
        }

        protected int getTotal(string KodeBuku)
        {
            int total = 0;
            string sql = "select total from Master_Buku where KodeBuku=@KodeBuku";
            conn.Open();

            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@KodeBuku", SqlDbType.VarChar);
                cmd.Parameters["@KodeBuku"].Value = KodeBuku;
                total = (int)cmd.ExecuteScalar();
                conn.Close();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                Response.Write(ex.Message);
            }
            return total;
        }

        protected int insertQuantity(string KodeBuku, int Total)
        {
            int result = 0;
            string sql = "update master_buku set total=@total where kodebuku=@KodeBuku";
            conn.Open();

            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@KodeBuku", SqlDbType.VarChar);
                cmd.Parameters.Add("@Total", SqlDbType.Int);
                cmd.Parameters["@KodeBuku"].Value = KodeBuku;
                cmd.Parameters["@Total"].Value = Total;
                cmd.ExecuteNonQuery();
                result = 1;
                conn.Close();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                Response.Write(ex.Message);
            }
            return result;
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}