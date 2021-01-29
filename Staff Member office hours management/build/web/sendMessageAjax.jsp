<%-- 
    Document   : sendMessageAjax
    Created on : Jan 13, 2021, 12:53:36 AM
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

    String content = request.getParameter("content");
    String time=request.getParameter("time");


%>

<div class="d-flex justify-content-end mb-4">
    <div class="msg_cotainer_send">
        <%= content%>
        <span class="msg_time"  style="  position: absolute; width: 100px;  right:-5px;  bottom: -15px; color: rgba(255,255,255,0.5); font-size: 10px;"><%= time%></span>

    </div>
</div>
        
 <% } %> 