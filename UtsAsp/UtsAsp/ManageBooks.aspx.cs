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
    public partial class ManageBooks : System.Web.UI.Page
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
            string JudulBuku = TitleOfBook.Text;
            string Kategori = Category.Text;
            string Kuantitas = Quantity.Text;
            if(KodeBuku == "" || JudulBuku == "" || Kategori == "" 
                || Kuantitas == "")
            {
                lbl_error.ForeColor = System.Drawing.Color.Red;
                lbl_error.Text = "Please input all the required fields";
                return;
            }

            if (!Image.HasFile)
            {
                lbl_error.ForeColor = System.Drawing.Color.Red;
                lbl_error.Text = "Please Select Image File";
                return;
            }
            else
            {
                int Jumlah = Convert.ToInt32(Kuantitas);
                int length = Image.PostedFile.ContentLength;
                /*
                byte[] pic = new byte[length];
                Image.PostedFile.InputStream.Read(pic, 0, length);
                */
                byte[] pic = new byte[Image.PostedFile.ContentLength];
                HttpPostedFile Posted_Image = Image.PostedFile; 
                Posted_Image.InputStream.Read(pic, 0, (int)Image.PostedFile.ContentLength);


                string result = insertBooks(KodeBuku, JudulBuku, Kategori,
                    pic, Jumlah);
                if(result.Equals("berhasil"))
                {
                    Response.Redirect("ManageBooks.aspx");
                }
                else
                {
                    lbl_error.ForeColor = System.Drawing.Color.Red;
                    lbl_error.Text = "Please input all the required fields correctly";
                }
            }
        }

        protected string insertBooks(string KodeBuku, string JudulBuku, string Kategori,
             byte[] Gambar, int Total)
        {
            string result = "";
            string sql;

            sql = "insert into Master_Buku (KodeBuku, JudulBuku, Kategori,Gambar,Total) "
            + "values (@KodeBuku,@JudulBuku,@Kategori,@Gambar,@Total)";
            conn.Open();

            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@KodeBuku", SqlDbType.VarChar);
                cmd.Parameters.Add("@JudulBuku", SqlDbType.VarChar);
                cmd.Parameters.Add("@Kategori", SqlDbType.VarChar);
                cmd.Parameters.Add("@Gambar", SqlDbType.Image);
                cmd.Parameters.Add("@Total", SqlDbType.Int);

                cmd.Parameters["@KodeBuku"].Value = KodeBuku;
                cmd.Parameters["@JudulBuku"].Value = JudulBuku;
                cmd.Parameters["@Kategori"].Value = Kategori;
                cmd.Parameters["@Gambar"].Value = Gambar;
                cmd.Parameters["@Total"].Value = Total;
                cmd.ExecuteNonQuery();

                result = "berhasil";

                conn.Close();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                //Response.Write(ex.Message);
            }
            return result;
        }

        protected void GridView1_SelectedIndexChanged1(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            string KodeBuku = GridView1.DataKeys[e.RowIndex].Value.ToString();
            deleteTransaksi_Pinjam(KodeBuku);
            //deleteMaster_Buku(KodeBuku);

            
        }

        protected void deleteTransaksi_Pinjam(string KodeBuku)
        {
            string sql = "delete from transaksi_pinjam where KodeBuku=@KodeBuku";
            conn.Open();

            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@KodeBuku", SqlDbType.VarChar);
                cmd.Parameters["@KodeBuku"].Value = KodeBuku;
                cmd.ExecuteNonQuery();

                conn.Close();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                Response.Write(ex.Message);
            }
        }

        protected void deleteMaster_Buku(string KodeBuku)
        {
            string sql = "delete from Master_Buku where KodeBuku=@KodeBuku";
            conn.Open();

            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@KodeBuku", SqlDbType.VarChar);
                cmd.Parameters["@KodeBuku"].Value = KodeBuku;
                cmd.ExecuteNonQuery();

                conn.Close();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                Response.Write(ex.Message);
            }
        }

        protected void SqlDataSource1_Deleting(object sender, SqlDataSourceCommandEventArgs e)
        {
            
        }

        

        /*
        protected void select()
        {
            try
            {
                DataTable DtTable = new DataTable();
                string sql = "select KodeBuku,JudulBuku,Kategori,Gambar,Total,TanggalMasuk from Master_Buku";
                SqlCommand cmd = new SqlCommand(sql, conn);
                conn.Open();

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                da.Fill(DtTable);

                GridView1.DataSource = DtTable;
                GridView1.DataBind();

                conn.Close();
                da.Dispose();

            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                lbl_error.Text = ex.Message;
            }
        }
        */
    }
}