<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="Search.aspx.cs" Inherits="UtsAsp.Search" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <div class="form-horizontal" id="Div1" role="form" runat="server">
            <h2>Search Book</h2>
            <div class="form-group">
                    <label for="Title" class="col-sm-3 control-label">Title</label>
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
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover table-sortable tab_logic" DataKeyNames="KodeBuku" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AllowPaging="True">
              <Columns>
                   <asp:BoundField DataField="KodeBuku" HeaderText="Book Code" ReadOnly="True" SortExpression="KodeBuku" />
                   <asp:BoundField DataField="JudulBuku" HeaderText="Title" SortExpression="JudulBuku" />
                   <asp:BoundField DataField="Kategori" HeaderText="Category" SortExpression="Kategori" />
                   <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" />
              </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ASPNETConnectionString %>" 
               SelectCommand="SELECT [KodeBuku], [JudulBuku], [Kategori], [Total] FROM [Master_Buku]" 
               UpdateCommand = "UPDATE [Master_Buku] SET [JudulBuku]=@JudulBuku, [Kategori]=@Kategori, [Total]=@Total FROM [Master_Buku] WHERE [KodeBuku]=@KodeBuku"
               DeleteCommand =  "DELETE FROM [Master_Buku] WHERE [KodeBuku]=@KodeBuku" FilterExpression="KodeBuku LIKE '{0}%' OR JudulBuku LIKE '{0}%' OR Kategori LIKE '{0}%' OR CONVERT([Total],'System.String') LIKE '{0}%'">
               <FilterParameters>
                    <asp:ControlParameter Name="SearchBook" ControlID="txtSearch" />
                </FilterParameters>
        </asp:SqlDataSource>
</asp:Content>


