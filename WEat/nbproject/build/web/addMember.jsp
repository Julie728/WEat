<%-- 
    Document   : addMember
    Created on : Apr 14, 2014, 2:14:30 AM
    Author     : Doris
--%>

<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"
        import="edu.pitt.domain.User"
        import="edu.pitt.domain.Group"
        %>
<!DOCTYPE html>
<html>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Member</title>
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/signin.css" rel="stylesheet">
    </head>
    <body>
        <div class="container">

                <div class="header">
                <center>
                <h3 class="text-muted">WEat</h3>
                </center>
                </div>
            
            <div>
		

                    <center>
                    <h2 class="form-login-heading">Add Member</h2>
                    </center>
                    <form class="form-login" action="AddMember" method ="POST">
                    <% int userID = 0;
                       String groupID = "";
                       if (request.getParameter("userID") != null && request.getParameter("groupID") != null) {
                           userID = Integer.parseInt(request.getParameter("userID"));
                           groupID = request.getParameter("groupID");
                           System.out.println(groupID);
                           Group curGroup= new Group(userID,groupID);
                           
                           System.out.println(curGroup.getGroupName());
                           
                    %>
                                 
                    
                    <input type="hidden" name="groupID" value="<%=curGroup.getGroupID()%>"/>
                    <input type="hidden" name="groupName" value="<%=curGroup.getGroupName()%>"/>
                    <input type="hidden" name="curUserID" value="<%=userID%>"/>
                    <label>Enter new member's email:</label><br>
                    <input type="text" name="newEmail" class="form-control" placeholder="New Member's email" required autofocus>
                     
<!--                    <input type="text" name="userID" class="form-control" placeholder="userID" required autofocus>-->
                    <button class="btn btn-lg btn-primary btn-block" type="submit" value="submit">Add</button>
                    <a href="group.jsp" class="btn btn-lg btn-primary btn-block active" role="button">Cancel</a>
                    </form>
                    
                    <%
                          }
                       
                       
                    %> 
                </div>
                
            </div>
        
        
    </body>
    
    <script src="js/transition.js" type="text/javascript"></script>
</html>
