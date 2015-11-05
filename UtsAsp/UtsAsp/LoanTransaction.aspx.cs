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
    public partial class LoanTransaction : System.Web.UI.Page
    {
        string KodeBuku = "";
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        SqlConnection conn = new SqlConnection(ConfigurationManager
          .ConnectionStrings["ASPNETConnectionString"]
          .ConnectionString);

        protected void BtnSave_Click(object sender, EventArgs e)
        {
            string IdMember = MemberID.SelectedValue.ToString();
            string KodeBuku = BookCode.SelectedValue.ToString();
            string TglKembali = ReturnDate.SelectedDate.ToString("MM/dd/yyyy");
            if (IdMember == "" || KodeBuku == "" || TglKembali == "" || ReturnDate.SelectedDate < DateTime.Today)
            {
                lbl_error.Text = "Please input all the required fields correctly.";
            }
            else
            {
                int stock = CheckStock(KodeBuku);
                if (stock != 0)
                {
                    UpdateStock(KodeBuku, stock);
                    int result = InsertTransaksiPinjam(IdMember, KodeBuku, TglKembali);
                    if (result == 0)
                    {
                        lbl_error.Text = "Failed to Loan";
                    }
                    else
                    {
                        Response.Redirect("LoanTransaction.aspx");
                    }
                }
                else
                {
                    lbl_error.Text = "Stock is not enough";
                }
            }
        }

        protected int InsertTransaksiPinjam(string IdMember, string KodeBuku, string TglKembali)
        {
            int result = 0;

            string sql = "Insert into Transaksi_Pinjam (KodeBuku,IdMember,TglPinjam,TglKembali,Status) "
                + "values (@KodeBuku,@IdMember,@TglPinjam,@TglKembali,@Status)";
            conn.Open();

            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@KodeBuku", SqlDbType.VarChar);
                cmd.Parameters.Add("@IdMember", SqlDbType.Int);
                cmd.Parameters.Add("@TglPinjam", SqlDbType.Date);
                cmd.Parameters.Add("@TglKembali", SqlDbType.Date);
                cmd.Parameters.Add("@Status", SqlDbType.VarChar);
                cmd.Parameters["@KodeBuku"].Value = KodeBuku;
                cmd.Parameters["@IdMember"].Value = IdMember;
                cmd.Parameters["@TglPinjam"].Value = DateTime.Now.ToString("MM/dd/yyyy");
                cmd.Parameters["@TglKembali"].Value = TglKembali;
                cmd.Parameters["@Status"].Value = "Progress";
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

        protected int CheckStock(string KodeBuku)
        {
            int result = 0; //tidak tersedia
            string sql = "select Total from Master_Buku where KodeBuku=@KodeBuku";
            conn.Open();

            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@KodeBuku", SqlDbType.VarChar);
                cmd.Parameters["@KodeBuku"].Value = KodeBuku;
                result = (int) cmd.ExecuteScalar();
                conn.Close();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                Response.Write(ex.Message);
            }
            return result;
        }


        protected void UpdateStock(string KodeBuku, int stok)
        {
            int result = 0; //tidak tersedia
            string sql = "update Master_Buku set Total=@Total where KodeBuku=@KodeBuku";
            conn.Open();

            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@KodeBuku", SqlDbType.VarChar);
                cmd.Parameters.Add("@Total", SqlDbType.Int);
                cmd.Parameters["@KodeBuku"].Value = KodeBuku;
                cmd.Parameters["@Total"].Value = stok - 1;
                cmd.ExecuteNonQuery();

                conn.Close();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                Response.Write(ex.Message);
            }
        }

        protected void SqlDataSource3_Deleted(object sender, SqlDataSourceStatusEventArgs e)
        {
            //Response.Redirect("LoanTransaction.aspx");
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string KodeBuku = GridView1.Rows[e.RowIndex].Cells[1].Text;
            int Total = CheckStock(KodeBuku);
            UpdateStokBuku(KodeBuku, Total);
        }

        protected void UpdateStokBuku(string KodeBuku, int stok)
        {
            int result = 0; //tidak tersedia
            string sql = "update Master_Buku set Total=@Total where KodeBuku=@KodeBuku";
            conn.Open();

            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@KodeBuku", SqlDbType.VarChar);
                cmd.Parameters.Add("@Total", SqlDbType.Int);
                cmd.Parameters["@KodeBuku"].Value = KodeBuku;
                cmd.Parameters["@Total"].Value = stok + 1;
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