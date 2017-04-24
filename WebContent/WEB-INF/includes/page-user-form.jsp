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
						<label>Busca por pessoa</label><br/>
						<input id="searchPessoa" class="w3-padding w3-section w3-border" style="width:80%;" type="text" placeholder="CPF, RG, CNH, CTPS, Passaporte ou Certidão de Nasc." autocomplete="off">
						<a id="searchButton" class="w3-button w3-white w3-border w3-hover-blue">
							<i class="fa fa-search"></i>
						</a><br/>
						<label id="infoBusca"></label>
					</div>
				</div>
				<hr />
				<form class="w3-container" id="formCadastro" name="formCadastro" method="POST" action="/pessoa">
					<input type="hidden" name="codPessoa" value=<%=pessoa.getCodigo()%>>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label>Nome</label> <input class="w3-input" type="text" id="nome" name="nome" value="<%=pessoa.getNome()%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label>Data de Nascimento</label> <input class="w3-input" type="text" id="dtNascimento" name="dtNascimento" value="<%=df.format(pessoa.getDataNascimento())%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label>Gênero</label> <select class="w3-input" id="genero" name="genero">
								<option value="M" <%if (genero.getValue().equals("M")) {%> selected <%}%>>Masculino</option>
								<option value="F" <%if (genero.getValue().equals("F")) {%> selected <%}%>>Feminino</option>
								<option value="O" <%if (genero.getValue().equals("O")) {%> selected <%}%>>Outro</option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label>Naturalidade</label> <input class="w3-input" type="text" id="naturalidade" name="naturalidade" value="<%=pessoa.getNaturalidade()%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label>Nacionalidade</label> <input class="w3-input" type="text" id="nacionalidade" name="nacionalidade" value="<%=pessoa.getNacionalidade()%>">
						</div>
						
						<div class="w3-col m4 l4 w3-padding-large">
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
						<div class="w3-col m6 l3 w3-padding-small">
							<label>CPF</label> <input class="w3-input" type="text" id="cpf" name="cpf" value="<%=pessoa.getCpf()%>">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-large">
							<label>Outro Documento</label> <select class="w3-input" id="tipodoc" name="tipodoc">
								<option value="1" <%if (tipoDocumento.getValue().equals(1)) {%> selected <%}%>>RG</option>
								<option value="2" <%if (tipoDocumento.getValue().equals(2)) {%> selected <%}%>>Passaporte</option>
								<option value="3" <%if (tipoDocumento.getValue().equals(3)) {%> selected <%}%>>CNH</option>
								<option value="4" <%if (tipoDocumento.getValue().equals(4)) {%> selected <%}%>>CTPS</option>
							</select>
						</div>

						<div class="w3-col m6 l3 w3-padding-small">
							<label>Número do Documento</label> <input class="w3-input" type="text" id="documento" name="documento" value="<%=pessoa.getDocumento()%>">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label>Órgão Emissor</label> <input class="w3-input" type="text" id="emissor" name="emissor" value="<%=pessoa.getEmissor()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label>Endereço</label> <input class="w3-input" type="text" id="endereco" name="endereco" value="<%=pessoa.getLogradouro()%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label>Complemento</label> <input class="w3-input" type="text" id="complemento" name="complemento" value="<%=pessoa.getComplemento()%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label>CEP</label> <input class="w3-input" type="text" id="cep" name="cep" value="<%=pessoa.getCep()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label>Bairro</label> <input class="w3-input" type="text" id="bairro" name="bairro" value="<%=pessoa.getBairro()%>">
						</div>
					
						<div class="w3-col m4 l4 w3-padding-large">
							<label>Estado</label> <select class="w3-input" id="estado" name="estado">
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
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label>Telefone</label> <input class="w3-input" type="text" id="telefone" name="telefone" value="<%=pessoa.getTelefone()%>">
						</div>

						<div class="w3-col m6 l4 w3-padding-small">
							<label>E-mail</label> <input class="w3-input" type="text" id="email" name="email" value="<%=pessoa.getEmail()%>">
						</div>
					</div>
					<hr />
					<div class="w3-row">
						<div class="w3-col w3-padding-tiny">
							<button type="submit" id="saveButton" class="w3-btn w3-white w3-border w3-hover-blue w3-right">
								<i class="fa fa-floppy-o"></i> SALVAR ALTERAÇÕES
							</button>
						</div>
					</div>
				</form>
	
	<% } else { %>
	
				<div class="w3-row">
					<div class="w3-col m6 l5">
						<label>Busca por pessoa</label><br/>
						<input id="searchPessoa" class="w3-padding w3-section w3-border" style="width:80%;" type="text" placeholder="CPF, RG, CNH, CTPS, Passaporte ou Certidão de Nasc." autocomplete="off">
						<a id="searchButton" class="w3-button w3-white w3-border w3-hover-blue">
							<i class="fa fa-search"></i>
						</a><br/>
						<label id="infoBusca">Cadastro não encontrado!</label>
					</div>
				</div>
				<hr />
				<form class="w3-container" id="formCadastro" name="formCadastro" method="POST" action="/pessoa">
					<input type="hidden" name="codPessoa" value="">
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label>Nome</label> <input class="w3-input" type="text" id="nome" name="nome" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label>Data de Nascimento</label> <input class="w3-input" type="text" id="dtNascimento" name="dtNascimento" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label>Gênero</label> <select class="w3-input" id="genero" name="genero">
								<option value="M">Masculino</option>
								<option value="F">Feminino</option>
								<option value="O">Outro</option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label>Naturalidade</label> <input class="w3-input" type="text" id="naturalidade" name="naturalidade" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label>Nacionalidade</label> <input class="w3-input" type="text" id="nacionalidade" name="nacionalidade" value="">
						</div>
						
						<div class="w3-col m4 l4 w3-padding-large">
							<label>Nível de Escolaridade</label> <select class="w3-input" id="escolaridade" name="escolaridade">
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
							<label>CPF</label> <input class="w3-input" type="text" id="cpf" name="cpf" value="">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-large">
							<label>Outro Documento</label> <select class="w3-input" id="tipodoc" name="tipodoc">
								<option value="1">RG</option>
								<option value="2">Passaporte</option>
								<option value="3">CNH</option>
								<option value="4">CTPS</option>
							</select>
						</div>

						<div class="w3-col m6 l3 w3-padding-small">
							<label>Número do Documento</label> <input class="w3-input" type="text" id="documento" name="documento" value="">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label>Órgão Emissor</label> <input class="w3-input" type="text" id="emissor" name="emissor" value="">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label>Endereço</label> <input class="w3-input" type="text" id="endereco" name="endereco" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label>Complemento</label> <input class="w3-input" type="text" id="complemento" name="complemento" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label>CEP</label> <input class="w3-input" type="text" id="cep" name="cep" value="">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label>Bairro</label> <input class="w3-input" type="text" id="bairro" name="bairro" value="">
						</div>
					
						<div class="w3-col m4 l4 w3-padding-large">
							<label>Estado</label> <select class="w3-input" id="estado" name="estado">
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
							<label>Cidade</label> <select class="w3-input" id="cidade" name="cidade" >
								<option value=""></option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label>Telefone</label> <input class="w3-input" type="text" id="telefone" name="telefone" value="">
						</div>

						<div class="w3-col m6 l4 w3-padding-small">
							<label>E-mail</label> <input class="w3-input" type="text" id="email" name="email" value="">
						</div>
					</div>
					<hr />
					<div class="w3-row">
						<div class="w3-col w3-padding-tiny">
							<button type="submit" id="saveButton" class="w3-btn w3-white w3-border w3-hover-blue w3-right">
								<i class="fa fa-floppy-o"></i> CADASTRAR USUÁRIO
							</button>
						</div>
					</div>
				</form>
				
			<% } %>

