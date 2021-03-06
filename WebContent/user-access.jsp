<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sistema de Controle de Vacina��o (SCV)</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="./resources/styles/style.css">
<link rel="stylesheet" href="./resources/styles/validation.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

<script src="./resources/scripts/jquery-1.7.2.js" type="text/javascript"></script>
<script src="./resources/scripts/jquery.validate.min.js" type="text/javascript"></script>
<script src="./resources/scripts/validation.js" type="text/javascript"></script>

<meta name="description" content="P�gina inicial do Sistema de Controle de Vacina��o">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-light-grey">

	<%
		String sucesso = request.getParameter("sucesso");
		
		if (sucesso == null) {
			sucesso = "";
		}
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
				<h3 class="w3-center" style="color: #ffffff;">ACESSO AO SISTEMA</h3>
			</header>
			<div class="w3-padding">
				<form method="POST" class="w3-container" id="loginForm" name="loginForm" action="/userLogin">
					<div>
						<h6 class="w3-center">Informe seus dados</h6>
						<% if (sucesso.equals("0")) { %>
						<label class="w3-small w3-text-red" id="mensagem">Login e/ou senha inv�lidos!</label>
						<% } %>
					</div>
					<div>
						<p>
							<input class="w3-input w3-border" type="text" id="doc" name="doc" placeholder="N�mero do documento" autocomplete="off">
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
						<hr/>
						<p>
							<a href="user-registration.jsp" class="w3-button w3-white w3-border w3-hover-green">
								CRIAR CONTA
							</a>
						</p>
					</div>
				</form>
			</div>
		</div>
	</div>
</body>
</html>
