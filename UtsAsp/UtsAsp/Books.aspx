<%@ Page Title="" Language="C#" MasterPageFile="~/Member.Master" AutoEventWireup="true" CodeBehind="Books.aspx.cs" Inherits="UtsAsp.Books" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <asp:DataList ID="DataList1" runat="server" RepeatColumns="3" RepeatDirection="Horizontal"
     Width="100%" BorderColor="Black" BorderStyle="Solid" BorderWidth="3px">
    
   <ItemTemplate>
      <asp:Label ID="Label1" runat="server" Text='<%# Eval("JudulBuku") %>' Font-Bold="True" Font-Size="1.2em" ForeColor="Navy"/><br />
      <asp:Label ID="Label2" runat="server" Text='<%# Eval("Kategori") %>' Font-Italic="true"/><br /> 
      <asp:Label ID="Label3" runat="server" Text='<%# "Stok: " +System.Convert.ToString(Eval("Total")) %>' Font-Bold="True" Font-Size="1.2em" ForeColor="Navy"/><br />
      <asp:Image ID="Image1" runat="server" ImageUrl='<%# "GetImageDatafromDB.aspx?KodeBuku=" + System.Convert.ToString(Eval("KodeBuku")) %>'/>
   </ItemTemplate>
   <ItemStyle HorizontalAlign="Center" VerticalAlign="Top"  />
</asp:DataList>
</asp:Content>
