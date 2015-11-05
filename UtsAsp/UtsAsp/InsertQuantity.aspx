<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="InsertQuantity.aspx.cs" Inherits="UtsAsp.InsertQuantity" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Heading Row -->
        <div class="form-horizontal" id="FormPassword" role="form" runat="server">
                <h2 >Add Quantity</h2>
                <div class="form-group">
                    <label for="BookCode" class="col-sm-3 control-label" >Book Code</label>
                    <div class="col-sm-9">
                        <asp:TextBox ID="BookCode" runat="server"  CssClass="form-control" 
                            required="required" />
                    </div>
                </div>
                <div class="form-group">
                    <label for="Quantity" class="col-sm-3 control-label">Quantity</label>
                    <div class="col-sm-9">
                        <asp:TextBox ID="Quantity" runat="server"  CssClass="form-control" 
                            required="required" TextMode="Number" />
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-7 col-sm-offset-3">
                        <asp:Button runat="server" ID="BtnSave" Text="Save" 
                          OnClick="BtnSave_Click"   CssClass="btn btn-primary btn-block"></asp:Button>
                    </div>
                </div>
                <div class="form-group">
                    <div class="col-sm-9 col-sm-offset-3">
                        <asp:Label ID="lbl_error" runat="server" CssClass="col-sm-9"></asp:Label>
                    </div>
                </div>
            </div> <!-- /form -->
        <!-- /.row -->
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover table-sortable tab_logic" DataKeyNames="KodeBuku" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" AllowPaging="True">
              <Columns>
                   <asp:BoundField DataField="KodeBuku" HeaderText="Book Code" ReadOnly="True" SortExpression="KodeBuku" />
                   <asp:BoundField DataField="JudulBuku" HeaderText="Title" SortExpression="JudulBuku" />
                   <asp:BoundField DataField="Kategori" HeaderText="Category" SortExpression="Kategori" />
                   <asp:BoundField DataField="Total" HeaderText="Total" SortExpression="Total" />
                   <asp:CommandField ShowEditButton="True" ButtonType="Button" />
              </Columns>
        </asp:GridView>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ASPNETConnectionString %>" 
               SelectCommand="SELECT [KodeBuku], [JudulBuku], [Kategori], [Total] FROM [Master_Buku]" 
               UpdateCommand = "UPDATE [Master_Buku] SET [JudulBuku]=@JudulBuku, [Kategori]=@Kategori, [Total]=@Total FROM [Master_Buku] WHERE [KodeBuku]=@KodeBuku"
               DeleteCommand =  "DELETE FROM [Master_Buku] WHERE [KodeBuku]=@KodeBuku"
        ></asp:SqlDataSource>
        
</asp:Content>
