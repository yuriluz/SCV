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
<title>Sistema de Controle de Vacina��o (SCV)</title>

<meta name="viewport" content="width=device-width, initial-scale=1">

<link rel="stylesheet" href="http://www.w3schools.com/lib/w3.css">
<link rel="stylesheet" href="./resources/styles/style.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Raleway">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">

<script src="./resources/scripts/jquery-1.12.4.js"></script>
<script src="./resources/scripts/jquery-ui.js"></script>

<meta name="description" content="Sistema de Controle de Vacina��o">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-white">

<jsp:include page="/WEB-INF/includes/menu/adm-menu.jsp">
	<jsp:param name="selecionado" value="2"/>
</jsp:include>

	<%
		Pessoa pessoa = (Pessoa) request.getAttribute("pessoa");
	
	%>

	<div class="w3-container w3-padding-32">
			<div class="w3-padding">
				<div class="w3-row">
					<div class="w3-col l6 w3-padding-tiny">
						<form id="buscaUsuario" method="POST" action="/cartao">
							<label><b>Informe o n�mero do documento</b></label>
							<div class="w3-bar">
								<input id="idPessoa" name="idPessoa" class="w3-bar-item w3-input w3-border" style="width:72%; min-width:120px;" type="text" placeholder="CPF, RG, CNH, CTPS, Passaporte ou Certid�o de Nascimento" autocomplete="off">
								<button type="submit" id="searchButton" class="w3-bar-item w3-button w3-white w3-border w3-hover-blue">
									<i class="fa fa-search"></i>
								</button>
							</div>
						</form>
					</div>
				</div>
				<hr />
				<% if (pessoa != null) {
					Sexo sexoPessoa = pessoa.getSexo();
					String sexo = "Outro";
					String tipoDoc = "";
					String nDoc = "";
					
					if (sexoPessoa.getValue().equals("M")) {
						sexo = "Masculino";
					} else if (sexoPessoa.getValue().equals("F")) {
						sexo = "Feminino";
					} else if (sexoPessoa.getValue().equals("")) { 
						sexo = "Outro";
					}
					
					if (!pessoa.getDocumento().isEmpty()) {
						switch(pessoa.getTipoDocumento()) {
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
						nDoc = pessoa.getDocumento();
					} else {
						tipoDoc = "CPF";
						nDoc = pessoa.getCpf();
					}
					
					SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
					
					List<Registro> registros = RegistroDAO.getInstance().carregarPorPessoa(pessoa);
					
			%>
				<div class="w3-row">
						<div class="w3-col w3-padding-tiny w3-center">
							<h5><b>CART�O DE VACINA��O</b></h5>
						</div>
				</div>
					<div class="w3-row">
						<div class="w3-col">
							<p><b>Nome: </b><%=pessoa.getNome().toUpperCase()%></p> 
						</div>
					</div>
					
					<div class="w3-row">
						<div class="w3-col m4 l4">
							<p><b>Sexo: </b><%=sexo.toUpperCase()%></p> 
						</div>
					
						<div class="w3-col m4 l4">
							<p><b>Data de Nascimento: </b><%=df.format(pessoa.getDataNascimento())%></p>
						</div>
						
						<div class="w3-col m4 l4">
							<p><b>Nacionalidade: </b><%=pessoa.getNacionalidade()%></p>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col">
							<p><b>Documento nacional de identifica��o: </b><%=tipoDoc%> - <%=nDoc%> - <%=pessoa.getEmissor()%></p>
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
									<th>Vacina</th><th>Data</th><th>Cl�nico ou agente de sa�de respons�vel</th><th>Fabricante e n�mero de lote</th><th>Validade</th><th>Unidade de Sa�de</th>
								</tr>
								<%
									for (Registro r : registros) {
										if (r.getVerificado()) {
								%>
									<tr>
										<td><%=r.getVacina().getNome()%></td><td><%=df.format(r.getDataVacina())%></td><td><%=r.getConsulta().getVacinador().getNome() == null ? r.getVerificador().getNome() + " (verificado em " + df.format(r.getDataVerificacao()) + ")" : r.getConsulta().getVacinador().getNome() %></td><td><%=r.getLote()%></td><td><%=df.format(r.getDataValidade())%></td><td><%=r.getConsulta().getUnidade().getNomeFantasia()%></td>
									</tr>
								<%
										}
									}
								%>
							</table>
						</div>
					</div>
					<% } %>
			</div>
		</div>
		
	<script src="./resources/scripts/navigation.js"></script>
	
</body>
</html>
