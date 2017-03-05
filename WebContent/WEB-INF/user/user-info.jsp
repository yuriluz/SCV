<%@page import="com.scv.persistence.dao.PaisDAO"%>
<%@page import="com.scv.persistence.dao.EstadoDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.persistence.dao.CampanhaDAO"%>
<%@page import="com.scv.javabean.Pessoa.Escolaridade"%>
<%@page import="com.scv.entities.enums.Sexo"%>
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

	function desabilitarBotao() {
		document.getElementById("saveButton").disabled=true;
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
	
	$('#saveButton').on('click', function() {
		desabilitarBotao();
	});
});
</script>

<meta name="description" content="Página do Usuário do Sistema de Controle de Vacinação">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-white">
	<div id="menu">
		<ul class="w3-navbar w3-light-grey w3-card-2" id="myNavbar">
			<li><b><a href="/userLogin" class="w3-wide">SCV</a></b></li>

			<li class="w3-right w3-hide-small">
				<a class="w3-bottombar w3-border-blue" href="/dados">MEUS DADOS</a>
				<a href="/cartao">CARTÃO DE VACINAÇÃO</a>
				<a href="/calendario">CALENDÁRIO DE VACINAÇÃO</a>
				<a href="/logout">Sair</a>
			</li>

			<li><a href="javascript:void(0)" class="w3-right w3-hide-large w3-hide-medium" onclick="w3_open()"> <i class="fa fa-bars w3-padding-right w3-padding-left"></i>
			</a></li>
		</ul>
	</div>

	<nav class="w3-sidenav w3-margin-0 w3-light-grey w3-card-2 w3-animate-left w3-hide-medium w3-hide-large" style="display: none" id="mySidenav">
		<a href="javascript:void(0)" onclick="w3_close()" class="w3-large w3-padding-16">Fechar ×</a> 
		<a href="/dados" onclick="w3_close()">CADASTRO</a>
		<a href="/cartao" onclick="w3_close()">CARTÃO DE VACINAÇÃO</a> 
		<a href="/calendario" onclick="w3_close()">CALENDÁRIO DE VACINAÇÃO</a> 
		<a href="/logout" onclick="w3_close()">Sair</a>
	</nav>

	<%
		Pessoa usuario = (Pessoa) session.getAttribute("usuario");
		String nome = usuario.getNome().substring(0, usuario.getNome().indexOf(" ")).toUpperCase();
		Sexo genero = usuario.getSexo();
		Escolaridade escolaridade = usuario.getEscolaridade();
		Estado estado = usuario.getEstado();
		Cidade cidade = usuario.getCidade();
		
		List<Pessoa> cadastros = new ArrayList<Pessoa>();
		cadastros.add(usuario);

	%>

	<div class="w3-container w3-padding-64">
			<div class="w3-padding">
				<div class="w3-row">
					<div class="w3-col m3 l6 w3-padding-tiny">
						<table>
							<tr>
								<td>
									<h6><b>Usuário:</b></h6>
								</td>
								<td>
									<select class="w3-input w3-hover-blue" id="usuario" name="usuario">
									<%
									for (Pessoa p : cadastros) {
									%>
										<option value=<%=p.getCodigo()%> <%if (p.getCodigo().equals(usuario.getCodigo())) {%> selected <%}%>><%=p.getNome()%> - <%=p.getDocumento()%></option>
									<%
									}
									%>
									</select>
								</td>
							</tr>
						</table>
					</div>
				</div>
				<hr />
				<form class="w3-container" id="formCadastro" name="formCadastro" action="">
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Nome</label> <input class="w3-input" type="text" id="nome" name="nome" value="<%=usuario.getNome()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Data de Nascimento</label> <input class="w3-input" type="text" id="dtNascimento" name="dtNascimento" value="<%=usuario.getDataNascimento()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Gênero</label> <select class="w3-input" id="genero" name="genero">
								<option value="M" <%if (genero.getValue().equals("M")) {%> selected <%}%>>Masculino</option>
								<option value="F" <%if (genero.getValue().equals("F")) {%> selected <%}%>>Feminino</option>
								<option value="O" <%if (genero.getValue().equals("O")) {%> selected <%}%>>Outro</option>
							</select>
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Nível de Escolaridade</label> <select class="w3-input" id="escolaridade" name="escolaridade">
								<option value=0 <%if (escolaridade.getValue() == 0) {%> selected <%}%>>Não possui</option>
								<option value=1 <%if (escolaridade.getValue() == 1) {%> selected <%}%>>Fundamental</option>
								<option value=2 <%if (escolaridade.getValue() == 2) {%> selected <%}%>>Médio</option>
								<option value=3 <%if (escolaridade.getValue() == 3) {%> selected <%}%>>Superior Incompleto</option>
								<option value=4 <%if (escolaridade.getValue() == 4) {%> selected <%}%>>Superior Completo</option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>CPF</label> <input class="w3-input" type="text" id="cpf" name="cpf" value="<%=usuario.getCpf()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Documento de Identidade</label> <input class="w3-input" type="text" id="documento" name="documento" value="<%=usuario.getDocumento()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Naturalidade</label> <input class="w3-input" type="text" id="naturalidade" name="naturalidade" value="<%=usuario.getNaturalidade()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Nacionalidade</label> <input class="w3-input" type="text" id="nacionalidade" name="nacionalidade" value="<%=usuario.getNacionalidade()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Endereço</label> <input class="w3-input" type="text" id="endereco" name="endereco" value="<%=usuario.getLogradouro()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Complemento</label> <input class="w3-input" type="text" id="complemento" name="complemento" value="<%=usuario.getComplemento()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Bairro</label> <input class="w3-input" type="text" id="bairro" name="bairro" value="<%=usuario.getBairro()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>CEP</label> <input class="w3-input" type="text" id="cep" name="cep" value="<%=usuario.getCep()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Estado</label> <select class="w3-input" id="estado" name="estado">
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

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Cidade</label> <select class="w3-input" id="cidade" name="cidade" >
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

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Telefone</label> <input class="w3-input" type="text" id="telefone" name="telefone" value="<%=usuario.getTelefone()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>E-mail</label> <input class="w3-input" type="text" id="email" name="email" value="<%=usuario.getEmail()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col w3-padding-tiny">
							<button type="reset" id="saveButton" class="w3-btn w3-white w3-border w3-hover-blue w3-right" disabled>
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
