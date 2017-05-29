<%@page import="com.scv.javabean.Usuario"%>
<%@page import="java.util.*"%>

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
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="./resources/scripts/jquery-1.7.2.js" type="text/javascript"></script>
<script src="./resources/scripts/jquery.validate.min.js" type="text/javascript"></script>
<script src="./resources/scripts/validation.js" type="text/javascript"></script>
<script src="./resources/scripts/jquery-ui.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	function habilitarBotao() {
		document.getElementById("saveButton").disabled=false;
	}
	
	$('input, select').on('change', function() {
		habilitarBotao();
	});
});
</script>

<meta name="description" content="Página do Usuário do Sistema de Controle de Vacinação">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-white">

<jsp:include page="/WEB-INF/includes/menu/adm-menu.jsp">
	<jsp:param name="selecionado" value="9"/>
</jsp:include>

	<%
		Usuario usuario = (Usuario) session.getAttribute("login");
	%>

	<div class="w3-container w3-padding-32">
			<div class="w3-padding">
				<form class="w3-container" id="passwordForm" name="passwordForm" method="POST" action="/senha">
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Senha atual</b></label>
							<input class="w3-input" type="password" id="senhaAtual" name="senhaAtual" value="">
						</div>

					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Nova senha</b></label>
							<input class="w3-input" type="password" id="novaSenha1" name="novaSenha1" value="">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Repita a nova senha</b></label>
							<input class="w3-input" type="password" id="novaSenha2" name="novaSenha2" value="">
						</div>
					</div>
					<hr />
					<div class="w3-row">
						<div class="w3-col w3-padding-tiny">
							<button type="submit" id="saveButton" class="w3-btn w3-white w3-border w3-hover-blue w3-right" disabled>
								SALVAR ALTERAÇÕES <i class="fa fa-floppy-o"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		
	<script src="./resources/scripts/navigation.js"></script>
	
</body>
</html>
