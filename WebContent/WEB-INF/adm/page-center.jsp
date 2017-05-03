<%@page import="com.scv.persistence.dao.EstadoDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.persistence.dao.UnidadeDAO"%>
<%@page import="com.scv.entities.enums.Sexo"%>
<%@page import="com.scv.entities.enums.TipoDocumento"%>
<%@page import="com.scv.javabean.Usuario.TipoUsuario"%>
<%@page import="com.scv.javabean.Usuario"%>
<%@page import="com.scv.javabean.Gerente"%>
<%@page import="com.scv.javabean.Unidade"%>
<%@page import="com.scv.javabean.Estado"%>
<%@page import="com.scv.javabean.Cidade"%>
<%@page import="java.util.*"%>

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
	
	function updateCenter(codigo) {
		if (window.XMLHttpRequest) {
			// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp = new XMLHttpRequest();
		} else { // code for IE6, IE5
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange = function() {
			if (this.readyState == 4 && this.status == 200) {
				document.getElementById("dadosUnidade").innerHTML = this.responseText;
			}
		}
		xmlhttp
				.open("GET", "loadUnidade?unidade=" + codigo,
						true);
		xmlhttp.send();
	}

	$('#estado').on('change', function() {
		updateCities(this.value);
	});
	
	$(document).on('change', '#unidade', function() {
		updateCenter(this.value);
	});
});
</script>

<meta name="description" content="Página do Usuário do Sistema de Controle de Vacinação">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-white">

<jsp:include page="/WEB-INF/includes/menu/adm-menu.jsp">
	<jsp:param name="selecionado" value="7"/>
</jsp:include>

	<%
	Usuario usuario = (Usuario) session.getAttribute("login");
	%>

	<div class="w3-container w3-padding-32">
			<div id="dadosUnidade" class="w3-padding">
					<div class="w3-row">
						<div class="w3-col m6 l5 w3-padding-small">
							<label><b>Selecione a unidade</b></label>
							<select class="w3-input" id="unidade" name="unidade">
								<option value=""></option>
								<%
									List<Unidade> unidades = new ArrayList<Unidade>();
									unidades = UnidadeDAO.getInstance().carregarPorUsuario(usuario);
	
									for (Unidade u : unidades) {
								%>
								<option value=<%=u.getCodigo()%>><%=u.getCodigo()%> - <%=u.getNomeFantasia()%></option>
								<%
									}
								%>
							</select>
						</div>
					</div>
					<hr />
					<form class="w3-container" id="formCadastro" name="formCadastro" method="POST" action="/unidade">
					<input type="hidden" id="codUni" name="codUni" value="">
					<input type="hidden" id="codUser" name="codUser" value=<%=usuario.getCodigo() %>>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Nome Fantasia</b></label> <input class="w3-input" type="text" id="nome" name="nome" value="">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Razão Social</b></label> <input class="w3-input" type="text" id="razao" name="razao" value="">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>CNES</b></label> <input class="w3-input" type="text" id="cnes" name="cnes" value="">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>CNPJ</b></label> <input class="w3-input" type="text" id="cnpj" name="cnpj" value="">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Endereço</b></label> <input class="w3-input" type="text" id="endereco" name="endereco" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Bairro</b></label> <input class="w3-input" type="text" id="bairro" name="bairro" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>CEP</b></label> <input class="w3-input" type="text" id="cep" name="cep" value="">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Estado</b></label> <select class="w3-input" id="estado" name="estado">
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
							<label><b>Cidade</b></label> <select class="w3-input" id="cidade" name="cidade" >
								<option value=""></option>
							</select>
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Telefone</b></label> <input class="w3-input" type="text" id="telefone" name="telefone" value="">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Tipo da Unidade</b></label> <select class="w3-input" id="tipouni" name="tipouni">
								<option value="H">Hospital</option>
								<option value="P">Centro de Saúde</option>
								<option value="C">Clínica</option>
							</select>
						</div>
						
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Tipo de Gestão</b></label> <select class="w3-input" id="gestao" name="gestao">
								<option value="P">Particular</option>
								<option value="M">Municipal</option>
								<option value="E">Estadual</option>
								<option value="D">Dupla</option>
								<option value="F">Federal</option>
								<option value="T">Militar</option>
							</select>
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Status</b></label> <select class="w3-input" id="status" name="status">
								<option value="true">Ativo</option>
								<option value="false">Inativo</option>
							</select>
						</div>
					</div>
					<hr />
					<div class="w3-row">
						<div class="w3-col w3-padding-tiny">
							<button type="submit" id="saveButton" class="w3-btn w3-white w3-border w3-hover-green w3-right">
								<i class="fa fa-floppy-o"></i> CADASTRAR UNIDADE
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		
	<script src="./resources/scripts/navigation.js"></script>
	
</body>
</html>
