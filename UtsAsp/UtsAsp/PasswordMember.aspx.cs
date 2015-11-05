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
    public partial class PasswordMember : System.Web.UI.Page
    {
        static bool isValidPassword;
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        static SqlConnection conn = new SqlConnection(ConfigurationManager
            .ConnectionStrings["ASPNETConnectionString"]
            .ConnectionString);

        [System.Web.Services.WebMethod]
        public static string CheckPassword(string password)
        {
            string retval = "";
            int idmember = Convert.ToInt32(HttpContext.Current.Session["idmember"].ToString());
            string sql = "Select NamaMember From Member Where IdMember=@IdMember "
                 + "and Password=@Password";
            conn.Open();
            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@IdMember", SqlDbType.Int);
                cmd.Parameters.Add("@Password", SqlDbType.VarChar);
                cmd.Parameters["@IdMember"].Value = idmember;
                cmd.Parameters["@Password"].Value = password;

                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    retval = "true";
                    isValidPassword = true;
                }
                else
                {
                    retval = "false";
                    isValidPassword = false;
                }
                conn.Close();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {

            }

            return retval;
        }

        protected void BtnPassword_Click(object sender, EventArgs e)
        {
            lbl_error.Text = "";
            lbl_error.ForeColor = System.Drawing.Color.Red;
            bool complete = true;
            string newpassword = NewPassword.Text;
            string retypenewpassword = RetypeNewPassword.Text;

            if (isValidPassword == false)
            {
                complete = false;
            }

            if (newpassword.Length < 6)
            {
                complete = false;
                lbl_error.Text = "Minimum password length is 6 . <br/> ";
                return;
            }

            if (newpassword != retypenewpassword)
            {
                complete = false;
            }

            if (!complete)
            {
                lbl_error.Text += "Please fill all the required fields correctly. ";
                return;
            }
            else
            {
                updatePassword(newpassword);
            }
        }

        protected void updatePassword(string newpassword)
        {
            string sql = "update Member set Password=@Password where IdMember=@IdMember";
            conn.Open();


            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@Password", SqlDbType.VarChar);
                cmd.Parameters.Add("@IdMember", SqlDbType.Int);
                cmd.Parameters["@Password"].Value = newpassword;
                cmd.Parameters["@IdMember"].Value =
                    Convert.ToInt32(HttpContext.Current.Session["idmember"].ToString());
                cmd.ExecuteNonQuery();

                lbl_error.ForeColor = System.Drawing.Color.Green;
                lbl_error.Text = "Your Password has been changed.";
                conn.Close();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                Response.Write(ex.Message);
            }
        }
    }
}