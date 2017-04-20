<%@page import="com.scv.persistence.dao.UnidadeDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.javabean.Unidade"%>
<%@page import="com.scv.javabean.Cidade"%>
<%@page import="java.util.*"%>

	<%
		Cidade cidade = (Cidade) request.getAttribute("cidade");

		List<Unidade> unidades = new ArrayList<Unidade>();
		unidades = UnidadeDAO.getInstance().carregarPorCidade(cidade);
		
		int i = 0;

		for (Unidade u : unidades) {			
	%>
			<option value=<%=u.getCodigo()%> <%if (i == 0) {%> selected <%}%>><%=u.getNomeFantasia()%></option>
	<%
			i++;
			}
	%>

