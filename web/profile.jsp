<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*,java.util.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
    </head>
    <body>
        <div class="container-fluid mb-2">
            <div class="row border-top px-xl-5">
                <div class="col-lg-12">
                    <%@include file="header.jsp" %>
                </div>
            </div>
        </div>

        <div class="container-fluid bg-secondary mb-5">
            <div class="d-flex flex-column align-items-center justify-content-center" style="min-height: 300px">
                <h1 class="font-weight-semi-bold text-uppercase mb-3">Profile</h1>
                <div class="d-inline-flex">
                    <p class="m-0"><a href="index.jsp">Home</a></p>
                    <p class="m-0 px-2">-</p>
                    <p class="m-0">Update profile</p>
                </div>
            </div>
        </div>
        <%
    String message = request.getParameter("message");
    if (message != null && message.equals("success")) {
        %>
        <div class="alert alert-success" role="alert">
            Profile updated successfully!
        </div>
        <%
            }
        %>

        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-6">
                    <form method="POST" id="updateForm" action="updateProfile"> 
                        <div class="mb-3">
                            <label for="u_name" class="form-label">Name</label>
                            <input type="text" class="form-control" id="u_name" name="u_name">
                        </div>
                        <div class="mb-3">
                            <label for="u_email" class="form-label">Email address</label>
                            <input type="email" class="form-control" id="u_email" name="u_email">
                        </div>

                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <input type="text" class="form-control" id="address" name="address">
                        </div>
                        <button type="submit" class="btn btn-primary">Update</button>
                    </form>
                </div>
            </div>
        </div>


        <%
            // Establish database connection
            Connection conn = null;
            PreparedStatement pstmt = null;

            try {
                // Load the MySQL JDBC driver
                Class.forName("com.mysql.jdbc.Driver");

                // Connect to the database
                String url = "jdbc:mysql://localhost:3306/auction";
                String username = "root";
                String dbPassword = "";
                conn = DriverManager.getConnection(url, username, dbPassword);

                // Retrieve user data from the database
                String currentUID = (String) session.getAttribute("u_id");
                String query = "SELECT u_name, u_email, address FROM user WHERE u_id = ?";
                pstmt = conn.prepareStatement(query);
                pstmt.setString(1, currentUID);
                ResultSet rs = pstmt.executeQuery();

                // Check if the result set has data
                if (rs.next()) {
                    // Retrieve user data from the result set
                    String name = rs.getString("u_name");
                    String email = rs.getString("u_email");
                    String address = rs.getString("address");
        %>

        <script>
            // Populate the form fields with existing data
            document.getElementById("u_name").value = "<%= name %>";
            document.getElementById("u_email").value = "<%= email %>";
            document.getElementById("address").value = "<%= address %>";
        </script>

        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } finally {
                // Close the database resources
                try { if (pstmt != null) pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js" integrity="sha384-IQsoLXl5PILFhosVNubq5LC7Qb9DXgDA9i+tQ8Zj3iwWAwPtgFTxbJ8NT4GN1R8p" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js" integrity="sha384-cVKIPhGWiC2Al4u+LWgxfKTRIcfu0JTxR+EQDz/bgldoEyl4H0zUF0QKbrJ0EcQF" crossorigin="anonymous"></script>
        <!--              JavaScript Libraries -->
        <script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.bundle.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>

        <!--             Contact Javascript File -->
        <script src="mail/jqBootstrapValidation.min.js"></script>
        <script src="mail/contact.js"></script>

        <!--             Template Javascript -->
        <script src="js/main.js"></script>
        <%@include file="footer.jsp" %>

    </body>
</html>
