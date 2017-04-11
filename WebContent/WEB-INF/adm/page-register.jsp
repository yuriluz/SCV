<%@page import="com.scv.persistence.dao.VacinaDAO"%>
<%@page import="com.scv.persistence.dao.PessoaDAO"%>
<%@page import="com.scv.persistence.dao.CampanhaDAO"%>
<%@page import="com.scv.persistence.dao.UnidadeDAO"%>
<%@page import="com.scv.javabean.Usuario.TipoUsuario"%>
<%@page import="com.scv.javabean.Gerente"%>
<%@page import="com.scv.javabean.Vacinador"%>
<%@page import="com.scv.javabean.Campanha"%>
<%@page import="com.scv.javabean.Estado"%>
<%@page import="com.scv.javabean.Cidade"%>
<%@page import="com.scv.javabean.Vacina"%>
<%@page import="com.scv.javabean.Campanha"%>
<%@page import="com.scv.javabean.Unidade"%>
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
		function updateUser(documento) {
			if (documento == "") {
				document.getElementById("nomePessoa").text = "Informe os dados da pessoa!";
				return;
			} else {
				Pessoa pessoa;
				pessoa = PessoaDAO.getInstance().carregarPorDocumento(documento);
				
				if (pessoa != null) {
					document.getElementById("nomePessoa").text = pessoa.getNome();
				} else {
					document.getElementById("nomePessoa").text = "Pessoa não encontrada.";
				}
				
				return;
			}
		}
		
		$('#searchButton').on('click', function() {
			updatePessoa($('#searchPessoa').value);
		});
	});
</script>

<meta name="description" content="Sistema de Controle de Vacinação">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-white">

<jsp:include page="/WEB-INF/includes/menu/adm-menu.jsp">
	<jsp:param name="selecionado" value="4"/>
</jsp:include>

	<%
	List<Vacina> vacinas = VacinaDAO.getInstance().carregarTodos();
	TipoUsuario tipoUsuario = (TipoUsuario) session.getAttribute("tipoUsuario");
	List<Campanha> campanhas = new ArrayList<Campanha>();
	Date hoje = new Date();
	SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	Unidade unidade = new Unidade();
	Estado estado;
	Cidade cidade;

	if (tipoUsuario.equals(TipoUsuario.GERENTE)) {
		Gerente gerente = (Gerente) session.getAttribute("gerente");
		estado = gerente.getUnidade().getEstado();
		cidade = gerente.getUnidade().getCidade();
		unidade = gerente.getUnidade();
		
		if (!estado.equals(null) && !cidade.equals(null)){
			campanhas.addAll(CampanhaDAO.getInstance().carregarTodasEmAndamento());
			campanhas.addAll(CampanhaDAO.getInstance().carregarTodasEmAndamento(estado, cidade));
		} else {
			campanhas.addAll(CampanhaDAO.getInstance().carregarTodasEmAndamento());
		}
	} else if (tipoUsuario.equals(TipoUsuario.VACINADOR)) {
		Vacinador vacinador = (Vacinador) session.getAttribute("vacinador");
		estado = vacinador.getUnidade().getEstado();
		cidade = vacinador.getUnidade().getCidade();
		unidade = vacinador.getUnidade();
		
		if (!estado.equals(null) && !cidade.equals(null)){
			campanhas.addAll(CampanhaDAO.getInstance().carregarTodasEmAndamento());
			campanhas.addAll(CampanhaDAO.getInstance().carregarTodasEmAndamento(estado, cidade));
		} else {
			campanhas.addAll(CampanhaDAO.getInstance().carregarTodasEmAndamento());
		}
	}

	%>

	<div class="w3-container w3-padding-64">
			<div class="w3-padding">
				<form id="buscaUsuario" method="POST" action="/vacinacao">
					<div class="w3-row">
						<div class="w3-col l6 w3-padding-tiny">
							<label>Informe o número do documento</label>
							<input type="hidden" name="codPessoa" value="">
							<div class="w3-bar">
								<input id="searchPessoa" class="w3-bar-item w3-input w3-border" style="width:72%; min-width:120px;" type="text" placeholder="CPF, RG, CNH, CTPS, Passaporte ou Certidão de Nascimento" autocomplete="off">
								<a id="searchButton" class="w3-bar-item w3-button w3-white w3-border w3-hover-blue">
									<i class="fa fa-search"></i>
								</a>
								<label id="nomePessoa"></label>
							</div>
						</div>
					</div>
					<hr />
					<div class="w3-row">
							<div class="w3-col m4 l4 w3-padding-tiny w3-center">
								<label>Data da consulta</label>
								<input class="w3-input" type="text" name="dtConsulta" value=<%=df.format(hoje) %> disabled>
							</div>
							<div class="w3-col m4 l4 w3-padding-tiny w3-center">
								<label>Unidade de Saúde</label>
								<input type="hidden" name="codUnidade" value=<%=unidade.getCodigo()%>>
								<input class="w3-input" type="text" name="nomeUnidade" value=<%=unidade.getNomeFantasia()%> disabled>
							</div>
							<div class="w3-col m4 l4 w3-padding-tiny w3-center">
								<label>Campanha</label>
								<select class="w3-input" id="campanha" name="campanha">
									<option value=""></option>
									<%
										for (Campanha c : campanhas) {
									%>
									<option value=<%=c.getCodigo()%>><%=c.getNome()%></option>
									<%
										}
									%>
								</select>
							</div>
					</div>
					<hr />
					<div class="w3-row">
						<div class="w3-col">
							<h6><b>Vacinas</b></h6> 
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m3 l3 w3-padding-small">
							<label>Vacina</label>
							<select class="w3-input" id="vacina_1" name="vacina_1">
								<%
									for (Vacina v : vacinas) {
								%>
								<option value=<%=v.getCodigo()%>><%=v.getNome()%></option>
								<%
									}
								%>
							</select>
						</div>
						<div class="w3-col m3 l3 w3-padding-small">
							<label>Data da Vacinação</label>
							<input class="w3-input" type="text" name="dataVacina_1" value="">
						</div>
						<div class="w3-col m3 l3 w3-padding-small">
							<label>Lote</label>
							<input class="w3-input" type="text" name="loteVacina_1" value="">
						</div>
						<div class="w3-rest w3-padding-large w3-margin-top">
							<a><i class="fa fa-close w3-text-red"></i></a>
						</div>
					</div>
					<hr />
					<div class="w3-row">
						<div class="w3-col">
							<button type="submit" id="registerButton" class="w3-button w3-white w3-border w3-hover-blue">
									REGISTRAR
							</button>
						</div>
					</div>
				</form>
			</div>
		</div>
		
	<script src="./resources/scripts/navigation.js"></script>
	
</body>
</html>
