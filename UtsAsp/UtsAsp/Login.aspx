<%@ Page Title="" Language="C#" MasterPageFile="~/NavigationBar.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="UtsAsp.Login" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Heading Row -->
        <form id="Form1" class="form-horizontal" role="form" runat="server">
                <h2 style="padding-left:40px;">Login Form</h2>
                <div class="form-group">
                    <label for="email" class="col-sm-3 control-label" >Email</label>
                    <div class="col-sm-9">
                        <asp:TextBox ID="Email" runat="server"  TextMode="Email" CssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="FullName" class="col-sm-3 control-label">Password</label>
                    <div class="col-sm-9">
                        <asp:TextBox ID="Password" runat="server"  CssClass="form-control" TextMode="Password" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-7 col-sm-offset-3">
                        <asp:Button runat="server" ID="BtnLogin" Text="Login" OnClientClick="submitting();" CssClass="btn btn-primary btn-block" OnClick="BtnLogin_Click"></asp:Button>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-3">
                        <asp:Label ID="lbl_error" runat="server" CssClass="col-sm-9"></asp:Label>
                    </div>
                </div>
            </form> <!-- /form -->
        <!-- /.row -->

    <script>
        function submitting() {
            var Email = $("#<%=Email.ClientID %>").val();
            var Password = $("#<%=Password.ClientID %>").val();

            var complete = true;
            if (Email == "") {
                complete = false;
            }

            if (Password == "") {
                complete = false;
            }

            if (complete == true) {
                document.getElementById("RegistrationForm").submit();
            } else {
                alert("Please Fill In all the required fields correctly");
            }
        }

    </script>

</asp:Content>
