<%@page import="com.scv.javabean.Usuario"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sistema de Controle de Vacinação (SCV)</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="./resources/styles/style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="./resources/scripts/jquery-1.12.4.js"></script>
<script src="./resources/scripts/jquery-ui.js"></script>

<meta name="description" content="Página do Usuário do Sistema de Controle de Vacinação">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-white">

	<%
		Usuario usuario = (Usuario) session.getAttribute("login");
		String email = usuario.getEmail().toLowerCase();
	%>

	<jsp:include page="/WEB-INF/includes/menu/adm-menu.jsp">
		<jsp:param name="selecionado" value="0"/>
	</jsp:include>

	<div class="w3-container w3-padding-64">
		
	</div>
	<script src="./resources/scripts/user-home.js"></script>
	<script src="./resources/scripts/navigation.js"></script>
</body>
</html>
