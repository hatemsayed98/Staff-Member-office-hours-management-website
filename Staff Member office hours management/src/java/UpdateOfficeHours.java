/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author LENOVO
 */
@WebServlet(urlPatterns = {"/UpdateOfficeHours"})
public class UpdateOfficeHours extends HttpServlet {

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

                PreparedStatement preStmt = null;

                HttpSession session = request.getSession(true);
                Con = DriverManager.getConnection(url, user, password);

                int OfficeID = Integer.parseInt(request.getParameter("officeID"));

                String slot = request.getParameter("slot");
                String from = request.getParameter("from");
                String to = request.getParameter("to");
                String type = request.getParameter("type");
                LocalDateTime date_from = LocalDateTime.parse(from);
                LocalDateTime dateTime_to = LocalDateTime.parse(to);

                if (date_from.isAfter(dateTime_to) || date_from.isEqual(dateTime_to)) {
                    out.print("<script type=text/javascript>"
                            + "alert('Wrong in time range');"
                            + "location='UpdateOfficeHoursForm.jsp';"
                            + "</script>");
                } else {

                    try {
                        String line = "UPDATE  officehours SET officehours.from=?,officehours.to=?,slot=?,type=? WHERE id=?";
                        preStmt = Con.prepareStatement(line);

                        preStmt.setString(1, from);
                        preStmt.setString(2, to);
                        preStmt.setString(3, slot);
                        preStmt.setString(4, type);
                        preStmt.setInt(5, OfficeID);
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
                            + "alert('Updated successfully');"
                            + "location='ManageOffice.jsp';"
                            + "</script>");

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
