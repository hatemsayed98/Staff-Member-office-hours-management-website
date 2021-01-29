/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;

/**
 *
 * @author user
 */
@WebServlet(urlPatterns = {"/updateUser"})
public class updateUser extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/internetproject";
                String user = "root";
                String password = "root";
                String Line;
                Connection Con = null;
                PreparedStatement Stmt = null;
                String userName = request.getSession().getAttribute("session_username").toString();
                String newEmail = request.getParameter("email");
                String newDisName = request.getParameter("displayName");
                String newPassword = request.getParameter("password");

                Con = DriverManager.getConnection(url, user, password);
                try {
                    Line = "UPDATE user SET userEmail=?,displayName=?,password=? WHERE userName=?";
                    Stmt = Con.prepareStatement(Line);
                    Stmt.setString(1, newEmail);
                    Stmt.setString(2, newDisName);
                    Stmt.setString(3, newPassword);
                    Stmt.setString(4, userName);
                    int Row = Stmt.executeUpdate();
                    if (Row == 0) {
                        out.print("not updated");
                    } else {
                        request.getSession().setAttribute("session_userEmail", newEmail);
                        out.println("<script type=\"text/javascript\">");
                        out.println("alert('done successfully');");
                        out.println("location='profile.jsp';");
                        out.println("</script>");
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
