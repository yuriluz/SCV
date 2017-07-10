<%@page import="com.scv.persistence.dao.PaisDAO"%>
<%@page import="com.scv.persistence.dao.EstadoDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.javabean.Pessoa.Escolaridade"%>
<%@page import="com.scv.entities.enums.Sexo"%>
<%@page import="com.scv.entities.enums.TipoDocumento"%>
<%@page import="com.scv.javabean.Estado"%>
<%@page import="com.scv.javabean.Cidade"%>
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
<link rel="stylesheet" href="./resources/styles/validation.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="./resources/scripts/jquery-1.7.2.js" type="text/javascript"></script>
<script src="./resources/scripts/jquery.validate.min.js" type="text/javascript"></script>
<script src="./resources/scripts/validation.js" type="text/javascript"></script>
<script src="./resources/scripts/jquery-ui.js"></script>
<script src="./resources/scripts/calendar.js"></script>

<script type="text/javascript">
$(document).ready(function() {
	function updateCities(estado) {
		if (estado == "") {
			document.getElementById("cidade").innerHTML = "";
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
				document.getElementById("cidade").innerHTML = this.responseText;
			}
		}
		xmlhttp
				.open("GET", "loadCities?estado=" + estado,
						true);
		xmlhttp.send();
	}
	
	function habilitarBotao() {
		document.getElementById("saveButton").disabled=false;
	}

	$('#estado').on('change', function() {
		updateCities(this.value);
	});
	
	$('#usuario').on('change', function() {
		updateUser(this.value);
	});
	
	$('input, select').on('change', function() {
		habilitarBotao();
	});
	
});
</script>

<meta name="description" content="Página do Usuário do Sistema de Controle de Vacinação">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-white">

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

	<div class="w3-container w3-padding-32">
			<div class="w3-padding">
				<div class="w3-row" id="title">
					<h4><b>NOVO USUÁRIO</b></h4>
				</div>
				<hr />
				<form class="w3-container" id="registerForm" name="registerForm" method="POST" action="/registrarPessoa">
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Nome</b></label> <input class="w3-input" type="text" id="nome" name="nome" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Data de Nascimento</b></label> <input class="w3-input" type="text" id="dtNascimento" name="dtNascimento" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Gênero</b></label> <select class="w3-input" id="genero" name="genero">
								<option value="M">Masculino</option>
								<option value="F">Feminino</option>
								<option value="O">Outro</option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Naturalidade</b></label> <input class="w3-input" type="text" id="naturalidade" name="naturalidade" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Nacionalidade</b></label> <input class="w3-input" type="text" id="nacionalidade" name="nacionalidade" value="">
						</div>
						
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Escolaridade</b></label> <select class="w3-input" id="escolaridade" name="escolaridade">
								<option value=0>Não possui</option>
								<option value=1>Fundamental</option>
								<option value=2>Médio</option>
								<option value=3>Superior Incompleto</option>
								<option value=4>Superior Completo</option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>CPF</b></label> <input class="w3-input" type="text" id="cpf" name="cpf" value="">
						</div>
					
						<div class="w3-col m6 l3 w3-padding-large">
							<label><b>Documento</b></label> <select class="w3-input" id="tipodoc" name="tipodoc">
								<option value="1">RG</option>
								<option value="2">Passaporte</option>
								<option value="3">CNH</option>
								<option value="4">CTPS</option>
							</select>
						</div>

						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Número do Documento</b></label> <input class="w3-input" type="text" id="documento" name="documento" value="">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Órgão Emissor</b></label> <input class="w3-input" type="text" id="emissor" name="emissor" value="">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Endereço</b></label> <input class="w3-input" type="text" id="endereco" name="endereco" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Complemento</b></label> <input class="w3-input" type="text" id="complemento" name="complemento" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>CEP</b></label> <input class="w3-input" type="text" id="cep" name="cep" value="">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Bairro</b></label> <input class="w3-input" type="text" id="bairro" name="bairro" value="">
						</div>
						
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Estado</b></label> <select class="w3-input" id="estado" name="estado">
								<%
									List<Estado> estados = new ArrayList<Estado>();
									estados = EstadoDAO.getInstance().carregarTodos();

									for (Estado e : estados) {
								%>
								<option value=<%=e.getCodigo()%>><%=e.getNome()%></option>
								<%
									}
								%>
							</select>
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Cidade</b></label> <select class="w3-input" id="cidade" name="cidade" >
								<%
									List<Cidade> cidades = new ArrayList<Cidade>();

									for (Cidade c : cidades) {
								%>
								<option value=<%=c.getCodigo()%>><%=c.getNome()%></option>
								<%
									}
								%>
							</select>
						</div>
					</div>
					<div class="w3-row">	
						<div class="w3-col m5 l2 w3-padding-small">
							<label><b>Telefone</b></label> <input class="w3-input" type="text" id="telefone" name="telefone" value="">
						</div>

						<div class="w3-col m7 l4 w3-padding-small">
							<label><b>E-mail</b></label> <input class="w3-input" type="text" id="email" name="email" value="">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Informe a senha</b></label> <input class="w3-input" type="password" id="senha1" name="senha1" value="">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Confirme a senha</b></label> <input class="w3-input" type="password" id="senha2" name="senha2" value="">
						</div>
					</div>
					<hr />
					<div class="w3-row">
						<div class="w3-col w3-padding-tiny">
							<button type="submit" id="saveButton" class="w3-btn w3-white w3-border w3-hover-green w3-right" disabled>
								FINALIZAR CADASTRO <i class="fa fa-check"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		
		<% if (sucesso.equals("0")) { %>
		<div id="popup" class="w3-modal">
			<div class="w3-modal-content w3-animate-bottom">
				<header class="w3-container w3-red"> 
        			<span onclick="document.getElementById('popup').style.display='none'" class="w3-button w3-display-topright w3-red"><i class="fa fa-close"></i></span>
        			<h4>Ops, houve um problema</h4>
      			</header>
				<div class="w3-container">
			      	<h5>Por favor, confira os dados e tente novamente</h5>
			    </div>
			</div>
		</div>
		<% } else if (sucesso.equals("1")) { %>
		<div id="popup" class="w3-modal">
			<div class="w3-modal-content w3-animate-bottom">
				<header class="w3-container w3-blue"> 
        			<span onclick="document.getElementById('popup').style.display='none'" class="w3-button w3-display-topright w3-blue"><i class="fa fa-close"></i></span>
        			<h4>Cadastro realizado com sucesso!</h4>
      			</header>
				<div class="w3-container">
			      	<h4>Faça seu login na página de acesso!</h4>
			    </div>
			</div>
		</div>
		<% } %>
		
		<% if (!sucesso.equals("")) { %>
		<script type="text/javascript">
			$(document).ready(function() {
				document.getElementById("popup").style.display="block";
			});
		</script>
		<% } %>
		
	<script src="./resources/scripts/navigation.js"></script>
	
</body>
</html>
