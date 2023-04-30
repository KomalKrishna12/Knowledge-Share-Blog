<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="java.text.DateFormat"%>
<%@page import="com.tech.blog.dao.UserDao"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page errorPage="error_page.jsp" %>
<%@page import="com.tech.blog.dao.PostDao" %>
<%@page import="java.util.*" %>
<%@page import="com.tech.blog.entities.Category" %>
<%
    User user = (User) session.getAttribute("currentUser");

    if (user == null) {
        response.sendRedirect("login_page.jsp");
    }
%>
<%
    int postId = Integer.parseInt(request.getParameter("post_id"));

    PostDao pDao = new PostDao(ConnectionProvider.getConnection());

    Post p = pDao.getPostByPostId(postId);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><%= p.getpTitle()%> || Knowledge Share Blog</title>
        <!--CSS-->
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/mystyle.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .banner-background{
                clip-path: polygon(30% 0%, 70% 0%, 100% 0, 100% 93%, 74% 100%, 24% 92%, 0 100%, 0 0);
            }

            .post-title{
                font-weight: 100;
                font-size: 30px;
            }

            .post-content{
                font-weight: 100;
                font-size: 25px;
            }

            .post-date{
                font-style: italic;
                font-weight: bold;
            }

            .post-user-info{
                font-size: 20px;
            }

            .row-user{
                border: 1px solid #e2e2e2;
                padding-top: 15px;
            }

            body{
                background: url(img/bg.jpeg);
                background-size: cover;
                background-attachment: fixed;
            }

        </style>

    <div id="fb-root"></div>
    <script async defer crossorigin="anonymous" src="https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v15.0&appId=527519912671944&autoLogAppEvents=1" nonce="0uEoYTpO"></script></head>
<body>

    <!--navbar start-->

    <nav class="navbar navbar-expand-lg navbar-dark primary-background">
        <a class="navbar-brand" href="index.jsp"><span class="fa fa-asterisk"></span> Knowledge Share Blog</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="profile.jsp"><span class="fa fa-home"></span> Home <span class="sr-only">(current)</span></a>
                </li>

                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                        <span class="fa fa-check-square-o"></span> Categories
                    </a>
                    <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                        <a class="dropdown-item" href="#">Programming language</a>
                        <a class="dropdown-item" href="#">Project implementation</a>
                        <div class="dropdown-divider"></div>
                        <a class="dropdown-item" href="#">Data structure</a>
                    </div>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#"><span class="fa fa-address-card-o"></span> Contact</a>
                </li>

                <li class="nav-item">
                    <a class="nav-link" href="#!" data-toggle="modal" data-target="#do-post-modal"><span class="fa fa-asterisk"></span> do Post</a>
                </li>


            </ul>

            <ul class="navbar-nav mr-right">
                <li class="nav-item">
                    <a class="nav-link" href="#!" data-toggle="modal" data-target="#profile-modal"><span class="fa fa-user-circle"></span> <%= user.getName()%></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="LogoutServlet"><span class="fa fa-power-off"></span> logout</a>
                </li>
            </ul>

        </div>
    </nav>

    <!--navbar end-->

    <!--main content of body-->

    <div class="container">

        <div class="row my-4">

            <div class="col-md-8 offset-md-2">

                <div class="card ">

                    <div class="card-header primary-background text-white">

                        <h4 class="post-title"><%= p.getpTitle()%></h4>

                    </div>

                    <div class="card-body">

                        <img class="card-img-top my-2" src="blog_pics/<%= p.getpPic()%>" alt="Card image cap">

                        <div class="row my-3 row-user">

                            <div class="col-md-8">
                                <% UserDao dao = new UserDao(ConnectionProvider.getConnection());%>
                                <p class="post-user-info"><a href="#!"><%= dao.getUserByUserId(p.getUserId()).getName()%></a> has posted : </p>
                            </div>

                            <div class="col-md-4">
                                <p class="post-date"><%= DateFormat.getDateTimeInstance().format(p.getpDate())%></p>
                            </div>

                        </div>

                        <p class="post-content"><%= p.getpContent()%></p>

                        <br>
                        <br>

                        <div class="post-code">
                            <pre><%= p.getpCode()%></pre>
                        </div>

                    </div>



                    <div class="card-footer primary-background">

                        <%
                            LikeDao ld = new LikeDao(ConnectionProvider.getConnection());
                        %>

                        <a href="#!" onclick="doLike(<%= p.getPid()%>,<%= user.getId()%>)" class="btn btn-outline-light btn-sm"> <i class="fa fa-thumbs-o-up"></i> <span class="like-counter"><%= ld.countLikeOnPost(p.getPid())%></span></a>
                        <a href="#!" class="btn btn-outline-light btn-sm"> <i class="fa fa-commenting-o"></i> <span>20</span>  </a>


                    </div>

                    <div class="card-footer">
                        <div class="fb-comments" data-href="http://localhost:9494/KnowledgeShareBlog/show_blog_page.jsp?post_id=16" data-width="" data-numposts="5"></div>
                    </div>

                </div>

            </div>

        </div>

    </div>

    <!--end of main content of body-->

    <!-- Modal -->
    <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header primary-background text-white">
                    <h5 class="modal-title" id="exampleModalLabel">Knowledge Share Blog</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container text-center">
                        <img src="pics/<%= user.getProfile()%>" class="img-fluid" style="border-radius: 50%; max-width: 150px" >
                        <br>
                        <h5 class="modal-title mt-3" id="exampleModalLabel"><%= user.getName()%></h5>
                        <!--details-->
                        <div id="profile-detail">
                            <table class="table">

                                <tbody>
                                    <tr>
                                        <th scope="row">ID :</th>
                                        <td><%= user.getId()%></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Email :</th>
                                        <td><%= user.getEmail()%></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Gender :</th>
                                        <td><%= user.getGender()%></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">About :</th>
                                        <td><%= user.getAbout()%></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">Registered on :</th>
                                        <td><%= user.getDateTime().toString()%></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>

                        <!--edit profile table-->
                        <div id="profile-edit" style="display: none;">
                            <h3>Please edit carefully</h3>
                            <form action="EditServlet" method="POST" enctype="multipart/form-data">
                                <table class="table">
                                    <tr>
                                        <td>ID :</td>
                                        <td><%= user.getId()%></td>
                                    </tr>

                                    <tr>
                                        <td>Email :</td>
                                        <td><input type="email" name="user_email" class="form-control" value="<%= user.getEmail()%>"></td>
                                    </tr>

                                    <tr>
                                        <td>Name :</td>
                                        <td><input type="text" name="user_name" class="form-control" value="<%= user.getName()%>"></td>
                                    </tr>

                                    <tr>
                                        <td>Password :</td>
                                        <td><input type="password" name="user_password" class="form-control" value="<%= user.getPassword()%>"></td>
                                    </tr>

                                    <tr>
                                        <td>Gender :</td>
                                        <td><%= user.getGender()%></td>
                                    </tr>

                                    <tr>
                                        <td>About :</td>
                                        <td>
                                            <textarea rows="3" name="user_about" class="form-control"><%= user.getAbout()%>
                                            </textarea>
                                        </td>
                                    </tr>

                                    <tr>
                                        <td>New profile pic :</td>
                                        <td>
                                            <input type="file" name="image" class="form-control">
                                        </td>
                                    </tr>
                                </table>

                                <div class="container">
                                    <button type="submit" class="btn btn-outline-primary">Save</button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button id="edit-profile-btn" type="button" class="btn btn-primary">Edit</button>
                </div>
            </div>
        </div>
    </div>

    <!--end of profile modal-->

    <!--add post modal-->

    <!-- Modal -->
    <div class="modal fade" id="do-post-modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Provide the post details...</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <div class="modal-body">
                    <form id="add-post-form" action="AddPostServlet" method="POST">
                        <div class="form-group">
                            <select class="form-control" name="cid">
                                <option selected disabled>---Select category---</option>

                                <%
                                    PostDao pDao2 = new PostDao(ConnectionProvider.getConnection());
                                    ArrayList<Category> list = pDao2.getAllCategories();
                                    for (Category cat : list) {
                                %>
                                <option value="<%= cat.getCid()%>"><%= cat.getName()%></option>
                                <%
                                    }
                                %>

                            </select>
                        </div>
                        <div class="form-group">
                            <input name="pTitle" type="text" placeholder="Enter post title" class="form-control"/>
                        </div>

                        <div class="form-group">
                            <textarea name="pContent" class="form-control" style="height: 200px;" placeholder="Enter your content"></textarea>
                        </div>

                        <div class="form-group">
                            <textarea name="pCode" class="form-control" style="height: 200px;" placeholder="Enter your program (if any)"></textarea>
                        </div>

                        <div class="form-group">
                            <label>Select your pic..</label>
                            <br>
                            <input name="pic" type="file">
                        </div>

                        <div class="container text-center">
                            <button class="btn btn-outline-primary" type="submit">Post</button>
                        </div>
                    </form>
                </div>
                \
            </div>
        </div>
    </div>

    <!--end of add post modal-->

    <!--JavaScript-->
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@7.12.15/dist/sweetalert2.all.min.js"></script>

    <script>

                            $(document).ready(function () {
                                let editStatus = false;
                                $('#edit-profile-btn').click(function () {
                                    if (editStatus === false) {
                                        $('#profile-detail').hide();
                                        $('#profile-edit').show();
                                        editStatus = true;
                                        $(this).text('Back');
                                    } else {
                                        $('#profile-detail').show();
                                        $('#profile-edit').hide();
                                        editStatus = false;
                                        $(this).text('Edit');
                                    }
                                });
                            });

    </script>

    <script>
        function doLike(pid, uid) {
            console.log(pid + "," + uid)
            const d = {
                uid: uid,
                pid: pid,
                operation: 'like'
            }

            $.ajax({
                url: "LikeServlet",
                data: d,
                success: function (data, textStatus, jqXHR) {
                    console.log(data);
                    if (data.trim() == 'true')
                    {
                        let c = $(".like-counter").html();
                        c++;
                        $('.like-counter').html(c);
                    }
                },
                error: function (jqXHR, textStatus, errorThrown) {
                    console.log(data)
                }
            })
        }
    </script>



    <!--now add post jquery-->
    <script>
        $(document).ready(function (e) {
            $("#add-post-form").on("submit", function (event) {
                // this code will called when form is submitted
                event.preventDefault();

                console.log("you have clicked submit");

                let form = new FormData(this);

                // now requesting to server
                $.ajax({
                    url: "AddPostServlet",
                    type: 'POST',
                    data: form,
                    success: function (data, textStatus, jqXHR) {
                        // success
                        console.log("data : " + data);
                        if (data.trim() == "done") {
                            swal("Good job!", "saved successfully", "success");
                        } else {
                            swal("Error!!", "Something went wrong... try again!!", "error");
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        // error
                        swal("Error!!", "Something went wrong... try again!!", "error");
                    },
                    processData: false,
                    contentType: false
                })
            });
        })
    </script>
    <!--
            <script src="js/myjs.js" type="text/javascript"></script>-->
</body>
</html>
