<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Soccer &mdash;</title>


<link rel="stylesheet" type="text/css" href="css/test.css?v=1.0">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
    	<div class="header">
    <!-- Logo -->
			    <div class="logo-container">
			        <a href="FE.jsp">
			            <img src="IMG/logo.png" alt="Logo">
			        </a>
			    </div>
	    
	    <!-- Menu -->
			    <div class="menu">
			        <a href="FE.jsp">HOME</a> 
			        <a href="player.jsp">PLAYERS</a>
			        <a href="team.jsp">TEAM</a>
			        <a href="match.jsp">MATCHES</a>
			        <a href="stats.jsp">STATS</a>
			        
			        <div class="dropdown">
		            <button class="dropdown-btn">ADMIN</button>
		            <div class="dropdown-content">
                <a href="/web/TeamManagement.jsp">TEAM </a>
                <a href="/web/PlayerManagement.jsp">PLAYERS </a>
                <a href="/web/ChooseSeason.jsp">MATCH </a>
                <a href="/web/StatsManagement.jsp">STATS </a>
            </div>
        </div>
			    </div>
		</div>       
                 
       	<div class="hero overlay">
       	
	       	<div class="hero">
	       		<div class="h1">
	       		<h1>SOCCER MANAGER</h1>
	       		</div>
	       	</div>
	       	
       		<div>
       			<h2>Let's go play soccer</h2>
       		</div>
       	
       	
       	</div>
      
		 <div class="container mt-4">
        <!-- Row for Cards -->
        <div class="row justify-content-center">
            <!-- Card 1 -->
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/bayerlogo.svg" class="card-img-top" alt="Giai bong da">
                    <div class="card-body">
                        <h5 class="card-title">Bayer 04 Leverkusen</h5>
                        <p class="card-text">Silver Lions.</p>
                        <a href="team.jsp" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_4.png" class="card-img-top" alt="Truong dai hoc">
                    <div class="card-body">
                        <h5 class="card-title">University Team</h5>
                        <p class="card-text">Discover top university teams and their achievements.</p>
                        <a href="#" class="btn btn-primary">Discover</a>
                    </div>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_2.png" class="card-img-top" alt="Logo 5">
                    <div class="card-body">
                        <h5 class="card-title">Upcoming Matches</h5>
                        <p class="card-text">Stay updated with the latest .</p>
                        <a href="#" class="btn btn-primary">View Matches</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_1.png" class="card-img-top" alt="Truong dai hoc">
                    <div class="card-body">
                        <h5 class="card-title">University Team</h5>
                        <p class="card-text">Discover top university teams and their achievements.</p>
                        <a href="#" class="btn btn-primary">Discover</a>
                    </div>
                </div>
            </div>
            
        </div>
        
        <!-- Row 2 -->
        <div class="row justify-content-center mt-4">
            <!-- Card 1 -->
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_3.png" class="card-img-top" alt="Giai bong da">
                    <div class="card-body">
                        <h5 class="card-title">Soccer League</h5>
                        <p class="card-text">Explore exciting soccer tournaments worldwide.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_4.png" class="card-img-top" alt="Truong dai hoc">
                    <div class="card-body">
                        <h5 class="card-title">University Team</h5>
                        <p class="card-text">Discover top university teams and their achievements.</p>
                        <a href="#" class="btn btn-primary">Discover</a>
                    </div>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_2.png" class="card-img-top" alt="Logo 5">
                    <div class="card-body">
                        <h5 class="card-title">Upcoming Matches</h5>
                        <p class="card-text">Stay updated with the latest .</p>
                        <a href="#" class="btn btn-primary">View Matches</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_1.png" class="card-img-top" alt="Truong dai hoc">
                    <div class="card-body">
                        <h5 class="card-title">University Team</h5>
                        <p class="card-text">Discover top university teams and their achievements.</p>
                        <a href="#" class="btn btn-primary">Discover</a>
                    </div>
                </div>
            </div>
            
        </div>
        
        <!-- Row 3 -->
        <div class="row justify-content-center mt-4">
            <!-- Card 1 -->
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_3.png" class="card-img-top" alt="Giai bong da">
                    <div class="card-body">
                        <h5 class="card-title">Soccer League</h5>
                        <p class="card-text">Explore exciting soccer tournaments worldwide.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_4.png" class="card-img-top" alt="Truong dai hoc">
                    <div class="card-body">
                        <h5 class="card-title">University Team</h5>
                        <p class="card-text">Discover top university teams and their achievements.</p>
                        <a href="#" class="btn btn-primary">Discover</a>
                    </div>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_2.png" class="card-img-top" alt="Logo 5">
                    <div class="card-body">
                        <h5 class="card-title">Upcoming Matches</h5>
                        <p class="card-text">Stay updated with the latest .</p>
                        <a href="#" class="btn btn-primary">View Matches</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_1.png" class="card-img-top" alt="Truong dai hoc">
                    <div class="card-body">
                        <h5 class="card-title">University Team</h5>
                        <p class="card-text">Discover top university teams and their achievements.</p>
                        <a href="#" class="btn btn-primary">Discover</a>
                    </div>
                </div>
            </div>
            
        </div>
        
        
        
        <div class="row justify-content-center mt-4">
            <!-- Card 1 -->
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_3.png" class="card-img-top" alt="Giai bong da">
                    <div class="card-body">
                        <h5 class="card-title">Soccer League</h5>
                        <p class="card-text">Explore exciting soccer tournaments worldwide.</p>
                        <a href="#" class="btn btn-primary">Learn More</a>
                    </div>
                </div>
            </div>

            <!-- Card 2 -->
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_4.png" class="card-img-top" alt="Truong dai hoc">
                    <div class="card-body">
                        <h5 class="card-title">University Team</h5>
                        <p class="card-text">Discover top university teams and their achievements.</p>
                        <a href="#" class="btn btn-primary">Discover</a>
                    </div>
                </div>
            </div>

            <!-- Card 3 -->
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_2.png" class="card-img-top" alt="Logo 5">
                    <div class="card-body">
                        <h5 class="card-title">Upcoming Matches</h5>
                        <p class="card-text">Stay updated with the latest .</p>
                        <a href="#" class="btn btn-primary">View Matches</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-2">
                <div class="card">
                    <img src="IMG/logo_1.png" class="card-img-top" alt="Truong dai hoc">
                    <div class="card-body">
                        <h5 class="card-title">University Team</h5>
                        <p class="card-text">Discover top university teams and their achievements.</p>
                        <a href="#" class="btn btn-primary">Discover</a>
                    </div>
                </div>
            </div>
            
        </div>
        
    </div>
    
    
    

	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

       	
       	
   

  
    
    
</body>
</html>
