<%@page import="com.scv.persistence.dao.VacinaDAO"%>
<%@page import="com.scv.persistence.dao.PessoaDAO"%>
<%@page import="com.scv.javabean.Vacinador"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>

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

<script type="text/javascript">
$(document).ready(function() {
	function updatePessoa(documento) {
		if (documento == "") {
			document.getElementById("infoPessoa").innerHTML = "Informe os dados do paciente!";
			return;
		}
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else { // code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("dados").innerHTML = this.responseText;
			}
		}
		xmlhttp.open("GET", "searchRegistro?documento=" + documento, true);
		xmlhttp.send();
	}
	
	$(document).on('click', '#searchButton', function() {
		updatePessoa($('#searchPessoa').val());
	});

});
</script>

<meta name="description" content="Sistema de Controle de Vacinação">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-white">

<jsp:include page="/WEB-INF/includes/menu/adm-menu.jsp">
	<jsp:param name="selecionado" value="5"/>
</jsp:include>

	<%
	Date hoje = new Date();
	SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
	Vacinador vacinador = (Vacinador) session.getAttribute("vacinador");
	%>

	<div class="w3-container w3-padding-32">
			<form id="confirmacao" method="POST" action="/confirmacao">
				<input type="hidden" name="dtConfirmacao" value=<%=df.format(hoje)%>>
				<div id="dados" class="w3-padding">
					<div class="w3-row">
						<div class="w3-col m6 l5">
							<label><b>Informe o número do documento</b></label><br/>
							<input id="searchPessoa" class="w3-padding w3-section w3-border" style="width:80%;" type="text" placeholder="CPF, RG, CNH, CTPS, Passaporte ou Certidão de Nasc." autocomplete="off">
							<a id="searchButton" class="w3-button w3-white w3-border w3-hover-blue">
								<i class="fa fa-search"></i>
							</a><br/>
							<label class="w3-small w3-text-red" id="infoPessoa"></label>
						</div>
					</div>
					<hr />
					<div class="w3-row">
					</div>
					<hr />
					<div class="w3-row">
							<button type="submit" id="registerButton" class="w3-button w3-white w3-border w3-hover-green w3-right w3-hide" disabled>
								<i class="fa fa-check"></i> CONFIRMAR VACINAÇÕES
							</button>
					</div>
				</div>
			</form>
		</div>
		
	<script src="./resources/scripts/navigation.js"></script>
	
</body>
</html>
