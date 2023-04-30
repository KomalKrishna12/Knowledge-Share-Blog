<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="java.util.*" %>
<%@page import="com.tech.blog.entities.Post" %>

<div class="row">
    <%
        User uu = (User) session.getAttribute("currentUser");
        Thread.sleep(500);
        PostDao pdao = new PostDao(ConnectionProvider.getConnection());

        int cid = Integer.parseInt(request.getParameter("cid"));

        List<Post> list = null;
        if (cid == 0) {
            list = pdao.getAllPosts();
        } else {
            list = pdao.getPostByCatId(cid);
        }

        if (list.size() == 0) {
            out.println("<h4 class='display-3 text-center'>No posts in this category</h4>");
        }

        for (Post p : list) {
    %>
    <div class="col-md-6 mt-2">
        <div class="card">
            <img class="card-img-top" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap">
            <div class="card-body">
                <b><%= p.getpTitle()%></b>
                <p><%= p.getpContent()%></p>
            </div>

            <div class="card-footer primary-background text-center">

                <%
                    LikeDao ldao = new LikeDao(ConnectionProvider.getConnection());
                %>

                <a href="#!" onclick="doLike(<%= p.getPid()%>,<%= uu.getId()%>)" class="btn btn-outline-light btn-sm "><i class="fa fa-thumbs-o-up"></i><span class="like-counter"><%= ldao.countLikeOnPost(p.getPid())%></span></a>
                <a href="#!" class="btn btn-outline-light btn-sm "><i class="fa fa-commenting-o"></i><span>20</span></a>
                <a href="show_blog_page.jsp?post_id=<%= p.getPid()%>" class="btn btn-outline-light btn-sm ">Read more...</a>
            </div>
        </div>
    </div>
    <%
        }

    %>

</div>
    