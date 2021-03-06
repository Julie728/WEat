<%-- 
    Document   : workspaceTest
    Created on : 2014-4-11, 17:59:06
    Author     : Liu
--%>
<%@page import="java.util.Collections"%>
<%@page import="java.util.Comparator"%>
<%@page import="java.util.ArrayList"%>
<%@page import="edu.pitt.utilities.*"%>
<%@page import="edu.pitt.domain.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%

    Workspace myWorkspace;
    int userID = 0;
    User user = null;
    Group group = null;
    Group curGroup = null;
    String groupID = null;

//    userID = 2;
//    groupID = "4795d862-23ca-42bc-88b0-59ff65dad359";
//    groupID = "d9cb3258-df24-4eaa-ad51-e73c23765872";
    //check if user is valid
    if (request.getParameter("userID") == null) {
        response.sendRedirect("login.jsp?error=Invalid user!");
    } else {
        userID = Integer.parseInt((String) request.getParameter("userID"));
        user = new User(userID);
        if (user.isValid() == false) {
            response.sendRedirect("login.jsp?error=Invalid user!");
        }
    }
    groupID = (String) request.getParameter("groupID");
    group = new Group(userID);
    curGroup = new Group(userID, groupID);
    ArrayList<Group> groupList = group.getGroupList();
    myWorkspace = new Workspace(userID, groupID);

    //if Button addComment  is clicked
    if (request.getParameter("btnAddComment") != null && request.getParameter("txtComment") != null && request.getParameter("selectedResultID") != null) {
        String txtComment = request.getParameter("txtComment");
        String selectedResultID = request.getParameter("selectedResultID");
        System.out.println("*_*_*_*_*_*_*_*selectedResultID = " + selectedResultID + "txtComment = " + txtComment);
        //insert the new commnet into database WEat.Comment
        Comment newComment = new Comment(selectedResultID, userID, groupID, txtComment);
        //update the commentList of the result by reloading from databse table  WEat.Comment 
        Result updateResult = new Result(selectedResultID, groupID);
        myWorkspace.getReultList().put(selectedResultID, updateResult);
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" cNo Sidebar - Telephasic by HTML5 UPontent="text/html; charset=UTF-8">
              <title>Workspace Page</title>
        <link href="css/bootstrap.css" rel="stylesheet">
        <link href="css/signin.css" rel="stylesheet">
        <meta http-equiv="content-type" content="text/html; charset=utf-8" />
        <meta name="description" content="" />
        <meta name="keywords" content="" />
        <link href="http://fonts.googleapis.com/css?family=Source+Sans+Pro:300,600" rel="stylesheet" type="text/css" />
        <script src="js/jquery.min.js"></script>
        <script src="js/jquery.dropotron.min.js"></script>
        <script src="js/skel.min.js"></script>
        <script src="js/skel-panels.min.js"></script>
        <script src="js/init.js"></script>
        <noscript>
        <link rel="stylesheet" href="css/skel-noscript.css" />
        <link rel="stylesheet" href="css/style.css" />
        <link rel="stylesheet" href="css/style-n1.css" />
        </noscript>
    </head>

    <body class="no-sidebar">

        <!-- Header Wrapper -->
        <div id="header-wrapper">

            <!-- Header -->
            <div id="header" class="container">

                <!-- Logo -->
                <h1 id="logo"><a href="index.jsp?userID=<%=userID%>&groupID=<%=groupID%>">WEat</a></h1>

                <!-- Nav -->
                <nav id="nav">
                    <ul>
                        <li>
                            <a href="viewGroup.jsp?userID=<%=userID%>&groupID=<%=groupID%>">Choose a Group</a>
                            <ul>
                                <%
                                    for (Group g : groupList) {
                                %>
                                <li><a href="workspace.jsp?userID=<%=userID%>&groupID=<%=g.getGroupID()%>"><%=g.getGroupName()%></a></li>
                                    <%
                                            //   out.println("<li><a href='workspace.jsp?userID=" + userID +"&groupID='" + g.getGroupID()+"'>" + g.getGroupName() + "</a></li>");
                                        }
                                    %>
                            </ul>
                        </li>
                        <li class="break"><a href="search.jsp?userID=<%=userID%>&groupID=<%=groupID%>">Search</a></li>
                    </ul>
                </nav>
            </div>
        </div>

        <!-- Main Wrapper -->
        <div class="wrapper">

            <div class="container">
                <div class="row" id="main">
                    <div class="12u">

                        <!-- Content -->
                        <article id="content">
                            <header class="major">
                                <h2><a href="workspace.jsp?userID=<%=userID%>&groupID=<%=groupID%>"><%=curGroup.getGroupName()%></a> Workspace</h2>
                                <span >Sharing and interacting  with friends.
                                    <%
   //                                     out.println("My workspace: userID = " + myWorkspace.getUserID() + ", groupID = " + myWorkspace.getGroupID() + ", resultList = " + myWorkspace.getReultList() + "<br><br>");
                                    %>
                                </span>
                            </header> 
                            <%
                                if (myWorkspace.getReultList().size() != 0) {

//sort resultList based on the number of user likes
                                    //more users like a result, the higher a result ranks
                                    ArrayList<Result> results = new ArrayList(myWorkspace.getReultList().values());

                                    class resultComparator implements Comparator<Result> {

                                        @Override
                                        public int compare(Result a, Result b) {
                                            return a.getUserList().size() > b.getUserList().size() ? -1 : a.getUserList().size() == b.getUserList().size() ? 0 : 1;
                                        }
                                    }

                                    Collections.sort(results, new resultComparator());

                                    for (int i = 0; i < results.size(); i++) {
                                        String resultID = results.get(i).getResultID();
                            %>           
                            <div class="row features">
                                <section class="2u feature">&nbsp;</section>
                                <section class="8u feature">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <header><h2><a href='http://www.yelp.com/biz/<%=results.get(i).getResultID()%>'><%=results.get(i).getResultName()%></a></h2></header>
                                        </div>
                                        <!--<p>liked by <%=results.get(i).userListToString()%> </p>-->
                                        <span>liked by <%=results.get(i).userListToString()%></span>
                                        <div class="panel-body">

                                            <table class="table table-hover">
                                                <%
                                                    ArrayList<Comment> commentList = results.get(i).getCommentList();
                                                    if (commentList.size() > 0) {

                                                        for (Comment c : commentList) {
                                                            String userName = "";
                                                            String commentText = "";
                                                            //if a user in the userList
                                                            if (results.get(i).getUserList().containsKey(c.getUserID())) {
                                                                userName = results.get(i).getUserList().get(c.getUserID()).getUserName();
                                                            } else//if not a user in the userList, retrieve username from database(WEat.user table)
                                                            {
                                                                User commentUser = new User(c.getUserID());
                                                                userName = commentUser.getUserName();

                                                            }
                                                            commentText = c.getCommentText();
                                                            //    s.append(userName + " : " + c.getCommentText() + "<br>");
                                                %>  
                                                <tr>
                                                    <td><%=userName%>:</td>
                                                    <td><%=commentText%></td>
                                                </tr>
                                                <%
                                                        }
                                                    }
                                                %>
                                            </table>

<!--                                 <p><%=results.get(i).commenListToString()%></p> -->

                                            <form id="formComment" name= "formComment" method="post" action="workspace.jsp">
                                                <ul class="actions">
                                                    <li><input type="text" class="text" name="txtComment" id="txtComment"  placeholder="Add comment..." required  value=""/></li>
                                                    <li><button type="submit" class="button" name="btnAddComment" id="btnAddComment" value = "Add">
                                                            <span class="glyphicon glyphicon-plus"></span>
                                                        </button><li>
                                                </ul>  

                                                <input type="hidden" name="selectedResultID" id="selectedResultID" value="<%=resultID%>">
                                                <input type="hidden" name="userID" value="<%=userID%>">
                                                <input type="hidden" name="groupID" value="<%=groupID%>">
                                            </form>
                                        </div>
                                </section>
                                <section class="2u feature">&nbsp;</section>
                            </div>

                            <%                    }//end of for

                            }//end of if
                            else {
                            %>

                            <p align="center">This group has not share anything yet.</p>.

                            <%
                                }//end of else
                            %> 




                        </article>
                    </div>
                </div>

            </div>
        </div>


        <!-- Footer Wrapper -->
        <div id="footer-wrapper">

            <!-- Footer -->
            <div id="footer" class="container">
                <header class="major">
                    <h2>WEat</h2>
                    <span>Collaborative Workspace<br />
                        <%--<%=curGroup.getGroupName()%>--%>
                    </span>
                </header>

            </div>

            <!-- Footer Wrapper -->
            <!-- Copyright -->
            <div id="copyright" class="container">
            <ul class="menu">
                <li>&copy; Group Member: Jun Liu, Qianwen Li, Huan Wang.  All rights reserved.</li>
                <li>Design: Everyone</li>
            </ul>
            </div>

        </div>

    </body>
</html>
