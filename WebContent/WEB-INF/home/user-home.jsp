<%@page import="com.scv.persistence.dao.PaisDAO"%>
<%@page import="com.scv.persistence.dao.EstadoDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.javabean.Pessoa.Escolaridade"%>
<%@page import="com.scv.entities.enums.Sexo"%>
<%@page import="com.scv.javabean.Pessoa"%>
<%@page import="com.scv.javabean.Estado"%>
<%@page import="com.scv.javabean.Cidade"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sistema de Controle de Vacina��o (SCV)</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="./resources/styles/style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="./resources/scripts/jquery-1.12.4.js"></script>
<script src="./resources/scripts/jquery-ui.js"></script>

<meta name="description" content="P�gina do Usu�rio do Sistema de Controle de Vacina��o">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-white">

<jsp:include page="/WEB-INF/includes/menu/user-menu.jsp">
	<jsp:param name="tipo" value="0"/>
</jsp:include>

	<%
		Pessoa usuario = (Pessoa) session.getAttribute("usuario");
		String nome = usuario.getNome().substring(0, usuario.getNome().indexOf(" ")).toUpperCase();
		Sexo genero = usuario.getSexo();
		Escolaridade escolaridade = usuario.getEscolaridade();
		Estado estado = usuario.getEstado();
		Cidade cidade = usuario.getCidade();
		String msg = "SEJA BEM VINDX,";
		if (genero.getValue().equals("M")) {
			msg = "SEJA BEM VINDO,";
		} else if (genero.getValue().equals("F")) {
			msg = "SEJA BEM VINDA,";
		}
	%>

	<div class="w3-container w3-center w3-padding-64 w3-margin-right w3-margin-left">
		<div class="w3-row">
			<div class="w3-col l6 w3-margin-bottom">
				<h3><%=msg%></h3>
				<h1 class="w3-text-shadow">
					<b><%=nome%>!</b>
				</h1>
				<h6>O que voc� deseja fazer?</h6>
			</div>
			<div class="w3-col l6">
				<a href="/usuario-dados"><button style="width: 80%; white-space: normal;" class="w3-btn w3-white w3-border w3-hover-blue w3-padding-xxlarge w3-margin-bottom w3-btn w3-round">Atualizar meus dados</button></a>
				<a href="/usuario-cartao"><button style="width: 80%; white-space: normal;" class="w3-btn w3-white w3-border w3-hover-blue w3-padding-xxlarge w3-margin-bottom w3-btn w3-round">Consultar meu Cart�o de Vacina��o</button></a>
				<a href="/usuario-calendario"><button style="width: 80%; white-space: normal;" class="w3-btn w3-white w3-border w3-hover-blue w3-padding-xxlarge w3-margin-bottom w3-btn w3-round">Consultar o Calend�rio de Vacina��o</button></a>
			</div>
		</div>

	</div>
	
	<script src="./resources/scripts/navigation.js"></script>

</body>
</html>
