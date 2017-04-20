<%@page import="com.scv.persistence.dao.VacinaDAO"%>
<%@page import="com.scv.persistence.dao.PessoaDAO"%>
<%@page import="com.scv.persistence.dao.EstadoDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.persistence.dao.UnidadeDAO"%>
<%@page import="com.scv.javabean.Pessoa"%>
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
	
	function updateCenters(cidade) {
		if (cidade == "") {
			document.getElementById("unidade").innerHTML = "";
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
				document.getElementById("unidade").innerHTML = this.responseText;
			}
		}
		xmlhttp
				.open("GET", "loadCenters?cidade=" + cidade,
						true);
		xmlhttp.send();
	}
	
	var counter = 1;

	function addItem(){
		counter++;
		var div = document.getElementById('item').cloneNode(true);
		div.id = '';
		var newItem = div.childNodes;
		for (var i=0; i<newItem.length; i++) {
			
			var fields = newItem[i].childNodes;
			for (var j=0; j<fields.length; j++) {
				var fieldName = fields[j].name
				if (fieldName) {
					fields[j].name = fields[j].id + counter;
					fields[j].setAttribute("class", "w3-input w3-margin-top");
				}
				if (fields[j].tagName == "LABEL")
					fields[j].setAttribute("class", "w3-margin-top w3-hide-medium w3-hide-large");
				if (fields[j].tagName == "BUTTON")
					fields[j].removeAttribute("disabled");
			}
		}
		
		document.getElementById("nVacinas").setAttribute("value", counter);
		document.getElementById("vacinas").appendChild(div);
	}
	
	$('#estado').on('change', function() {
		updateCities(this.value);
	});
	
	$('#cidade').on('change', function() {
		updateCenters(this.value);
	});
	
	$(document).on('click', '#addButton', function() {
		addItem();
	});

});
</script>

<meta name="description" content="Sistema de Controle de Vacinação">
<meta name="author" content="Yuri Luz">
</head>
<body class="w3-white">

<jsp:include page="/WEB-INF/includes/menu/user-menu.jsp">
	<jsp:param name="tipo" value="4"/>
</jsp:include>

	<%
	List<Vacina> vacinas = VacinaDAO.getInstance().carregarTodos();
	Pessoa pessoa = (Pessoa) session.getAttribute("usuario");
	Date hoje = new Date();
	SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	Unidade unidade = new Unidade();
	Estado estado = pessoa.getEstado();
	Cidade cidade = pessoa.getCidade();
	
	List<Pessoa> cadastros = new ArrayList<Pessoa>();
	cadastros.add(pessoa);
	%>

	<div class="w3-container w3-padding-32">
			<div class="w3-padding">
				<form id="registroVacina" method="POST" action="/registro">
					<div id="dadosPessoa" class="w3-row">
						<div class="w3-col m6 l5">
							<label>Selecione o Cartão de Vacinação</label><br/>
							<select class="w3-input w3-hover-blue" id="usuario" name="usuario">
									<%
									for (Pessoa p : cadastros) {
									%>
										<option value=<%=p.getCodigo()%> <%if (p.getCodigo().equals(pessoa.getCodigo())) {%> selected <%}%>><%=p.getNome()%> - <%=p.getDocumento()%></option>
									<%
									}
									%>
							</select>
							<input type="hidden" name="codPessoa" value="1">
						</div>
					</div>
					<hr />
					<div class="w3-row">
							<div class="w3-col m3 l3 w3-padding-tiny">
								<label>Data da consulta</label>
								<input class="w3-input" type="text" name="dtConsulta" value=<%=df.format(hoje) %> disabled>
							</div>
							<div class="w3-col m3 l3 w3-padding-tiny">
								<label>Estado da Unidade de Saúde</label>
									<select class="w3-input" id="estado" name="estado">
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
							<div class="w3-col m3 l3 w3-padding-tiny">
								<label>Cidade da Unidade de Saúde</label>
								<select class="w3-input" id="cidade" name="cidade" >
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
							<div class="w3-col m3 l3 w3-padding-tiny">
								<label>Unidade de Saúde</label>
								<select class="w3-input" id="unidade" name="unidade" >
								<%
									List<Unidade> unidades = new ArrayList<Unidade>();
									unidades = UnidadeDAO.getInstance().carregarPorCidade(cidade);

									for (Unidade u : unidades) {
								%>
									<option value=<%=u.getCodigo()%>><%=u.getNomeFantasia()%></option>
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
							<input type="hidden" id="nVacinas" name="nVacinas" value="1">
						</div>
					</div>
					<div id="vacinas" class="w3-row w3-border w3-padding">
						<div class="w3-row" id="item">
							<div class="w3-col m3 l3 w3-padding-small">
								<label>Vacina</label>
								<select class="w3-input" id="vacina" name="vacina1">
									<% for (Vacina v : vacinas) { %>
										<option value=<%=v.getCodigo()%>><%=v.getNome()%> | <%=v.getDescricao()%></option>
									<% } %>
								</select>
							</div>
							<div class="w3-col m3 l3 w3-padding-small">
								<label>Data da Vacinação</label>
								<input class="w3-input" type="text" id="dataVacina" name="dataVacina1" value="">
							</div>
							<div class="w3-col m3 l3 w3-padding-small">
								<label>Lote</label>
								<input class="w3-input" type="text" id="loteVacina" name="loteVacina1" value="">
							</div>
							<div class="w3-col m3 l3 w3-padding-small w3-margin-top">
								<button class="w3-button w3-white w3-border w3-hover-red" onclick="this.parentNode.parentNode.parentNode.removeChild(this.parentNode.parentNode);" disabled>
									<i class="fa fa-trash"></i> REMOVER
								</button>
							</div>
						</div>
					</div>
					<div class="w3-row w3-padding">
							<a id="addButton" class="w3-button w3-white w3-border w3-hover-blue">
								<i class="fa fa-plus-circle"></i> VACINAS
							</a>
					</div>	
					<hr />
					<div class="w3-row">
							<button type="submit" id="registerButton" class="w3-button w3-white w3-border w3-hover-green">
								<i class="fa fa-check"></i> REGISTRAR
							</button>
					</div>
				</form>
			</div>
		</div>
		
	<script src="./resources/scripts/navigation.js"></script>
	
</body>
</html>
