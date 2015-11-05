using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UtsAsp
{
    public partial class Member1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["sessionlogin"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            else
            {
                string name = Session["sessionlogin"].ToString();
                string position = Session["position"].ToString();
                Lbl_SessionInfo.Text = "" + name + " logged as " + position + "";
            }
        }

        protected void LinkLogout_Click(object sender, EventArgs e)
        {
            Session.Remove("idmember");
            Session.Remove("sessionlogin");
            Session.Remove("position");
            Response.Redirect("Login.aspx");
        }
    }
}