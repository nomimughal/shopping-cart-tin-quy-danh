/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author CongDanh
 */
public class utility extends HttpServlet {

    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/xml;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter out = response.getWriter();
        try {
            String catID = request.getParameter("catID");
            String email = request.getParameter("customerEmail");
            String comment = request.getParameter("txtAddedContent");
            java.sql.Connection con = hp.helper.getConnection(getServletContext());
            java.sql.PreparedStatement pSt = con.prepareStatement("select customerID from tblCustomer where email=?");
            java.sql.ResultSet rs = pSt.executeQuery();
            if (!rs.next()) {
                pSt = con.prepareStatement("insert into tblCustomer (customerName,email) values(?,?)");
                pSt.setNString(1, request.getParameter("customerName"));
                pSt.setString(2, email);
                pSt.execute();
                pSt = con.prepareStatement("select customerID from tblCustomer where email=?");
                rs = pSt.executeQuery();
                rs.next();
            }
            int customerID = rs.getInt(1);
            pSt = con.prepareStatement("insert into tblComment (catID,customerID,timeComment,comment)"
                    + " values(?,?,getdate(),?)");
            pSt.setString(1, catID);
            pSt.setInt(2, customerID);
            pSt.setNString(3, comment);
            String parentCmtID = request.getParameter("parentCmtID");
            if (parentCmtID != null && parentCmtID.isEmpty()) {
                //reply
                pSt = con.prepareStatement("select cmtID from tblComment where catID=? and customerID=? and comment like ?");
                rs = pSt.executeQuery();
                rs.next();
                int childCmtID = rs.getInt(1);
                pSt = con.prepareStatement("insert into tblCommentRelative (parentCommentID,childCommentID) values(?,?)");
                pSt.setString(1, parentCmtID);
                pSt.setInt(2, childCmtID);
                pSt.execute();
            }
        } catch (SQLException ex) {
            Logger.getLogger(utility.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            response.sendRedirect(request.getContextPath());
            out.close();
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
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
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
