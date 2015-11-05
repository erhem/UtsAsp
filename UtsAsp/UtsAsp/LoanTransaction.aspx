<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="LoanTransaction.aspx.cs" Inherits="UtsAsp.LoanTransaction" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <!-- Heading Row -->
        <div class="form-horizontal" id="FormPassword" role="form" runat="server">
                <h2 >Loan Transaction</h2>
                <div class="form-group">
                    <label for="BookCode" class="col-sm-3 control-label upupup" >Book Code</label>
                    <div class="col-sm-9">
                        <asp:DropDownList ID="BookCode" runat="server" required="required" DataSourceID="SqlDataSource1" DataTextField="KodeBuku" DataValueField="KodeBuku" ></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ASPNETConnectionString %>" SelectCommand="SELECT [KodeBuku] FROM [Master_Buku]"></asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                    <label for="MemberID" class="col-sm-3 control-label upupup">Member ID</label>
                    <div class="col-sm-9">
                       <asp:DropDownList ID="MemberID" runat="server" required="required" DataSourceID="SqlDataSource2" DataTextField="IdMember" DataValueField="IdMember"  ></asp:DropDownList>
                        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:ASPNETConnectionString %>" SelectCommand="SELECT [IdMember] FROM [Member] WHERE [Posisi]='Member'"></asp:SqlDataSource>
                    </div>
                </div>
                <div class="form-group">
                    <label for="ReturnDate" class="col-sm-3 control-label upupup">Return Date</label>
                    <div class="col-sm-9">
                        <asp:Calendar ID="ReturnDate" runat="server" ></asp:Calendar>
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
                        <asp:Label ID="lbl_error" runat="server" CssClass="col-sm-9" ForeColor="#FF3300"></asp:Label>
                    </div>
                </div>
            </div> <!-- /form -->
        <!-- /.row -->
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover table-sortable tab_logic" DataKeyNames="IdPinjam" DataSourceID="SqlDataSource3" OnRowDeleting="GridView1_RowDeleting">
            <Columns>
                <asp:BoundField DataField="IdPinjam" HeaderText="Loan ID" InsertVisible="False" ReadOnly="True" SortExpression="IdPinjam" />
                <asp:BoundField DataField="KodeBuku" HeaderText="Book Code" SortExpression="KodeBuku" />
                <asp:BoundField DataField="JudulBuku" HeaderText="Book Title" SortExpression="JudulBuku" />
                <asp:BoundField DataField="IdMember" HeaderText="Member ID" SortExpression="IdMember" />
                <asp:BoundField DataField="NamaMember" HeaderText="Member Name" SortExpression="NamaMember" />
                <asp:BoundField DataField="TglPinjam" HeaderText="Loan Date" SortExpression="TglPinjam" />
                <asp:BoundField DataField="TglKembali" HeaderText="Return Date" SortExpression="TglKembali" />
                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
                <asp:CommandField DeleteText="Clear" ShowDeleteButton="True" ButtonType="Button" />
            </Columns>
     </asp:GridView>
     <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ASPNETConnectionString %>" 
         SelectCommand="SELECT Transaksi_Pinjam.IdPinjam, Transaksi_Pinjam.KodeBuku, Master_Buku.JudulBuku , Transaksi_Pinjam.IdMember, Member.NamaMember, Transaksi_Pinjam.TglPinjam, Transaksi_Pinjam.TglKembali, Transaksi_Pinjam.Status FROM Master_Buku INNER JOIN Transaksi_Pinjam ON Master_Buku.KodeBuku = Transaksi_Pinjam.KodeBuku INNER JOIN Member ON Transaksi_Pinjam.IdMember = Member.IdMember Where Transaksi_Pinjam.Status='Progress'"
         DeleteCommand = "UPDATE [Transaksi_Pinjam] SET [Status]='Completed' WHERE [IdPinjam]=@IdPinjam" OnDeleted="SqlDataSource3_Deleted" >
     </asp:SqlDataSource>
</asp:Content>
