<%@ Page Title="" Language="C#" MasterPageFile="~/Member.Master" AutoEventWireup="true" CodeBehind="PasswordMember.aspx.cs" Inherits="UtsAsp.PasswordMember" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<!-- Heading Row -->
        <div class="form-horizontal" id="FormPassword" role="form" runat="server">
                <h2 >Change Password</h2>
                <div class="form-group">
                    <label for="CurrentPassword" class="col-sm-3 control-label" >Current Password</label>
                    <div class="col-sm-9">
                        <asp:TextBox ID="CurrentPassword" runat="server"  CssClass="form-control" 
                            TextMode="Password" onchange="isValidPassword()" required="required" />
                             <asp:Label ID="lblStatus" runat="server"></asp:Label>  
                    </div>
                </div>
                <div class="form-group">
                    <label for="NewPassword" class="col-sm-3 control-label">New Password</label>
                    <div class="col-sm-9">
                        <asp:TextBox ID="NewPassword" runat="server"  CssClass="form-control" 
                            TextMode="Password" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="RetypeNewPassword" class="col-sm-3 control-label">Re-Type New Password</label>
                    <div class="col-sm-9">
                        <asp:TextBox ID="RetypeNewPassword" runat="server"  CssClass="form-control" 
                            TextMode="Password" required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-7 col-sm-offset-3">
                        <asp:Button runat="server" ID="BtnPassword" Text="Save Changes" 
                            OnClick="BtnPassword_Click" CssClass="btn btn-primary btn-block"></asp:Button>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-3">
                        <asp:Label ID="lbl_error" runat="server" CssClass="col-sm-9"></asp:Label>
                    </div>
                </div>
            </div> <!-- /form -->
        <!-- /.row -->

    <script>
        function isValidPassword() { //This function call on text change.      
            $.ajax({
                type: "POST",
                url: "PasswordMember.aspx/CheckPassword",
                data: '{password: "' + $("#<%=CurrentPassword.ClientID%>")[0].value + '" }',
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: OnSuccess,
                failure: function (response) {
                    alert(response);
                }
            });
        }

        // function OnSuccess  
        function OnSuccess(response) {
            var msg = $("#<%=lblStatus.ClientID%>")[0];
            switch (response.d) {
                case "true":
                    isvalidpassword = true;
                    msg.style.display = "block";
                    msg.style.color = "green";
                    msg.innerHTML = "Current Password match";
                    break;
                case "false":
                    isvalidpassword = false;
                    msg.style.display = "block";
                    msg.style.color = "red";
                    msg.innerHTML = "Current Password doesn't match";
                    break;
            }
        }

    </script>
</asp:Content>
