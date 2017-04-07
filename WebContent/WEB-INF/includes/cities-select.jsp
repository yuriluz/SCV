<%@page import="com.scv.persistence.dao.EstadoDAO"%>
<%@page import="com.scv.persistence.dao.CidadeDAO"%>
<%@page import="com.scv.javabean.Estado"%>
<%@page import="com.scv.javabean.Cidade"%>
<%@page import="java.util.*"%>

	<%
		Estado estado = (Estado) request.getAttribute("estado");

		List<Cidade> cidades = new ArrayList<Cidade>();
		cidades = CidadeDAO.getInstance().carregarPorEstado(estado);
		
		int i = 0;

		for (Cidade c : cidades) {			
	%>
			<option value=<%=c.getCodigo()%> <%if (i == 0) {%> selected <%}%>><%=c.getNome()%></option>
	<%
			i++;
			}
	%>

