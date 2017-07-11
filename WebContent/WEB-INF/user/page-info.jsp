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
	
	function updateUser(usuario) {
		if (usuario == "") {
			document.getElementById("formCadastro").innerHTML = "";
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
				document.getElementById("formCadastro").innerHTML = this.responseText;
			}
		}
		xmlhttp
				.open("GET", "loadUser?usuario=" + usuario,
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

<jsp:include page="/WEB-INF/includes/menu/user-menu.jsp">
	<jsp:param name="tipo" value="1"/>
</jsp:include>

	<%
		Pessoa usuario = (Pessoa) session.getAttribute("usuario");
		String nome = usuario.getNome().substring(0, usuario.getNome().indexOf(" ")).toUpperCase();
		Sexo genero = usuario.getSexo();
		Escolaridade escolaridade = usuario.getEscolaridade();
		Estado estado = usuario.getEstado();
		Cidade cidade = usuario.getCidade();
		TipoDocumento tipoDocumento = usuario.getTipoDocumento();
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

	%>

	<div class="w3-container w3-padding-32">
			<div class="w3-padding">
				<form class="w3-container" id="formCadastro" name="formCadastro" method="POST" action="/usuario-dados">
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Nome</b></label> <input class="w3-input" type="text" id="nome" name="nome" value="<%=usuario.getNome()%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Data de Nascimento</b></label> <input class="w3-input" type="text" id="dtNascimento" name="dtNascimento" value="<%=df.format(usuario.getDataNascimento())%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Gênero</b></label> <select class="w3-input" id="genero" name="genero">
								<option value="M" <%if (genero.getValue().equals("M")) {%> selected <%}%>>Masculino</option>
								<option value="F" <%if (genero.getValue().equals("F")) {%> selected <%}%>>Feminino</option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Naturalidade</b></label> <input class="w3-input" type="text" id="naturalidade" name="naturalidade" value="<%=usuario.getNaturalidade()%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Nacionalidade</b></label> <input class="w3-input" type="text" id="nacionalidade" name="nacionalidade" value="<%=usuario.getNacionalidade()%>">
						</div>
						
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Escolaridade</b></label> <select class="w3-input" id="escolaridade" name="escolaridade">
								<option value=0 <%if (escolaridade.getValue() == 0) {%> selected <%}%>>Não possui</option>
								<option value=1 <%if (escolaridade.getValue() == 1) {%> selected <%}%>>Fundamental</option>
								<option value=2 <%if (escolaridade.getValue() == 2) {%> selected <%}%>>Médio</option>
								<option value=3 <%if (escolaridade.getValue() == 3) {%> selected <%}%>>Superior Incompleto</option>
								<option value=4 <%if (escolaridade.getValue() == 4) {%> selected <%}%>>Superior Completo</option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>CPF</b></label> <input class="w3-input" type="text" id="cpf" name="cpf" value="<%=usuario.getCpf()%>">
						</div>
					
						<div class="w3-col m6 l3 w3-padding-large">
							<label><b>Outro Documento</b></label> <select class="w3-input" id="tipodoc" name="tipodoc">
								<option value="1" <%if (tipoDocumento.getValue().equals(1)) {%> selected <%}%>>RG</option>
								<option value="2" <%if (tipoDocumento.getValue().equals(2)) {%> selected <%}%>>Passaporte</option>
								<option value="3" <%if (tipoDocumento.getValue().equals(3)) {%> selected <%}%>>CNH</option>
								<option value="4" <%if (tipoDocumento.getValue().equals(4)) {%> selected <%}%>>CTPS</option>
								<option value="5" <%if (tipoDocumento.getValue().equals(5)) {%> selected <%}%>>Certidão de Nascimento</option>
							</select>
						</div>

						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Número do Documento</b></label> <input class="w3-input" type="text" id="documento" name="documento" value="<%=usuario.getDocumento()%>">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Órgão Emissor</b></label> <input class="w3-input" type="text" id="emissor" name="emissor" value="<%=usuario.getEmissor()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Endereço</b></label> <input class="w3-input" type="text" id="endereco" name="endereco" value="<%=usuario.getLogradouro()%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Complemento</b></label> <input class="w3-input" type="text" id="complemento" name="complemento" value="<%=usuario.getComplemento()%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>CEP</b></label> <input class="w3-input" type="text" id="cep" name="cep" value="<%=usuario.getCep()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Bairro</b></label> <input class="w3-input" type="text" id="bairro" name="bairro" value="<%=usuario.getBairro()%>">
						</div>
						
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Estado</b></label> <select class="w3-input" id="estado" name="estado">
								<%
									List<Estado> estados = new ArrayList<Estado>();
									estados = EstadoDAO.getInstance().carregarTodos();

									for (Estado e : estados) {
								%>
								<option value=<%=e.getCodigo()%> <%if (e.getCodigo().equals(estado.getCodigo())) {%> selected <%}%>><%=e.getNome()%></option>
								<%
									}
								%>
							</select>
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Cidade</b></label> <select class="w3-input" id="cidade" name="cidade" >
								<%
									List<Cidade> cidades = new ArrayList<Cidade>();
									cidades = CidadeDAO.getInstance().carregarPorEstado(estado);

									for (Cidade c : cidades) {
								%>
								<option value=<%=c.getCodigo()%> <%if (c.getCodigo().equals(cidade.getCodigo())) {%> selected <%}%>><%=c.getNome()%></option>
								<%
									}
								%>
							</select>
						</div>
					</div>
					<div class="w3-row">	
						<div class="w3-col m5 l3 w3-padding-small">
							<label><b>Telefone</b></label> <input class="w3-input" type="text" id="telefone" name="telefone" value="<%=usuario.getTelefone()%>">
						</div>

						<div class="w3-col m7 l4 w3-padding-small">
							<label><b>E-mail</b></label> <input class="w3-input" type="text" id="email" name="email" value="<%=usuario.getEmail()%>">
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
