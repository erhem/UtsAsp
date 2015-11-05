<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ListMember.aspx.cs" Inherits="UtsAsp.ListMember" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-horizontal" id="Div1" role="form" runat="server">
            <h2>Search</h2>
            <br />
            <div class="form-group">
                    <label for="Title" class="col-sm-3 control-label">Search</label>
                    <div class="col-sm-6">
                        <asp:TextBox ID="txtSearch" runat="server"  CssClass="form-control" 
                             />
                    </div>
                    <div class="col-sm-3">
                        <asp:Button runat="server" ID="BtnSearch" Text="Search" 
                          CssClass="btn btn-primary btn-block"></asp:Button>
                    </div>
            </div>
     </div>
     <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover table-sortable tab_logic" DataKeyNames="IdMember" DataSourceID="SqlDataSource1" OnRowDeleting="GridView1_RowDeleting">
         <Columns>
             <asp:BoundField DataField="IdMember" HeaderText="Member ID" InsertVisible="False" ReadOnly="True" SortExpression="IdMember" />
             <asp:BoundField DataField="NamaMember" HeaderText="Member Name" SortExpression="NamaMember" />
             <asp:BoundField DataField="Umur" HeaderText="Age" SortExpression="Umur" />
             <asp:BoundField DataField="Alamat" HeaderText="Address" SortExpression="Alamat" />
             <asp:BoundField DataField="JenisKelamin" HeaderText="Gender" SortExpression="JenisKelamin" />
             <asp:BoundField DataField="Email" HeaderText="Email" SortExpression="Email" />
             <asp:BoundField DataField="Password" HeaderText="Password" SortExpression="Password" />
             <asp:CommandField ButtonType="Button" ShowDeleteButton="True" ShowEditButton="True" />
         </Columns>
    </asp:GridView>    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ASPNETConnectionString %>" 
        SelectCommand="SELECT IdMember, NamaMember, Umur, Alamat, JenisKelamin, Email, Password FROM Member WHERE (Posisi = 'Member')"
        UpdateCommand = "UPDATE [Member] SET [NamaMember]=@NamaMember, [Umur]=@Umur, [Alamat]=@Alamat , [JenisKelamin]=@JenisKelamin , [Email]=@Email , [Password]=@Password FROM [Master_Buku] WHERE [IdMember]=@IdMember" 
        DeleteCommand = "DELETE FROM [Member] WHERE [IdMember]=@IdMember">

    </asp:SqlDataSource>
</asp:Content>
