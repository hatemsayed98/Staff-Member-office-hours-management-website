<%-- 
    Document   : findSubjectAjax
    Created on : Jan 1, 2021, 7:22:35 PM
    Author     : LENOVO
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import ="java.io.PrintWriter"%>
<%@page import ="java.io.StringWriter" %>
<%@page import=" javax.servlet.http.HttpSession"%>
 <%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);

  if(session.getAttribute("session_username")==null)
      response.sendRedirect("index.jsp");
  else{

  %> 
<%

    String url = "jdbc:mysql://localhost:3306/internetproject";
    String user = "root";
    String password = "root";
  
    Connection Con = null;
    Statement Stmt = null;
    ResultSet RS = null;
    
    String userName = request.getParameter("myInput");
    String myType=session.getAttribute("session_userType").toString();
    

    try {
        Con = DriverManager.getConnection(url, user, password);
        Stmt = Con.createStatement();
        String line=null;
        if(myType.equals("student")){
              line ="SELECT userName,userEmail FROM user inner join staff on user.userName=staff.user_userName And user.userName=" + "'" + userName + "'";
        }
        else{
             line ="SELECT userName,userEmail FROM user inner join student on user.userName=student.user_userName And user.userName=" + "'" + userName + "'";
        }

      try{
        RS = Stmt.executeQuery(line);}
      catch (SQLException ex) {
                    StringWriter sw = new StringWriter();
                    PrintWriter pw = new PrintWriter(sw);
                    ex.printStackTrace(pw);
                    String stackTrace = sw.toString();
                    String replace = stackTrace.replace(System.getProperty("line.separator"), "<br/>\n");
                    out.println(replace);
                }




%>
<table>
    <tr class="header">
        <th style="width:50%;background-color: #f1f1f1;">Name</th>
        <th style="width:50%;">Email</th>

    </tr>
    <%
        while (RS.next()) {%>
    <tr>
        <td>
            <%

                out.print(RS.getString("userName"));
            %>
        </td>
        <td>
            <%
                out.print(RS.getString("userEmail"));
            %>
        </td>
    </tr>
    <%}%>

</table>


<%} catch (Exception cnfe) {
        System.err.println("Exception: " + cnfe);
    }
%>

<%} %>