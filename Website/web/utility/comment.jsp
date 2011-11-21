<%-- 
    Document   : comment
    Created on : Nov 20, 2011, 2:51:12 PM
    Author     : CongDanh
--%>
<%@page import="java.sql.Time"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<jsp:declaration>

</jsp:declaration>
<script src="../javascript/AjaxRequest.js" type="text/javascript" language="javascript"></script>
<script src="../javascript/vietUni.js" type="text/javascript" language="javascript" ></script>
<%
            try {
                java.sql.Connection con = hp.helper.getConnection(getServletContext());
                java.sql.PreparedStatement pSt = con.prepareStatement("select * from tblComment where catID=? and not exists (select * from tblCommentRelative where tblCommentRelative.parentCommentID = tblComment.cmtID)");
                pSt.setString(1, request.getParameter("catID"));
                java.sql.ResultSet rs = pSt.executeQuery();
                while (rs.next()) {
                    String cmt = rs.getNString("comment");
                    int cmtID = rs.getInt("cmtID");
                    Date date = rs.getDate("timeComment");
                    Time time = rs.getTime("timeComment");
                    int cusID = rs.getInt("customerID");
                    pSt = con.prepareStatement("select customerName from tblCustomer where customerID = " + cusID);
                    String name = pSt.executeQuery().getNString(1);
%>
<div clasd="parent">
    V�o l�c <%= time.toString()%> ng�y <%= date%>, <%= name%> ?� vi?t:
    <br/>
    <%= cmt%>

</div>

<%
                    pSt = con.prepareStatement("select * from tblComment where cmtID in (select childCommentID from tblCommentRelative where parentCommentID =?)");
                    pSt.setInt(1, cmtID);
                    java.sql.ResultSet rs1 = pSt.executeQuery();
                    while (rs.next()) {
                        cmt = rs.getNString("comment");
                        date = rs.getDate("timeComment");
                        time = rs.getTime("timeComment");
                        cusID = rs.getInt("customerID");
                        pSt = con.prepareStatement("select customerName from tblCustomer where customerID = " + cusID);
                        name = pSt.executeQuery().getNString(1);
%>
<div class="child">
    V�o l�c <%= time.toString()%> ng�y <%= date%>, <%= name%> ?� vi?t:
    <br/>
    <%= cmt%>
</div>
<%
                    }
%>
<div class="reply">
    <form name="frmReply" onsubmit="submitForm(this);return false;" action="uility">
        <div style="padding-top:0px;">
            <div style="padding-top:10px; width:476px; background-color:#ffffff">
                <div style="padding-bottom:5px; overflow:hidden;">
                    <div style="width:60%">
                        <input type="text" value="H? t�n" name="customerName" style="width:280px;" size="29" onfocus="NameOnFocus(this)" onblur="NameOnBlur(this)" onkeyup="initTyper(this)">
                    </div>
                    <div style="width:180px;">
                        <input type="text" value="Email" name="customerEmail" style="width:172px" size="29" onfocus="EmailOnFocus(this)" onblur="EmailOnBlur(this)">
                    </div>
                </div>
                <div style="overflow:hidden;">
                    <div style="width:60%">
                        <input type="submit" value="G?i To� so?n" name="B1">
                        <input type="button" value="Xo� tr?ng" name="B2" onclick="InputDefault();">
                        <input type="hidden" name="catID" value="<%=request.getParameter("catID")%>">
                        <input type="hidden" name="parentCmtID" value="<%= cmtID%>"
                    </div>
                    <div style="width:40%; text-align:right;">
                        <input type="radio" name="optInput" value="0" style="vertical-align:middle; margin-top:0px;" onfocus="setTypingMode(0)">
                        Off
                        <input type="radio" name="optInput" value="1" style="vertical-align:middle; margin-top:0px;" onfocus="setTypingMode(1)" checked="">
                        Telex
                        <input type="radio" name="optInput" value="2" style="vertical-align:middle; margin-top:0px;" onfocus="setTypingMode(2)">
                        VNI
                        <input type="radio" name="optInput" value="3" style="vertical-align:middle; margin-top:0px;" onfocus="setTypingMode(3)">
                        VIQR
                    </div>
                </div>
            </div>
            <div style="padding-top:0px;">
                <textarea rows="10" name="txtAddedContent" cols="43" onkeyup="initTyper(this)" class="SForm" style="width: 470px"></textarea>
            </div>
        </div>
    </form>
</div>
<%
                }

%>



<!-- form comment -->
<form method="post" name="frmComment" target="_blank" onsubmit="submitForm(this);return false;" action="uility">
    <div style="padding-top:0px;">
        <div style="padding-top:10px; width:476px; background-color:#ffffff">
            <div style="padding-bottom:5px; overflow:hidden;">
                <div style="width:60%">
                    <input type="text" value="H? t�n" name="customerName" style="width:280px;" size="29" onfocus="NameOnFocus(this)" onblur="NameOnBlur(this)" onkeyup="initTyper(this)">
                </div>
                <div style="width:180px;">
                    <input type="text" value="Email" name="customerEmail" style="width:172px" size="29" onfocus="EmailOnFocus(this)" onblur="EmailOnBlur(this)">
                </div>
            </div>
            <div style="overflow:hidden;">
                <div style="width:60%">
                    <input type="submit" value="G?i To� so?n" name="B1">
                    <input type="button" value="Xo� tr?ng" name="B2" onclick="InputDefault();">
                    <input type="hidden" name="catID" value="<%=request.getParameter("catID")%>">
                </div>
                <div style="width:40%; text-align:right;">
                    <input type="radio" name="optInput" value="0" style="vertical-align:middle; margin-top:0px;" onfocus="setTypingMode(0)">
                    Off
                    <input type="radio" name="optInput" value="1" style="vertical-align:middle; margin-top:0px;" onfocus="setTypingMode(1)" checked="">
                    Telex
                    <input type="radio" name="optInput" value="2" style="vertical-align:middle; margin-top:0px;" onfocus="setTypingMode(2)">
                    VNI
                    <input type="radio" name="optInput" value="3" style="vertical-align:middle; margin-top:0px;" onfocus="setTypingMode(3)">
                    VIQR
                </div>
            </div>
        </div>
        <div style="padding-top:0px;">
            <textarea rows="10" name="txtAddedContent" cols="43" onkeyup="initTyper(this)" class="SForm" style="width: 470px"></textarea>
        </div>
    </div>
</form>

<script type="text/javascript">
    function submitForm(theform){
        document.frmComment.customerName.value = Trim(document.frmComment.customerName.value);
        if (document.frmComment.customerName.value == '' || document.frmComment.customerName.value == 'H? t�n')
        {
            alert('Xin hay nhap Ho ten!');
            document.frmComment.customerName.focus();
            return;
        }

        if ((SEmail = CheckEmailAddress(document.frmComment.customerEmail.value))=='')
        {
            alert('Dia chi Email khong hop le!');
            document.frmComment.customerEmail.focus();
            return;
        }

        document.frmComment.customerEmail.value = SEmail;
        document.frmComment.txtAddedContent.value = Trim(document.frmComment.txtAddedContent.value);
        if (document.frmComment.txtAddedContent.value == '')
        {
            alert('Xin hay nhap Noi dung!');
            document.frmComment.txtAddedContent.focus();
            return;
        }

        if (!confirm('Gui yeu cau?'))
            return;

        var status = AjaxRequest.submit(
        theform
        ,{
            'onSuccess':function(req){
                    alert('chung toi da ghi nhan y kien cua ban, y kien dang qua trinh kiem tra');
                    InputDefault();
            }
            ,'onError':function(req){
                alert('co loi xay ra khi dang y kien cua ban');
            }
        }
    );
        return status;
    }
    function InputDefault() {
        document.frmComment.customerName.value = 'H? t�n';
        document.frmComment.customerEmail.value = 'Email';
        document.frmComment.txtAddedContent.value = '';
        document.frmComment.txtAddedContent.focus();
    }
    function NameOnFocus(field)
    {
        if(field.value=='H? t�n'){ field.value = '';}
    }

    function NameOnBlur(field)
    {
        if(field.value==''){ field.value='H? t�n';}
    }

    function EmailOnFocus(field)
    {
        if(field.value=='Email'){ field.value = '';}
    }

    function EmailOnBlur(field)
    {
        if(field.value==''){ field.value='Email';}
    }
    function Trim(iStr)
    {
        while (iStr.charCodeAt(0) <= 32)
        {
            iStr=iStr.substr(1);
        }

        while (iStr.charCodeAt(iStr.length - 1) <= 32)
        {
            iStr=iStr.substr(0, iStr.length - 1);
        }

        return iStr;
    }
    function CheckEmailAddress(Email)
    {
        Email = Trim(Email);

        while (Email != '')
        {
            c = Email.charAt(0);
            if (c==' ' || c=='<' || c==39 || c==':' || c=='.')
            {
                Email = Email.substr(1);
            }
            else
            {
                break;
            }
        }

        i = Email.indexOf('>');
        if (i==-1)
        {
            while (Email != '')
            {
                c = Email.charAt(Email.length - 1);
                if (c==' ' || c==39 || c=='.')
                {
                    Email = Email.substr(0, Email.length - 1);
                }
                else
                {
                    break;
                }
            }
        }
        else
        {
            Email = Email.substr(0, i);
        }

        if (Email.length > 96)
            return '';

        i = Email.lastIndexOf('@');
        j = Email.lastIndexOf('.');
        if (i < j)
            i = j;

        switch (Email.length - i - 1)
        {
            case 2:
                break;
            case 3:
                switch (Email.substr(i).toLowerCase())
                {
                    case '.com':
                    case '.net':
                    case '.org':
                    case '.edu':
                    case '.mil':
                    case '.gov':
                    case '.biz':
                    case '.pro':
                    case '.int':
                        break;
                    default:
                        return '';
                }
                break;
            default:
                switch (Email.substr(i).toLowerCase())
                {
                    case '.name':
                    case '.info':
                        break;
                    default:
                        return '';
                }
                break;
        }

        Email = Email.toLowerCase();

        if (Email == '')
            return '';

        if (Email.indexOf(' ') != -1)
            return '';

        if (Email.indexOf('..') != -1)
            return '';

        if (Email.indexOf('.@') != -1)
            return '';

        if (Email.indexOf('@.') != -1)
            return '';

        if (Email.indexOf(':') != -1)
            return '';

        for (i=0; i < Email.length; i++)
        {
            c = Email.charAt(i);

            if (c >= '0' && c <= '9')
                continue;

            if (c >= 'a' && c <= 'z')
                continue;

            if ('`~!#$%^&*-_+=?/\\|@.'.indexOf(c) != -1)
                continue;

            return '';
        }

        if ((i=Email.indexOf('@'))==-1)
            return '';

        if (Email.substr(i + 1).indexOf('@')!=-1)
            return '';

        if (Email.charAt(0)=='.' || Email.charAt(Email.length - 1)=='.')
            return '';

        return Email;
    }


</script>
<%
            } catch (java.sql.SQLException ex) {
                Logger.getLogger(hp.helper.class.getName()).log(Level.SEVERE, null, ex);
            }
%>