package com.scv.servlet;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.scv.entities.enums.Sexo;
import com.scv.entities.enums.TipoDocumento;
import com.scv.javabean.Cidade;
import com.scv.javabean.Estado;
import com.scv.javabean.Unidade;
import com.scv.javabean.Vacinador;
import com.scv.javabean.Vacinador.TipoVacinador;
import com.scv.persistence.dao.CidadeDAO;
import com.scv.persistence.dao.EstadoDAO;
import com.scv.persistence.dao.UnidadeDAO;
import com.scv.persistence.dao.VacinadorDAO;
import com.scv.persistence.exception.DAOException;

public class AdmVacinadorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdmVacinadorServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("WEB-INF/adm/page-agent.jsp").forward(request, response);
	
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String codVacinador;
		codVacinador = request.getParameter("codVac");
		SimpleDateFormat df = new SimpleDateFormat("dd/MM/yyyy");
		
		try {
			String matricula = request.getParameter("matricula");
			String nome = request.getParameter("nome");
			Sexo sexo = Sexo.getByValue(request.getParameter("genero"));
			String nacionalidade = request.getParameter("nacionalidade");
			String naturalidade = request.getParameter("naturalidade");
			String cpf = request.getParameter("cpf");
			TipoVacinador tipoVacinador = TipoVacinador.getByValue(Integer.parseInt(request.getParameter("tipo")));
			String crm = request.getParameter("crm");;
			String documento = request.getParameter("documento");
			TipoDocumento tipoDocumento = TipoDocumento.getByValue(Integer.parseInt(request.getParameter("tipodoc")));
			String emissor = request.getParameter("emissor");
			Date dataNascimento = df.parse(request.getParameter("dtNascimento"));
			String telefone = request.getParameter("telefone");
			String email = request.getParameter("email");
			String logradouro = request.getParameter("endereco");
			String complemento = request.getParameter("complemento");
			String bairro = request.getParameter("bairro");
			Cidade cidade = CidadeDAO.getInstance().carregarPorCodigo(Integer.parseInt(request.getParameter("cidade")));
			Estado estado = EstadoDAO.getInstance().carregarPorCodigo(Integer.parseInt(request.getParameter("estado")));
			String cep = request.getParameter("cep");
			Unidade unidade = UnidadeDAO.getInstance().carregarPorCodigo(Integer.parseInt(request.getParameter("codUni")));
			Boolean status = Boolean.valueOf(request.getParameter("status"));
			
			if (!codVacinador.isEmpty()) {
				Vacinador vacinador = VacinadorDAO.getInstance().carregarPorCodigo(Integer.parseInt(codVacinador));
				vacinador.setNome(nome);
				vacinador.setMatricula(matricula);
				vacinador.setSexo(sexo);
				vacinador.setNacionalidade(nacionalidade);
				vacinador.setNaturalidade(naturalidade);
				vacinador.setCpf(cpf);
				vacinador.setTipoVacinador(tipoVacinador);
				vacinador.setCrm(crm);
				vacinador.setDocumento(documento);
				vacinador.setTipoDocumento(tipoDocumento);
				vacinador.setEmissor(emissor);
				vacinador.setDataNascimento(dataNascimento);
				vacinador.setTelefone(telefone);
				vacinador.setEmail(email);
				vacinador.setLogradouro(logradouro);
				vacinador.setComplemento(complemento);
				vacinador.setBairro(bairro);
				vacinador.setCidade(cidade);
				vacinador.setEstado(estado);
				vacinador.setCep(cep);
				vacinador.setUnidade(unidade);
				vacinador.setStatus(status);
				
				VacinadorDAO.getInstance().alterar(vacinador);
			} else {
				Vacinador vacinador = new Vacinador(matricula, nome, sexo, nacionalidade, naturalidade, 
						cpf, tipoVacinador, crm, documento, tipoDocumento, 
						emissor, dataNascimento, telefone, email, logradouro, complemento, 
						bairro, cidade, estado, cep, unidade, status);
				
				VacinadorDAO.getInstance().inserir(vacinador);
			}
			
		} catch (ClassNotFoundException | DAOException | ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
		}
		
		request.getRequestDispatcher("WEB-INF/adm/page-agent.jsp").forward(request, response);
		
	}

}
