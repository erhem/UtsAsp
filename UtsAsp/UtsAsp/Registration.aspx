<%@ Page Title="" Language="C#" MasterPageFile="~/NavigationBar.Master" AutoEventWireup="true" CodeBehind="Registration.aspx.cs" Inherits="UtsAsp.Registration" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Heading Row -->
        <form id="Form1" class="form-horizontal" role="form" runat="server">
                <h2>Registration Form</h2>
                <div class="form-group">
                    <label for="FullName" class="col-sm-3 control-label">Full Name</label>
                    <div class="col-sm-9">
                        <asp:TextBox ID="FullName" runat="server"  CssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="Age" class="col-sm-3 control-label">Age</label>
                    <div class="col-sm-9">
                        <asp:TextBox ID="Age" runat="server"  CssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="Address" class="col-sm-3 control-label">Address</label>
                    <div class="col-sm-9">
                        <asp:TextBox ID="Address" runat="server"  CssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="email" class="col-sm-3 control-label">Email</label>
                    <div class="col-sm-9">
                        <asp:TextBox ID="Email" runat="server"  TextMode="Email" CssClass="form-control" />
                    </div>
                </div>
                <div class="form-group">
                    <label class="control-label col-sm-3">Gender</label>
                    <div class="col-sm-6">
                        <div class="row">
                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" CssClass="control-label col-sm-3 col-sm-8 rbl" RepeatDirection="Horizontal" Width="175px">
                                 <asp:ListItem Text="Male" Value="Male"/>
                                 <asp:ListItem Text="Female" Value="Female" />
                            </asp:RadioButtonList>
                        </div>
                    </div>
                </div> <!-- /.form-group -->

                <div class="form-group">
                    <div class="col-sm-7 col-sm-offset-3">
                        <asp:Button runat="server" ID="BtnRegister" Text="Register" OnClientClick="submitting();" CssClass="btn btn-primary btn-block" OnClick="BtnRegister_Click" ></asp:Button>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-3">
                        <asp:Label ID="lbl_error" runat="server" CssClass="col-sm-9"></asp:Label>
                    </div>
                </div>
        </form>
        <!-- /.row -->

    <script>
            function submitting() {
                var FullName = $("#<%=FullName.ClientID %>").val();
                var Age = $("#<%=Age.ClientID %>").val();
                var Address = $("#<%=Address.ClientID %>").val();
                var Email = $("#<%=Email.ClientID %>").val();

                var complete = true;
                if (FullName == "") {
                    complete = false;
                }

                if (Age == "") {
                    complete = false;
                } else if (isNaN(Age)) {
                    alert("Age must a number");
                    complete = false;
                }

                if (Address == "") {
                    complete = false;
                }

                if (Email == "") {
                    complete = false;
                } else if (!isValidEmailAddress(Email)) {
                    complete = false;
                    alert("Please input valid email");
                }

                var RB1 = document.getElementById("<%=RadioButtonList1.ClientID%>");
                    var radio = RB1.getElementsByTagName("input");
                    var isChecked = false;
                    for (var i = 0; i < radio.length; i++) {
                        if (radio[i].checked) {
                            isChecked = true;
                            break;
                        }
                    }
                    if (!isChecked) {
                        complete = false;
                        alert("Please select your gender");
                    }

                    if (complete == true) {
                        document.getElementById("RegistrationForm").submit();
                    } else {
                        alert("Please Fill In all the required fields correctly");
                    }
                }

                function isValidEmailAddress(emailAddress) {
                    var pattern = /^([a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+(\.[a-z\d!#$%&'*+\-\/=?^_`{|}~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]+)*|"((([ \t]*\r\n)?[ \t]+)?([\x01-\x08\x0b\x0c\x0e-\x1f\x7f\x21\x23-\x5b\x5d-\x7e\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|\\[\x01-\x09\x0b\x0c\x0d-\x7f\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))*(([ \t]*\r\n)?[ \t]+)?")@(([a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\d\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.)+([a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]|[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF][a-z\d\-._~\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]*[a-z\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])\.?$/i;
                    return pattern.test(emailAddress);
                };

    </script>

</asp:Content>

