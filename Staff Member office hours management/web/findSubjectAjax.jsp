<%-- 
    Document   : findSubjectAjax
    Created on : Jan 1, 2021, 7:22:35 PM
    Author     : LENOVO
--%>
 <%
  response.setHeader("Cache-Control","no-cache");
  response.setHeader("Cache-Control","no-store");
  response.setHeader("Pragma","no-cache");
  response.setDateHeader ("Expires", 0);

  if(session.getAttribute("session_username")==null)
      response.sendRedirect("index.jsp");

  %> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.Date"%>
<%@page import="javax.servlet.http.HttpSession" %>
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
    String Line;
    Connection Con = null;
    Statement Stmt = null;
    ResultSet RS = null;
    String subjecName = request.getParameter("myInput");

    try {
        Con = DriverManager.getConnection(url, user, password);
        Stmt = Con.createStatement();

        String line = "SELECT  user_userName,type  FROM staff  inner join staff_has_subject on staff_has_subject.staff_id=staff.id AND staff_has_subject.subject_name=" + "'" + subjecName + "'" + "inner join user on user.userName=user_userName;   ";
        RS = Stmt.executeQuery(line);%>
<table>
    <tr class="header">
        <th style="width:50%;background-color: #f1f1f1;">Name</th>
        <th style="width:50%;">Type</th>

    </tr>
    <%
        while (RS.next()) {%>
    <tr>
        <td>
            <%

                out.print(RS.getString("user_userName"));
            %>
        </td>
        <td>
            <%
                out.print(RS.getString("type"));
            %>
        </td>
    </tr>
    <%}%>

</table>


<%} catch (Exception cnfe) {
        System.err.println("Exception: " + cnfe);
    }}
%>
