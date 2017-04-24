<%@page import="com.scv.persistence.dao.PaisDAO"%>
<%@page import="com.scv.persistence.dao.EstadoDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.persistence.dao.CampanhaDAO"%>
<%@page import="com.scv.javabean.Pessoa.Escolaridade"%>
<%@page import="com.scv.entities.enums.Sexo"%>
<%@page import="com.scv.entities.enums.TipoDocumento"%>
<%@page import="com.scv.javabean.Pessoa"%>
<%@page import="com.scv.javabean.Campanha"%>
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
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="./resources/scripts/jquery-1.12.4.js"></script>
<script src="./resources/scripts/jquery-ui.js"></script>

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
	
	function updatePessoa(documento) {
		if (documento == "") {
			document.getElementById("infoBusca").innerHTML = "Informe o documento da pessoa!";
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
				document.getElementById("dadosPessoa").innerHTML = this.responseText;
			}
		}
		xmlhttp.open("GET", "loadPessoa?documento=" + documento, true);
		xmlhttp.send();
	}

	$('#estado').on('change', function() {
		updateCities(this.value);
	});
	
	$(document).on('click', '#searchButton', function() {
		updatePessoa($('#searchPessoa').val());
	});
});
</script>

<meta name="description" content="Página do Usuário do Sistema de Controle de Vacinação">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-white">

<jsp:include page="/WEB-INF/includes/menu/adm-menu.jsp">
	<jsp:param name="selecionado" value="1"/>
</jsp:include>


	<div class="w3-container w3-padding-32">
			<div id="dadosPessoa" class="w3-padding">
				<div class="w3-row">
					<div class="w3-col m6 l5">
						<label>Busca por pessoa</label><br/>
						<input id="searchPessoa" class="w3-padding w3-section w3-border" style="width:80%;" type="text" placeholder="CPF, RG, CNH, CTPS, Passaporte ou Certidão de Nasc." autocomplete="off">
						<a id="searchButton" class="w3-button w3-white w3-border w3-hover-blue">
							<i class="fa fa-search"></i>
						</a>
						<label id="infoBusca"></label>
					</div>
				</div>
				<hr />
				<form class="w3-container" id="formCadastro" name="formCadastro" method="POST" action="/pessoa">
					<input type="hidden" name="codPessoa" value="">
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label>Nome</label> <input class="w3-input" type="text" id="nome" name="nome" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label>Data de Nascimento</label> <input class="w3-input" type="text" id="dtNascimento" name="dtNascimento" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label>Gênero</label> <select class="w3-input" id="genero" name="genero">
								<option value="M">Masculino</option>
								<option value="F">Feminino</option>
								<option value="O">Outro</option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label>Naturalidade</label> <input class="w3-input" type="text" id="naturalidade" name="naturalidade" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label>Nacionalidade</label> <input class="w3-input" type="text" id="nacionalidade" name="nacionalidade" value="">
						</div>
						
						<div class="w3-col m4 l4 w3-padding-large">
							<label>Nível de Escolaridade</label> <select class="w3-input" id="escolaridade" name="escolaridade">
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
							<label>CPF</label> <input class="w3-input" type="text" id="cpf" name="cpf" value="">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-large">
							<label>Outro Documento</label> <select class="w3-input" id="tipodoc" name="tipodoc">
								<option value="1">RG</option>
								<option value="2">Passaporte</option>
								<option value="3">CNH</option>
								<option value="4">CTPS</option>
							</select>
						</div>

						<div class="w3-col m6 l3 w3-padding-small">
							<label>Número do Documento</label> <input class="w3-input" type="text" id="documento" name="documento" value="">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label>Órgão Emissor</label> <input class="w3-input" type="text" id="emissor" name="emissor" value="">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label>Endereço</label> <input class="w3-input" type="text" id="endereco" name="endereco" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label>Complemento</label> <input class="w3-input" type="text" id="complemento" name="complemento" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label>CEP</label> <input class="w3-input" type="text" id="cep" name="cep" value="">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label>Bairro</label> <input class="w3-input" type="text" id="bairro" name="bairro" value="">
						</div>
					
						<div class="w3-col m4 l4 w3-padding-large">
							<label>Estado</label> <select class="w3-input" id="estado" name="estado">
								<option value=""></option>
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
							<label>Cidade</label> <select class="w3-input" id="cidade" name="cidade" >
								<option value=""></option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label>Telefone</label> <input class="w3-input" type="text" id="telefone" name="telefone" value="">
						</div>

						<div class="w3-col m6 l4 w3-padding-small">
							<label>E-mail</label> <input class="w3-input" type="text" id="email" name="email" value="">
						</div>
					</div>
					<hr />
					<div class="w3-row">
						<div class="w3-col w3-padding-tiny">
							<button type="submit" id="saveButton" class="w3-btn w3-white w3-border w3-hover-green w3-right">
								<i class="fa fa-floppy-o"></i> CADASTRAR USUÁRIO
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		
	<script src="./resources/scripts/navigation.js"></script>
	
</body>
</html>
