<%@page import="com.scv.persistence.dao.RegistroDAO"%>
<%@page import="com.scv.entities.enums.Sexo"%>
<%@page import="com.scv.javabean.Pessoa"%>
<%@page import="com.scv.javabean.Registro"%>
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
				<a href="/dados">MEUS DADOS</a>
				<a class="w3-bottombar w3-border-blue" href="/cartao">CARTÃO DE VACINAÇÃO</a>
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
		Sexo userSexo = usuario.getSexo();
		String sexo = "Outro";
		String tipoDoc = "";
		String nDoc = "";
		
		if (userSexo.getValue().equals("M")) {
			sexo = "Masculino";
		} else if (userSexo.getValue().equals("F")) {
			sexo = "Feminino";
		} else if (userSexo.getValue().equals("")) { 
			sexo = "Outro";
		}
		
		if (!usuario.getDocumento().isEmpty()) {
			switch(usuario.getTipoDocumento()) {
			case RG:
				tipoDoc = "RG";
				break;
			case CNH:
				tipoDoc = "CNH";
				break;
			case CTPS:
				tipoDoc = "CTPS";
				break;
			case PASSAPORTE:
				tipoDoc = "Passaporte";
				break;
			}
			nDoc = usuario.getDocumento();
		} else {
			tipoDoc = "CPF";
			nDoc = usuario.getCpf();
		}
		
		List<Registro> registros = RegistroDAO.getInstance().carregarPorPessoa(usuario);
		
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
									<h6><b>Selecione um cartão de vacinação:</b></h6>
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
				<div class="w3-row">
						<div class="w3-col w3-padding-tiny w3-center">
							<h5><b>CARTÃO DE VACINAÇÃO (NÃO OFICIAL)</b></h5>
						</div>
				</div>
					<div class="w3-row">
						<div class="w3-col">
							<p><b>Nome: </b><%=usuario.getNome().toUpperCase()%></p> 
						</div>
					</div>
					
					<div class="w3-row">
						<div class="w3-col m4 l4">
							<p><b>Sexo: </b><%=sexo.toUpperCase()%></p> 
						</div>
					
						<div class="w3-col m4 l4">
							<p><b>Data de Nascimento: </b><%=usuario.getDataNascimento()%></p>
						</div>
						
						<div class="w3-col m4 l4">
							<p><b>Nacionalidade: </b><%=usuario.getNacionalidade()%></p>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col">
							<p><b>Documento nacional de identificação: </b><%=tipoDoc%> - <%=nDoc%> - <%=usuario.getEmissor()%></p>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col">
							<p><b>Foi vacinado nas datas indicadas contra: </b></p>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col">
							<table class="w3-table w3-bordered w3-border">
								<tr>
									<th>Vacina</th><th>Data</th><th>Clínico ou agente de saúde responsável</th><th>Fabricante e número de lote</th><th>Validade</th><th>Unidade de Saúde</th>
								</tr>
								<%
									for (Registro r : registros) {
								%>
									<tr>
										<td><%=r.getVacina().getNome()%></td><td><%=r.getDataVacina()%></td><td><%=r.getConsulta().getVacinador().getNome()%></td><td><%=r.getLote()%></td><td><%=r.getDataValidade()%></td><td><%=r.getConsulta().getUnidade().getNomeFantasia()%></td>
									</tr>
								<%
									}
								%>
							</table>
						</div>
					</div>
			</div>
		</div>
		
	<script src="./resources/scripts/navigation.js"></script>
	
</body>
</html>
