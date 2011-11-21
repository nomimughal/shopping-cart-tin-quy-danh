/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package hp;

import javax.servlet.ServletContext;

/**
 *
 * @author CongDanh
 */
public class helper {
    public static java.sql.Connection getConnection(ServletContext context) {
        try {
            java.util.Properties pr = new java.util.Properties();
            java.io.InputStream is = context.getResourceAsStream("/WEB-INF/config.properties");
            pr.load(is);
            String driver = pr.getProperty("driver");
            String url = pr.getProperty("url");
            is.close();
            Class.forName(driver);
            return java.sql.DriverManager.getConnection(url);
        } catch (Exception e) {
            return null;
        }
    }
//    public static java.util.TreeSet getAllComment(ServletContext context,String catID){
//        try {
//            java.sql.Connection con = getConnection(context);
//            java.sql.PreparedStatement pSt = con.prepareStatement("select * from tblComment where catID=? and not exists (select * from tblCommentRelative where tblCommentRelative.parentCommentID = tblComment.cmtID)");
//            pSt.setString(1, catID);
//            java.sql.ResultSet rs = pSt.executeQuery();
//            java.util.TreeSet ts = new java.util.TreeSet();
//            ts.
//        } catch (SQLException ex) {
//            Logger.getLogger(helper.class.getName()).log(Level.SEVERE, null, ex);
//        }
//    }
}
