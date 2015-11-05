<%@ Page Title="" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="LoanReport.aspx.cs" Inherits="UtsAsp.LoanReport" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="form-horizontal" id="Div1" role="form" runat="server">
            <h2>Loan Report</h2>
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
     <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover table-sortable tab_logic" DataKeyNames="IdPinjam" DataSourceID="SqlDataSource3">
            <Columns>
                <asp:BoundField DataField="IdPinjam" HeaderText="Loan ID" InsertVisible="False" ReadOnly="True" SortExpression="IdPinjam" />
                <asp:BoundField DataField="KodeBuku" HeaderText="Book Code" SortExpression="KodeBuku" />
                <asp:BoundField DataField="JudulBuku" HeaderText="Book Title" SortExpression="JudulBuku" />
                <asp:BoundField DataField="IdMember" HeaderText="Member ID" SortExpression="IdMember" />
                <asp:BoundField DataField="NamaMember" HeaderText="Member Name" SortExpression="NamaMember" />
                <asp:BoundField DataField="TglPinjam" HeaderText="Loan Date" SortExpression="TglPinjam" />
                <asp:BoundField DataField="TglKembali" HeaderText="Return Date" SortExpression="TglKembali" />
                <asp:BoundField DataField="Status" HeaderText="Status" SortExpression="Status" />
            </Columns>
     </asp:GridView>
     <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:ASPNETConnectionString %>" 
         SelectCommand="SELECT Transaksi_Pinjam.IdPinjam, Transaksi_Pinjam.KodeBuku, Master_Buku.JudulBuku , Transaksi_Pinjam.IdMember, Member.NamaMember, Transaksi_Pinjam.TglPinjam, Transaksi_Pinjam.TglKembali, Transaksi_Pinjam.Status FROM Master_Buku INNER JOIN Transaksi_Pinjam ON Master_Buku.KodeBuku = Transaksi_Pinjam.KodeBuku INNER JOIN Member ON Transaksi_Pinjam.IdMember = Member.IdMember" FilterExpression="CONVERT([IdPinjam],'System.String') LIKE '{0}%' OR KodeBuku LIKE '{0}%' OR JudulBuku LIKE '{0}%' OR CONVERT([IdMember],'System.String') LIKE '{0}%' OR NamaMember LIKE '{0}%' OR CONVERT([TglPinjam],'System.String') LIKE '{0}%' OR CONVERT([TglKembali],'System.String') LIKE '{0}%' OR Status LIKE '{0}%'">
        <FilterParameters>
              <asp:ControlParameter Name="SearchBook" ControlID="txtSearch" />
        </FilterParameters>
     </asp:SqlDataSource>
</asp:Content>

