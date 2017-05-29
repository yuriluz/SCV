<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sistema de Controle de Vacinação (SCV)</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="./resources/styles/style.css">
<link rel="stylesheet" href="./resources/styles/validation.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="./resources/scripts/jquery-1.7.2.js" type="text/javascript"></script>
<script src="./resources/scripts/jquery.validate.min.js" type="text/javascript"></script>
<script src="./resources/scripts/validation.js" type="text/javascript"></script>

<meta name="description" content="Página inicial do Sistema de Controle de Vacinação">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-light-grey">

	<%
		String tipo = request.getParameter("t");
	%>
	
	<div id="menu">
		<ul class="w3-navbar w3-white w3-card-2" id="myNavbar">
			<li><b><a class="w3-large w3-wide">SCV</a></b></li>

			<li class="w3-right w3-hide-small"><a href="index.html"><i class="fa fa-home w3-large"></i> HOME</a></li>
			
			<li class="w3-right w3-hide-large w3-hide-medium"><a class="w3-right" href="index.html"><i class="fa fa-home w3-large w3-padding-right w3-padding-left"></i></a></li>
		</ul>
	</div>

	<div class="w3-container w3-margin-top w3-padding-64">
		<div class="w3-card-2 w3-white w3-display-middle w3-margin-top w3-animate-opacity" style="width: 80%; max-width: 420px;" id="access">
			<header class="w3-container w3-blue">
			<%if (tipo.equals("1")) { %>
				<h3 class="w3-center" style="color: #ffffff;">ACESSO PROFISSIONAL</h3>
			<%} else if (tipo.equals("2"))   {%>
				<h3 class="w3-center" style="color: #ffffff;">ACESSO ADMINISTRATIVO</h3>
			<%} else { %>
				<h3 class="w3-center" style="color: #ffffff;">ACESSO AO SISTEMA</h3>
			<%}%>
			</header>
			<div class="w3-padding">
				<form method="POST" class="w3-container" id="loginForm" name="loginForm" action="/admLogin">
					<div>
						<h6 class="w3-center">Informe seus dados</h6>
					</div>
					<div>
						<p>
							<input class="w3-input w3-border" type="text" id="email" name="email" placeholder="E-mail de acesso" autocomplete="off">
						</p>
						<p>
							<input class="w3-input w3-border" type="password" id="senha" name="senha" placeholder="Senha de acesso" autocomplete="off">
						</p>
					</div>
					<div class="w3-center">
						<p>
							<button class="w3-btn w3-white w3-border w3-hover-blue" type="submit">
								ACESSAR <i class="fa fa-arrow-right"></i>
							</button>
						</p>
					<%if (tipo.equals("1")) { %>
						<hr/>
						<p>
							<a href="first-access.html" class="w3-button w3-white w3-border w3-hover-green">
								PRIMEIRO ACESSO
							</a>
							<a href="password.jsp?t=A" class="w3-button w3-white w3-border w3-hover-yellow">
								RECUPERAR SENHA
							</a>
						</p>
					<% } else { %>
						<hr/>
						<p>
							<a href="adm-registration.html" class="w3-button w3-white w3-border w3-hover-green">
								CADASTRE-SE
							</a>
							<a href="password.jsp?t=A" class="w3-button w3-white w3-border w3-hover-yellow">
								RECUPERAR SENHA
							</a>
						</p>
					<% } %>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="./resources/scripts/navigation.js"></script>
</body>
</html>
