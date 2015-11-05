using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Text.RegularExpressions;
using System.Net.Mail;

namespace UtsAsp
{
    public partial class Registration : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        SqlConnection conn = new SqlConnection(ConfigurationManager
            .ConnectionStrings["ASPNETConnectionString"]
            .ConnectionString);

        protected void BtnRegister_Click(object sender, EventArgs e)
        {
            lbl_error.Text = "";
            string fullname = FullName.Text;
            string age = Age.Text;
            string address = Address.Text;
            string email = Email.Text;
            string gender = RadioButtonList1.SelectedValue;
            string password = "";

            if (fullname == "" || age == "" || address == "" || email == "" || gender == "")
            {
                lbl_error.ForeColor = System.Drawing.Color.Red;
                lbl_error.Text = "You must fill all the required fields";
                return;
            }
            else if (check_email(email) == 1)
            {
                lbl_error.ForeColor = System.Drawing.Color.Red;
                lbl_error.Text = "Sorry, that email already taken";
                return;
            }
            else
            {
                password = Membership.GeneratePassword(6, 0);
                password = Regex.Replace(password, @"[^a-zA-Z0-9]", m => "9");
                string messageDB = insert(fullname, Convert.ToInt32(age), address, email, gender, password);
                string messageEmail = SendMail(email, "bookrental88@gmail.com", "", "Member Rental Book",
                "<html><head></head><body><p>You already registered as Rental Book's member</p> <p> Your password is " + password + "</p> <p> Link to login page <a href='http://localhost:49893/Login.aspx'>Login Page</a> </p> </body></html>");

                lbl_error.ForeColor = System.Drawing.Color.Green;
                lbl_error.Text = "Registered Successfully ! Check your Email";
            }

        }


        protected string insert(String NamaMember, int Umur, String Alamat, String Email, String JenisKelamin, String Password)
        {
            string message = "";
            string sql = "insert into member (NamaMember,Umur,Alamat,Email,JenisKelamin,Password,Posisi) " +
                            "values (@NamaMember,@Umur,@Alamat,@Email,@JenisKelamin,@Password,@Posisi)";
            conn.Open();

            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@NamaMember", SqlDbType.VarChar);
                cmd.Parameters.Add("@Umur", SqlDbType.Int);
                cmd.Parameters.Add("@Alamat", SqlDbType.VarChar);
                cmd.Parameters.Add("@Email", SqlDbType.VarChar);
                cmd.Parameters.Add("@JenisKelamin", SqlDbType.VarChar);
                cmd.Parameters.Add("@Password", SqlDbType.VarChar);
                cmd.Parameters.Add("@Posisi", SqlDbType.VarChar);

                cmd.Parameters["@NamaMember"].Value = NamaMember;
                cmd.Parameters["@Umur"].Value = Umur;
                cmd.Parameters["@Alamat"].Value = Alamat;
                cmd.Parameters["@Email"].Value = Email;
                cmd.Parameters["@JenisKelamin"].Value = JenisKelamin;
                cmd.Parameters["@Password"].Value = Password;
                cmd.Parameters["@Posisi"].Value = "Member";
                cmd.ExecuteNonQuery();

                conn.Close();
                message = "Successfully insert to database";
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                message = ex.Message;
            }
            return message;
        }


        protected int check_email(string Email)
        {
            string sql = "select count(*) from Member where Email=@Email";
            conn.Open();

            int count = 0;
            try
            {
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.Add("@Email", SqlDbType.VarChar);
                cmd.Parameters["@Email"].Value = Email;
                count = (int)cmd.ExecuteScalar();
                conn.Close();
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                Response.Write(ex.Message);
            }
            return count;

        }


        public string SendMail(string toList, string from, string ccList, string subject, string body)
        {

            MailMessage message = new MailMessage();
            SmtpClient smtpClient = new SmtpClient();
            string msg = string.Empty;
            try
            {
                MailAddress fromAddress = new MailAddress(from);
                message.From = fromAddress;
                message.To.Add(toList);
                if (ccList != null && ccList != string.Empty)
                    message.CC.Add(ccList);
                message.Subject = subject;
                message.IsBodyHtml = true;
                message.Body = body;
                smtpClient.Host = "smtp.gmail.com";   // We use gmail as our smtp client
                smtpClient.Port = 587;
                smtpClient.EnableSsl = true;
                smtpClient.UseDefaultCredentials = true;
                smtpClient.Credentials = new System.Net.NetworkCredential("bookrental88@gmail.com", "bookrental123");

                smtpClient.Send(message);
                msg = "Successful<BR>";
            }
            catch (Exception ex)
            {
                msg = ex.Message;
            }
            return msg;
        }

    }
}
