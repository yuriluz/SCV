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
<body class="w3-light-grey">
	<div id="menu">
		<ul class="w3-navbar w3-white w3-card-2" id="myNavbar">
			<li><a href="#home" class="w3-wide">SCV</a></li>

			<li class="w3-right w3-hide-small"><a href="">CARTÃO DE VACINAÇÃO</a> <a href="">CALENDÁRIO DE VACINAÇÃO</a></li>

			<li><a href="javascript:void(0)" class="w3-right w3-hide-large w3-hide-medium" onclick="w3_open()"> <i class="fa fa-bars w3-padding-right w3-padding-left"></i>
			</a></li>
		</ul>
	</div>

	<nav class="w3-sidenav w3-margin-0 w3-white w3-card-2 w3-animate-left w3-hide-medium w3-hide-large" style="display: none" id="mySidenav">
		<a href="javascript:void(0)" onclick="w3_close()" class="w3-large w3-padding-16">Fechar ×</a> <a href="" onclick="w3_close()">CARTÃO DE VACINAÇÃO</a> <a href="" onclick="w3_close()">CALENDÁRIO DE VACINAÇÃO</a>
	</nav>

	<%
		Pessoa usuario = (Pessoa) request.getAttribute("usuario");
		String nome = usuario.getNome().substring(0, usuario.getNome().indexOf(" ")).toUpperCase();
		Sexo genero = usuario.getSexo();
		Escolaridade escolaridade = usuario.getEscolaridade();
		Estado estado = usuario.getEstado();
		Cidade cidade = usuario.getCidade();
		String msg = "SEJA BEM VINDX, ";
		if (genero.getValue().equals("M")) {
			msg = "SEJA BEM VINDO, ";
		} else if (genero.getValue().equals("F")) {
			msg = "SEJA BEM VINDA, ";
		}
	%>

	<div class="w3-container w3-padding-64">
		<div class="w3-card-2 w3-white w3-animate-opacity" id="userInfo">
			<header class="w3-container w3-blue">
				<h3 class="w3-center" style="color: #ffffff;"><%=msg.concat(nome)%>!
				</h3>
			</header>
			<div class="w3-padding">
				<h5 class="w3-center">
					<i class="w3-large fa fa-user"></i> Seus dados:
				</h5>
				<form class="w3-container" action="">
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Nome</label> <input class="w3-input" type="text" id="nome" name="nome" value="<%=usuario.getNome()%>" disabled>
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Data de Nascimento</label> <input class="w3-input" type="text" id="dtNascimento" name="dtNascimento" value="<%=usuario.getDataNascimento()%>" disabled>
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Gênero</label> <select class="w3-input" id="genero" name="genero" disabled>
								<option value="M" <%if (genero.getValue().equals("M")) {%> selected <%}%>>Masculino</option>
								<option value="F" <%if (genero.getValue().equals("F")) {%> selected <%}%>>Feminino</option>
								<option value="O" <%if (genero.getValue().equals("O")) {%> selected <%}%>>Outro</option>
							</select>
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Nível de Escolaridade</label> <select class="w3-input" id="escolaridade" name="escolaridade" disabled>
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
							<label>CPF</label> <input class="w3-input" type="text" id="cpf" name="cpf" value="<%=usuario.getCpf()%>" disabled>
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Documento de Identidade</label> <input class="w3-input" type="text" id="documento" name="documento" value="<%=usuario.getDocumento()%>" disabled>
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Naturalidade</label> <input class="w3-input" type="text" id="naturalidade" name="naturalidade" value="<%=usuario.getNaturalidade()%>" disabled>
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Nacionalidade</label> <input class="w3-input" type="text" id="nacionalidade" name="nacionalidade" value="<%=usuario.getNacionalidade()%>" disabled>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Endereço</label> <input class="w3-input" type="text" id="endereco" name="endereco" value="<%=usuario.getLogradouro()%>" disabled>
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Complemento</label> <input class="w3-input" type="text" id="complemento" name="complemento" value="<%=usuario.getComplemento()%>" disabled>
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Bairro</label> <input class="w3-input" type="text" id="bairro" name="bairro" value="<%=usuario.getBairro()%>" disabled>
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>CEP</label> <input class="w3-input" type="text" id="cep" name="cep" value="<%=usuario.getCep()%>" disabled>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>Estado</label> <select class="w3-input" id="estado" name="estado" disabled>
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
							<label>Cidade</label> <select class="w3-input" id="cidade" name="cidade" disabled>
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
							<label>Telefone</label> <input class="w3-input" type="text" id="telefone" name="telefone" value="<%=usuario.getTelefone()%>" disabled>
						</div>

						<div class="w3-col m6 l3 w3-padding-tiny">
							<label>E-mail</label> <input class="w3-input" type="text" id="email" name="email" value="<%=usuario.getEmail()%>" disabled>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m12 l4 w3-padding-tiny">
							<button type="reset" id="cancelButton" class="w3-btn w3-white w3-border w3-hover-red w3-right" style="display: none" onclick="desabilitarCampos()">
								CANCELAR <i class="fa fa-close"></i>
							</button>
						</div>
						<div class="w3-col m12 l4 w3-padding-tiny">
							<button type="reset" id="saveButton" class="w3-btn w3-white w3-border w3-hover-green w3-right" style="display: none" onclick="desabilitarCampos()">
								GRAVAR <i class="fa fa-floppy-o"></i>
							</button>
						</div>
						<div class="w3-col m12 l4 w3-padding-tiny">
							<button type="reset" id="editButton" class="w3-btn w3-white w3-border w3-hover-blue w3-right" onclick="habilitarCampos()">
								EDITAR <i class="fa fa-pencil-square-o"></i>
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="./resources/scripts/user-home.js"></script>
	<script src="./resources/scripts/navigation.js"></script>
</body>
</html>
