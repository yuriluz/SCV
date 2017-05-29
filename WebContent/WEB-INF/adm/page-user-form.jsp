<%@page import="com.scv.persistence.dao.EstadoDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.javabean.Pessoa.Escolaridade"%>
<%@page import="com.scv.entities.enums.Sexo"%>
<%@page import="com.scv.entities.enums.TipoDocumento"%>
<%@page import="com.scv.javabean.Pessoa"%>
<%@page import="com.scv.javabean.Estado"%>
<%@page import="com.scv.javabean.Cidade"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>

	<%
		Pessoa pessoa = (Pessoa) request.getAttribute("pessoa");
		Sexo genero = pessoa.getSexo();
		Escolaridade escolaridade = pessoa.getEscolaridade();
		Estado estado = pessoa.getEstado();
		Cidade cidade = pessoa.getCidade();
		TipoDocumento tipoDocumento = pessoa.getTipoDocumento();
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		if (pessoa.getCodigo() != null) {
	%>
	
				<div class="w3-row">
					<div class="w3-col m6 l5">
						<label><b>Busca por pessoa</b></label><br/>
						<input id="searchPessoa" class="w3-padding w3-section w3-border" style="width:80%;" type="text" placeholder="CPF, RG, CNH, CTPS, Passaporte ou Certidão de Nasc." autocomplete="off">
						<a id="searchButton" class="w3-button w3-white w3-border w3-hover-blue">
							<i class="fa fa-search"></i>
						</a><br/>
						<label class="w3-small w3-text-red" id="infoBusca"></label>
					</div>
				</div>
				<hr />
				<form class="w3-container" id="formCadastro" name="formCadastro" method="POST" action="#">
					<input type="hidden" name="codPessoa" value=<%=pessoa.getCodigo()%>>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Nome</b></label> <input class="w3-input" type="text" id="nome" name="nome" value="<%=pessoa.getNome()%>" disabled>
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Data de Nascimento</b></label> <input class="w3-input" type="text" id="dtNascimento" name="dtNascimento" value="<%=df.format(pessoa.getDataNascimento())%>" disabled>
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Gênero</b></label> <select class="w3-input" id="genero" name="genero">
								<option value="M" <%if (genero.getValue().equals("M")) {%> selected <%}%>>Masculino</option>
								<option value="F" <%if (genero.getValue().equals("F")) {%> selected <%}%>>Feminino</option>
								<option value="O" <%if (genero.getValue().equals("O")) {%> selected <%}%>>Outro</option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Naturalidade</b></label> <input class="w3-input" type="text" id="naturalidade" name="naturalidade" value="<%=pessoa.getNaturalidade()%>" disabled>
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Nacionalidade</b></label> <input class="w3-input" type="text" id="nacionalidade" name="nacionalidade" value="<%=pessoa.getNacionalidade()%>" disabled>
						</div>
						
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Escolaridade</b></label> <select class="w3-input" id="escolaridade" name="escolaridade" disabled>
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
							<label><b>CPF</b></label> <input class="w3-input" type="text" id="cpf" name="cpf" value="<%=pessoa.getCpf()%>" disabled>
						</div>
						
						<div class="w3-col m6 l3 w3-padding-large">
							<label><b>Outro Documento</b></label> <select class="w3-input" id="tipodoc" name="tipodoc" disabled>
								<option value="1" <%if (tipoDocumento.getValue().equals(1)) {%> selected <%}%>>RG</option>
								<option value="2" <%if (tipoDocumento.getValue().equals(2)) {%> selected <%}%>>Passaporte</option>
								<option value="3" <%if (tipoDocumento.getValue().equals(3)) {%> selected <%}%>>CNH</option>
								<option value="4" <%if (tipoDocumento.getValue().equals(4)) {%> selected <%}%>>CTPS</option>
							</select>
						</div>

						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Número do Documento</b></label> <input class="w3-input" type="text" id="documento" name="documento" value="<%=pessoa.getDocumento()%>" disabled>
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Órgão Emissor</b></label> <input class="w3-input" type="text" id="emissor" name="emissor" value="<%=pessoa.getEmissor()%>" disabled>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Endereço</b></label> <input class="w3-input" type="text" id="endereco" name="endereco" value="<%=pessoa.getLogradouro()%>" disabled>
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Complemento</b></label> <input class="w3-input" type="text" id="complemento" name="complemento" value="<%=pessoa.getComplemento()%>" disabled>
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>CEP</b></label> <input class="w3-input" type="text" id="cep" name="cep" value="<%=pessoa.getCep()%>" disabled>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Bairro</b></label> <input class="w3-input" type="text" id="bairro" name="bairro" value="<%=pessoa.getBairro()%>" disabled>
						</div>
					
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Estado</b></label> <select class="w3-input" id="estado" name="estado" disabled>
								<option value=""></option>
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
							<label><b>Cidade</b></label> <select class="w3-input" id="cidade" name="cidade" disabled>
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
							<label><b>Telefone</b></label> <input class="w3-input" type="text" id="telefone" name="telefone" value="<%=pessoa.getTelefone()%>" disabled>
						</div>

						<div class="w3-col m7 l4 w3-padding-small">
							<label><b>E-mail</b></label> <input class="w3-input" type="text" id="email" name="email" value="<%=pessoa.getEmail()%>" disabled>
						</div>
					</div>
				</form>
	
	<% } else { %>
	
				<div class="w3-row">
					<div class="w3-col m6 l5">
						<label><b>Busca por pessoa</b></label><br/>
						<input id="searchPessoa" class="w3-padding w3-section w3-border" style="width:80%;" type="text" placeholder="CPF, RG, CNH, CTPS, Passaporte ou Certidão de Nasc." autocomplete="off">
						<a id="searchButton" class="w3-button w3-white w3-border w3-hover-blue">
							<i class="fa fa-search"></i>
						</a><br/>
						<label id="infoBusca">Cadastro não encontrado!</label>
					</div>
				</div>
				<hr />
				<form class="w3-container" id="formCadastro" name="formCadastro" method="POST" action="#">
					<input type="hidden" name="codPessoa" value="">
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Nome</b></label> <input class="w3-input" type="text" id="nome" name="nome" value="" disabled>
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Data de Nascimento</b></label> <input class="w3-input" type="text" id="dtNascimento" name="dtNascimento" value="" disabled>
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Gênero</b></label> <select class="w3-input" id="genero" name="genero" disabled>
								<option value="M">Masculino</option>
								<option value="F">Feminino</option>
								<option value="O">Outro</option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Naturalidade</b></label> <input class="w3-input" type="text" id="naturalidade" name="naturalidade" value="" disabled>
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Nacionalidade</b></label> <input class="w3-input" type="text" id="nacionalidade" name="nacionalidade" value="" disabled>
						</div>
						
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Escolaridade</b></label> <select class="w3-input" id="escolaridade" name="escolaridade" disabled>
								<option value=0>Não possui</option>
								<option value=1>Fundamental</option>
								<option value=2>Médio</option>
								<option value=3>Superior Incompleto</option>
								<option value=4>Superior Completo</option>
							</select>
						</div>	
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>CPF</b></label> <input class="w3-input" type="text" id="cpf" name="cpf" value="" disabled>
						</div>
						
						<div class="w3-col m6 l3 w3-padding-large">
							<label><b>Outro Documento</b></label> <select class="w3-input" id="tipodoc" name="tipodoc" disabled>
								<option value="1">RG</option>
								<option value="2">Passaporte</option>
								<option value="3">CNH</option>
								<option value="4">CTPS</option>
							</select>
						</div>

						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Número do Documento</b></label> <input class="w3-input" type="text" id="documento" name="documento" value="" disabled>
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Órgão Emissor</b></label> <input class="w3-input" type="text" id="emissor" name="emissor" value="" disabled>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Endereço</b></label> <input class="w3-input" type="text" id="endereco" name="endereco" value="" disabled>
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Complemento</b></label> <input class="w3-input" type="text" id="complemento" name="complemento" value="" disabled>
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>CEP</b></label> <input class="w3-input" type="text" id="cep" name="cep" value="" disabled>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Bairro</b></label> <input class="w3-input" type="text" id="bairro" name="bairro" value="" disabled>
						</div>
					
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Estado</b></label> <select class="w3-input" id="estado" name="estado" disabled>
								<option value=""></option>
								<%
									List<Estado> estados = new ArrayList<Estado>();
									estados = EstadoDAO.getInstance().carregarTodos();

									for (Estado e : estados) {
								%>
								<option value=<%=e.getCodigo()%>><%=e.getNome()%></option>
								<%
									}
								%>
							</select>
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Cidade</b></label> <select class="w3-input" id="cidade" name="cidade" disabled>
								<option value=""></option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m5 l3 w3-padding-small">
							<label><b>Telefone</b></label> <input class="w3-input" type="text" id="telefone" name="telefone" value="" disabled>
						</div>

						<div class="w3-col m7 l4 w3-padding-small">
							<label><b>E-mail</b></label> <input class="w3-input" type="text" id="email" name="email" value="" disabled>
						</div>
					</div>
				</form>
				
			<% } %>

