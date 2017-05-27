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

<jsp:include page="/WEB-INF/includes/menu/user-menu.jsp">
	<jsp:param name="tipo" value="3"/>
</jsp:include>

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
		
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");

	%>

	<div class="w3-container w3-padding-32">
					<div class="w3-row">
						<div class="w3-col">
							<table class="w3-table w3-bordered w3-border">
								<tr class="w3-blue">
									<th>Vacina</th><th>Data</th><th class="w3-hide-medium w3-hide-small">Profissional responsável</th><th class="w3-hide-medium w3-hide-small">Fabricante e número de lote</th><th class="w3-hide-medium w3-hide-small">Validade</th><th>Unidade de Saúde</th>
								</tr>
								<%
									for (Registro r : registros) {
								%>
									<tr>
										<td><%=r.getVacina().getNome()%></td><td><%=df.format(r.getDataVacina())%></td><td class="w3-hide-medium w3-hide-small"><%=r.getConsulta().getVacinador().getNome() == null ? (r.getVerificado() ? r.getVerificador().getNome() + " (verificado em " + df.format(r.getDataVerificacao()) + ")" : "Ainda não verificado") : r.getConsulta().getVacinador().getNome() %></td><td class="w3-hide-medium w3-hide-small"><%=r.getLote()%></td><td class="w3-hide-medium w3-hide-small"><%=df.format(r.getDataValidade())%></td><td><%=r.getConsulta().getUnidade().getNomeFantasia()%></td>
									</tr>
								<%
									}
								%>
							</table>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col w3-padding-32">
							<form action="/imprimirCartao" method="POST" target="_blank">
								<input type="hidden" id="codPessoa" name="codPessoa" value="<%=usuario.getCodigo()%>">
								<input type="hidden" id="print" name="print" value="2">
								<button id="printButton" type="submit" id="searchButton" class="w3-button w3-white w3-border w3-hover-blue">
									<i class="fa fa-print"></i> IMPRIMIR CARTÃO DE VACINAÇÃO
								</button>
							</form>
						</div>
					</div>
			</div>
		
	<script src="./resources/scripts/navigation.js"></script>
	
</body>
</html>
