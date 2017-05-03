<%@page import="com.scv.persistence.dao.EstadoDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.persistence.dao.UnidadeDAO"%>
<%@page import="com.scv.javabean.Pessoa.Escolaridade"%>
<%@page import="com.scv.entities.enums.Sexo"%>
<%@page import="com.scv.entities.enums.TipoDocumento"%>
<%@page import="com.scv.javabean.Usuario.TipoUsuario"%>
<%@page import="com.scv.javabean.Usuario"%>
<%@page import="com.scv.javabean.Gerente"%>
<%@page import="com.scv.javabean.Unidade"%>
<%@page import="com.scv.javabean.Estado"%>
<%@page import="com.scv.javabean.Cidade"%>
<%@page import="java.util.*"%>
<%@page import="java.text.SimpleDateFormat"%>

	<%
		Gerente gerente = (Gerente) request.getAttribute("gerente");
		Sexo genero = gerente.getSexo();
		Estado estado = gerente.getEstado();
		Cidade cidade = gerente.getCidade();
		TipoDocumento tipoDocumento = gerente.getTipoDocumento();
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		Usuario usuario = (Usuario) session.getAttribute("login");
		TipoUsuario tipoUsuario = (TipoUsuario) session.getAttribute("tipoUsuario");
		
		
		if (gerente.getCodigo() != null) {
	%>	
				<div class="w3-row">
					<div class="w3-col m6 l5">
						<label><b>Busca por gerente</b></label><br/>
						<input id="searchPessoa" class="w3-padding w3-section w3-border" style="width:80%;" type="text" placeholder="Matrícula, CPF ou Documento de Identificação" autocomplete="off">
						<a id="searchButton" class="w3-button w3-white w3-border w3-hover-blue">
							<i class="fa fa-search"></i>
						</a><br/>
						<label id="infoBusca"></label>
					</div>
				</div>
				<hr />
				<form class="w3-container" id="formCadastro" name="formCadastro" method="POST" action="/gerente">
					<input type="hidden" name="codGer" value=<%=gerente.getCodigo()%>>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Nome</b></label> <input class="w3-input" type="text" id="nome" name="nome" value="<%=gerente.getNome()%>">
						</div>
						
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Matrícula</b></label> <input class="w3-input" type="text" id="matricula" name="matricula" value="<%=gerente.getMatricula()%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Unidade</b></label> <select class="w3-input" id="unidade" name="unidade">
								<%
									List<Unidade> unidades = new ArrayList<Unidade>();
									unidades = UnidadeDAO.getInstance().carregarPorUsuario(usuario);

									for (Unidade u : unidades) {
								%>
								<option value=<%=u.getCodigo()%> <%if (u.getCodigo().equals(gerente.getUnidade().getCodigo())) {%> selected <% } %>><%=u.getNomeFantasia()%></option>
								<%
									}
								%>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Data de Nascimento</b></label> <input class="w3-input" type="text" id="dtNascimento" name="dtNascimento" value="<%=df.format(gerente.getDataNascimento())%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-large">
							<label><b>Gênero</b></label> <select class="w3-input" id="genero" name="genero">
								<option value="M" <%if (genero.getValue().equals("M")) {%> selected <%}%>>Masculino</option>
								<option value="F" <%if (genero.getValue().equals("F")) {%> selected <%}%>>Feminino</option>
								<option value="O" <%if (genero.getValue().equals("O")) {%> selected <%}%>>Outro</option>
							</select>
						</div>
					
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Naturalidade</b></label> <input class="w3-input" type="text" id="naturalidade" name="naturalidade" value="<%=gerente.getNaturalidade()%>">
						</div>

						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Nacionalidade</b></label> <input class="w3-input" type="text" id="nacionalidade" name="nacionalidade" value="<%=gerente.getNacionalidade()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>CPF</b></label> <input class="w3-input" type="text" id="cpf" name="cpf" value="<%=gerente.getCpf()%>">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-large">
							<label><b>Outro Documento</b></label> <select class="w3-input" id="tipodoc" name="tipodoc">
								<option value="1" <%if (tipoDocumento.getValue().equals(1)) {%> selected <%}%>>RG</option>
								<option value="2" <%if (tipoDocumento.getValue().equals(2)) {%> selected <%}%>>Passaporte</option>
								<option value="3" <%if (tipoDocumento.getValue().equals(3)) {%> selected <%}%>>CNH</option>
								<option value="4" <%if (tipoDocumento.getValue().equals(4)) {%> selected <%}%>>CTPS</option>
							</select>
						</div>

						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Número do Documento</b></label> <input class="w3-input" type="text" id="documento" name="documento" value="<%=gerente.getDocumento()%>">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Órgão Emissor</b></label> <input class="w3-input" type="text" id="emissor" name="emissor" value="<%=gerente.getEmissor()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Endereço</b></label> <input class="w3-input" type="text" id="endereco" name="endereco" value="<%=gerente.getLogradouro()%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Complemento</b></label> <input class="w3-input" type="text" id="complemento" name="complemento" value="<%=gerente.getComplemento()%>">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>CEP</b></label> <input class="w3-input" type="text" id="cep" name="cep" value="<%=gerente.getCep()%>">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Bairro</b></label> <input class="w3-input" type="text" id="bairro" name="bairro" value="<%=gerente.getBairro()%>">
						</div>
					
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Estado</b></label> <select class="w3-input" id="estado" name="estado">
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
							<label><b>Cidade</b></label> <select class="w3-input" id="cidade" name="cidade" >
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
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Telefone</b></label> <input class="w3-input" type="text" id="telefone" name="telefone" value="<%=gerente.getTelefone()%>">
						</div>

						<div class="w3-col m5 l6 w3-padding-small">
							<label><b>E-mail</b></label> <input class="w3-input" type="text" id="email" name="email" value="<%=gerente.getEmail()%>">
						</div>
						
						<div class="w3-col m3 l2 w3-padding-large">
							<label><b>Status</b></label> <select class="w3-input" id="status" name="status">
								<option value="true" <%if (gerente.getStatus()) { %> selected <% } %>>Ativo</option>
								<option value="false" <%if (!gerente.getStatus()) { %> selected <% } %>>Inativo</option>
							</select> 
						</div>
					</div>
					<hr />
					<div class="w3-row">
						<div class="w3-col w3-padding-tiny">
							<button type="submit" id="saveButton" class="w3-btn w3-white w3-border w3-hover-green w3-right">
								<i class="fa fa-floppy-o"></i> SALVAR ALTERAÇÕES
							</button>
						</div>
					</div>
				</form>
	<% } else { %>
				<div class="w3-row">
					<div class="w3-col m6 l5">
						<label><b>Busca por gerente</b></label><br/>
						<input id="searchPessoa" class="w3-padding w3-section w3-border" style="width:80%;" type="text" placeholder="CPF, RG, CNH, CTPS, Passaporte ou Certidão de Nasc." autocomplete="off">
						<a id="searchButton" class="w3-button w3-white w3-border w3-hover-blue">
							<i class="fa fa-search"></i>
						</a><br/>
						<label id="infoBusca">Cadastro não encontrado!</label>
					</div>
				</div>
				<hr />
				<form class="w3-container" id="formCadastro" name="formCadastro" method="POST" action="/gerente">
					<input type="hidden" name="codGer" value="">
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Nome</b></label> <input class="w3-input" type="text" id="nome" name="nome" value="">
						</div>
						
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Matrícula</b></label> <input class="w3-input" type="text" id="matricula" name="matricula" value="">
						</div>
						
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Unidade</b></label> <select class="w3-input" id="unidade" name="unidade">
								<%
									List<Unidade> unidades = new ArrayList<Unidade>();
									unidades = UnidadeDAO.getInstance().carregarPorUsuario(usuario);

									for (Unidade u : unidades) {
								%>
								<option value=<%=u.getCodigo()%>><%=u.getNomeFantasia()%></option>
								<%
									}
								%>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Data de Nascimento</b></label> <input class="w3-input" type="text" id="dtNascimento" name="dtNascimento" value="">
						</div>

						<div class="w3-col m6 l3 w3-padding-large">
							<label><b>Gênero</b></label> <select class="w3-input" id="genero" name="genero">
								<option value="M">Masculino</option>
								<option value="F">Feminino</option>
								<option value="O">Outro</option>
							</select>
						</div>
					
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Naturalidade</b></label> <input class="w3-input" type="text" id="naturalidade" name="naturalidade" value="">
						</div>

						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Nacionalidade</b></label> <input class="w3-input" type="text" id="nacionalidade" name="nacionalidade" value="">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>CPF</b></label> <input class="w3-input" type="text" id="cpf" name="cpf" value="">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-large">
							<label><b>Outro Documento</b></label> <select class="w3-input" id="tipodoc" name="tipodoc">
								<option value="1">RG</option>
								<option value="2">Passaporte</option>
								<option value="3">CNH</option>
								<option value="4">CTPS</option>
							</select>
						</div>

						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Número do Documento</b></label> <input class="w3-input" type="text" id="documento" name="documento" value="">
						</div>
						
						<div class="w3-col m6 l3 w3-padding-small">
							<label><b>Órgão Emissor</b></label> <input class="w3-input" type="text" id="emissor" name="emissor" value="">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Endereço</b></label> <input class="w3-input" type="text" id="endereco" name="endereco" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Complemento</b></label> <input class="w3-input" type="text" id="complemento" name="complemento" value="">
						</div>

						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>CEP</b></label> <input class="w3-input" type="text" id="cep" name="cep" value="">
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Bairro</b></label> <input class="w3-input" type="text" id="bairro" name="bairro" value="">
						</div>
					
						<div class="w3-col m4 l4 w3-padding-large">
							<label><b>Estado</b></label> <select class="w3-input" id="estado" name="estado">
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
							<label><b>Cidade</b></label> <select class="w3-input" id="cidade" name="cidade" >
								<option value=""></option>
							</select>
						</div>
					</div>
					<div class="w3-row">
						<div class="w3-col m4 l4 w3-padding-small">
							<label><b>Telefone</b></label> <input class="w3-input" type="text" id="telefone" name="telefone" value="">
						</div>

						<div class="w3-col m5 l6 w3-padding-small">
							<label><b>E-mail</b></label> <input class="w3-input" type="text" id="email" name="email" value="">
						</div>
						
						<div class="w3-col m3 l2 w3-padding-large">
							<label><b>Status</b></label> <select class="w3-input" id="status" name="status">
								<option value="true">Ativo</option>
								<option value="false">Inativo</option>
							</select>
						</div>
					</div>
					<hr />
					<div class="w3-row">
						<div class="w3-col w3-padding-tiny">
							<button type="submit" id="saveButton" class="w3-btn w3-white w3-border w3-hover-green w3-right">
								<i class="fa fa-floppy-o"></i> CADASTRAR GERENTE
							</button>
						</div>
					</div>
				</form>
			<% } %>

