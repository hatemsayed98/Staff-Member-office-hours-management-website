/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.time.Instant;
import java.time.LocalDate;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import static java.time.format.DateTimeFormatter.ISO_LOCAL_DATE_TIME;
import java.util.Locale;

/**
 *
 * @author LENOVO
 */
@WebServlet(urlPatterns = {"/addOfficeHours"})
public class addOfficeHours extends HttpServlet {

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
                PreparedStatement preStmt = null;
                ResultSet RS = null;
                HttpSession session = request.getSession(true);

                String userName = session.getAttribute("session_username").toString();

                String slot = request.getParameter("slot");
                String from = request.getParameter("from");
                String type = request.getParameter("type");
                // out.println(from);
                String to = request.getParameter("to");
                LocalDateTime date_from = LocalDateTime.parse(from);
                LocalDateTime dateTime_to = LocalDateTime.parse(to);

                if (date_from.isAfter(dateTime_to) || date_from.isEqual(dateTime_to)) {
                    out.print("<script type=text/javascript>"
                            + "alert('Wrong in time range');"
                            + "location='ManageOffice.jsp';"
                            + "</script>");
                } else {
                    Con = DriverManager.getConnection(url, user, password);
                    Stmt = Con.createStatement();
                    RS = Stmt.executeQuery("SELECT id FROM staff WHERE user_userName=" + "'" + userName + "'");
                    RS.next();
                    String staffID = RS.getString("id");
                    try {
                        String line = "INSERT INTO officehours(officehours.from,officehours.to,slot,staff_id,type) VALUES(?,?,?,?,?);";
                        preStmt = Con.prepareStatement(line);

                        preStmt.setString(1, from);
                        preStmt.setString(2, to);
                        preStmt.setString(3, slot);

                        preStmt.setString(4, staffID);
                        preStmt.setString(5, type);
                        int Row = preStmt.executeUpdate();
                    } catch (SQLException ex) {
                        StringWriter sw = new StringWriter();
                        PrintWriter pw = new PrintWriter(sw);
                        ex.printStackTrace(pw);
                        String stackTrace = sw.toString();
                        String replace = stackTrace.replace(System.getProperty("line.separator"), "<br/>\n");
                        out.println(replace);
                    }

                    out.print("<script type=text/javascript>"
                            + "alert('Added successfully');"
                            + "location='ManageOffice.jsp';"
                            + "</script>");
                    Stmt.close();
                    Con.close();
                }
            } catch (Exception ex) {
                ex.printStackTrace();

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
