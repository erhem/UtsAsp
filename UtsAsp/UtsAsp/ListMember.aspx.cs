using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UtsAsp
{
    public partial class ListMember : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        SqlConnection conn = new SqlConnection(ConfigurationManager
         .ConnectionStrings["ASPNETConnectionString"]
         .ConnectionString);

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int IdMember = Convert.ToInt32(GridView1.Rows[e.RowIndex].Cells[0].Text);
            deleteTransaksi_Pinjam(IdMember);
            //UpdateStokBuku(KodeBuku, Total);
        }

        protected void deleteTransaksi_Pinjam(int IdMember)
        {
            string sql = "delete from Transaksi_Pinjam where IdMember=@IdMember";
            conn.Open();

            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@IdMember", SqlDbType.Int);
                cmd.Parameters["@IdMember"].Value = IdMember;
                cmd.ExecuteNonQuery();
                conn.Close();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}