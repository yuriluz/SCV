<%@page import="com.scv.javabean.Pessoa"%>
<%@page import="com.scv.javabean.Registro"%>
<%@page import="com.scv.persistence.dao.RegistroDAO"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>

	<%
		Pessoa pessoa = (Pessoa) request.getAttribute("pessoa");
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
	
		if (pessoa.getCodigo() != null) {
			
			List<Registro> registros = RegistroDAO.getInstance().carregarPorPessoa(pessoa);
	%>
	<div class="w3-row">
		<div class="w3-col m6 l5">
			<label>Informe o número do documento</label><br/>
			<input id="searchPessoa" class="w3-padding w3-section w3-border" style="width:80%;" type="text" placeholder="CPF, RG, CNH, CTPS, Passaporte ou Certidão de Nasc." autocomplete="off">
			<a id="searchButton" class="w3-button w3-white w3-border w3-hover-blue">
				<i class="fa fa-search"></i>
			</a>
			<label id="infoPessoa"></label>
		</div>
	</div>
	<hr />
	<div class="w3-row">
		<h5><b>Paciente:</b> <%=pessoa.getCodigo()%> - <%=pessoa.getNome()%></h5>
		<h5><b>Vacinações não confirmadas:</b></h5>
		<ul class="w3-ul">
		<% for (Registro registro : registros) {
			if (!registro.getVerificado().booleanValue()) {
		%>
			<li class="w3-row w3-padding-large">
			<div class="w3-col s2 m1 l1">
				<input class="w3-check" type="checkbox" name="confRegistros" value=<%=registro.getCodigo()%>>
			</div>
			<div class="w3-col s10 m11 l11">
  				<span class="w3-large"><%=registro.getVacina().getNome()%> - <%=registro.getVacina().getDescricao()%></span><br>
  				<span>Local: <%=registro.getConsulta().getUnidade().getNomeFantasia()%> | Data: <%=df.format(registro.getDataVacina())%> </span>
  			</div>
			</li>
		<%
			}
		}
		%>
		</ul>
	</div>
	<hr />
	<div class="w3-row">
		<button type="submit" id="registerButton" class="w3-button w3-white w3-border w3-hover-green w3-right">
			<i class="fa fa-check"></i> CONFIRMAR VACINAÇÕES
		</button>
	</div>		
	<% } else { %>
	<div class="w3-row">
		<div class="w3-col m6 l5">
			<label>Informe o número do documento</label><br/>
			<input id="searchPessoa" class="w3-padding w3-section w3-border" style="width:80%;" type="text" placeholder="CPF, RG, CNH, CTPS, Passaporte ou Certidão de Nasc." autocomplete="off">
			<a id="searchButton" class="w3-button w3-white w3-border w3-hover-blue">
				<i class="fa fa-search"></i>
			</a><br/>
			<label id="infoPessoa">Pessoa não encontrada!</label>
		</div>
	</div>
	<hr />
	<div class="w3-row">
	</div>
	<hr />
	<div class="w3-row">
		<button type="submit" id="registerButton" class="w3-button w3-white w3-border w3-hover-green w3-right w3-hide" disabled>
			<i class="fa fa-check"></i> CONFIRMAR VACINAÇÕES
		</button>
	</div>		
	<% } %>
