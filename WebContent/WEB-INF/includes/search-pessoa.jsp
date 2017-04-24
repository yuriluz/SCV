<%@page import="com.scv.javabean.Pessoa"%>

	<%
		Pessoa pessoa = (Pessoa) request.getAttribute("pessoa");
	
		if (pessoa.getCodigo() != null) {
	%>
		<div class="w3-col m6 l5">
			<label><b>Informe o número do documento</b></label><br/>
			<input id="searchPessoa" class="w3-padding w3-section w3-border" style="width:80%;" type="text" placeholder="CPF, RG, CNH, CTPS, Passaporte ou Certidão de Nasc." autocomplete="off">
			<a id="searchButton" class="w3-button w3-white w3-border w3-hover-blue">
				<i class="fa fa-search"></i>
			</a>
			<input type="hidden" name="codPessoa" value=<%=pessoa.getCodigo()%>>
			<label id="nomePessoa"><b>Paciente:</b> <%=pessoa.getCodigo()%> - <%=pessoa.getNome()%></label>
		</div>
	<% } else { %>
		<div class="w3-col m6 l5">
			<label><b>Informe o número do documento</b></label><br/>
			<input id="searchPessoa" class="w3-padding w3-section w3-border" style="width:80%;" type="text" placeholder="CPF, RG, CNH, CTPS, Passaporte ou Certidão de Nasc." autocomplete="off">
			<a id="searchButton" class="w3-button w3-white w3-border w3-hover-blue">
				<i class="fa fa-search"></i>
			</a>
			<input type="hidden" name="codPessoa" value="">
			<label id="nomePessoa">Paciente não encontrado!</label>
		</div>
	<% } %>
