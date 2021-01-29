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
import javax.servlet.RequestDispatcher;

/**
 *
 * @author user
 */
@WebServlet(urlPatterns = {"/loginValidate"})
public class loginValidate extends HttpServlet {

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
                Connection Con = null;
                Statement Stmt = null;
                ResultSet RS = null;
           
                Con = DriverManager.getConnection(url, user, password);
                Stmt = Con.createStatement();

                String username = request.getParameter("username");
                String userPassword = request.getParameter("password");

                RS = Stmt.executeQuery("SELECT * FROM user WHERE userName='" + username + "' AND Password='" + userPassword + "';");

                if (RS.isBeforeFirst()) {

                    HttpSession session = request.getSession(true);
                    session.setAttribute("session_username", username);
                    RS = Stmt.executeQuery("SELECT * FROM student WHERE user_userName='" + username + "';");
                    if (RS.isBeforeFirst()) {

                        String type = "student";
                        session.setAttribute("session_userType", type);

                    } else {

                        String type = "staff";
                        session.setAttribute("session_userType", type);

                    }

                    RS.close();
                    Stmt.close();
                    Con.close();

                } else {
                    out.print("wrong email or password");
                }

            } catch (Exception e) {
                out.print(e);
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
