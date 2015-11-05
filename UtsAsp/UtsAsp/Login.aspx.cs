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
    public partial class Login : System.Web.UI.Page
    {
        string position = "";
        int idmember = 0;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["sessionlogin"] != null)
            {
                string session_position = Session["position"].ToString();
                Response.Redirect(session_position + ".aspx");
            }
        }

        SqlConnection conn = new SqlConnection(ConfigurationManager
            .ConnectionStrings["ASPNETConnectionString"]
            .ConnectionString);

        protected void BtnLogin_Click(object sender, EventArgs e)
        {
            string email = Email.Text;
            string password = Password.Text;
            string name = isValidUser(email, password);
            if (name != "")
            {
                Session["idmember"] = idmember;
                Session["sessionlogin"] = name;
                Session["position"] = position;
                if (position.Equals("Member"))
                {
                    Response.Redirect("Member.aspx");
                }
                else
                {
                    Response.Redirect("Admin.aspx");
                }
            }
            else
            {
                lbl_error.ForeColor = System.Drawing.Color.Red;
                lbl_error.Text = "The username or password you entered is incorrect .";
            }
        }

        protected string isValidUser(string Email, string Password)
        {
            string sql = "select IdMember,NamaMember,Posisi from Member where Email=@Email " +
                "and Password=@Password";
            conn.Open();

            string name = "";
            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@Email", SqlDbType.VarChar);
                cmd.Parameters.Add("@Password", SqlDbType.VarChar);
                cmd.Parameters["@Email"].Value = Email;
                cmd.Parameters["@Password"].Value = Password;
                //name = Convert.ToString(cmd.ExecuteScalar());
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    idmember = Convert.ToInt32(dr[0].ToString());
                    name = dr[1].ToString();
                    position = dr[2].ToString();
                }
                conn.Close();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                Response.Write(ex.Message);
            }
            return name;
        }
    }
}
