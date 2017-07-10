package com.scv.servlet;

import java.io.IOException;
import java.util.logging.Level;
import java.util.logging.Logger;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.javabean.Cidade;
import com.scv.javabean.Estado;
import com.scv.javabean.Unidade;
import com.scv.javabean.Usuario;
import com.scv.javabean.Unidade.Gestao;
import com.scv.javabean.Unidade.TipoUnidade;
import com.scv.persistence.dao.CidadeDAO;
import com.scv.persistence.dao.EstadoDAO;
import com.scv.persistence.dao.UnidadeDAO;
import com.scv.persistence.dao.UsuarioDAO;
import com.scv.persistence.exception.DAOException;

public class AdmUnidadeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static Logger LOGGER = Logger.getLogger(AdmUnidadeServlet.class.getName());
       
    public AdmUnidadeServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("WEB-INF/adm/page-center.jsp").forward(request, response);
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String codUnidade;
		codUnidade = request.getParameter("codUni");
		
		try {
			String nomeFantasia = request.getParameter("nome");
			String razaoSocial = request.getParameter("razao");
			String cnes = request.getParameter("cnes");
			String cnpj = request.getParameter("cnpj");
			String telefone = request.getParameter("telefone");
			TipoUnidade tipo = TipoUnidade.getByValue(request.getParameter("tipouni"));
			Gestao gestao = Gestao.getByValue(request.getParameter("gestao"));
			String logradouro = request.getParameter("endereco");
			String bairro = request.getParameter("bairro");
			Cidade cidade = CidadeDAO.getInstance().carregarPorCodigo(Integer.parseInt(request.getParameter("cidade")));
			Estado estado = EstadoDAO.getInstance().carregarPorCodigo(Integer.parseInt(request.getParameter("estado")));
			String cep = request.getParameter("cep");
			Usuario usuario = UsuarioDAO.getInstance().carregarPorCodigo(Integer.parseInt(request.getParameter("codUser")));
			Boolean status = Boolean.valueOf(request.getParameter("status"));
			
			if (!codUnidade.isEmpty()) {
				Unidade unidade = UnidadeDAO.getInstance().carregarPorCodigo(Integer.parseInt(codUnidade));
				unidade.setNomeFantasia(nomeFantasia);
				unidade.setRazaoSocial(razaoSocial);
				unidade.setCnes(cnes);
				unidade.setCnpj(cnpj);
				unidade.setTelefone(telefone);
				unidade.setTipo(tipo);
				unidade.setGestao(gestao);
				unidade.setLogradouro(logradouro);
				unidade.setBairro(bairro);
				unidade.setCidade(cidade);
				unidade.setEstado(estado);
				unidade.setCep(cep);
				unidade.setUsuario(usuario);
				unidade.setStatus(status);
				
				UnidadeDAO.getInstance().alterar(unidade);
			} else {
				Unidade unidade = new Unidade(nomeFantasia, razaoSocial, cnes, cnpj, 
						telefone, tipo, gestao, logradouro, bairro, 
						cidade, estado, cep, usuario, status);
				
				UnidadeDAO.getInstance().inserir(unidade);
			}
			
		} catch (ClassNotFoundException | DAOException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
            request.getRequestDispatcher("erro.html").forward(request, response);
		}
		
		request.getRequestDispatcher("WEB-INF/adm/page-center.jsp").forward(request, response);
		
	}

}
